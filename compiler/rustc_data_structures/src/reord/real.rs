use std::cell::Cell;
use std::collections::VecDeque;
use std::ops::RangeBounds;
use std::sync::atomic::{AtomicU64, Ordering};
use std::thread;
use std::time::{Duration, Instant};

use crossbeam_channel::{Receiver, RecvTimeoutError, Sender};
use rand::SeedableRng;
use rand::rngs::StdRng;
use rand::seq::IndexedRandom;

use crate::fx::{FxHashMap, FxHashSet};
use crate::reord::{Config, LockInfo};

struct StopPoint {
    task_id: u64,
    resume: Sender<()>,
    maybe_lock: bool,
    locks_about_to_be_acquired: Vec<LockInfo>,
}

impl std::fmt::Debug for StopPoint {
    fn fmt(&self, fmt: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        fmt.debug_struct("StopPoint")
            .field("task_id", &self.task_id)
            .field("maybe_lock", &self.maybe_lock)
            .field("locks_about_to_be_acquired", &self.locks_about_to_be_acquired)
            .finish()
    }
}

impl StopPoint {
    fn without_lock(resume: Sender<()>) -> StopPoint {
        StopPoint {
            task_id: TASK_ID.get(),
            resume,
            maybe_lock: false,
            locks_about_to_be_acquired: Vec::new(),
        }
    }

    fn with_locks(resume: Sender<()>, locks_about_to_be_acquired: Vec<LockInfo>) -> StopPoint {
        StopPoint { task_id: TASK_ID.get(), resume, maybe_lock: false, locks_about_to_be_acquired }
    }

    fn maybe_lock(resume: Sender<()>) -> StopPoint {
        StopPoint {
            task_id: TASK_ID.get(),
            resume,
            maybe_lock: true,
            locks_about_to_be_acquired: Vec::new(),
        }
    }
}

#[derive(Debug)]
enum Message {
    NewTask(StopPoint),
    Stop(StopPoint),
    Unlock(u64, LockInfo),
    TaskEnd(u64),
}

impl Message {
    fn task_id(&self) -> u64 {
        match self {
            Message::NewTask(p) | Message::Stop(p) => p.task_id,
            Message::Unlock(t, _) | Message::TaskEnd(t) => *t,
        }
    }
}

static SENDER: parking_lot::RwLock<Option<Sender<Message>>> = parking_lot::RwLock::new(None);
static OVERSEER: parking_lot::Mutex<Option<(Config, Receiver<Message>)>> =
    parking_lot::Mutex::new(None);
static NEXT_TASK_ID: AtomicU64 = AtomicU64::new(1);

std::thread_local! {
    static TASK_ID: Cell<u64> = Cell::new(0);
}

#[derive(Debug)]
enum TaskState {
    Running,
    BlockedOn(FxHashSet<LockInfo>),
    BlockedOnMaybe,
    Waiting(StopPoint),
}

#[derive(Debug)]
struct Task {
    state: TaskState,
    owned_locks: FxHashSet<LockInfo>,
}

impl Task {
    fn new(stop: StopPoint) -> Task {
        Task { state: TaskState::Waiting(stop), owned_locks: FxHashSet::default() }
    }
}

#[derive(Debug)]
struct Overseer {
    peeked_messages: VecDeque<Message>,
    receiver: Receiver<Message>,
    cfg: Config,
    rng: StdRng,
    // Invariant: only one task has state BlockedOn at a time, to avoid issues with not knowing
    // which task got the lock after an unlock
    tasks: FxHashMap<u64, Task>,
}

impl Overseer {
    fn new(cfg: Config, receiver: Receiver<Message>, initial_tasks: Vec<StopPoint>) -> Overseer {
        Overseer {
            peeked_messages: VecDeque::new(),
            receiver,

            rng: StdRng::seed_from_u64(cfg.seed),
            cfg,

            tasks: initial_tasks.into_iter().map(|p| (p.task_id, Task::new(p))).collect(),
        }
    }

