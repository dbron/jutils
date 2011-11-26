bd =: verb define                          NB.  Bracket Delimited
	'()' bd y
:
	nlr =. +:/ 'l r' =. lr =. x =/ y
	d   =. nlr # r + +/\ -/ lr
	y   =. nlr # y
	d bfn y
)

bfn =: dyad define                          NB.  Box from nest
	nested  =. 1 , 2 ~:/\ x = {.x
	
	x       =. nested <;.1 <:x
	y       =. nested <;.1 y
	  
	nestmsk =. (#y) $ 0 1
	nest    =. (<:&.> nestmsk # x) bfn&.> nestmsk # y
	(_2|#y) }. , |: nest ,:~ y #~ -.nestmsk 
)


Note 'Demonstrate use'
	   bd 'this is (a (deeply (deeply (nested list)))) and (less deeply)'
	+--------+--------------------------------------+-----+-------------+
	|this is |+--+---------------------------------+| and |+-----------+|
	|        ||a |+-------+-----------------------+||     ||less deeply||
	|        ||  ||deeply |+-------+-------------+|||     |+-----------+|
	|        ||  ||       ||deeply |+-----------+||||     |             |
	|        ||  ||       ||       ||nested list|||||     |             |
	|        ||  ||       ||       |+-----------+||||     |             |
	|        ||  ||       |+-------+-------------+|||     |             |
	|        ||  |+-------+-----------------------+||     |             |
	|        |+--+---------------------------------+|     |             |
	+--------+--------------------------------------+-----+-------------+
	
	   NB.  Pick a complicated, standard verb...
	   ;:^:_1: _3 }.&.> (\: 7!:5) (#~ 0 = [: +/ 1 2 #@(5!:7)/ ]) ((4!:3'') i. getscripts_j_ <'stdlib') ((= 4!:4)#]) '_z_' ,L:0~ nl_z_ 3
	assert toCRLF toJ type script scriptd Note names smoutput...
	
	   5!:5 <'toJ'
	((10{a.) I.@(e.&(13{a.))@]} ])@:(#~ -.@((13 10{a.)&E.@,))
	   
	   bd 5!:5 <'toJ'
	+-----+------+---+------------------------------------+-----+
	|10{a.|+----+|e.&|+-----+-------------------+--------+|&E.@,|
	|     || I.@||   ||13{a.|+-----+----+------+|13 10{a.||     |
	|     |+----+|   ||     ||@]} ]|+--+|#~ -.@||        ||     |
	|     |      |   ||     ||     ||@:||      ||        ||     |
	|     |      |   ||     ||     |+--+|      ||        ||     |
	|     |      |   ||     |+-----+----+------+|        ||     |
	|     |      |   |+-----+-------------------+--------+|     |
	+-----+------+---+------------------------------------+-----+

	NB.  Note that bfn doesn't work on toJ
	NB.  The cause is toJ starts with a nested depth of 2 rather than zero
	NB.  Have to think about this...
)