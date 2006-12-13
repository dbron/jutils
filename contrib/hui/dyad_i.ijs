NB.  Roger's dyadic I. implentation
bs          =: 1 : 0
:
     i      =.  0,_1+#x

     while. <:/i do.
          k =.  <.-:+/i
          b =.  0 1 -: u y,:k{x 
          i =.  (k+_1^b) b}i 
     end.

     1+{:i
)

atype       =:  e.&>&(1 4 8 16 64 128 4096 8192 16384 ; 2 2048 131072 ; 32 32768 ;65536)@(3!:0)

Idot        =:  verb define
     I. y  NB. Added this to make I ambivalent, like I.
:
     r      =.  0>._1+#$x
     assert. (}.$x) -: (-r){.$y                      NB. rank error
     assert. (0 e.$x) +. (0 e.$y) +. x -:&atype y  NB. domain error
     ord    =. /:`\: @. (1 0 -: /: 0 _1{ :: 0: x)
     x ord f. bs"(_,r) y
)


EMAILS =: noun define
	From: Roger Hui [mailto:rhui000@SHAW.CA]
	Sent: Saturday, July 30, 2005 11:28 AM
	To: JFORUM@PEACH.EASE.LSOFT.COM
	Subject: Re: [Jforum] binary search
	
	 
	Version 0.3
	__________________________________
	
	0 $ 0 : 0
	Binary Search    x I. y    ranks: _ _  
	
	x is assumed to be sorted in ascending or descending order; 
	ascending is assumed if all the items of x are the same.  
	The comparison used in the ordering is not tolerant.
	
	If y has the shape of an item of x, then x I. y is the 
	least non-negative integer j such y precedes j{x in 
	the ordering, or #x if y follows {:x in the ordering
	or if x has no items.  In general, binary search applies 
	to the rank (0>.(#$x)-1) cells of higher-ranked y .
	)
	
	bs=: 1 : 0
	:
	 i=. 0,_1+#x
	 while. <:/i do. 
	  k=. <.-:+/i 
	  b=. u y ,: k{x
	  i=. (i*-.b) + b*k+1 _1
	 end.
	 1+{:i
	)
	
	I=: 4 : 0
	 r=. 0>._1+#$x
	 assert. r<:#$y               NB. rank error
	 assert. (}.$x) -: (-r){.$y  NB. length error
	 assert. 1 [ x,y             NB. domain error
	 ord=. /:`\: @. ({. /: 0 _1{ :: 0: x)
	 x ord f. bs"(_,r) y
	)
	
	test=: 3 : 0
	 x=. 0 1 1 1 2 3 7
	 assert. 0    -: x I _5
	 assert. 0    -: x I _4.5
	 assert. (#x) -: x I 99
	 assert. 4    -: x I 2
	 assert. 4    -: x I 1.5
	 assert. (0 0,(#x),4 4) -: x I _5 _4.5 99 2 1.5
	 assert. (i.~ -: I~) x
	 assert. (i.~ -: I~) x=. /:~ ~. 100   ?@$ 1e6
	 assert. (i.~ -: I~) x=. /:~ ~. 100 2 ?@$ 0
	 assert. 0 0 0 -: '' I 'abc'
	 assert. (i.~ -: I~) i.  6 3
	 assert. (i.~ -: I~) i. _6 3
	 1
	)
)