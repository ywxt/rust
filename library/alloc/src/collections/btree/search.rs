use core::borrow::Borrow;
use core::cmp::Ordering;
use core::ops::{Bound, RangeBounds};

use SearchBound::*;
use SearchResult::*;

use super::node::ForceResult::*;
use super::node::{CAPACITY, Handle, NodeRef, marker};

/// Internal specialization of the in-node linear search.
///
/// The generic implementation must call `cmp` in ascending key order and stop
/// at the first non-`Greater` result, because `Ord` impls can have observable
/// side effects. For primitive integer keys the comparison is pure, so a full
/// node can instead be scanned branchlessly (counting `key > k`), which
/// auto-vectorizes and avoids the branch mispredictions of the early-exit
/// loop.
trait SpecSearchLinear<Q: ?Sized>: Borrow<Q> + Sized {
    /// See [`NodeRef::find_key_index`]. `start_index` must not exceed `keys.len()`.
    unsafe fn spec_find_key_index(keys: &[Self], key: &Q, start_index: usize) -> IndexResult;
}

impl<K, Q: ?Sized> SpecSearchLinear<Q> for K
where
    Q: Ord,
    K: Borrow<Q>,
{
    #[inline]
    default unsafe fn spec_find_key_index(
        keys: &[K],
        key: &Q,
        start_index: usize,
    ) -> IndexResult {
        for (offset, k) in unsafe { keys.get_unchecked(start_index..) }.iter().enumerate() {
            match key.cmp(k.borrow()) {
                Ordering::Greater => {}
                Ordering::Equal => return IndexResult::KV(start_index + offset),
                Ordering::Less => return IndexResult::Edge(start_index + offset),
            }
        }
        IndexResult::Edge(keys.len())
    }
}

macro_rules! spec_search_linear_int {
    ($($t:ty),+) => {$(
        impl SpecSearchLinear<$t> for $t {
            #[inline]
            unsafe fn spec_find_key_index(
                keys: &[$t],
                key: &$t,
                start_index: usize,
            ) -> IndexResult {
                let key = *key;
                let sub = unsafe { keys.get_unchecked(start_index..) };
                if sub.len() == CAPACITY {
                    // Full node: branchless fixed-length scan. Outlined so
                    // that the code size of callers inlining the search
                    // stays close to the generic early-exit loop.
                    let full = unsafe { &*(sub.as_ptr() as *const [$t; CAPACITY]) };
                    return match spec_full_scan(full, key) {
                        (idx, true) => IndexResult::KV(start_index + idx),
                        (idx, false) => IndexResult::Edge(start_index + idx),
                    };
                }
                // Partial node: early-exit scan, same as the generic path.
                // A branchless scan over a dynamic length does not vectorize
                // well and regresses leftmost-biased patterns.
                for (offset, &k) in sub.iter().enumerate() {
                    match key.cmp(&k) {
                        Ordering::Greater => {}
                        Ordering::Equal => return IndexResult::KV(start_index + offset),
                        Ordering::Less => return IndexResult::Edge(start_index + offset),
                    }
                }
                IndexResult::Edge(keys.len())
            }
        }

    )+};
}
spec_search_linear_int!(u8, u16, u32, u64, u128, usize, i8, i16, i32, i64, i128, isize);

/// Branchless scan of a full node. Returns the edge index within the node and
/// whether the key at that index equals the searched key. Outlined
/// (`inline(never)`) so callers keep the code size of the early-exit loop.
#[inline(never)]
fn spec_full_scan<T: Copy + Ord>(full: &[T; CAPACITY], key: T) -> (usize, bool) {
    // First-key guard: keeps the O(1) exit of leftmost-biased access patterns
    // (e.g. draining a map through ascending `remove` calls) that a full scan
    // would otherwise lose. Low entropy for both leftmost (always taken) and
    // uniform (rarely taken) patterns.
    match key.cmp(&full[0]) {
        Ordering::Less => return (0, false),
        Ordering::Equal => return (0, true),
        Ordering::Greater => {}
    }
    let mut count = 0usize;
    for &k in full {
        count += (k < key) as usize;
    }
    (count, count < CAPACITY && full[count] == key)
}

pub(super) enum SearchBound<T> {
    /// An inclusive bound to look for, just like `Bound::Included(T)`.
    Included(T),
    /// An exclusive bound to look for, just like `Bound::Excluded(T)`.
    Excluded(T),
    /// An unconditional inclusive bound, just like `Bound::Unbounded`.
    AllIncluded,
    /// An unconditional exclusive bound.
    AllExcluded,
}

impl<T> SearchBound<T> {
    pub(super) fn from_range(range_bound: Bound<T>) -> Self {
        match range_bound {
            Bound::Included(t) => Included(t),
            Bound::Excluded(t) => Excluded(t),
            Bound::Unbounded => AllIncluded,
        }
    }
}

