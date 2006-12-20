rmcol2 =:(1;(3 2 2 $    2 1  1 1    2 2  1 2    2 2  1 1);LF=a.)&;:


text=: rmcol2 0 : 0
#((
#abc
#defg
#)
#lmn
#)
)

   rmcol3 =: (5;(3 2 2 $    1 1  2 1    1 2  2 0    1 1  1 2    );(a.='.');0 _1 0 1)&;:
   
   require'doog'




0 0  1 2    1 0  0 1
	t    =. '.' = ]
    fsm  =:  (< Atop  '`f s m'   =:  1:`( (_2 ]\^:2:    0 0  1 2    2 2  1 2    0 1  1 1    )"_ )`( (t a. )"_ )) `: 0
    ijrd =:  (        '`i j r d' =:  1:`0:`(t f.@:{.)`1:) `: 0
    fsm_ijrd =: fsm (,<) ijrd
    rmcol2 =: ;:~ fsm_ijrd

fXm_ijrd =: 1 : 0
	T        =. '.' = ]
    fsm      =.  (< Atop  '`F S M'   =.  1:`( (_2 ]\^:2 m )"_ )`( (T a. )"_ )) `: 0
    ijrd     =.  (        '`I J R D' =.  1:`0:`(T f.@:{.)`1:) `: 0
    fsm_ijrd =. fsm (,<) ijrd
    rmcol2   =. ;:~ fsm_ijrd
    rmcol2 f.

)

   tests  =: <@:({&('.',ALPHANUM) )@:;@:(<@:(+/\);.1 1: 0} -.)@:#:"0 i.2^6
   rmcol1 =: (#~ [: -. (0 1 E. '.' = ])&.|.)&.('.'&,)
   right  =: rmcol1&.> tests

   smoutput X =: tests,right ,: Y=: rmcol2 :: 0:&.> tests    
   WeR=:((>: 2032 12 31 12 59 60 1000)  #.&:x: }: , 1 1000 <.@:* 0 1 #: {:)@:(6!:0@(''"_)^:(0 -: #))

GO=:3 : 0 
   K =: 3 #.^:_1 i. 3 ^*/ 3 2 2
NB.   K =: K }.~ 39056 NB.  For expediency's sake.
   R =: 3 }. right
   T =: 3 }. tests    

	WeR=:((>: 2032 12 31 12 59 60 1000)  #.&:x: }: , 1 1000 <.@:* 0 1 #: {:)@:(6!:0@(''"_)^:(0 -: #))
	smoutput #K
	min_moop =. <./''
	min_k    =. __
NB.	answer  =: a: $~ K ,&# T

    elapsedSpan =: [: formatTimeSpan  elapsed =: (WeR'') -~ WeR
	elim =: _4 + 4 + 0$~#K
	W =: 0 {. K	
	for_k. K  do.
		
		try. (f ; k ; m)&;: catch. elim   =: 2 k_index} elim  continue. end.
		a      =. (b=:(;:~ (f ; (_2 ]\^:2 k) ; m) , <@ijrd) :: 0:&.>) T
		badSM  =. _4 + 4 + *./ (<0)=a
		elim   =: badSM k_index} elim 
NB.		answer =: a k_index} answer

    	if. 0 -: moop=.+/ R ~: a do.
		 	smoutput W=:W,k
		end.

		if. moop < min_moop do.
			min_moop =. moop
			min_k    =. k_index
		end.

		if. 0 = 2500 | k_index do. smoutput (elapsedSpan '');k_index;moop;min_k;min_moop end.
		if. (0~:k_index)*. 0 = 20000 | k_index do. smoutput formatTimeSpan &.> WART ;~ EP -~ WART=.(#K) *&:x: k_index %~ EP =. elapsed '' end.
	end.
	'Not this way';min_moop;min_k
)




GO2=:3 : 0 
   K2 =: 3 #.^:_1 i. 3^*/2 2 2
NB.   K =: K }.~ 39056 NB.  For expediency's sake.
    R2 =: 1 }. right
    T2 =: 1 }. tests    

	WeR=:((>: 2032 12 31 12 59 60 1000)  #.&:x: }: , 1 1000 <.@:* 0 1 #: {:)@:(6!:0@(''"_)^:(0 -: #))
	smoutput #K
	min_moop =. <./''
	min_k    =. __
NB.	answer  =: a: $~ K ,&# T

    elapsedSpan2 =: [: formatTimeSpan  elapsed2 =: (WeR'') -~ WeR
	elim2 =: _4 + 4 + 0$~#K
	W2 =: 0 {. K2
	for_k. K2  do.
		
		try. (f ; k ; m)&;: catch. elim2   =: 2 k_index} elim2  continue. end.

		a       =.  (;:~ f ; (_2 ]\^:2 k) ; m ) :: 0:&.> T2
		badSM   =.  _4 + 4 + *./ (<0)=a
		elim2   =:  badSM k_index} elim2
NB.		answer =: a k_index} answer

    	if. 0 -: moop=.+/ R2 ~: a do.
		 	W2=:W2,k
		end.

		if. moop < min_moop do.
			min_moop =. moop
			min_k    =. k_index
		end.

		if. 0 = 2500 | k_index do. smoutput (elapsedSpan2 '');k_index;moop;min_k;min_moop end.
		if. (0~:k_index)*. 0 = 20000 | k_index do. smoutput formatTimeSpan &.> WART ;~ EP -~ WART=.(#K) *&:x: k_index %~ EP =. elapsed2 '' end.
	end.
	'Not this way';min_moop;min_k
)



noun define
    [nominal]
    not LF => output, go to nominal
    LF     => output, go to previous was LF

    [previous was LF]
    not LF => move up pointer, go to nominal
    LF     => output         , go to nominal

[init]
Not LF => queue for output, go to nominal
LF     => queue for output, go to nominal


[nominal]
Not LF  =>  output, go to nominal
LF      =>  output, go to toss-next

[toss next]
Not LF => Move Up Pointer, go to nominal
LF     => output, go to nominal


)