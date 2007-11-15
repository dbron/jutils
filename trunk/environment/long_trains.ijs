require'task strings files jmf'

NB.  Binary search
bs=: adverb define
:
	m =. _

	while. x <: y do.
		m =. <.-:x+y
		smoutput 'trying...',":m	
		if. m u x,y  do.
			x =. >: m
		else. 
			y =. <: m 
		end.
	end.

	x,m,y
)

t  =:  conjunction define
	NB.  n  is the J code to execute
	NB.  u  is the verb to apply to the results
	u 'jconsole' spawn~ ; ,&(toHOST LF) L: 0 boxxopen n
)

c  =:  adverb define
	NB.  m  is the J code to execute
	NB.  returns boolean indicating whether J crashed
	dlb =. }.~ e.&(CR,LF,TAB,' ') i. 0:
	('done' -: 4 {. dlb) t (1 |. '0 0 $ 1!:2&2 ''done'' ' ; m)
)

NB. =========================================================
NB.  Different ways to build large trains, what are their 
NB.  limits?

t0 =:  dyad define
	NB.  1e4 t0 bs 1e5
	NB.  65534 works, 65535 is limit error
	'limit'&(1 - 1 e. E.) t ('+ 1 :(}:^:(''@''-:{:)','$''-@'')',~":x) 
)

t1 =:  dyad define
	NB.  1e5 t1 bs 1e6
	NB.  139791 works, 139792 crashes.
	('a=.(','$-`-)`:6',~":x) c
)

t2a=:  dyad define
	NB.  1e4 t2a bs 1e5
	NB.  39997 applies verb to argument, 39998 is stack error. 
	'stack'&(1 - 1 e. E.) t  ('(', '$''-'') 128!:2 ''a'' ',~ ": x)
)

NB.  39998 t2b bs 1e6
NB.  419381 is stack error, 419382 crashes.
t2b=:  -.@:t2a  

t3 =:  dyad define
	NB.  1e5 t3 bs 1e6	
	NB.  139787 works, 139788 crashes
	('".''a=.'',', '$''-''',~ ": x) c
)

NB. =========================================================
NB.  All the above methods relied upon J's tree-building
NB.  parser. Try generating the train by hand, instead. First,
NB.  build  the gerund (atomic rep) form of the verb then 
NB.  evoke it in some way.  For example, 
NB.    *  ar 5!:0
NB.    *  '`name dummy'=.ar`+   NB.  Why doesn't just  '`name' =. ar  work?
NB.    *  ar`:6
NB.    *  Maybe things like   
NB.       *  +:^:(ar`]) 
NB.       *  ar`]} 
NB.       *  ar/ 
NB.  
NB.  But I can't test this, because I can't generate the 
NB.  gerund. the obvious J-way using iterative or recursive 
NB.  boxing hangs forever or eventually signals out of memory.
NB.  And building the  3!:1  rep by hand crashes when 3!:2
NB.  is applied, so I can't manifest the gerund in memory
NB.  to investigate.
NB.
NB.  This latter crash may be because J can't handle 
NB.  structures nested that deeply, or it may be because
NB.  I'm creating the structure improperly (Offsets
NB.  to deeper boxes may be out of range?  This seems
NB.  doubtful because the algorithm to double the train
NB.  is invariant up to the point of crashing; but maybe
NB.  eventually the pointers get so deep Roger changes
NB.  the structure of the noun?).

NB.  Build the train by hand:
NB.  Linear growth, too slow.
lsd  =:  -`''
lg   =:  <@:((<,'3') (,<)  -`- , ])^:(|.lsd"_`])

NB.  Exponential growth, too fat.
NB.  Note that  5!:0  is a bit permissive:
NB.
NB.   (< (,'3') ; < (;:'--') ,<^:1 (,'3'); <;:'---')5!:0
NB.   (< (,'3') ; < (;:'--') ,<^:2 (,'3'); <;:'---')5!:0
NB.
NB.  are both valid representations of the same verb.
esd   =:  lg 1 
assert esd -: (- - -) 1 : '5!:1{.;:''u'''

NB. wrt permissivness noted, egX produces
NB. the "extra boxing" form of the verbs. It still
NB. produces the proper gerunds, but they're fatter.
egX   =:     [^:(] -:&(>lg 1))L:_ 2~^:(|. (lg 2)"_`] )
eg    =:  >@:[^:(] -:&(>lg 1))L:_ 2~^:(|. (lg 2)"_`] )

assert (eg 0) -: lg 2
assert (eg 1) -: lg 3
assert (eg 2) -: lg 5
assert (eg 3) -: lg 9  NB.  And so on

NB.  Exponential growth by manipulating  3!:1  strings.
NB.
NB.  The phrase  (eg N) -: 3!:2 ] N train trd  is a tautolgy.
NB.
NB.  That is, train and eg produce identical gerunds
NB.  only  train  produces it faster and leaner, in the
NB.  3!:1  format.  
NB.
NB.  However, while  3!:2 ] 14 train tsd works fine,
NB.  the phrase  3!:2 ] 15 train tsd  crashes J.
NB.
NB.  I think this crash is different from the tree-builder
NB.  crash, but am not positive.  Certainly, given:
NB.        B =: (A=: 3!:2 ] 14 train tsd) 5!:0
NB.        #;:5!:5{.B`''    NB. ({.-`'') +/@:= <S:0 A  is too slow
NB.     32771
NB.  the depth of the tree (the number of verbs in the train) 
NB.  is less than the  139792  required to crash  (n$-`-)`:6 
NB.  for example.  But since  tsd  only doubles the train length 
NB.  at each iteration, we'd require about 17 (2^.139792) iterations.
NB.  So since  tsd  crashes at 15 iterations, I can't be sure this is
NB.  the same crash.  Certainly it's not a way around the train length
NB.  limit.
tsd   =: eg 0
train =: dyad define

	HEADERLEN =. 176
	JUMP      =. HEADERLEN -~ # d =. 3!:1 y 


	I         =. 156 + +/\  0 4 8   4
	D         =.           30 1 1 _17
	j         =. 0.5
	
	fn        =. jpath '~temp\T_z_.jmf'

NB.	createjmf_jmf_ fn;HEADERLEN + JUMP * 2^x
NB.    JCHAR map_jmf_ 'T_z_';fn

	T         =. d

	for. i. x do.

		f     =. HEADERLEN}.T

		i     =. I +  JUMP * j =. +: j
		t     =. a.{~D+a.i.i{T

		T     =. t i}T
	    T     =. T,f

	end.

NB.	E =. a: { T_z_  NB.  copy by value (until Roger "fixes" it)

NB.	ferase fn [ erase 'T_z_' [ unmap_jmf_ :: 0: 'T_z_'

NB.	E

	T
)

assert (eg 0) -: 3!:2 (0 train tsd)
assert (eg 1) -: 3!:2 (1 train tsd)
assert (eg 2) -: 3!:2 (2 train tsd)  NB.  And so on

NB.  However, while 3!:2 ] 14 train tsd   works fine,
NB.  3!:2 ] 15 train tsd   crashes.
