NB.  No use of constants (except maybe for foreigns, if required).

NB.  |  seems like it has a 0 or 1  in it
NB.  <.  seems like it has a 1 in it - 1&|.
NB.  ,   feels like it as a  _  in it
NB.  ,.  feels like it has a  1 or  _1  in it (it always 
NB.      produces a 2D array (i.e. ravels items into rank-1 
NB.      arrays).
NB.  r.  is ^@j  so it has both 1x1 and 1p1 as implied constants
NB.              unfortunately it's a circular function so
NB.              all outputs are coerced into a significant subdomain
NB.              which loses information about the original y
NB.              Reversing that, it's hard to user the original y to
NB.              extract the other constants (without mentioning those
NB.              constants, implicitly or explicitly).

NB.  Foreigns
NB.  ' 6!:3 (0.2) '&(1 round [: %/ 3 : '5!:5<''y'' '@:[ (6!:2@:([ , ' 6!:2 ' , ])S:0"0 1~ ;&'') '(' , ')' ,~ ":@:]) 6

NB.  Both #.  and  #:  have implied 2s;  need to figure
NB.  out how to extract them
NB.
NB.  This appears to be a tautology for any non-singleton list of numbers:
NB.  ((p.~ p.@|.) = #:^:_1:)~
NB.
NB.  Using that information, then, here's a way to extract  2  from  #.  but 
NB.   the input can't be a singleton, or it won't work:
NB.  ({ :: ({.@])~ 0 ((<:{.) i.&1@:*.(={:)) |:@:+.)@>@{:@(|.((-~ {.) p.@, }.@])~ #.) 

NB.  Not restricted to verbs.  For example:
NB.  &.  has a  _1  implied in it, can you find it?
NB.  :.  has a  _1  implied in it, can you find it?
NB.  ..  probably has a 2 and/or 0 in it (even)
NB.  .:  probably has a 2 and/or 1 in it (odd)

NB.  For rational implied constants, expressions which produce 
NB.  non-negative integers are preferred.  For example,
NB.  halve (-:) can be expressed as  0.5&*  or  ((^-)2)&*  but 
NB.  it is preferred to express it as (%2)&*  (the fewest 
NB.  primitives which derive the result from a non-negative 
NB.  integer).

NB.  Should maybe make this result in  1  rather
NB.  than  _1  per preference above.

NB.  Write your expression such that the primitive whose 
NB.  constant is being "extracted" is rightmost (if syntactically possible).

nOne0  =:  (A.@i. - !@#@[)   |.
nOne1  =:  (A.@i. - !@#@[)&$ |:
nOne2  =:  # -~ (i:     {:)          NB.!!  Doesn't work for  ''
nOne3  =:  # -~ (i: (-. }:))         NB.  Probably not in all cases?  Certainly not when ''-:(-.}.)

zero0  =:  i.   {.
zero1  =:  i.(-.}.)                  NB.  Probably not in all cases?  Certainly not when ''-:(-.}.)
zero2  =:  +  -

one0   =:  -  <:
one1   =:  -~ >:
one2   =:  +  -.
one3   =:  *  %

two0   =:  %  -:                     NB.  two0  =:  * %@-:
two1   =:  %~ +:
two2   =:  ^. *:
two3   =:  ^.~%:                     NB.  two2   =:  %@(^.%:)   NB.  Could be considered a constant of 0.5, or a constant or 2

e0     =:  %: ^
e1     =:  %:~^.

pi     =:  %~ o.

i0     =:  %~ j.

NB.  Neat plot!
NB.  plot 2-([: {.@+. ] ^.~ >:@#@#:)&> 0-.~i:500