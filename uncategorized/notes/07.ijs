COMMENTS =: noun define
   ps1=. <: #/.~ (>: i. -N) , +/@:~:"1 (10&#.^:_1) i. 10^N=.1
   ps2=. <: #/.~ (>: i. -N) , +/@:~:"1 (10&#.^:_1) i. 10^N=.2
   ps3=. <: #/.~ (>: i. -N) , +/@:~:"1 (10&#.^:_1) i. 10^N=.3
   ps4		=. <: #/.~ (>: i. -N) , +/@:~:"1 (10&#.^:_1) i. 10^N=.4
   ps5		=. <: #/.~ (>: i. -N) , +/@:~:"1 (10&#.^:_1) i. 10^N=.5
   ps6	=. <: #/.~ (>: i. -N) , +/@:~:"1 (10&#.^:_1) i. 10^N=.6
)


NB.  Pick:  N R r
P		=:  (!@:[ % !@:-)&x:

NB.  Choose:  N C r
C		=:  (!@:[ % !@:] * !@:-)&x:
   

roll	=: dyad define
	N =. x
	r =. y
	
	Q=.0 2 $ 0
	
	for_q. i. r do.
		Q =. Q , (r C q)  ,  N P r - q
	end.
	
	Q
)

pp1		=: {:"1 ] 10 roll 1
pp2		=: {:"1 ] 10 roll 2
pp3		=: {:"1 ] 10 roll 3
pp4		=: {:"1 ] 10 roll 4
pp5		=: {:"1 ] 10 roll 5
pp6		=: {:"1 ] 10 roll 6

		    PASCAL	=:  (C i.@:>:)&.> i. 6
smoutput NOTPASCAL	=:  (ps1;ps2;ps3;ps4;ps5;ps6) %&.> pp1;pp2;pp3;pp4;pp5;pp6
