require 'strings numeric doog'

NB.  Mesaure time of execution of a sentence
time          =:  6!:2
NB.  Measure memory usage of execution of a sentence
space         =:  7!:2
NB.  Give time & spece measurements for execution of a sentence.
ts            =:  time , space@:]

TIME_TEMPLATE =: verb define
   z=.$~0
   q =. count__ ts :: ((13!:11 ,&:< 13!:12) bind '') 'z =. NAME__ y'
   z ,&<  q
:
   z=.$~0
   q =. count__ ts :: ((13!:11 ,&:< 13!:12) bind '') 'z =. x NAME__ y'
   z ,&:<  q
)

9!:41 0: retain =. 9!:40 ''
EXPL_VERB_TEMPLATE =: (verb define) (adverb define)
   5!:1{.;:'u'
)
   SMURF__  NB.  Will be replaced with TIME_TEMPLATE
)
9!:41 retain


H       =:  conjunction define
   verb_bodies =. LF >@:}:@:}.@:cut each (<'count__';'(',(5!:5{.;:'m'),')') stringreplace each ('NAME__' <@;"1 0 n) stringreplace&.> <5!:5 {.;:'TIME_TEMPLATE'
   (EXPL_VERB_TEMPLATE  [^:((,:'SMURF__') -: ]) L: 0 ~ verb_bodies ) `: 0

)

nvtxt     =:  (,. '   '&,"1)&.>/ @: ((;:'alg time space') (<1 0)&C.@:('-'&,)@:, each ]) 
rnd       =:  (',' (8!:1) 0.01 round  (%"1 <./)@:>@:(L.&>`(,:&(< _ _))})@:({:"1)) 
nvrnd     =:  nvtxt@:(, rnd)

time_rpt  =:  dyad define
   9!:7' ' #~# BOXDRAW =. 9!:6''
   9!:17 (1 1) [ BOXPOSN =. 0 0[9!:16''
        
   Q =. (<<<2) { ":  (;:'set alg time space') , (,~ $&'-'@:(1 , {:)@:$&.>@:{.)>,.&.>/ <"_1 each ,1 ]`]`(rjust&.>)`(rjust&.>);.1 <@:>"1 |:  x ,. (<<@:>b1) (, rnd) &> y
        
   9!:7 BOXDRAW 
   9!:17 BOXPOSN

   Q
)

	W0       =.  _12 ]\ 0 0 1 2 2 2 1 2 2 2 1 1   0 0 2 2 0 1 2 1 1 2 2 2   0 0 2 2 1 2 2 1 1 2 2 2   0 2 1 2 2 2 1 2 0 1 1 1   0 2 1 2 2 2 1 2 2 2 1 1   0 2 2 2 0 1 2 1 1 2 2 2   0 2 2 2 1 2 2 1 1 2 2 2
    W1       =. 170 171 176 177 351 352 357 358 {  L =. 0&".;._2 noun define
0 2 1 1 0 2 1 2 0 0 0 0
0 2 1 1 0 2 1 2 0 0 0 1
0 2 1 1 0 2 1 2 0 0 0 2
0 2 1 1 0 2 1 2 0 0 1 0
0 2 1 1 0 2 1 2 0 0 1 1
0 2 1 1 0 2 1 2 0 0 1 2
0 2 1 1 0 2 1 2 0 0 2 0
0 2 1 1 0 2 1 2 0 0 2 1
0 2 1 1 0 2 1 2 0 0 2 2
0 2 1 1 0 2 1 2 0 1 0 0
0 2 1 1 0 2 1 2 0 1 0 1
0 2 1 1 0 2 1 2 0 1 0 2
0 2 1 1 0 2 1 2 0 1 1 0
0 2 1 1 0 2 1 2 0 1 1 1
0 2 1 1 0 2 1 2 0 1 1 2
0 2 1 1 0 2 1 2 0 1 2 0
0 2 1 1 0 2 1 2 0 1 2 1
0 2 1 1 0 2 1 2 0 1 2 2
0 2 1 1 0 2 1 2 0 2 0 0
0 2 1 1 0 2 1 2 0 2 0 1
0 2 1 1 0 2 1 2 0 2 0 2
0 2 1 1 0 2 1 2 0 2 1 0
0 2 1 1 0 2 1 2 0 2 1 1
0 2 1 1 0 2 1 2 0 2 1 2
0 2 1 1 0 2 1 2 0 2 2 0
0 2 1 1 0 2 1 2 0 2 2 1
0 2 1 1 0 2 1 2 0 2 2 2
0 2 1 1 0 2 1 2 1 0 0 0
0 2 1 1 0 2 1 2 1 0 0 1
0 2 1 1 0 2 1 2 1 0 0 2
0 2 1 1 0 2 1 2 1 0 1 0
0 2 1 1 0 2 1 2 1 0 1 1
0 2 1 1 0 2 1 2 1 0 1 2
0 2 1 1 0 2 1 2 1 0 2 0
0 2 1 1 0 2 1 2 1 0 2 1
0 2 1 1 0 2 1 2 1 0 2 2
0 2 1 1 0 2 1 2 1 1 0 0
0 2 1 1 0 2 1 2 1 1 0 1
0 2 1 1 0 2 1 2 1 1 0 2
0 2 1 1 0 2 1 2 1 1 1 0
0 2 1 1 0 2 1 2 1 1 1 1
0 2 1 1 0 2 1 2 1 1 1 2
0 2 1 1 0 2 1 2 1 1 2 0
0 2 1 1 0 2 1 2 1 1 2 1
0 2 1 1 0 2 1 2 1 1 2 2
0 2 1 1 0 2 1 2 1 2 0 0
0 2 1 1 0 2 1 2 1 2 0 1
0 2 1 1 0 2 1 2 1 2 0 2
0 2 1 1 0 2 1 2 1 2 1 0
0 2 1 1 0 2 1 2 1 2 1 1
0 2 1 1 0 2 1 2 1 2 1 2
0 2 1 1 0 2 1 2 1 2 2 0
0 2 1 1 0 2 1 2 1 2 2 1
0 2 1 1 0 2 1 2 1 2 2 2
0 2 1 1 0 2 1 2 2 0 0 0
0 2 1 1 0 2 1 2 2 0 0 1
0 2 1 1 0 2 1 2 2 0 0 2
0 2 1 1 0 2 1 2 2 0 1 0
0 2 1 1 0 2 1 2 2 0 1 1
0 2 1 1 0 2 1 2 2 0 1 2
0 2 1 1 0 2 1 2 2 0 2 0
0 2 1 1 0 2 1 2 2 0 2 1
0 2 1 1 0 2 1 2 2 0 2 2
0 2 1 1 0 2 1 2 2 1 0 0
0 2 1 1 0 2 1 2 2 1 0 1
0 2 1 1 0 2 1 2 2 1 0 2
0 2 1 1 0 2 1 2 2 1 1 0
0 2 1 1 0 2 1 2 2 1 1 1
0 2 1 1 0 2 1 2 2 1 1 2
0 2 1 1 0 2 1 2 2 1 2 0
0 2 1 1 0 2 1 2 2 1 2 1
0 2 1 1 0 2 1 2 2 1 2 2
0 2 1 1 0 2 1 2 2 2 0 0
0 2 1 1 0 2 1 2 2 2 0 1
0 2 1 1 0 2 1 2 2 2 0 2
0 2 1 1 0 2 1 2 2 2 1 0
0 2 1 1 0 2 1 2 2 2 1 1
0 2 1 1 0 2 1 2 2 2 1 2
0 2 1 1 0 2 1 2 2 2 2 0
0 2 1 1 0 2 1 2 2 2 2 1
0 2 1 1 0 2 1 2 2 2 2 2
0 2 1 1 0 2 2 2 0 2 1 2
0 2 1 1 0 2 2 2 0 2 2 2
0 2 1 1 2 2 1 2 0 2 1 1
0 2 1 1 2 2 1 2 2 2 1 1
0 2 2 1 0 0 0 0 0 2 2 2
0 2 2 1 0 0 0 1 0 2 2 2
0 2 2 1 0 0 0 2 0 2 2 2
0 2 2 1 0 0 1 0 0 2 2 2
0 2 2 1 0 0 1 1 0 2 2 2
0 2 2 1 0 0 1 2 0 2 2 2
0 2 2 1 0 0 2 0 0 2 2 2
0 2 2 1 0 0 2 1 0 2 2 2
0 2 2 1 0 0 2 2 0 2 2 2
0 2 2 1 0 1 0 0 0 2 2 2
0 2 2 1 0 1 0 1 0 2 2 2
0 2 2 1 0 1 0 2 0 2 2 2
0 2 2 1 0 1 1 0 0 2 2 2
0 2 2 1 0 1 1 1 0 2 2 2
0 2 2 1 0 1 1 2 0 2 2 2
0 2 2 1 0 1 2 0 0 2 2 2
0 2 2 1 0 1 2 1 0 2 2 2
0 2 2 1 0 1 2 2 0 2 2 2
0 2 2 1 0 2 0 0 0 2 2 2
0 2 2 1 0 2 0 1 0 2 2 2
0 2 2 1 0 2 0 2 0 2 2 2
0 2 2 1 0 2 1 0 0 2 2 2
0 2 2 1 0 2 1 1 0 2 2 2
0 2 2 1 0 2 1 2 0 2 1 2
0 2 2 1 0 2 1 2 0 2 2 2
0 2 2 1 0 2 2 0 0 2 2 2
0 2 2 1 0 2 2 1 0 2 2 2
0 2 2 1 0 2 2 1 1 2 2 2
0 2 2 1 0 2 2 2 0 2 1 2
0 2 2 1 0 2 2 2 0 2 2 2
0 2 2 1 1 0 0 0 0 2 2 2
0 2 2 1 1 0 0 1 0 2 2 2
0 2 2 1 1 0 0 2 0 2 2 2
0 2 2 1 1 0 1 0 0 2 2 2
0 2 2 1 1 0 1 1 0 2 2 2
0 2 2 1 1 0 1 2 0 2 2 2
0 2 2 1 1 0 2 0 0 2 2 2
0 2 2 1 1 0 2 1 0 2 2 2
0 2 2 1 1 0 2 2 0 2 2 2
0 2 2 1 1 1 0 0 0 2 2 2
0 2 2 1 1 1 0 1 0 2 2 2
0 2 2 1 1 1 0 2 0 2 2 2
0 2 2 1 1 1 1 0 0 2 2 2
0 2 2 1 1 1 1 1 0 2 2 2
0 2 2 1 1 1 1 2 0 2 2 2
0 2 2 1 1 1 2 0 0 2 2 2
0 2 2 1 1 1 2 1 0 2 2 2
0 2 2 1 1 1 2 2 0 2 2 2
0 2 2 1 1 2 0 0 0 2 2 2
0 2 2 1 1 2 0 1 0 2 2 2
0 2 2 1 1 2 0 2 0 2 2 2
0 2 2 1 1 2 1 0 0 2 2 2
0 2 2 1 1 2 1 1 0 2 2 2
0 2 2 1 1 2 1 2 0 2 2 2
0 2 2 1 1 2 2 0 0 2 2 2
0 2 2 1 1 2 2 1 0 2 2 2
0 2 2 1 1 2 2 1 1 2 2 2
0 2 2 1 1 2 2 2 0 2 2 2
0 2 2 1 2 0 0 0 0 2 2 2
0 2 2 1 2 0 0 1 0 2 2 2
0 2 2 1 2 0 0 2 0 2 2 2
0 2 2 1 2 0 1 0 0 2 2 2
0 2 2 1 2 0 1 1 0 2 2 2
0 2 2 1 2 0 1 2 0 2 2 2
0 2 2 1 2 0 2 0 0 2 2 2
0 2 2 1 2 0 2 1 0 2 2 2
0 2 2 1 2 0 2 2 0 2 2 2
0 2 2 1 2 1 0 0 0 2 2 2
0 2 2 1 2 1 0 1 0 2 2 2
0 2 2 1 2 1 0 2 0 2 2 2
0 2 2 1 2 1 1 0 0 2 2 2
0 2 2 1 2 1 1 1 0 2 2 2
0 2 2 1 2 1 1 2 0 2 2 2
0 2 2 1 2 1 2 0 0 2 2 2
0 2 2 1 2 1 2 1 0 2 2 2
0 2 2 1 2 1 2 2 0 2 2 2
0 2 2 1 2 2 0 0 0 2 2 2
0 2 2 1 2 2 0 1 0 2 2 2
0 2 2 1 2 2 0 2 0 2 2 2
0 2 2 1 2 2 1 0 0 2 2 2
0 2 2 1 2 2 1 1 0 2 2 2
0 2 2 1 2 2 1 2 0 2 2 2
0 2 2 1 2 2 2 0 0 2 2 2
0 2 2 1 2 2 2 1 0 2 2 2
0 2 2 1 2 2 2 2 0 2 2 2
1 1 2 1 1 0 2 2 0 2 2 2
1 1 2 1 1 2 2 2 0 2 2 2
1 2 2 1 0 2 2 1 0 2 2 2
1 2 2 1 0 2 2 1 1 2 2 2
1 2 2 1 1 2 2 1 0 2 2 2
1 2 2 1 1 2 2 1 1 2 2 2
2 1 1 1 0 2 1 2 2 0 1 2
2 1 1 1 0 2 1 2 2 2 1 2
2 2 1 1 0 2 1 2 0 2 1 1
2 2 1 1 0 2 1 2 2 2 1 1
2 2 1 1 2 2 1 2 0 2 1 1
0 2 1 1 0 2 1 2 0 0 0 0
0 2 1 1 0 2 1 2 0 0 0 1
0 2 1 1 0 2 1 2 0 0 0 2
0 2 1 1 0 2 1 2 0 0 1 0
0 2 1 1 0 2 1 2 0 0 1 1
0 2 1 1 0 2 1 2 0 0 1 2
0 2 1 1 0 2 1 2 0 0 2 0
0 2 1 1 0 2 1 2 0 0 2 1
0 2 1 1 0 2 1 2 0 0 2 2
0 2 1 1 0 2 1 2 0 1 0 0
0 2 1 1 0 2 1 2 0 1 0 1
0 2 1 1 0 2 1 2 0 1 0 2
0 2 1 1 0 2 1 2 0 1 1 0
0 2 1 1 0 2 1 2 0 1 1 1
0 2 1 1 0 2 1 2 0 1 1 2
0 2 1 1 0 2 1 2 0 1 2 0
0 2 1 1 0 2 1 2 0 1 2 1
0 2 1 1 0 2 1 2 0 1 2 2
0 2 1 1 0 2 1 2 0 2 0 0
0 2 1 1 0 2 1 2 0 2 0 1
0 2 1 1 0 2 1 2 0 2 0 2
0 2 1 1 0 2 1 2 0 2 1 0
0 2 1 1 0 2 1 2 0 2 1 1
0 2 1 1 0 2 1 2 0 2 1 2
0 2 1 1 0 2 1 2 0 2 2 0
0 2 1 1 0 2 1 2 0 2 2 1
0 2 1 1 0 2 1 2 0 2 2 2
0 2 1 1 0 2 1 2 1 0 0 0
0 2 1 1 0 2 1 2 1 0 0 1
0 2 1 1 0 2 1 2 1 0 0 2
0 2 1 1 0 2 1 2 1 0 1 0
0 2 1 1 0 2 1 2 1 0 1 1
0 2 1 1 0 2 1 2 1 0 1 2
0 2 1 1 0 2 1 2 1 0 2 0
0 2 1 1 0 2 1 2 1 0 2 1
0 2 1 1 0 2 1 2 1 0 2 2
0 2 1 1 0 2 1 2 1 1 0 0
0 2 1 1 0 2 1 2 1 1 0 1
0 2 1 1 0 2 1 2 1 1 0 2
0 2 1 1 0 2 1 2 1 1 1 0
0 2 1 1 0 2 1 2 1 1 1 1
0 2 1 1 0 2 1 2 1 1 1 2
0 2 1 1 0 2 1 2 1 1 2 0
0 2 1 1 0 2 1 2 1 1 2 1
0 2 1 1 0 2 1 2 1 1 2 2
0 2 1 1 0 2 1 2 1 2 0 0
0 2 1 1 0 2 1 2 1 2 0 1
0 2 1 1 0 2 1 2 1 2 0 2
0 2 1 1 0 2 1 2 1 2 1 0
0 2 1 1 0 2 1 2 1 2 1 1
0 2 1 1 0 2 1 2 1 2 1 2
0 2 1 1 0 2 1 2 1 2 2 0
0 2 1 1 0 2 1 2 1 2 2 1
0 2 1 1 0 2 1 2 1 2 2 2
0 2 1 1 0 2 1 2 2 0 0 0
0 2 1 1 0 2 1 2 2 0 0 1
0 2 1 1 0 2 1 2 2 0 0 2
0 2 1 1 0 2 1 2 2 0 1 0
0 2 1 1 0 2 1 2 2 0 1 1
0 2 1 1 0 2 1 2 2 0 1 2
0 2 1 1 0 2 1 2 2 0 2 0
0 2 1 1 0 2 1 2 2 0 2 1
0 2 1 1 0 2 1 2 2 0 2 2
0 2 1 1 0 2 1 2 2 1 0 0
0 2 1 1 0 2 1 2 2 1 0 1
0 2 1 1 0 2 1 2 2 1 0 2
0 2 1 1 0 2 1 2 2 1 1 0
0 2 1 1 0 2 1 2 2 1 1 1
0 2 1 1 0 2 1 2 2 1 1 2
0 2 1 1 0 2 1 2 2 1 2 0
0 2 1 1 0 2 1 2 2 1 2 1
0 2 1 1 0 2 1 2 2 1 2 2
0 2 1 1 0 2 1 2 2 2 0 0
0 2 1 1 0 2 1 2 2 2 0 1
0 2 1 1 0 2 1 2 2 2 0 2
0 2 1 1 0 2 1 2 2 2 1 0
0 2 1 1 0 2 1 2 2 2 1 1
0 2 1 1 0 2 1 2 2 2 1 2
0 2 1 1 0 2 1 2 2 2 2 0
0 2 1 1 0 2 1 2 2 2 2 1
0 2 1 1 0 2 1 2 2 2 2 2
0 2 1 1 0 2 2 2 0 2 1 2
0 2 1 1 0 2 2 2 0 2 2 2
0 2 1 1 2 2 1 2 0 2 1 1
0 2 1 1 2 2 1 2 2 2 1 1
0 2 2 1 0 0 0 0 0 2 2 2
0 2 2 1 0 0 0 1 0 2 2 2
0 2 2 1 0 0 0 2 0 2 2 2
0 2 2 1 0 0 1 0 0 2 2 2
0 2 2 1 0 0 1 1 0 2 2 2
0 2 2 1 0 0 1 2 0 2 2 2
0 2 2 1 0 0 2 0 0 2 2 2
0 2 2 1 0 0 2 1 0 2 2 2
0 2 2 1 0 0 2 2 0 2 2 2
0 2 2 1 0 1 0 0 0 2 2 2
0 2 2 1 0 1 0 1 0 2 2 2
0 2 2 1 0 1 0 2 0 2 2 2
0 2 2 1 0 1 1 0 0 2 2 2
0 2 2 1 0 1 1 1 0 2 2 2
0 2 2 1 0 1 1 2 0 2 2 2
0 2 2 1 0 1 2 0 0 2 2 2
0 2 2 1 0 1 2 1 0 2 2 2
0 2 2 1 0 1 2 2 0 2 2 2
0 2 2 1 0 2 0 0 0 2 2 2
0 2 2 1 0 2 0 1 0 2 2 2
0 2 2 1 0 2 0 2 0 2 2 2
0 2 2 1 0 2 1 0 0 2 2 2
0 2 2 1 0 2 1 1 0 2 2 2
0 2 2 1 0 2 1 2 0 2 1 2
0 2 2 1 0 2 1 2 0 2 2 2
0 2 2 1 0 2 2 0 0 2 2 2
0 2 2 1 0 2 2 1 0 2 2 2
0 2 2 1 0 2 2 1 1 2 2 2
0 2 2 1 0 2 2 2 0 2 1 2
0 2 2 1 0 2 2 2 0 2 2 2
0 2 2 1 1 0 0 0 0 2 2 2
0 2 2 1 1 0 0 1 0 2 2 2
0 2 2 1 1 0 0 2 0 2 2 2
0 2 2 1 1 0 1 0 0 2 2 2
0 2 2 1 1 0 1 1 0 2 2 2
0 2 2 1 1 0 1 2 0 2 2 2
0 2 2 1 1 0 2 0 0 2 2 2
0 2 2 1 1 0 2 1 0 2 2 2
0 2 2 1 1 0 2 2 0 2 2 2
0 2 2 1 1 1 0 0 0 2 2 2
0 2 2 1 1 1 0 1 0 2 2 2
0 2 2 1 1 1 0 2 0 2 2 2
0 2 2 1 1 1 1 0 0 2 2 2
0 2 2 1 1 1 1 1 0 2 2 2
0 2 2 1 1 1 1 2 0 2 2 2
0 2 2 1 1 1 2 0 0 2 2 2
0 2 2 1 1 1 2 1 0 2 2 2
0 2 2 1 1 1 2 2 0 2 2 2
0 2 2 1 1 2 0 0 0 2 2 2
0 2 2 1 1 2 0 1 0 2 2 2
0 2 2 1 1 2 0 2 0 2 2 2
0 2 2 1 1 2 1 0 0 2 2 2
0 2 2 1 1 2 1 1 0 2 2 2
0 2 2 1 1 2 1 2 0 2 2 2
0 2 2 1 1 2 2 0 0 2 2 2
0 2 2 1 1 2 2 1 0 2 2 2
0 2 2 1 1 2 2 1 1 2 2 2
0 2 2 1 1 2 2 2 0 2 2 2
0 2 2 1 2 0 0 0 0 2 2 2
0 2 2 1 2 0 0 1 0 2 2 2
0 2 2 1 2 0 0 2 0 2 2 2
0 2 2 1 2 0 1 0 0 2 2 2
0 2 2 1 2 0 1 1 0 2 2 2
0 2 2 1 2 0 1 2 0 2 2 2
0 2 2 1 2 0 2 0 0 2 2 2
0 2 2 1 2 0 2 1 0 2 2 2
0 2 2 1 2 0 2 2 0 2 2 2
0 2 2 1 2 1 0 0 0 2 2 2
0 2 2 1 2 1 0 1 0 2 2 2
0 2 2 1 2 1 0 2 0 2 2 2
0 2 2 1 2 1 1 0 0 2 2 2
0 2 2 1 2 1 1 1 0 2 2 2
0 2 2 1 2 1 1 2 0 2 2 2
0 2 2 1 2 1 2 0 0 2 2 2
0 2 2 1 2 1 2 1 0 2 2 2
0 2 2 1 2 1 2 2 0 2 2 2
0 2 2 1 2 2 0 0 0 2 2 2
0 2 2 1 2 2 0 1 0 2 2 2
0 2 2 1 2 2 0 2 0 2 2 2
0 2 2 1 2 2 1 0 0 2 2 2
0 2 2 1 2 2 1 1 0 2 2 2
0 2 2 1 2 2 1 2 0 2 2 2
0 2 2 1 2 2 2 0 0 2 2 2
0 2 2 1 2 2 2 1 0 2 2 2
0 2 2 1 2 2 2 2 0 2 2 2
1 1 2 1 1 0 2 2 0 2 2 2
1 1 2 1 1 2 2 2 0 2 2 2
1 2 2 1 0 2 2 1 0 2 2 2
1 2 2 1 0 2 2 1 1 2 2 2
1 2 2 1 1 2 2 1 0 2 2 2
1 2 2 1 1 2 2 1 1 2 2 2
2 1 1 1 0 2 1 2 2 0 1 2
2 1 1 1 0 2 1 2 2 2 1 2
2 2 1 1 0 2 1 2 0 2 1 1
2 2 1 1 0 2 1 2 2 2 1 1
2 2 1 1 2 2 1 2 0 2 1 1
2 2 1 1 2 2 1 2 2 2 1 1
)

   text=. LF sr '.' 0 : 0
#((
#abc
#defg
#)
#lmn
#)
)
    W       =.  _12 ]\ 1 1 2 1 1 0 2 2 0 2 2 2    1 1 2 1 1 2 2 2 0 2 2 2    2 1 1 1 0 2 1 2 2 0 1 2    2 1 1 1 0 2 1 2 2 2 1 2


	fXm_ijrd =: adverb define
		T        =. '.' = ]
	    fsm      =.  (< Atop  '`F S M'   =.  1:`( (_2 ]\^:2 m )"_ )`( (T a. )"_ )) `: 0
	    ijrd     =.  (        '`I J R D' =.  1:`0:`(T f.@:{.)`1:) `: 0
	    fsm_ijrd =. fsm (,<) ijrd
	    rmcol2   =. ;:~ fsm_ijrd
	    rmcol2 f.
)

   'a1 b1'=:4!:5&.> i.2  NB.  Local and global assigment can't happen for the same name under 'load'

   ('`',;:^:_1 VERBS =. 'res', L:0 ":&.>i. # W)=:3 : ('Y =. y fXm_ijrd';' 5!:1{.;:''Y''')"1 W

   'a1 b1' =:  4!:5&.> i._2
   b1      =:  (;:'a1 b1') -.~(#~ =&({.;:'_base_'))/ |: (split~ i:&2@:(* +/\.)@:=&'_')&> a1

   tiny    =: 10000 H  b1 'x.x.xx'
   small   =:  1000 H  b1 text
   medium  =:   100 H  b1 4e4$;T=.3}.<@:({&('.',ALPHANUM) )@:;@:(<@:(+/\);.1 1: 0} -.)@:#:"0 i.2^6
   large   =:     1 H  b1 5e6$;T

   ]A      =: (time_rpt ".&.>) nnj =: ;: 'tiny small medium large'




<. 100 * (%"1 <./)"2 KiU { S: 0 ~ winners =. b1 i. b1 {.@:/: S: 1 0 KiU=:>@:(L.&>`(,:&(< _ _))})@:({:"1)@:".&.> nnj