    fn handle_message(&mut self, m: Message) {
        match m {
            Message::TaskEnd(t) => {
                let remaining_locks = &self.tasks.get(&t).unwrap().owned_locks;
                assert!(
                    remaining_locks.is_empty(),
                    "Task completed without releasing all its locks: it still had {remaining_locks:?}"
                );
                self.tasks.remove(&t);
            }
            Message::Unlock(t, l) => {
                self.tasks.get_mut(&t).unwrap().owned_locks.remove(&l);
                for t in self.tasks.values_mut() {
                    if let TaskState::BlockedOn(locks) = &mut t.state {
                        if locks.remove(&l) {
                            t.owned_locks.insert(l);
                            t.state = TaskState::Running;
                            break;
                        }
                    }
                }
            }
            Message::NewTask(p) => {
                self.tasks.insert(p.task_id, Task::new(p));
            }
            Message::Stop(p) => {
                let task = self.tasks.get_mut(&p.task_id).unwrap();
                task.state = TaskState::Waiting(p);
            }
        }
    }

    fn is_already_locked(&self, l: &LockInfo) -> bool {
        self.tasks.values().any(|t| t.owned_locks.contains(l))
    }

    fn conflicting_locks_for(
        &self,
        locks_about_to_be_acquired: &Vec<LockInfo>,
    ) -> FxHashSet<LockInfo> {
        locks_about_to_be_acquired.iter().filter(|l| self.is_already_locked(l)).cloned().collect()
    }

    fn has_task_blocked_on_locks(&self) -> bool {
        self.tasks.values().any(|t| matches!(t.state, TaskState::BlockedOn(_)))
    }

    /// Returns either a duration for which to check the locks, or None if it's not something we're configured to do
    fn time_to_check_locks(&self, locks: &FxHashSet<LockInfo>) -> Option<Duration> {
        let mut res = Duration::from_millis(0);
        for l in locks {
            match l {
                LockInfo::Addressed(_) => {
                    res = std::cmp::max(res, self.cfg.check_addressed_locks_work_for?)
                }
                LockInfo::Named(_) => {
                    res = std::cmp::max(res, self.cfg.check_named_locks_work_for?)
                }
            }
        }
        Some(res)
    }

    fn can_resume(&self, p: &StopPoint) -> bool {
        let conflicting_locks = self.conflicting_locks_for(&p.locks_about_to_be_acquired);
        conflicting_locks.is_empty()
            || (!self.has_task_blocked_on_locks()
                && self.time_to_check_locks(&conflicting_locks).is_some())
    }

    /// Returns `None` iff there is currently no resumable task
    fn get_resumable_task(&mut self) -> Option<u64> {
        let mut resumable_idxs = self
            .tasks
            .iter()
            .filter_map(|(t, s)| match &s.state {
                TaskState::Waiting(p) if self.can_resume(p) => Some(*t),
                _ => None,
            })
            .collect::<Vec<_>>();
        resumable_idxs.sort(); // make sure we're reproducible and not dependent on hashmap iteration order
        resumable_idxs.choose(&mut self.rng).copied()
    }

    // Returns true iff there is no new message from a task in range `tasks` for `check_for` time
    fn check_if_task_is_blocked(
        &mut self,
        tasks: impl RangeBounds<u64>,
        check_for: Duration,
    ) -> bool {
        let deadline = Instant::now() + check_for;
        loop {
            let now = Instant::now();
            if now >= deadline {
                return true;
            }
            let remaining = deadline - now;
            match self.receiver.recv_timeout(remaining) {
                Err(RecvTimeoutError::Timeout) => return true,
                Err(RecvTimeoutError::Disconnected) => panic!("Overseer receiver disconnected"),
                Ok(m) => {
                    let task_id = m.task_id();
                    self.peeked_messages.push_back(m);
                    if tasks.contains(&task_id) {
                        return false;
                    }
                    // else continue waiting until timeout or a message in range appears
                }
            }
        }
    }

