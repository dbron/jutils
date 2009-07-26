fw   =: {.@:;:  NB.  'f'irst 'w'ord

nnit =: adverb define
    if. noun=nc{.;:'u'do.
        <u
    else.
        {.u`''
    end.

	NB.  Similiar idea
    NB.  <`{:@.((<,''0'')-:{.) u"_`'''' {::~ ,&.>0 1 0
)

strand =:conjunction     define

    m =. u nnit

    if. m -: {: n do.
        }: n
    else.
        strand (m , n)
    end.

)

s  =: conjunction define
    u strand (v nnit)
)

fancyStrand =: adverb define

	NB.  Through manipulation of the text of  strand  ,
    NB.  permit "paired  markers" for strand notation, 
	NB.  e.g.
    NB.     [ 'hello' 'there'  fs ]   ,  < 'hello' 'there'  fs >  
    NB.    '(' 'hello' 'there' fs ')' , '{' 'hello' 'there' fs '}'
	NB.  Paired markers are given as the argument to 
	NB.  this adverb.

	
	NB.  Since we don't have anonymous operator recursion
	NB.  (or, in fact, anonymous explicit recursion), need
	NB.  to assign a name to use. Find a name that hasn't
	NB.  been defined.
	recurse =. fw ([ $:^:(_1: ~: nc@:<))@:('fs_' , 5&(] {~ (?@:# #)) bind '0123456789abcdefghijklmnopqrstuvwxyz') ''
	
	lines    =. {:"1 (2) 5!:7 fw 'strand'
	lines    =. (fw 'strand')&=`(,:&recurse)}&.:;: L:0  lines
	assignM  =. (({. ,&:< }.)~ 1 + 1 i:~ 'm=.' +./@:E.&:;: S:0 ]) lines
	newLines =. ; 2 A. assignM ;~ <'m=.(m,~{:"1 k) {~ m i.~ {."1 k=. _2 ]\ (,,&.>) ;/',5!:5 fw 'm'
	(recurse)=: 2 : newLines
)

NB.  "fancy" analog to  s  .  Also produced through text manipulation.
fs =: conjunction def ( (fw 'strand')&=`(,:&(<' ''()[]{}<>'' fancyStrand'))}&.:;: L:0 {:"1 (2) 5!:7 fw 's' )

t =: s __

0!:111^:0: Note 'Examples.  Change  0:  to  1:  to run'

	__ 'a' 'b' 'c' + - * (+/ % #) a:   t
	__  'a' 'b' 'c' + - * (+/ % #) a:  s __
	| 'a' 'b' 'c' + - * (+/ % #) a:    s |

	| hello there s |

	| hello there fs |
	[hello there fs]
    <hello there fs>

	'(' hello there fs ')'
	'{' hello there fs '}'
	

    | 'this is' 3 'words' 'of strand notation'  s|
    
	[ 'this is' 4 'words of strand notation, which is ' > 3   fs]

)

Note 'Promises, promises'

	If J ever supports Unicode identifiers, or if I ever write 
	my Punycode-ish IJS converter script, we could have notation
	like this:

	» =: s «
	« =: '«'"_
	
    « 'This' 'is' 'strand' 'notation' »

	« > (+/%#)  »  NB.  Gerund

)