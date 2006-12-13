require 'strings'
require jpath '~system\extras\util\help.ijs'

HTML_ENT =:  <@:(('&'&,@:,&';'@:{. ,&:< }.@:}.)~ i.&'=')@:('?' sr ' ' )@:trim;._2 noun define
	lt=<
	gt=>
	amp=&
	#149=*
	nbsp=?
    harr=<==>
	quot="
)

rb       =:  ] #~ (0&~:@:(+/\@:(-/)) +: {:)@:(E.&> boxopen)
html     =:  HTML_ENT&(stringreplace seq)@:('<>'&rb)

qdoj     =:  dyad define  NB.  Quote dictionary of J
	try.
		x (html;.0~ ,:/)"_ 1~  > {. fread @: jpath each ('~system\extras\help\dictionary\';'.htm')  <@:;@:(1&A.)@:,"1 0  y (,&(<y)@:{:@:] {~ {.@:] i. ;:@:[) |: ;:@:-.&'?';._2 toJ DICTNDX_jhelp_
	catch.
		'topic not found'  assert 0
	end.
)

qdojH    =:  dyad define  NB.  Quote dictionary of J
	htmll =. 5!:5{.;:'html'
	html  =: ]
	z=.x qdoj y
	". 'html =: ',htmll
	z
)


NB. QUOTES   =:  (trim&.>@:{. ,. (_2: ]\ 0&".)&.>@:{:) |: ' :' makeTable noun define
NB. 	!. : 1035 250   1620 99
NB. 	<  : 1352 255
NB. 	=  : 1719 240
NB. )
NB.
NB. smoutput qdoj~&>/"1 QUOTES
NB.
NB.
NB. QUOTES2  =:  (trim&.>@:{. ,. (_2: ]\ 0&".)&.>@:{:) |: ' :' makeTable noun define
NB.    ^: : 1929 670   8780 66   9170 47   9756 108   9410 83
NB. )
NB.
NB. smoutput CRLF join <@:trim"1 qdoj~&>/"1 QUOTES2
