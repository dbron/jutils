NB.  Fix local names.
NB.  EG:     NB.  Put these lines in a script (seperate file):
NB.  EG:     
NB.  EG:	   local   =. +
NB.  EG:	   global  =: -
NB.  EG:	   r       =. global local %
NB.  EG:
NB.  EG:	   f       =: r fl
NB.  EG:	   g       =: (global local r global -) fl
NB.  EG:     
NB.  EG:     NB.  End of script
NB.  EG:    
NB.  EG:     load'name_of_your_script.ijs' 
NB.  EG:
NB.  EG:     f
NB.  EG:  global + %
NB.  EG:  
NB.  EG:     g
NB.  EG:  global + (global + %) global -
NB.  EG: 
NB.  EG:     require 'strings'
NB.  EG: 
NB.  EG:     # 1 : ('w=.[: u&.> cut';'w   ')  
NB.  EG: |value error: w
NB.  EG: 
NB.  EG:     # 1 : ('w=.[: u&.> cut';'w f.')  
NB.  EG:  [: #&.> 3 : ''' ''&$: :([: -.&a: <;._2@,~) y' :(4 : 'x '' ''&$: :([: -.&a: <;._2@,~) y')
NB.  EG: 
NB.  EG:     # 1 : ('w=.[: u&.> cut';'w fl')
NB.  EG:  [: #&.> cut


NB.  The verb 'peel' takes one name-layer off its argument,
NB.  which is a string giving a name (local or global). Have
NB.  to use "do" so we retain the lexical scope of our caller.
peel     =:  [: ". '{. 5!:1 {. ;: '' ' , '''' ,~ ]
NB.  Adverbial version of "peel", so that instead of saying
NB.  peel'foo'  we can say  foo Peel  (so we don't have to
NB.  quote names) or even pass anonymous verb arguments like
NB.  (+/ # foo) Peel.
NB.
NB. Peel     =:  1 : 'peel ''u'' ' NB. ' > {. u`[ 'NB. ~  NB. We can use an explicit def here, because 'u' is special  in exp. defs (it doesn't hide behind its name).
Peel     =:  1 : '{. u + 1 : ((''`'' ; ''&;'') {::~ noun -: nc {.;:''m'') a:'
NB.  Keep peeling layers until no local names are left.
NB.  Could I use  $:@resolve  and elide the  ^:_  ?  I think there's a subtle bug in that method.
resolve  =:  >@:peel^:({.@:ns_hasLOCAL :: 0: *. 1 = #@:$) L: 0^:_  
NB.
NB.  An adverb, like  f.  , that only fixes local names.
NB. 
NB. fl   =: `({.;:'Peel') (resolve`) (`:6) (5!:0)     NB.   The "{.;:'Peel'" trick is because the train  (conjunction adverb) is a syntax error.
NB. fl   =:  Peel (`(;:'`')) (`]) ({.`)  (`:6) (5!:0)  NB.  The (`(;:'`'))   trick is because C0 C1 is a syntax error.  
fl       =: Peel ("_) (`(;:'a:')) (resolve `) (`:6) (5!:0) 



NB.  For a list of (boxed) names y, returns a table of booleans
NB.  indicating whether the corresponding name has local and/or
NB.  global scope (that "and/or" is just for you, Devon! ;)
NB.
NB.  The shape of the output is  shape  2 ,~ #y  and the verb 
NB.  is defined such that the first column indicates whether
NB.  the name is defined locally, and the last indicates  
NB.  whether the name is defined globally.  Note that those two
NB.  possibilities are not mutually exclusive.
nameScope  =: (( (~: ,. *.&:(~:&_1))  ({~ i.&1@:~:&_1 <. _1 + #)"1 )&:(([ #!._1^:_1: 15!:6@:# )"1~ _1 < nc) [: ;&.> @:{ 1j1 1j1 #!.(<<'_')   ] ,&< (, |.@:copath)@:coname@:(''"_) )@:(;:^:(0 = L.))



NB.  This verb encapsulates the possibile outputs of 
NB.  nameScope. 
ns         =:  #.@:nameScope
NB.  The noun ns_RC lists all possible return codes, and the 
NB.  corresponding noun  ns_ENUM  gives their meanings.  The 
NB.  set of nouns  
NB.
NB.             ns_UNASSIGNED,ns_GLOBAL,ns_LOCAL,ns_SHADOWED 
NB. 
NB.  allow you to compare against the output of  ns  without 
NB.  having "magic numbers" in your code.
NB.
NB.  Finally, the verb  ns_type  is good for debugging: give 
NB.  it a list of names, and it'll output the corresponding 
NB.  readable elements from  ns_ENUM  .
NB.
NB.  EG:  3 : 'ns_type ;:''y each nada both'' [ both=. 14' both_z_ =: 22
(       nss=.'ns_'   ,L:0 ns_ENUM)  =: ns_RC =: i.#ns_ENUM =: ;:'UNASSIGNED GLOBAL LOCAL SHADOWED'
ns_type                             =: ;:^:(0 = L.) ,. ns_ENUM {~ ns_RC i. ns


NB.  The next few lines define some utility verbs.  The first
NB.  set indicate iff the name has the attribute (that's if
NB.  and ONLY if.  If a name is shadowed, it's NOT [stricty]
NB.  local).  The set is:
NB. 
NB.       ns_isUNASSIGNED  the name is not used (or is
NB.                        invalid)
NB.       ns_isLOCAL       if evoked, would get def from local
NB.                        symbol table
NB.       ns_isGLOBAL      has a definition in a global 
NB.                        symbol table.
NB.       ns_isSHADOWED    local definition overrides global
NB.                        definitition.
NB.          
NB.  EG:     3 : 'ns_isUNASSIGNED '   'nada''   '                     NB.  equivalent to ns_UNASSIGNED = ns
NB.  EG:     3 : 'ns_isLOCAL          ''y''     '                     NB.  equivalent to ns_LOCAL      = ns
NB.  EG:     3 : 'ns_isGLOBAL         ''each''  '                     NB.  equivalent to ns_GLOBAL     = ns
NB.  EG:     3 : 'ns_isSHADOWED both=.''both''  ' both =: 'global'    NB.  equivalent to ns_SHADOWED   = ns
NB.
NB.  The second set of verbs indicate if a name HAS the 
NB.  attribute (e.g., if a name is shadowed, it HAS local).
NB.  The set is:
NB.
NB.       ns_hasLOCAL`ns_hasGLOBAL 
NB.
NB.  EG:     3 : '(ns_hasLOCAL  > ns_isLOCAL ) both=.''both'' ' both =: 'global'
NB.  EG:     3 : '(ns_hasGLOBAL > ns_isGLOBAL) both=.''both'' ' both =: 'global'
parenclose =.  '(' , ')' ,~ ]
join       =.  -@:#@:[ }. ;@:(,&.> boxopen)~
('`', ;:^:_1 'ns_is' ,L:0 ns_ENUM)  =: ". '`' join nss parenclose@:, L: 0 ' = ns'
('`', ;:^:_1 'ns_has',L:0 lg       )=:".'`'  join ' e.~ ns' parenclose@:, L: 0 ~ parenclose@:(','&join)&.> ('ns_' ,L:0 { ) 's lg'=. split |.}. ns_ENUM
