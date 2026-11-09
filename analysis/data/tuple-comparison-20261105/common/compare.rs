pub type Item<'a>=(&'a str,usize);
#[inline(always)]pub fn predicates(x:&Item<'_>,y:&Item<'_>)->[bool;4]{[x<y,x<=y,x>y,x>=y]}
#[inline(always)]pub fn fused(x:&Item<'_>,y:&Item<'_>)->[bool;4]{let o=x.cmp(y);[o.is_lt(),!o.is_gt(),o.is_gt(),!o.is_lt()]}
#[inline(always)]pub fn string_once(x:&Item<'_>,y:&Item<'_>)->[bool;4]{let o=x.0.cmp(y.0).then_with(||x.1.cmp(&y.1));[o.is_lt(),!o.is_gt(),o.is_gt(),!o.is_lt()]}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_original(x:&Item<'_>,y:&Item<'_>)->[bool;4]{predicates(x,y)}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_fused(x:&Item<'_>,y:&Item<'_>)->[bool;4]{fused(x,y)}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_once(x:&Item<'_>,y:&Item<'_>)->[bool;4]{string_once(x,y)}
#[inline(always)]pub fn two_relations(x:&Item<'_>,y:&Item<'_>)->[bool;4]{let lt=x<y;let gt=x>y;[lt,!gt,gt,!lt]}
#[inline(always)]pub fn pointer_equal(x:&Item<'_>,y:&Item<'_>)->[bool;4]{if std::ptr::eq(x,y){[false,true,false,true]}else{predicates(x,y)}}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_two(x:&Item<'_>,y:&Item<'_>)->[bool;4]{two_relations(x,y)}
#[inline(always)]pub fn ordering_match(x:&Item<'_>,y:&Item<'_>)->[bool;4]{match x.cmp(y){std::cmp::Ordering::Less=>[true,true,false,false],std::cmp::Ordering::Equal=>[false,true,false,true],std::cmp::Ordering::Greater=>[false,false,true,true]}}
