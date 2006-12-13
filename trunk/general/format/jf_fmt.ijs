require 'hui'  NB.  For 'all partitions'

NB.  Parse JForum formatted data
parags   =. ((LF;~LF,LF)&multiCut)@:(#~ [: -. _1: |.!.0 (LF,' ')&E.)@:(TAB sr ' ')@:toJ
names    =.  (|.@:; }:&.>)~&>/@:(;:@:deb L: 0)
values   =.  <@:(0&".&>)@:;"1@:(1: |:  (' '&arbCut &>)@:(deb each)@:|:)
nvjoin   =.  {."1@:[ (, <)"_1 (,"0~ >@:({:"1))~
NxV      =.  (names@:[ nvjoin values@:])&>/@:(split~ 2:)@:|:
jf_parse =:  NxV@:parags f. NB. <@:(0&".&>)@:;"1@:(1: |:  (' '&arbCut &>)@:(deb each)@:(2: }."1  ))


NB.  Format data for sharing on the JForum
shapes   =:  /:~@:~.@:;@:(<"1@:anagram&.>)@:ap@:#@:, NB.  All possible shapes of an argument

square   =:  (#~ 2: = #&>)                      NB.  Only want squares.  Could score with __ for non conformant, but easier to just filter first

mostSqr  =:  ((>: @:i.~  \:~) % #)@:|@:(-/&>)   NB.  Rank by squareness
NB.mostSqr  =:  (= <./)@:(|@:(-/&>))            NB.  Symmetry is pleasing.  The most square results.
middle   =:  2: | {:&>                          NB.  Prefer squares who have an odd width, 
                                                NB.  so I can put a single 'x' or 'y' directly in the center

lxw     =:  </&>                                NB.  Length less than width (more cols than rows, ie minimize # of lines)

prsur    =: (1 2 1) ,&< lxw`middle`mostSqr      NB.  This currently reads: get me the most square matrix, prefer
                                                NB.  Choose the transpose if it'll save me some lines, unless the
                                                NB.  normal way gives me a center.
                                                NB.
                                                NB.  Could have other pressures, too.
                                                

                                                NB.  Just add 'em
scores   =: (>{.prsur)"_ +/ . * (> {: prsur)`:0 NB.  Multiply by weights
maxScore =:  (= >./)@:scores                    NB.  Find shapes with max scores
bestShape=: (#~ maxScore)@:square@:shapes       NB. Select shapes with maximum scores
reshape  =: $~ >@:{.@:bestShape
format   =: -.&' '"1@:":@:reshape

putTopMid=: [`(0: <@:; <.@:-:@:{:@:$@:])`]}     NB.  Place an item in the middle of the first row
id       =: putTopMid  ' '&,@:format            NB.  Identify this argument (x or y)
arg      =: (,. ' '&,.)&.>/ @:(id&.>)"1      
arguments=:  'xy'&arg                           NB.  Format the argument set

sets     =:  (,&':'@:[  , (5#' ')&(,"1)@:])&.>"1
store    =:  (sets~ {.&(UCALPHA,LCALPHA)@:#)@:arguments           NB.  Name the argument sets; we're in trouble if there are more than 52
jf_fmt   =:  _2&}.@:;@:(<@:,&CRLF@:dtb"1)@:(' '&join)@:store f.   NB.  Make argument sets email-compatible




NB.  Test
   input       =: jf_parse }: noun define
A:
		  x              y
	00100100101001 00010010010010
	01010101001000 00100000010001
	10001000000000 00010000000001
	10000001000100 00010010001001

B:
          x              y
	00000000001001 00000000000100
	00010101000100 10001010100010
	01000101010100 00100010101010
	10000001000100 01001000100010
)

newInput  =: jf_fmt ({:"1)@:>@:({:"1) input

'Formatting fucked up' assert input -: jf_parse newInput





NB.!  Argument to email is a N by 2 array of boxes (rows correspond to input sets, column 0 is x and column 1 is y).
NB.!  Each pair of x and y should have the same shape.  IE *./@:(-:/@:($&.>)"1)  




NB.!  'Email' could also make use of the 'pressures' scheme.  
NB.!  That is, it could choose the 'best' scheme to format data for the Forum.
NB.!
NB.!  One pressure would be human readability, which the current implentation provides.
NB.!
NB.!         A:
NB.!          		  x              y
NB.!          	00100100101001 00010010010010
NB.!          	01010101001000 00100000010001
NB.!          	10001000000000 00010000000001
NB.!          	10000001000100 00010010001001
NB.!
NB.!         B:
NB.!                  x              y
NB.!          	00000000001001 00000000000100
NB.!          	00010101000100 10001010100010
NB.!          	01000101010100 00100010101010
NB.!         	10000001000100 01001000100010
NB.!
NB.!  Another pressure would be terseness (because email is a low bandwidth channel).
NB.!  We could tersely format boolean arguments in multiple ways,
NB.!
NB.!         b=. 1 0 0 1 0 0 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 0 1 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0 0
NB.!         fmtB2I=:'; (-@:[ <@{."_1 #:@:])/'&,@:((,' ,: '&,)&":)/@:|:@:(_16&((# , #.)\))
NB.!         fmtB2I b
NB.!      ; (-@:[ <@{."_1 #:@:])/16 16 16 6 ,: 37525 21026 129 4
NB.!        (-: ".@:fmtB2I) b
NB.!      1
NB.!
NB.!  Maybe I shoudl explore hex options, like _16 ,@:(' ' sr '0')@:rjust@:(hfd@#.\) &.> b 
NB.!  
NB.!  An intermediate approach is my J4 utility 'shorthand'.
NB.!
NB.!         shorthand 0 0 0 0 0 0 0  1 0 0 0 0 0 0 0 0 1  0 0 0 0 
NB.!      (7#0), 1, (8#0), 1, 4#0
NB.! 
NB.!  We could embed the nouns in YAML along with their parsing code (or a type ID if in a 'standard' format).
NB.!
NB.  _2}.;<@:,&CRLF@:dtb"1 ' ' join 'AB' (,&':'@:[  , (5#' ')&(,"1)@:])&.>"1 'xy' ([: (,. ' '&,.)&.>/ ([`(0: <@:; <.@:-:@:{:@:$@:])`]} ' '&,@:((-.&' '"1)@:":@:$~ >@:{.@:(#~ [: (= >./) (= <./)@:(|@:(-/&>)) + 2: 0.5&*@:| {:&>)@:(#~ 2: = #&>)@:(, |.&.>)@:ap@:#))&.>)"1  smallInput

