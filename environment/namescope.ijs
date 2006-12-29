NB.  For a list of (boxed) names y, returns a boolean table with shape  2 ,~ #y
NB.
NB.  The verb is defined such 
NB.  that {."1@:nameScope indicates which names are defined locally (i.e. which, if evoked, would pull their values from the __local__ symbol table).
NB.  and  {:"1@:nameScope indicates whether the name is defined globally.
NB.  So, +./"1@:nameScope indicates which names are defined (same as   _1 < nc ),
NB.  and </ "1@:nameScope indicates which names will come from a global name table.
NB.  and >/ "1@:nameScope indicates which names are strictly local.
NB.  and =/ "1@:nameScope indicates which names are locals shadowing globals
nameScope  =: (( (~: ,. *.&:(~:&_1))  ({~ i.&1@:~:&_1 <. _1 + #)"1 )&:(([ #!._1^:_1: 15!:6@:# )"1~ _1 < nc) [: ;&.> @:{ 1j1 1j1 #!.(<<'_')   ] ,&< (, |.@:copath)@:coname@:(''"_) )@:(;:^:(0 = L.))
NB.
NB.  The four possibilities above are encapsulted in this verb:
ns         =:  #.@:nameScope
NB.  define some utility names:
NB.  First, list of all possible return codes:  ns_RC ,
NB.  and the attribuates associated with those return codes: ns_ENUM
NB.  and one name per return code, ns_UNASSIGNED, ns_GLOBAL, ns_LOCAL, ns_SHADOWED .
NB.
NB.  EG:  3 : 'ns_type ;:''y each nada both'' [ both=. 14' both_z_ =: 22
NB.
NB.  Then, define some verbs based on those names.  The first set of verbs 
NB.  indicate  iff  the name has the attribute (that's if and ONLY if.
NB.  If a name is shadowed, it's NOT [stricty] local): ns_isUNASSIGNED`ns_isLOCAL`ns_isGLOBAL`ns_isSHADOWED 
NB.         
NB.
NB.  EG:  3 : 'ns_isUNASSIGNED '   'nada''   '                     NB.  equivalent to ns_UNASSIGNED = ns
NB.  EG:  3 : 'ns_isLOCAL          ''y''     '                     NB.  equivalent to ns_LOCAL      = ns
NB.  EG:  3 : 'ns_isGLOBAL         ''each''  '                     NB.  equivalent to ns_GLOBAL     = ns
NB.  EG:  3 : 'ns_isSHADOWED both=.''local'' ' both =: 'global'    NB.  equivalent to ns_SHADOWED   = ns
NB.
NB.  The second set of verbs indicate if a name HAS the attribute  
NB.  (e.g., if a name is shadowed, it HAS local): ns_hasLOCAL`ns_hasGLOBAL 
NB.
NB.  EG:  3 : '(ns_hasLOCAL  > ns_isLOCAL ) both=.''local'' ' both =: 'global'
NB.  EG:  3 : '(ns_hasGLOBAL > ns_isGLOBAL) both=.''local'' ' both =: 'global'
(       nss=.'ns_'   ,L:0 ns_ENUM)  =: ns_RC =: i.#ns_ENUM =: ;:'UNASSIGNED GLOBAL LOCAL SHADOWED'
ns_type                             =: ;:^:(0 = L.) ,. ns_ENUM {~ ns_RC i. ns
('`', ;:^:_1 'ns_is' ,L:0 ns_ENUM)  =: ". '`' join nss parenclose@:, L: 0 ' = ns'
('`', ;:^:_1 'ns_has',L:0 lg       )=:".'`'  join ' e.~ ns' parenclose@:, L: 0 ~ parenclose@:(','&join)&.> ('ns_' ,L:0 { ) 's lg'=. split |.}. ns_ENUM

NB.  An adverb, like  f.  , that only fixes local names.
NB.  In a in a script or an explicit definition, try:
NB.  EG:   0!:011 (0 : 0)
NB.  EG:	   local    =. 4
NB.  EG:	   localv   =. +
NB.  EG:	   global   =: 45612
NB.  EG:	   globalv  =: +:
NB.  EG:	   r        =. local localv global globalv ]
NB.  EG:  
NB.  EG:	   A        =:  r fl
NB.  EG:	   B        =:  (local localv global globalv r) fl
NB.  EG:   )  
NB.  EG:
NB.  EG:   A  is now  4 + 45612 globalv ]
NB.  EG:   B  is now  4 + 45612 globalv 4 + 45612 globalv ]
NB.
NB.  The verb 'peel' takes one name-layer off its argument,
NB.  which is a string giving a name (local or global).
NB.  Have to use "do" so we retain the lexical scope of our caller.
peel     =:  [: ". '{. 5!:1 {. ;: '' ' , '''' ,~ ]
NB.
NB.  Adverbial version of "peel", so that instead of:
NB.  saying   peel'foo'  we can say  foo Peel  (so we don't have 
NB.  to quote names) or even pass anonymous verb arguments like
NB.  (+/ # foo) Peel.
NB.
NB.  We can use an explicit def here, because 'u' is special 
NB.  in exp. defs (it doesn't hide behind its name).
Peel     =:  1 : 'peel ''u'' ' NB. ' > {. u`[ 'NB. ~
NB.
NB.  Keep peeling layers until no local names are left
resolve  =:  >@:peel^:({.@:ns_isLOCAL :: 0:) L: 0^:_
NB.
NB.  Fix local names.  The "{.;:'Peel'" trick is because
NB.  conjunction-adverb is a syntax error.  I could have also
NB.  said (`5!:1{.;:'Peel').
fl       =:  fixLocal =:`({.;:'Peel') (resolve`) (`:6) (5!:0)