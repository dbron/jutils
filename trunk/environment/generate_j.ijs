NB.  Utility functions
idx0         =:  $ #: I.@:,
ts           =:  6!:2 , 7!:2@:]
ats          =:  4 : ('y =. y 5!:0';'100 ts ''y x'' ')"_ 0
a2l          =:  3 : ('y =. y 5!:0';'5!:5{.;:''y''')"0@:]
l2a          =:  3 : ('y =. 3 : (y -. CR)"0';'{. y`[')&.> 

NB.  Cover to D. which corrects rank; due to Hui.
D            =:  2 : 'u"0 D. v'

NB.  Names assigned.
nms          =:  ;:'lngamma digamma trigamma tetragamma'

NB.  Different formulation of each name...
LNGAMMAS     =:       ^.@:!@:<:   `(1x1 ^. !@:<:)
DIGAMMAS     =:  1 {. lngamma D 1`[
TRIGAMMAS    =:       lngamma D 2`(digamma D 1)
TETRAGAMMAS  =:       lngamma D 3`(digamma D 2)` (trigamma D 1)

GAMMAS       =:  LNGAMMAS;DIGAMMAS;TRIGAMMAS;<TETRAGAMMAS

NB.  Set of all formulations.
G            =:  (nms ,. ({.;:'=.') ,. <@:a2l"0 )&.> { GAMMAS
G            =:  ;:^:_1&.> G 
G            =:  l2a G ,&.> <LF,':0 y',~;'`',&.>~nms

NB.  Test data
TEST_IN      =:  (i: % <.@:%:) 10
NB.  Obviously, in real life, the canonical test results would come 
NB.  from elsewhere; maybe an external file. Here, I appoint a random
NB.  formulation "canonical"
TEST_OUT     =:  ( G {~ < <"0 IDX =: ?.$ G ) 5!:0  TEST_IN

NB.  Set of all candidate results
R            =:  G`:0  TEST_IN

NB.  All formulations with correct results.
WINNERS      =:  R idx0@:(-:"(#$TEST_OUT)) TEST_OUT

NB.  Sanity check
assert IDX e. WINNERS

NB.  Fastest, leanest, correct formulation.
WINNER       =: 1 }. _3 }. ];._2 LF ,~ TEST_IN  (a2l {.@:/: ats) G {~ <"1 <"0 WINNERS
