include!("methods.rs");
use std::{cell::Cell,rc::Rc};
struct D(usize,Rc<Cell<usize>>);impl Drop for D{fn drop(&mut self){self.1.set(self.1.get()+1)}}
fn main(){for m in [1,4,8]{let c=Rc::new(Cell::new(0));let mut x:Vec<_>=(0..7).map(|i|D(i,c.clone())).collect();let mut y:Vec<_>=(7..14).map(|i|D(i,c.clone())).collect();match m{1=>chunks2(&mut x,&mut y),4=>chunks4(&mut x,&mut y),_=>chunks8(&mut x,&mut y)}assert_eq!(c.get(),0);assert_eq!(x.iter().map(|d|d.0).collect::<Vec<_>>(),(7..14).collect::<Vec<_>>());drop(x);drop(y);assert_eq!(c.get(),14);}
 for n in 0..128{let mut a:Vec<_>=(0..2*n).collect();let(b,c)=a.split_at_mut(n);chunks8(b,c);assert_eq!(a,[ (n..2*n).collect::<Vec<_>>(),(0..n).collect::<Vec<_>>() ].concat());}
 std::panic::set_hook(Box::new(|_|{}));for m in [1,4,8]{let mut a=[1,2,3];let mut b=[4,5];let x=std::panic::catch_unwind(std::panic::AssertUnwindSafe(||{match m{1=>chunks2(&mut a,&mut b),4=>chunks4(&mut a,&mut b),_=>chunks8(&mut a,&mut b)}}));assert!(x.is_err());assert_eq!(a,[1,2,3]);assert_eq!(b,[4,5]);}println!("drop counts, adjacent disjoint slices and mismatch-before-write passed");}
