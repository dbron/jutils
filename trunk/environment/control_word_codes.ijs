
f            =: verb define
 t=.y+1
 t*t
)


g            =:  verb define
	this is some stuff
	x=.y+1
	if. this_is_a_t_block *. it_is do.
	   'hey this is the last result.'
	end.
	'no it it is not'
)


parse        =:  {.@:;:
is_verb      =:  3: = 4!:0
defn         =:  1 2"_ <@(5!:7)/ ]
is_a_verb    =:  'That`s not a verb'&assert@:0:`is_explicit@.is_verb@:parse
is_explicit  =:  ('That`s not an explicit verb'&assert@:0:`(1:)@.(+./@:]) 0: ~: #&>)@:defn
sentences    =:  {:"1@:>@:{.@:#~
t_blocks     =:  1: |. ({.;:'do.')@:=  NB.  This could probably be figured out from 1&{"1 from 5!:7, but the 'control code words' are not documented



F            =: {:"1 fx=:1 (5!:7) {.;:'f'
G            =: {:"1 gx=:1 (5!:7) {.;:'g'

i2s=:(s2i=: 6: s: s:) f. ^:_1
require'qdoj'
cntrl        =:  (#~ {: >: _1&(|.!.0)@:(~:/\)@:(+./)) '_.'&(=/)
is_ctrl      =:  e.&CONTROL_WORDS@:(cntrl&.>)@:{.@:[^:] (1: = #)

CONTROL_WORDS =: /:~ ~. cntrl&.> CONTROL_PAGE=:rrrr#~'.'={:&>rrrr=.}.rrr#~ ~:/\ (;:'available: Words') e.~ rrr=.;: 3 : '(LF=y)}y,: '' ''' toJ  ,'do.' qdoj~ ,: 0 _
NB.CONTROL_WORDS=: cntrl&.> /:~ ;: 3 :'(y=LF)}y,:'' ''' toJ noun define  
NB.assert.     break.      case.       
NB.catch.      catchd.     catcht.     
NB.continue.   do.         else.       
NB.elseif.     end.        fcase.      
NB.for.        for_xyz.    goto_name.  
NB.if.         label_name. return.     
NB.select.     throw.      try.        
NB.while.      whilst.
NB.)

DCD=:noun define
	assert.    25 011001
	                    
	break.     19 010011
	                    
	case.      21 010101
	                    
	catch.     11 001011
	                    
	catchd.    27 011011
	                    
	catcht.    28 011100
	                    
	continue.  13 001101
	                    
	do.         3 000011
	           18 010010
	           23 010111
	                    
	else.       5 000101
	                    
	elseif.     9 001001
	                    
	end.        6 000110
	           24 011000
	                    
	fcase.     22 010110
	                    
	for. for_. 17 010001
	                    
	goto_.     15 001111
	                    
	if.         4 000100
	                    
	label_.    14 001110
	                    
	return.    16 010000
	                    
	select.    20 010100
	                    
	try.       10 001010
	                    
	while.      7 000111
	                    
	whilst.     8 001000
)                    

NB. NVtext ,:^:(2: - #@$) L: 0 ({."1 ,. (-.&' '@:":@:(_8&{.)"1@#:&.>@:({:"1))) (/:{."1) words_to_codes 
NB. NVtext |."1 ({."1 ,. (-.&' '@:":@:(_8&{.)"1@#:&.>@:({:"1))) |."1 (/:{."1) codes_to_words



control_test=:3 : 0

	goto_end.
	
	
	try.
		throw.
	catch.
		problem
	end.
	
	
	try.
		assert. 0
	catchd.
		problemd
	end.
	
	
	try.
		the other
	catcht.
		problemt
	end.



	if. hi do.
		bye
	end.


	if. the truth do.
		the beauty
	else.
		the eye of the beholder
	end.
	
	
	if. the truth do.
		the beauty
	elseif. fuzzy do.
		warm
	elseif. 1 do.
		default
	end.



	select. an element
		case. all case do.
	end.


	select. an element
		fcase. all fcase do.
	end.


	select. an element
		case. mixed case do.
			
		fcase. and fcase do.
				hi
		fcase. hee hee do.
				not here
		case. last check do.
	end.



	for. i. 10 do.
		smoutput 'hi'
		break.
	end.


	for_xyz. i. 10 do.
		smoutput xyz
		continue.
	end.

	
	while. 1 do.
		forever
		return.
	end.


	whilst. 0 do.
		once
	end.



	label_end.
)


control_combos=:(>@:{. ; <@:}.@:}.)@:;:&> LF cut noun define  NB.!  Read these from the documentation.  Start with CONTROL_PAGE
	end. :  if. elseif. else.   select.   for. for_.   while. whilst.   catch. catchd. catcht.
	do.  :  if. elseif.   case. fcase.   for. for_.   while. whilst.
)


SCUNGILI=:((6: s: s:) msk#choopy ) ,.~  {."1 > 1{"1 FOOGLE#~msk=.e.&CONTROL_WORDS choopy =. cntrl&.> ; {.@:(;:)&.> ({:"1) FOOGLE=: 1 (5!:7) {.;:'control_test'
CONTROL_WORDS_SRC =: TAB sr ' ' (2#LF) join NVtext each ": L: 0 ": L: 0 (((6: s: s:)^:_1@:~.@:] ,. <@:~./.~)/ ,&< (<">@:~.@:[ ,. <@:(;:^:_1)@:~.@:((6: s: s:)^:_1)/.)/)|:SCUNGILI
'w2cSrc c2wSrc '=: 0&".^:('.'"_~:{:)@:trim L: 0 (split~  i.&' ')&>@:(LF&cut)&.>  (3#LF) arbCut TAB sr ' ' toJ CONTROL_WORDS_SRC

CHINESE=:(MASK_OD=:multi <"1@:(=/)  woids) ,.~  (<woids=:(6: s: s:)^:_1 {:"1 SCUNGILI) e.&.> ({:"1 control_combos) {~ (multi=:({."1 w2cSrc)#~ 1 < #&> {:"1 w2cSrc) i. {."1 control_combos
preceding =: 1: ` ((#  |.!.0@(>./\)@(* i.@#))~) ` (#@[ $ 0:) } "1
subtypes =: (<{:"1 SCUNGILI) #&.>~ CHINESE_MASK=:preceding&.>/"1  CHINESE
multiMap =: (;@:({."1) ,&< {:"1) (/: {."1) ;(MASK_OD #&.><{."1 SCUNGILI) (<">@:~.@:[ ,. <@:/:~@:i2s@:~./.)&.> subtypes 

w2c=:(/: {."1) ~. (|:@:e.@:({:"1)  (<@:(;:^:_1)@:({."1) , (<;/0 1)&{)@:>@:#"1 <"1) w2cSrc

NB.dcd=:(,. ' '&,.)&.>/"1 ' 0'   (*./\@:=&'0'@:] dyad : 'x}y',:~)"1&.>"1|: (10 2&([ <"1@:,. (>:@:>.@:^. >./@:;))   ([: -.&' '@:":"1 (#~/@:[ #.^:_1 /:~@:]))&.>/ ]) {:"1 w2c
NB.DCD=:;,&' '&.> dcd ,./@:,:&.>"1~ ({."1) w2c

dcd=:(,. ' '&,.)&.>/"1 ' 0'   (*./\@:=&'0'@:] dyad : 'x}y',:~)"1&.>"1|: (10 2&([ <"1@:,. (>:@:>.@:^. >./@:;))   ([: -.&' '@:":"1 (#~/@:[ #.^:_1 /:~@:]))&.>/ ]) {:"1 w2c
dcd=:dcd >@:((,. ' '&,.)&.>/)@:([: <@:>"1@:|: ;"1)&.>  (<multiMap,&.>a:,<a:) ((i.~  >@:{.)~ >@:{ >@:{:@:[)&.> {:"1 w2c
DCD=:(2#LF) join ((LF&join@:(#~ ([: +./\. a:&~:))@:(({.~ #) <@:dtb"1@:,. ' '&,.@:])&.>)/"1) ((({. each ~ <@:+&2@:(>./)@:($&>)) "1 &.|: ))(,:^:(2: - #@:$) each ) dcd ,.~ ({."1) w2c

NB.RUNG=: SCUNGILI#~ ((6: s: s:){.;:'do.') ~:{:"1 SCUNGILI




NB. (<(6: s: s:)^:_1{:"1 RUNG)<@#"1&.>~  ((#~ 1: < #&>) {:"1 w2cSrc)  1&(|.!.0)"1@:(=/)&.> <{."1 RUNG