    /// Returns true iff we NEED to handle a message RIGHT NOW
    fn resume_one(&mut self) -> bool {
        let Some(t) = self.get_resumable_task() else {
            // This can happen if the only remaining tasks are all BlockedOnMaybe. Try waiting a bit
            // before confirming the deadlock. Task ID 0 does not
            if self.check_if_task_is_blocked(.., self.cfg.maybe_lock_timeout) {
                panic!("Deadlock detected! Task states are {:#?}", self.tasks);
            } else {
                return true; // try again
            }
        };
        let TaskState::Waiting(p) =
            std::mem::replace(&mut self.tasks.get_mut(&t).unwrap().state, TaskState::Running)
        else {
            unreachable!();
        };
        p.resume.send(()).unwrap();
        if p.maybe_lock {
            assert!(p.locks_about_to_be_acquired.is_empty());
            if self.check_if_task_is_blocked(p.task_id..=p.task_id, self.cfg.maybe_lock_timeout) {
                self.tasks.get_mut(&t).unwrap().state = TaskState::BlockedOnMaybe;
            }
        }
        if !p.locks_about_to_be_acquired.is_empty() {
            let conflicting_locks = self.conflicting_locks_for(&p.locks_about_to_be_acquired);
            if conflicting_locks.is_empty() {
                self.tasks
                    .get_mut(&t)
                    .unwrap()
                    .owned_locks
                    .extend(p.locks_about_to_be_acquired.into_iter());
            } else {
                // There were conflicting locks, we need to check everything
                let check_locks_for = self.time_to_check_locks(&conflicting_locks).unwrap();
                tracing::debug!(
                    ?conflicting_locks,
                    "tentatively resuming a task to validate it does not make progress"
                );
                if self.check_if_task_is_blocked(p.task_id..=p.task_id, check_locks_for) {
                    tracing::debug!(
                        ?conflicting_locks,
                        "task successfully did not make any progress"
                    );
                    let task = self.tasks.get_mut(&t).unwrap();
                    task.owned_locks.extend(
                        p.locks_about_to_be_acquired
                            .into_iter()
                            .filter(|l| !conflicting_locks.contains(&l)),
                    );
                    task.state = TaskState::BlockedOn(conflicting_locks);
                } else {
                    panic!(
                        "Locks that should have blocked let the task go through: {conflicting_locks:?}"
                    );
                }
            }
        }
        false
    }

    fn should_resume(&self) -> bool {
        !self.tasks.values().any(|t| matches!(t.state, TaskState::Running))
    }

    fn next_message(&mut self) -> Option<Message> {
        if !self.peeked_messages.is_empty() {
            return self.peeked_messages.pop_front();
        }
        self.receiver.recv().ok()
    }

    fn run(&mut self) {
        self.resume_one(); // Start the system
        while let Some(m) = self.next_message() {
            self.handle_message(m);
            if self.tasks.is_empty() {
                return;
            }
            while self.should_resume() {
                if self.resume_one() {
                    break;
                }
            }
        }
    }
}

pub(super) fn init_test(cfg: Config) {
    let (s, r) = crossbeam_channel::unbounded();
    if let Some(s) = &*SENDER.write() {
        if !s.send(Message::TaskEnd(0)).is_err() {
            panic!(
                "Initializing a new test while the old test was still running! Note that `reord` is only designed to work with `cargo-nextest`."
            );
        }
    }
    *SENDER.write() = Some(s);

    assert!(OVERSEER.lock().is_none());
    *OVERSEER.lock() = Some((cfg, r));
    NEXT_TASK_ID.store(1, Ordering::Relaxed);
}

