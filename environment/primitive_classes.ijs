GRAPHICS     =: '!"#$%&''()*+,-./:;<=>?@[\]^_`{|}~'
UCALPHA      =: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
LCALPHA      =: 'abcdefghijklmnopqrstuvwxyz'
ALPHA        =: LCALPHA,UCALPHA
INFLECTIONS  =: '.: '

CLASS_NAMES  =: ;: 'ERROR INVALID UNUSED NOUN ADVERB CONJUNCTION VERB'
CLASSES      =:        _3      _2     _1    0      1           2    3 
(CLASS_NAMES)=:CLASSES

combinations =. { (< GRAPHICS,ALPHA), 2 # < INFLECTIONS  NB.  Graphs, digraphs, trigraphs
PRIM_CANDS   =: (names =. ,&.> ALPHA) -.~ ~. {.@:;: ::<  &> , combinations
PRIM_CLASSES =: ((CLASS_NAMES , ]) <@:}./.~ CLASSES , 3 : (' ". ''p =. '', y ';'nc{.;:''p'' ') :: (ERROR"_) &>) PRIM_CANDS
PRIM_NAMES   =: 'PRIM_', L: 0'S',L:0~ CLASS_NAMES {~ <<<  badIdx =. CLASSES i. ERROR,INVALID,UNUSED
(PRIM_NAMES) =:  PRIM_CLASSES =: PRIM_CLASSES     {~ <<<  badIdx

NB.   #PRIM_VERBS 
NB.72
NB.  (;:^:_1) 15 {. PRIM_VERBS 
NB.! ". ": #. #: # $. $: $ %. %: % *. *: *
