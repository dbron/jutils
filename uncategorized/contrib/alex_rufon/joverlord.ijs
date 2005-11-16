
require 'debug'

dbr 1

joverlord=: 3 : 0

	MAXX                =. -: 1024 * 1024
	stringsize          =. MAXX ([ ((#~ {.) , {:@:]) _2&{.@:(#.^:_1)) y.
	
	wd 'pc dbform'
	wd 'cc d oleautomation:jOverLord.jWired'
	
	retVal              =. ; wd @: ('olemethod d base createString '&,) @: ":&.> stringsize -. 0  NB. -. 0 in case 0 -: MAXX | y.
	retVal
)


NB. y. is new buffer size in bytes
rebuf=: 3 : 0
	wd'pc abc;cc g isigraph;'
	try. glqpixels 0 0 1,>.y.%4 catch. end.
	wd'pclose'
)

NB. rebuf 3e6

NB. HORST =:  joverlord 1024 * 2 
NB. PORST =:  joverlord 1024 * 1024 * 2

