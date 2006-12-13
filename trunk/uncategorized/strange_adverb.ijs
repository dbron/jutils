COMMENT =: noun define
	X =: adverb define
		({&m@:{.&.>@:>@:{. ;@:((,&.>) each) >@:{:)@:(<@:(0}~1:)@:(~: _1&|.) @:[  <;.1 each ,&<) NB. &:({.~ -@:>:@:#)
	)

	 

smoutput 1 1 1 0 0 0 1 (FUNCTIONS =: ,`+)X ;: names =: 'a b c d e f g'


smoutput ('('&join , #&')'@:<:@:# ) each 1 1 1 0 0 0 1  <;.1 ] _2 <\ }: 1 |.  ; 1 1 1 0 0 0 1 (,`+)X ;:'a b c d e f g'

D      =:  <"_1 |: ((,`+) {~ > {. 'r i' =: <"1 |: +. 1 1 1 0 0 0 1) ,: ;:'a b c d e f g'

ORIGINAL =: '(a + (b + ((c + (d , (e , f))) + g)))'
PRECEDENCE =: 2 -/\ &. |. 0 ,~ (-.nnn e. '()') # parenDepth nnn=.ORIGINAL -. ' + ,'
EXPR =: ; '(' ; ; D (0&=@:] }.&.> (|.&.>~ 0&<) (, <) each  (| #&.> {&' ()'@:*)@:])  PRECEDENCE 
DONE =: EEE #~ -.+./ _1 0|."_1 ('( ',:' )') E."1 EEE =: ;:^:_1 ;: EXPR 
assert DONE -: ORIGINAL

1 1 1 0 0 0 1 j. 1   2    4   5   6     3


'(a + (b + ((c + (d , (e , f))) + g)))'

 ORIGINAL-.names 
 (+(+((+(,(,)))+))) 

)

FUNCTIONS =: ,`+
ORIGINAL =: '(a + (b + ((c + (d , (e , f))) + g)))'
names    =: ORIGINAL -. '()', ' ' -.~ ;:^:_1 FUNCTIONS
N=:;:names

  WHAT_HE_MEANT =: (FUNCTIONS i. nnn-.&:;:'()') j. (-.nnn e. '()') # parenDepth nnn=.ORIGINAL-.names

  'F P'=.<"1|:+.WHAT_HE_MEANT
   D2 =: <"1 |: (;:names) ,: FUNCS =. F { FUNCTIONS

NB.  >^:(1: -: #) L: 1 ^:_   N ((#&>~/@:] ($:~^:(1: < #@:]) ) (<;.1~ 1: , >@:{:)) (; (~: >./))) P
foo=. ((#&>~/@:] ($:~^:(1: < #@:]) ) (<;.1~ 1: , >@:{:)) (; (~: >./)))
foo2=.;@:( ;^:(1: -: #) L: 1 ^:_ @: foo)
RES=: N foo2 P 
RESFUNCS=: FUNCS foo2 (#~ ] ~: >./) P

NNNNNNNNNNNN =: N (>@:{.@:] |.&.> (, each >@:{:)) ((0 , -.2 </\ P) ,&< FUNCS) (# each~ 1: <@:j. (= >./))  P


'ASSOCIATIVITY NEW_FUNCS EXPAND_MSK'=: ((0 , -.2 </\ P) ,&< FUNCS) ((# each~ , ]) 1: <@:j. (= >./))  P
AAAAAAAAAAA=: N (>@:{.@:] |.&.> (, each >@:{:)) ASSOCIATIVITY ,&< NEW_FUNCS 
PPPPPPPPPPPP=:(1|.EXPAND_MSK) # 2 -/\ &. |. 0 ,~ P
EXPR =: ; '(' ; ; (;: each AAAAAAAAAAA) (0&=@:] }.&.> (|.&.>~ 0&<) (, <) each  (| #&.> {&' ()'@:*)@:])  PPPPPPPPPPPP



fooooooo=. ((#&>~/@:] $:~^:(1: < #@:]) (<;.1~ 1: , >@:{:)) (; (~: >./)))
fooooooo2=.;@:( ;^:(1: -: #) L: 1 ^:_ @: fooooooo)
NNNNNNNNNNNN fooooooo2  P

implant=: 1 : '((; ,&.>)&m)@[ >@{.@:(]`[)@.(-:&}.) L: 1 (; L: 0 1 {::)~@]'
opick=._99&{:: 
foofunc =. (< S: 1 {:: FOO) {::~ (<_99) i.~ < S: 0 FOO=:(5!:1){.;:'opick'
iii=. foofunc implant
ARGS =. 3 ; each (i.@:# N) iii"0 FOO
RESARGS=: ARGS foo2 P 



NB.   plus =: 4 : 'parenclose (": x) , '' + '' , (": y)'
NB.   comma =: 4 : 'parenclose (": x) , '' , '' , (": y)'
NB.   (0&{:: plus (1&{:: plus ((2&{:: plus (3&{:: comma (4&{:: comma 5&{::))) plus 6&{::))) N
NB. foofff =. (4&{:: comma 5&{::)
NB. 5!:1 {. ;: 'foofff'


xandy  =: dyad define
   'x y'=. xandy&.>/^:(1&<@:L.)&.> x ,&< y
    3 
	CLAMS_z_ =: 0   
	if. (L. RES) = # dbstk'' do. assert CLAMS_z_ end.
)

require 'debug'
dbss 'xandy *:*'
dbss''
dbr 1
NB. RESFUNCS xandy L: 0 1 RESFUNCS xandy L: 0 1 RES 
xandy&.>/ RES