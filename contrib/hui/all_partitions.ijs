tu       =:  ] <@:*"1 [ ^ </\"1@=@]              NB.  Roger's "all partitions" verb.
ext      =:  [: ~. [: /:~&.> ,&.> , ;@:(tu&.>)   NB.  Finds all sets of factors
ap       =:  ,&.>`( ext/)@.(1:<#) @ q:          


EMAILS =: noun define

	> -----Original Message-----
	> From: Roger Hui [mailto:rhui000@SHAW.CA]
	> Sent: Tuesday, June 28, 2005 8:22 PM
	> To: JFORUM@PEACH.EASE.LSOFT.COM
	> Subject: Re: [Jforum] All Products
	> 
	> 
	> 2&^.&.> ap 2^n  generates all partitions of n ; alternatively,
	> judicious modifications of ap generate the partitions directly.
	> 
	>    ap 2^6
	> +-----------+---------+-------+-------+------+-----+----+-----+----+---+--+
	> |2 2 2 2 2 2|2 2 2 2 4|2 2 2 8|2 2 4 4|2 2 16|2 4 8|2 32|4 4 4|4 16|8 8|64|
	> +-----------+---------+-------+-------+------+-----+----+-----+----+---+--+
	> 
	>    2&^.&.> ap 2^6
	> +-----------+---------+-------+-------+-----+-----+---+-----+---+---+-+
	> |1 1 1 1 1 1|1 1 1 1 2|1 1 1 3|1 1 2 2|1 1 4|1 2 3|1 5|2 2 2|2 4|3 3|6| 
	> +-----------+---------+-------+-------+-----+-----+---+-----+---+---+-+
	> 
	> tu  =: ] <@:*"1 [ ^ </\"1@=@]
	> ext =: [: ~. [: /:~&.> ,&.> , ;@:(tu&.>)
	> ap  =: ,&.>`( ext/)@.(1:<#) @ q:
	> 
	> pu  =: ] <@:+"1 [ * </\"1@=@]
	> pext=: [: ~. [: /:~&.> ,&.> , ;@:(pu&.>)
	> part=: ,&.>`(pext/)@.(1:<#) @ ($&1)
	> 
	>    part 6
	> +-----------+---------+-------+-------+-----+-----+---+-----+---+---+-+
	> |1 1 1 1 1 1|1 1 1 1 2|1 1 1 3|1 1 2 2|1 1 4|1 2 3|1 5|2 2 2|2 4|3 3|6|
	> +-----------+---------+-------+-------+-----+-----+---+-----+---+---+-+
	> 
	> This computation of partitions in 3 lines is the neatest I have
	> seen over the years (although it is not the most efficient).
)