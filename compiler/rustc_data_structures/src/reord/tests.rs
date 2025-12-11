use std::sync::Arc;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::time::Duration;

use rand::rngs::StdRng;
use rand::{Rng, SeedableRng};

use crate::reord;

macro_rules! try_join {
    ($($handle:expr),+ $(,)?) => {{
        let mut err = None;

        $(
            if err.is_none() {
                match $handle.join() {
                    Ok(_) => {}

                    Err(panic) => {
                        err = Some(format!("thread panicked: {:?}", panic));
                    }
                }
            } else {
                let _ = $handle.join();
            }
        )+

        if let Some(e) = err {
            Err(e)
        } else {
            Ok(())
        }
    }};
}

macro_rules! join {
    ($($handle:expr),+ $(,)?) => {{
        (
            $($handle.join(),)+
        )
    }};
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn basic_working_test() {
    println!("before initializing test");
    reord::init_test(reord::Config::with_random_seed());
    println!("initialized test");

    let a = std::thread::spawn(reord::new_task(move || {
        println!("started task 1");
        reord::point();
        println!("finished task 1");
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        println!("started task 2");
        reord::point();
        println!("finished task 2");
    }));

    println!("before running tests");
    let h = reord::start(2);
    h.join().unwrap();
    println!("finished tests");

    try_join!(a, b).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn basic_failing_test() {
    reord::init_test(reord::Config::from_seed(Default::default()));

    let data = Arc::new(AtomicUsize::new(0));
    let data2 = data.clone();

    let a = std::thread::spawn(reord::new_task(move || {
        data.fetch_add(1, Ordering::Relaxed);
        reord::point();
        assert!(data.load(Ordering::Relaxed) < 2);
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        data2.fetch_add(1, Ordering::Relaxed);
        reord::point();
        assert!(data2.load(Ordering::Relaxed) < 2);
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap_err();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn check_failing_locks() {
    reord::init_test(reord::Config {
        check_named_locks_work_for: Some(Duration::from_secs(1)),
        ..reord::Config::from_seed(0)
    });

    let a = std::thread::spawn(reord::new_task(move || {
        println!("before lock 1");
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            println!("in lock 1");
            reord::point();
            reord::point();
            reord::point();
            reord::point();
            reord::point();
            reord::point();
        }
        println!("after lock 1");
        reord::point();
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        println!("before lock 2");
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            println!("in lock 2");
            reord::point();
            reord::point();
            reord::point();
            reord::point();
            reord::point();
            reord::point();
            reord::point();
        }
        println!("after lock 2");
        reord::point();
    }));

    let h = reord::start(2);

    let (_, _, h) = join!(a, b, h);
    h.unwrap_err();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn check_passing_locks() {
    reord::init_test(reord::Config {
        check_named_locks_work_for: Some(Duration::from_secs(1)),
        ..reord::Config::from_seed(Default::default())
    });

    let lock = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock2 = lock.clone();
    let a = std::thread::spawn(reord::new_task(move || {
        println!("before lock 1");
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            println!("taking lock 1");
            let _l = lock.lock();
            println!("in lock 1");
            reord::point();
        }
        reord::point();
        println!("after lock 1");
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        println!("before lock 2");
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            println!("taking lock 2");
            let _l = lock2.lock();
            println!("in lock 2");
            reord::point();
        }
        reord::point();
        println!("after lock 2");
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn detect_deadlock() {
    reord::init_test(reord::Config {
        check_addressed_locks_work_for: Some(Duration::from_secs(1)),
        ..reord::Config::from_seed(0)
    });

    let lock1 = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock1_clone = lock1.clone();
    let lock2 = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock2_clone = lock2.clone();
    let a = std::thread::spawn(reord::new_task(move || {
        {
            println!("A taking lock 1");
            let _l = reord::Lock::take_addressed(1);
            let _l = lock1.lock();
            println!("A successfully taken lock 1");
            for _ in 0..10 {
                reord::point();
            }
            eprintln!("A taking lock 2");
            let _l = reord::Lock::take_addressed(2);
            let _l = lock2.lock();
            println!("A successfully taken both locks");
            reord::point();
        }
        println!("A after unlock");
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        {
            println!("B taking lock 2");
            let _l = reord::Lock::take_addressed(2);
            let _l = lock2_clone.lock();
            println!("B successfully taken lock 2");
            for _ in 0..10 {
                reord::point();
            }
            eprintln!("B taking lock 1");
            let _l = reord::Lock::take_addressed(1);
            let _l = lock1_clone.lock();
            println!("B successfully taken both locks");
            reord::point();
        }
        println!("B after unlock");
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap_err();
}

#[test]
#[allow(non_snake_case)]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn lock_LUL_vs_L_deadlocked() {
    // This bug was with the following interleaving:
    // - A takes lock 1
    // - B takes lock 1. Reord lets B go for it in order to check that B doesn't progress. It works fine, reord continues.
    // - A releases lock 1. This should give the lock to B, but here reord was then counting the lock as being entirely free.
    // - A takes lock 1. This should be prevented by reord, but reord mistakenly thought that lock 1 was free. Ergo, deadlock.

    reord::init_test(reord::Config {
        check_addressed_locks_work_for: Some(Duration::from_secs(1)),
        ..reord::Config::from_seed(Default::default())
    });

    let lock = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock_clone = lock.clone();
    let a = std::thread::spawn(reord::new_task(move || {
        {
            {
                println!("A taking lock 1");
                let _l = reord::Lock::take_addressed(1);
                let _l = lock.lock();
                reord::point();
                eprintln!("A releasing lock 1");
            }
            reord::point();
            eprintln!("A taking lock 1");
            let _l = reord::Lock::take_addressed(1);
            let _l = lock.lock();
        }
        println!("A after unlock");
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        {
            eprintln!("B taking lock 1");
            let _l = reord::Lock::take_addressed(1);
            let _l = lock_clone.lock();
            // A few awaits to make sure the RNG makes B keep the lock for long enough to get back to A
            reord::point();
            reord::point();
            reord::point();
            reord::point();
            reord::point();
        }
        println!("B after unlock");
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn check_passing_two_locks() {
    reord::init_test(reord::Config {
        check_named_locks_work_for: Some(Duration::from_secs(1)),
        ..reord::Config::from_seed(Default::default())
    });

    let lock1 = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock1_clone = lock1.clone();
    let lock2 = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock2_clone = lock2.clone();
    let a = std::thread::spawn(reord::new_task(move || {
        println!("before lock 1");
        {
            let _l = reord::Lock::take_atomic(vec![
                reord::LockInfo::Named(String::from("lock1")),
                reord::LockInfo::Named(String::from("lock2")),
            ]);
            println!("taking lock 1");
            let _l = lock1.lock();
            let _l = lock2.lock();
            println!("in lock 1");
            reord::point();
        }
        reord::point();
        println!("after lock 1");
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        println!("before lock 2");
        {
            let _l = reord::Lock::take_atomic(vec![
                reord::LockInfo::Named(String::from("lock1")),
                reord::LockInfo::Named(String::from("lock2")),
            ]);
            println!("taking lock 2");
            let _l = lock1_clone.lock();
            let _l = lock2_clone.lock();
            println!("in lock 2");
            reord::point();
        }
        reord::point();
        println!("after lock 2");
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn waiting_on_two_locks_vs_one() {
    reord::init_test(reord::Config {
        check_addressed_locks_work_for: Some(std::time::Duration::from_millis(100)),
        ..reord::Config::from_seed(Default::default())
    });

    let lock = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock_clone = lock.clone();

    let a = std::thread::spawn(reord::new_task(move || {
        let _l = reord::Lock::take_addressed(0);
        let _l = lock.lock();
        reord::point();
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        let _l = reord::Lock::take_atomic(vec![
            reord::LockInfo::Addressed(0),
            reord::LockInfo::Addressed(1),
        ]);
        let _l = lock_clone.lock();
        reord::point();
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn functions_without_init_dont_break() {
    let lock = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock2 = lock.clone();
    let a = std::thread::spawn(reord::new_task(move || {
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            let _l = lock.lock();
            reord::point();
        }
        reord::point();
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            let _l = lock2.lock();
            reord::point();
        }
        reord::point();
    }));

    try_join!(a, b).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn functions_without_new_task_dont_break() {
    reord::init_test(reord::Config::from_seed(0));

    let lock = std::sync::Arc::new(std::sync::Mutex::new(()));
    let lock2 = lock.clone();
    let a = std::thread::spawn(move || {
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            let _l = lock.lock();
            reord::point();
        }
        reord::point();
    });

    let b = std::thread::spawn(move || {
        {
            let _l = reord::Lock::take_named(String::from("foo"));
            let _l = lock2.lock();
            reord::point();
        }
        reord::point();
    });

    try_join!(a, b).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn two_tests_same_thread() {
    // First test
    reord::init_test(reord::Config::with_random_seed());

    let a = std::thread::spawn(reord::new_task(move || {
        reord::point();
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        reord::point();
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap();

    // Second test
    reord::init_test(reord::Config::with_random_seed());

    let a = std::thread::spawn(reord::new_task(move || {
        reord::point();
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        reord::point();
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap();
}

#[test]
#[should_panic]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn join_does_not_deadlock() {
    reord::init_test(reord::Config::with_random_seed());

    let a = std::thread::spawn(reord::new_task(move || {
        reord::point();
    }));

    let b = std::thread::spawn(reord::new_task(move || {
        panic!("willing fail");
    }));

    let h = reord::start(2);

    try_join!(a, b, h).unwrap();
}

#[test]
#[ignore = "`record` is only designed to work with `cargo-nextest`"]
fn maybe_lock_smoke_test() {
    let cfg = reord::Config::from_seed(0);
    let mut rng = StdRng::seed_from_u64(cfg.seed);
    reord::init_test(cfg);

    let the_lock = Arc::new(std::sync::Mutex::new(()));

    const NUM_TASKS: usize = 32;
    let do_lock_it = (0..NUM_TASKS).map(|_| rng.random::<bool>());
    let tasks = do_lock_it
        .map(|do_lock_it| {
            std::thread::spawn(reord::new_task({
                let the_lock = the_lock.clone();
                move || {
                    reord::maybe_lock();
                    if do_lock_it {
                        tracing::info!("taking the lock");
                        let _lock = the_lock.lock();
                        tracing::info!("taken the lock");
                        reord::point();
                    } else {
                        tracing::info!("skipping the lock");
                        reord::point();
                    }
                }
            }))
        })
        .collect::<Vec<_>>();

    let h = reord::start(NUM_TASKS);
    h.join().unwrap();
    for task in tasks {
        task.join().unwrap();
    }
}
