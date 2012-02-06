NB.  Utils
G              =.  `''  NB.  Verb to atomic rep
Ev             =.  `:6  NB.  Atomic rep to verb
gerN           =.  noun&$: : ger =: ":@:[ <@,&< ]  NB.  Produce atomic rep of nameclass x and value y (which should be an atomic rep if x~:0)

fw             =.  {.@:;:  NB.  First Word
Fw             =.  ("_) (gerN`) (`(gerN 0)) (`:6) (fw`) (`:6)  NB.  Don't like the `(gerN 0) part, feels forced

NB.  Application
cap            =.  <@:transform^:pair@:>@:{:^:isAt@:($:&.>)^:boxed
  boxed        =.  0 < L.
  isAt         =.  ('@'Fw={.) *. pair
    pair       =.  2 = #
  transform    =.  at2Cap pullrank~ outrank ; {:
    outrank    =.  0 +./ .>~^:] _1 |. 1:G , rankG
      rankG    =.  [: |.&.>&.> (;:'@[b.') <@(subO/)@:,"1 0 ]
    pullrank   =.  <@fullrank {::~ ('';1;0) }.~ _2 * 0 {:: [
      fullrank =.  '"' Fw subO ,&{:~
        subO   =.  , <  NB. subOrdinate
    at2Cap     =.  verb ger [:G , ]

Cap_z_         =:  'G' f. ((<":0)`) (cap f.`) (@.(0;1 2)) (`:6)

Note 'Examples'
	   f@g Cap
	[: f g
	   f@(g@h) Cap
	[: f [: g h
	   f@g@h Cap
	[: ([: f g) h

	   {.@$ Cap
	[: {. $
	   {.@+. Cap
	([: {. +.)"0 0 0
	   <@%. Cap
	([: < %.)"2 _ 2
	   %.@< Cap
	([: %. <)"_ 0 0

	   NB.  FIX THIS
	   (+/ +:% #) Cap
	|domain error
	|       (+/+:%#)Cap
	   (+/ +:@% #) Cap
	|domain error
	|       (+/+:@%#)Cap

	   NB.  Once cap f. Cap works, we're done
	   CAP   =:  cap f. Cap
	   CAP2  =:  CAP f. Cap

       CAP2 G -: CAP G  NB.  No more @s to remove....
	1
)