pub(super) fn new_task<T>(f: impl FnOnce() -> T) -> impl FnOnce() -> T {
    let task_id = NEXT_TASK_ID.fetch_add(1, Ordering::Relaxed);
    assert!(task_id > 0, "Task ID wraparound detected");
    move || {
        TASK_ID.set(task_id);
        // If overseer not configured, just run
        if SENDER.read().is_none() {
            return f();
        }
        let (s, r) = crossbeam_channel::bounded(0);
        let sp = StopPoint::without_lock(s);
        SENDER
            .read()
            .as_ref()
            .unwrap()
            .send(Message::NewTask(sp))
            .expect("submitting credentials to run");
        tracing::trace!("prepared for running");
        // Now wait for overseer to unpark us
        r.recv().expect("Overseer died, please check other panic messages");
        tracing::trace!("running");
        // run the task, catching panic to still send TaskEnd
        let res = std::panic::catch_unwind(std::panic::AssertUnwindSafe(f));
        tracing::trace!("finished running");

        SENDER
            .read()
            .as_ref()
            .unwrap()
            .send(Message::TaskEnd(task_id))
            .expect("submitting task end");
        match res {
            Ok(v) => v,
            Err(e) => std::panic::resume_unwind(e),
        }
    }
}

pub(super) fn start(tasks: usize) -> thread::JoinHandle<()> {
    let (cfg, receiver): (Config, Receiver<Message>) = OVERSEER
        .lock()
        .take()
        .expect("Called `reord::start` without a `reord::init_test` call before");

    let mut new_tasks = Vec::with_capacity(tasks);
    for _ in 0..tasks {
        match receiver.recv().unwrap() {
            Message::NewTask(s) => new_tasks.push(s),
            m => {
                panic!("Got unexpected message {m:?} before {tasks} tasks were ready for execution")
            }
        }
    }

    thread::spawn(move || Overseer::new(cfg, receiver, new_tasks).run())
}

pub(super) fn point() {
    if TASK_ID.get() == 0 || SENDER.read().is_none() {
        return;
    }
    let (s, r) = crossbeam_channel::bounded(0);
    SENDER
        .read()
        .as_ref()
        .unwrap()
        .send(Message::Stop(StopPoint::without_lock(s)))
        .expect("submitting stop point");
    tracing::trace!("pausing");
    r.recv().expect("Overseer died, please check other panic messages");
    tracing::trace!("resuming");
}

pub(super) fn maybe_lock() {
    if TASK_ID.get() == 0 || SENDER.read().is_none() {
        return;
    }
    let (s, r) = crossbeam_channel::bounded(0);
    SENDER
        .read()
        .as_ref()
        .unwrap()
        .send(Message::Stop(StopPoint::maybe_lock(s)))
        .expect("submitting stop point");

    tracing::trace!("pausing before potential lock");
    r.recv().expect("Overseer died, please check other panic messages");
    tracing::trace!("resuming, about to try taking potential lock");
}

#[derive(Debug)]
pub(super) struct Lock(Vec<LockInfo>);

impl Lock {
    #[inline]
    pub(super) fn take_named(s: String) -> Lock {
        Self::take_atomic(vec![LockInfo::Named(s)])
    }

    #[inline]
    pub(super) fn take_addressed(a: usize) -> Lock {
        Self::take_atomic(vec![LockInfo::Addressed(a)])
    }

    pub(super) fn take_atomic(l: Vec<LockInfo>) -> Lock {
        if TASK_ID.get() == 0 || SENDER.read().is_none() {
            return Lock(l);
        }
        let (s, r) = crossbeam_channel::bounded(0);
        SENDER
            .read()
            .as_ref()
            .unwrap()
            .send(Message::Stop(StopPoint::with_locks(s, l.clone())))
            .expect("sending stop point");

        tracing::trace!(locks=?l, "pausing waiting for locks");
        r.recv().expect("Overseer died, please check other panic messages");
        tracing::trace!(locks=?l, "resuming and acquiring locks");
        Lock(l)
    }
}

impl Drop for Lock {
    fn drop(&mut self) {
        if TASK_ID.get() == 0 || SENDER.read().is_none() {
            return;
        }
        tracing::trace!(locks=?self.0, "releasing locks");
        for l in self.0.iter() {
            // Avoid double-panic on lock failures.
            SENDER.read().as_ref().map(|s| s.send(Message::Unlock(TASK_ID.get(), l.clone())));
        }
    }
}
