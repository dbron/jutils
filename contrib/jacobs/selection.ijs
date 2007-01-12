	NB. http://www.jsoftware.com/pipermail/general/2006-December/028472.html
	require 'viewmat ~addons\image3\image3.ijs'
	imPath=:'dir' in getNmdPath ''
	origIm=: {."1 read_image imPath,'mbra_22','.bmp'	NB. read in


	T0    =:    4
	NCs   =:    2
	n     =:   33

	c     =:  (<:n)%:1e_2%T0
	T     =:  T0*c^i.n

	L     =:  # MU =:  30 33 208 216
	
	NB.	5x5
	ALPHA=:		0.1
	
	delta   =:  _1 ^ =
	lhood   =:  origIm &(*:@:- {&MU)
	]Cs=:		(#~ (>&0 *. <:&NCs) @ | @ j./"1)@(,/ @ (,"0/~) @ i:) NCs
	NB.	compute likelihood
	prior=:4 : '+/ x delta"2 Cs |. y'
	NB.	compute prior
	NB. annealSingelStep
	NB.	y.	~	state
	NB.	x.	~	iteration count
	E=:4 : '(lhood x) + BETA * x prior y'
	f=:3 : 0
		'state index'=.y
		stateNew=.index{Gh
		TEMP=.index{T
		energy=. state E state
		energyNew=. stateNew E state
		deltaE=. energyNew - energy
		accept=. deltaE <: - TEMP * ^. ALPHA
		state=.accept}state,:stateNew
		state;>:index
   )
	
	smoutput 'START arch0 processing...'
	
	NB.image
	viewmat origIm
	NB. display
	
	
	NB. means are given
	(9!:1) 7^5
	NB. fix seed for random number generator
	BETA=:10
	NB. fixed for now
	
	g0=:?($origIm)$L
	NB. first random state
	smoutput'preparing array of random states...'
	Gh=:?(n,$origIm)$L
	NB. prepare array of random states
	arch0=: <. MU {~ >{. f^:n (g0;0)
	NB. quantise (MRF & SA)
	
	viewmat arch0
	NB. display