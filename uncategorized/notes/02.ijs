inputText   =: 'It was the best of times, it was the worst of times. So',CRLF,'starts the Dickens novel "A Tale of Two Cities".' 

NB.  Make sure past mistakes don't mess us up.
3 : 'erase BUILTUPNAMES_z_' :: empty ''

4!:5 ] 1

	ac				=.  [ (E. <;.1 ]) ,

	cutIntoWords	=.  (}.&.>@:{. , }.)@:(' '&ac)
	cutIntoWords 	=. ' ' & ac
	NB.cutIntoWords	=. ' ' & arbCut
	cutIntoWords 	=. <;.2@:,&' '

	wordify			=.  -.&a:@:cutIntoWords@:(LF sr ' ')@:-.&CR
words			=. wordify inputText

	breakIntoLines	=.  ] <;.1~ 1: , 2&(>:/\)@:(| +/\@:>:@:(#&>))

smoutput FLOOGLE=:(;: 'Words Lengths RunSum ModLen Frets') ,. <"0^:(L. = 0:) &> (; (; (; (; 1: , 2&(>:/\))@:((>:15)&|))@:(+/\))@:(#&>)) words
smoutput FNEEGLY=:_2 }.; ,&CRLF@:}:@:;&.> words <;.1~ ; }.{: FLOOGLE
smoutput >./ #&> CRLF arbCut FNEEGLY

	formatLines		=.  _2&}.@:;@:(,&CRLF@:(;:^:_1)&.>)
	wrap			=.  formatLines@:(breakIntoLines wordify)
	wordWrap		=:  80&$: : wrap f.

BUILTUPNAMES_z_	=: 4!:5]1

4!:5 ] 0

testWrap	=: dyad define
	*./ x <: #&> CRLF arbCut x wordWrap y
)

smoutput (;:'SUCCESS FAILURE') ;"1@:(a:&~:@:] # [ ,. ((<' @ ')&,.)@:]) (0 0 , wrapLengths) <@:listToEnglish@:(<@":"0)@:}./.~ 0 1 , -. ; inputText {:@testWrap~"_ 0 wrapLengths=:5 * >: i. 6

COMMENT=:noun define  NB.  The bottom code guaruntees that the lines are of the right length, but doesn't put spaces between words and cuts off the last character of every line
inputText   =: 'It was the best of times, it was the worst of times. So',CRLF,'starts the Dickens novel "A Tale of Two Cities".' 

NB.  Make sure past mistakes don't mess us up.
3 : 'erase BUILTUPNAMES_z_' :: empty ''

4!:5 ] 1

	ac				=.  [ (E. <;.1 ]) ,

	cutIntoWords	=.  (}.&.>@:{. , }.)@:(' '&ac)
	cutIntoWords 	=. ' ' & ac
	NB.cutIntoWords	=. ' ' & arbCut
	cutIntoWords 	=. <;.2@:,&' '
	cutIntoWords 	=. <;._2@:,&' '

	wordify			=.  -.&a:@:cutIntoWords@:(LF sr ' ')@:-.&CR
words			=. wordify inputText

	breakIntoLines	=.  ] <;.1~ 1: , 2&(>:/\)@:(| +/\@:>:@:(#&>))

smoutput FLOOGLE=:(;: 'Words Lengths RunSum ModLen Frets') ,. <"0^:(L. = 0:) &> (; (; (; (; 1: , 2&(>:/\))@:((>:15)&|))@:(+/\))@:(#&>)) words
smoutput FNEEGLY=:_2 }.; ,&CRLF@:}:@:;&.> words <;.1~ ; }.{: FLOOGLE
smoutput >./ #&> CRLF arbCut FNEEGLY

	formatLines		=.  _2&}.@:;@:(,&CRLF@:(;:^:_1)&.>)
	wrap			=.  formatLines@:(breakIntoLines wordify)
	wordWrap		=:  80&$: : wrap f.

BUILTUPNAMES_z_	=: 4!:5]1

4!:5 ] 0

testWrap	=: dyad define
	*./ x <: #&> CRLF arbCut x wordWrap y
	)

smoutput (;:'SUCCESS FAILURE') ;"1@:(a:&~:@:] # [ ,. ((<' @ ')&,.)@:]) (0 0 , wrapLengths) <@:listToEnglish@:(<@":"0)@:}./.~ 0 1 , -. ; inputText {:@testWrap~"_ 0 wrapLengths=:5 * >: i. 6
)