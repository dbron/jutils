a =: (- - -) 1 : '5!:1{.;:''u''' 

w0=:[^:(] -:&(>a))L:_ 2~^:0 <@:(({.;:'3') (,<)  -`- , ]) a
w1=:[^:(] -:&(>a))L:_ 2~^:1 <@:(({.;:'3') (,<)  -`- , ]) a
w2=:[^:(] -:&(>a))L:_ 2~^:2 <@:(({.;:'3') (,<)  -`- , ]) a
w3=:[^:(] -:&(>a))L:_ 2~^:3 <@:(({.;:'3') (,<)  -`- , ]) a
w4=:[^:(] -:&(>a))L:_ 2~^:4 <@:(({.;:'3') (,<)  -`- , ]) a
w5=:[^:(] -:&(>a))L:_ 2~^:5 <@:(({.;:'3') (,<)  -`- , ]) a

W0=:3!:1 w0
W1=:3!:1 w1
W2=:3!:1 w2
W3=:3!:1 w3
W4=:3!:1 w4
W5=:3!:1 w5

require 'files jmf'
train =: dyad define


	HEADERLEN =. 156
	OFFSET    =. HEADERLEN+4

	I         =. +/\ 0 ,4 * >: 0j13 1j11 1j3 1j1#_ 1 2 2
	NB.              0  4  4   4   4    4  4 4  4  4   4    4   4  4  8   4   4   4    4 4  4  4  4   4    4  4 12   4    4  4 12   4
	D         =.    _1 _1 18 197 _20 _223 _1 1 27 51 174 _223 _31 _2 48 193 _24 _77 _224 1 31 55 79 180 _223 _1 44 180 _223 _1 44 180


	fn        =. jpath '~temp\T1.jmf'
	erase 'T1' [ unmap_jmf_ :: 0: 'T1'
	ferase fn

	createjmf_jmf_ fn;HEADERLEN + (HEADERLEN-4)*2^x
    JCHAR map_jmf_ 'T1';fn

	T1         =: 3!:1 y

	for_w. i. x do.
		smoutput w

		f     =. HEADERLEN}.T1

		i     =. OFFSET+I
		t     =. a.{~D+a.i.i{T1
		OFFSET=.  +: _4 + OFFSET 

		T1     =: t i}T1
	    T1     =: T1,f

	end.

	T1
)

  lg =: <@:((<,'3') (,<)  -`- , ])^:(|.( -`'')"_`])
lg


NB.  This will crash
ASS=:3!:2 ] 15 train <@:(({.;:'3') (,<)  -`- , ]) a

NB. =========================================================
NB.  Trying to make a cleaner version.
NB.
NB.
NB. NB. Older version of train.  
NB. NB. wrt permissivness noted, trainX produces
NB. NB. the "extra boxing" form of the verbs. It 
NB. NB. is identical to  egX  .  It crashes at
NB. NB. 3!:2 ] 15 trainX egX 0   NB.  14  works fine
NB. tsdX   =: egX 0
NB. trainX =: dyad define
NB.
NB.
NB. 	HEADERLEN =. 156
NB. 	OFFSET    =. HEADERLEN+4
NB.
NB. 	I         =. +/\ 0 ,4 * >: 0j13 1j11 1j3 1j1#_ 1 2 2
NB. 	NB.              0  4  4   4   4    4  4 4  4  4   4    4   4  4  8   4   4   4    4 4  4  4  4   4    4  4 12   4    4  4 12   4
NB. 	D         =.    _1 _1 18 197 _20 _223 _1 1 27 51 174 _223 _31 _2 48 193 _24 _77 _224 1 31 55 79 180 _223 _1 44 180 _223 _1 44 180
NB.
NB. 	fn        =. jpath '~temp\T1_z_.jmf'
NB.
NB. 	createjmf_jmf_ fn;HEADERLEN + (HEADERLEN-4)*2^x
NB.     JCHAR map_jmf_ 'T1_z_';fn
NB.
NB. 	T1_z_     =: 3!:1 y
NB.
NB. 	for_w. i. x do.
NB. 		f     =. HEADERLEN}.T1_z_
NB.
NB. 		i     =. OFFSET+I
NB. 		t     =. a.{~D+a.i.i{T1_z_
NB. 		OFFSET=.  +: _4 + OFFSET 
NB.
NB. 		T1_z_ =: t i}T1_z_
NB. 	    T1_z_ =: T1_z_,f
NB.
NB. 	end.
NB.
NB. 	E =: a: { T1_z_  NB.  copy by value (until Roger "fixes" it)
NB.
NB. 	ferase fn [ erase 'T1_z_' [ unmap_jmf_ :: 0: 'T1_z_'
NB.
NB.     E
NB. )
NB.
NB. assert (egX 0) -:  3!:2 ] 0 trainX  egX 0
NB. assert (egX 1) -:  3!:2 ] 1 trainX  egX 0
NB. assert (egX 2) -:  3!:2 ] 2 trainX  egX 0  NB.  And so on
NB.
NB.
NB. tsdX2   =: egX 0
NB. trainX2 =: dyad define
NB.
NB.
NB. 	HEADERLEN =. 156
NB. 	JUMP      =. HEADERLEN -~ # d =. 3!:1 y
NB.
NB. 	I         =. 160 ++/\ 0 ,4 * >: 0j13 1j11 1j3 1j1#_ 1 2 2
NB. 	D         =. _1 _1 18 197 _20 _223 _1 1 27 51 174 _223 _31 _2 48 193 _24 _77 _224 1 31 55 79 180 _223 _1 44 180 _223 _1 44 180
NB. 	j         =. 0.5
NB.
NB. 	fn        =. jpath '~temp\T2_z_.jmf'
NB.
NB. 	createjmf_jmf_ fn;HEADERLEN + JUMP * 2^x
NB.     JCHAR map_jmf_ 'T2_z_';fn
NB.
NB. 	T2_z_     =: 3!:1 y
NB.
NB. 	for_w. i. x do.
NB. 		f     =. HEADERLEN}.T2_z_
NB.
NB. 		i     =. I + JUMP * j =. +: j
NB. 		t     =. a.{~D+a.i.i{T2_z_
NB.
NB. 		T2_z_ =: t i}T2_z_
NB. 	    T2_z_ =: T2_z_,f
NB.
NB. 	end.
NB.
NB. 	E =: a: { T2_z_  NB.  copy by value (until Roger "fixes" it)
NB.
NB. 	erase 'T2_z_' [ unmap_jmf_ :: 0: 'T2_z_'
NB. 	ferase fn
NB.
NB.     E
NB. )
NB.
NB.
NB.
NB.