pub(super) enum SearchResult<BorrowType, K, V, FoundType, GoDownType> {
    Found(Handle<NodeRef<BorrowType, K, V, FoundType>, marker::KV>),
    GoDown(Handle<NodeRef<BorrowType, K, V, GoDownType>, marker::Edge>),
}

pub(super) enum IndexResult {
    KV(usize),
    Edge(usize),
}

impl<BorrowType: marker::BorrowType, K, V> NodeRef<BorrowType, K, V, marker::LeafOrInternal> {
    /// Looks up a given key in a (sub)tree headed by the node, recursively.
    /// Returns a `Found` with the handle of the matching KV, if any. Otherwise,
    /// returns a `GoDown` with the handle of the leaf edge where the key belongs.
    ///
    /// The result is meaningful only if the tree is ordered by key, like the tree
    /// in a `BTreeMap` is.
    pub(super) fn search_tree<Q: ?Sized>(
        mut self,
        key: &Q,
    ) -> SearchResult<BorrowType, K, V, marker::LeafOrInternal, marker::Leaf>
    where
        Q: Ord,
        K: Borrow<Q>,
    {
        loop {
            self = match self.search_node(key) {
                Found(handle) => return Found(handle),
                GoDown(handle) => match handle.force() {
                    Leaf(leaf) => return GoDown(leaf),
                    Internal(internal) => internal.descend(),
                },
            }
        }
    }

    /// Descends to the nearest node where the edge matching the lower bound
    /// of the range is different from the edge matching the upper bound, i.e.,
    /// the nearest node that has at least one key contained in the range.
    ///
    /// If found, returns an `Ok` with that node, the strictly ascending pair of
    /// edge indices in the node delimiting the range, and the corresponding
    /// pair of bounds for continuing the search in the child nodes, in case
    /// the node is internal.
    ///
    /// If not found, returns an `Err` with the leaf edge matching the entire
    /// range.
    ///
    /// As a diagnostic service, panics if the range specifies impossible bounds.
    ///
    /// The result is meaningful only if the tree is ordered by key.
    pub(super) fn search_tree_for_bifurcation<'r, Q: ?Sized, R>(
        mut self,
        range: &'r R,
    ) -> Result<
        (
            NodeRef<BorrowType, K, V, marker::LeafOrInternal>,
            usize,
            usize,
            SearchBound<&'r Q>,
            SearchBound<&'r Q>,
        ),
        Handle<NodeRef<BorrowType, K, V, marker::Leaf>, marker::Edge>,
    >
    where
        Q: Ord,
        K: Borrow<Q>,
        R: RangeBounds<Q>,
    {
        // Determine if map or set is being searched
        let is_set = <V as super::set_val::IsSetVal>::is_set_val();

        // Inlining these variables should be avoided. We assume the bounds reported by `range`
        // remain the same, but an adversarial implementation could change between calls (#81138).
        let (start, end) = (range.start_bound(), range.end_bound());
        match (start, end) {
            (Bound::Excluded(s), Bound::Excluded(e)) if s == e => {
                if is_set {
                    panic!("range start and end are equal and excluded in BTreeSet")
                } else {
                    panic!("range start and end are equal and excluded in BTreeMap")
                }
            }
            (Bound::Included(s) | Bound::Excluded(s), Bound::Included(e) | Bound::Excluded(e))
                if s > e =>
            {
                if is_set {
                    panic!("range start is greater than range end in BTreeSet")
                } else {
                    panic!("range start is greater than range end in BTreeMap")
                }
            }
            _ => {}
        }
        let mut lower_bound = SearchBound::from_range(start);
        let mut upper_bound = SearchBound::from_range(end);
        loop {
            let (lower_edge_idx, lower_child_bound) = self.find_lower_bound_index(lower_bound);
            let (upper_edge_idx, upper_child_bound) =
                unsafe { self.find_upper_bound_index(upper_bound, lower_edge_idx) };
            if lower_edge_idx < upper_edge_idx {
                return Ok((
                    self,
                    lower_edge_idx,
                    upper_edge_idx,
                    lower_child_bound,
                    upper_child_bound,
                ));
            }
            debug_assert_eq!(lower_edge_idx, upper_edge_idx);
            let common_edge = unsafe { Handle::new_edge(self, lower_edge_idx) };
            match common_edge.force() {
                Leaf(common_edge) => return Err(common_edge),
                Internal(common_edge) => {
                    self = common_edge.descend();
                    lower_bound = lower_child_bound;
                    upper_bound = upper_child_bound;
                }
            }
        }
    }

    /// Finds an edge in the node delimiting the lower bound of a range.
    /// Also returns the lower bound to be used for continuing the search in
    /// the matching child node, if `self` is an internal node.
    ///
    /// The result is meaningful only if the tree is ordered by key.
    pub(super) fn find_lower_bound_edge<'r, Q>(
        self,
        bound: SearchBound<&'r Q>,
    ) -> (Handle<Self, marker::Edge>, SearchBound<&'r Q>)
    where
        Q: ?Sized + Ord,
        K: Borrow<Q>,
    {
        let (edge_idx, bound) = self.find_lower_bound_index(bound);
        let edge = unsafe { Handle::new_edge(self, edge_idx) };
        (edge, bound)
    }

    /// Clone of `find_lower_bound_edge` for the upper bound.
    pub(super) fn find_upper_bound_edge<'r, Q>(
        self,
        bound: SearchBound<&'r Q>,
    ) -> (Handle<Self, marker::Edge>, SearchBound<&'r Q>)
    where
        Q: ?Sized + Ord,
        K: Borrow<Q>,
    {
        let (edge_idx, bound) = unsafe { self.find_upper_bound_index(bound, 0) };
        let edge = unsafe { Handle::new_edge(self, edge_idx) };
        (edge, bound)
    }
}

