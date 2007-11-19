parenthesize  =:  verb define
	if. 1 = # y do.
		,<'(',')',~;y return.
	end.
	m =.  (3 #:@:+ [: i.@:<:&.-: 2^#) y
	M =. m <@:(<;.2)"1 y
	; ('(',')',~;)each each ,@:{ each parenthesize each each M
)

NB.  parenthesize ;:'a b c d'
   