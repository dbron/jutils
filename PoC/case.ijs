
NB.  Bitwise operation
bw      =:   adverb : '(+&16@:(u./~ ({.@:i. ,:)~ 0 1"_ |: (i. 16) b./~) i. 2) b.'

NB.  Bitwise OR
bwOr    =:  +. bw
bwNot   =:  -.@:]"0 bw
bwInvrt =:  2 : 'u.&n. :. (u.&(bwNot n.))' 

NB. Difference between cases.
msk     =:  -/ a. i. 'aA'

NB.  Between
btwn    =:  conjunction : 'm.&<: *. <:&n.'
btw     =:  adverb : '({.m.) btwn ({:m.)'

NB.  In the range of lowercase
isL     =: (a.i.'az') btw

NB.  In the range of uppercase
isU     =: (a.i.'AZ') btw

LC      =:  (bwOr *&msk@:isU)&.:(a.&i.)
UC      =:  (bwOr *&(bwNot msk)@:isL)&.:(a.&i.)

is      =:  isU :. isL
tms     =:  * bwInvrt msk

tmsis   =:  tms@:is :. (tms^:_1@:(is^:_1))

C       =: (bwOr tmsis) :. (bwOr tmsis^:1) &.(a.&i.) 

*&(bwNot msk)