impl<BorrowType, K, V, Type> NodeRef<BorrowType, K, V, Type> {
    /// Looks up a given key in the node, without recursion.
    /// Returns a `Found` with the handle of the matching KV, if any. Otherwise,
    /// returns a `GoDown` with the handle of the edge where the key might be found
    /// (if the node is internal) or where the key can be inserted.
    ///
    /// The result is meaningful only if the tree is ordered by key, like the tree
    /// in a `BTreeMap` is.
    pub(super) fn search_node<Q: ?Sized>(
        self,
        key: &Q,
    ) -> SearchResult<BorrowType, K, V, Type, Type>
    where
        Q: Ord,
        K: Borrow<Q>,
    {
        match unsafe { self.find_key_index(key, 0) } {
            IndexResult::KV(idx) => Found(unsafe { Handle::new_kv(self, idx) }),
            IndexResult::Edge(idx) => GoDown(unsafe { Handle::new_edge(self, idx) }),
        }
    }

    /// Returns either the KV index in the node at which the key (or an equivalent)
    /// exists, or the edge index where the key belongs, starting from a particular index.
    ///
    /// The result is meaningful only if the tree is ordered by key, like the tree
    /// in a `BTreeMap` is.
    ///
    /// # Safety
    /// `start_index` must be a valid edge index for the node.
    unsafe fn find_key_index<Q: ?Sized>(&self, key: &Q, start_index: usize) -> IndexResult
    where
        Q: Ord,
        K: Borrow<Q>,
    {
        let node = self.reborrow();
        let keys = node.keys();
        debug_assert!(start_index <= keys.len());
        unsafe { <K as SpecSearchLinear<Q>>::spec_find_key_index(keys, key, start_index) }
    }

    /// Finds an edge index in the node delimiting the lower bound of a range.
    /// Also returns the lower bound to be used for continuing the search in
    /// the matching child node, if `self` is an internal node.
    ///
    /// The result is meaningful only if the tree is ordered by key.
    fn find_lower_bound_index<'r, Q>(
        &self,
        bound: SearchBound<&'r Q>,
    ) -> (usize, SearchBound<&'r Q>)
    where
        Q: ?Sized + Ord,
        K: Borrow<Q>,
    {
        match bound {
            Included(key) => match unsafe { self.find_key_index(key, 0) } {
                IndexResult::KV(idx) => (idx, AllExcluded),
                IndexResult::Edge(idx) => (idx, bound),
            },
            Excluded(key) => match unsafe { self.find_key_index(key, 0) } {
                IndexResult::KV(idx) => (idx + 1, AllIncluded),
                IndexResult::Edge(idx) => (idx, bound),
            },
            AllIncluded => (0, AllIncluded),
            AllExcluded => (self.len(), AllExcluded),
        }
    }

    /// Mirror image of `find_lower_bound_index` for the upper bound,
    /// with an additional parameter to skip part of the key array.
    ///
    /// # Safety
    /// `start_index` must be a valid edge index for the node.
    unsafe fn find_upper_bound_index<'r, Q>(
        &self,
        bound: SearchBound<&'r Q>,
        start_index: usize,
    ) -> (usize, SearchBound<&'r Q>)
    where
        Q: ?Sized + Ord,
        K: Borrow<Q>,
    {
        match bound {
            Included(key) => match unsafe { self.find_key_index(key, start_index) } {
                IndexResult::KV(idx) => (idx + 1, AllExcluded),
                IndexResult::Edge(idx) => (idx, bound),
            },
            Excluded(key) => match unsafe { self.find_key_index(key, start_index) } {
                IndexResult::KV(idx) => (idx, AllIncluded),
                IndexResult::Edge(idx) => (idx, bound),
            },
            AllIncluded => (self.len(), AllIncluded),
            AllExcluded => (start_index, AllExcluded),
        }
    }
}
