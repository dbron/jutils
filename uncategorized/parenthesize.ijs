parenthesize  =:  verb define
	if. 1 = # y do.
		,<'(',')',~;y return.
	end.

	m =.  (3 #:@:+ [: i.@:<:&.-: 2^#) y
	M =. m <@:(<;.2)"1 y

	; ('(',')',~;)each each ,@:{ each parenthesize each each M
)

> parenthesize ;:'a b c d'

paren1=: <@('(' , ')',~ ;:inv) `{. @.(1 = #@])
parens=: (2 +/\"1@#:@i.@^ #) paren1/.^:(1 < #@~.@[)"1 ]
parenthesis=: [: ;:inv"1 ([: ~.@; <@parens at -.&a:"1)^:_@,:@;:
