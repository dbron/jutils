
NB.  Error function
erf     =:  (*&(%:4p_1) % ^@:*:) * [: 1 H. 1.5 *: NB. Ewart Shaw Vector 18.4
NB. CDF of N(0,1) 
cnd     =:  N =: [: -: 1: + [: erf %&(%:2)
NB.  Black scholes
BS      =:  monad define
	'S X T r v' =. y
	-/(S,X*^-r*T)*N((^.S%X)+T*r(+,-)-:*:v)%v*%:T
)
y       =:  60 65 0.25 0.08
smoutput BS y ,  0.3  NB.  Call
smoutput BS y , _0.3  NB.  Put

