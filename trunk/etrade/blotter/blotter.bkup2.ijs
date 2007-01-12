require'jmf doog winapi'

coclass 'blotter'
coinsert'base'

NB. Application directory of this script
me          =: getNmdPath ''
me          =: getNmdPath@:([ mkdir) dir__me ,'data\' NB.  Place to put data

NB.  Replace fills in a list with the last non-fill item.
NB.  First item must not be a fill.w
NB.  EG:  (drag  1 0 0 2 0 0 3 0 0 0 0 4 5 6 7 0 0 0 0 0 0 8)  -: (3 3 5 1 1 1 7 1#>:i.8)
NB.	 drag0 =:  {~ (I. {~ _1: + +/\)@:(+./"1@:~:&' ')
NB.	 drag1 =:  (;@:(<@:(# # 1: {. ]);.1)~ (+./"1@:~:&' ')) 
NB.	 drag2 =:  (#;.1 # #)~ +./"1@:~:&' '
NB.	 drag3 =:  [: > a: (] {~ (I. {~ _1 + +/\)@:~:)&.:s: ]
drag         =:  ((_1 + +/\)@] { #~)  [: -. ] -:"_1 _ [: {. 0 {. ]  NB.  Thanks to Powell & Nitikin

NB.  Faithful token-replacer.  Given a literal y comprising a sentence or definition 
NB.  (simple literal, LF-delimiter literal, or literal table) and a replacement specification x
NB.  (simple literal, vector of boxes, 2-column table of boxes), will replace {."1 x with {:"1 x
NB.  in the definition, preserving the layout and whitespace in the original definition.
NB.  Replacing strings of tokens is not yet possible (because of the intervening whitespace).
NB.  EG: 
NB.     X=.'x0 x1 x2'=.(< 'NAME OTHER'),(<;:'NAME OTHER'                   ),(< ,:;:'NAME OTHER'             )
NB.     Y=.'y0 y1 y2'=.(< 'NAME =: 4' ),(<  'NAME =: 4',LF,'more ... stuff'),(< 'NAME =: 4',:'more ... stuff')
NB.     *./ 'OTHER' -:&:{.&:,&:;: S: 0 rplcTokens&>/&.> { X ,&:< Y
rplcTokens   =:  dyad def '; (Y,~{:"1 x) {~ (Y,~{."1 x=._2 ]\^:(2 < #@$@]) ;:^:(0 -: L.) x) i. Y=.y <;.1~ 1 0:} (#&>wn) (] +.] (e.~ i.@:#)~ (+ I.)) +./ </\  (w=.= wn) (= +/)~&:((*+/\)"1) (wn =. ;: y) E.&> < y'"2 1

NB.  THe column-cutting mask is stored as  '';boolean
NB.  this extract the boolean.
hh           =:  ;@:({:"1)

NB.  dtb =: delete trailing blanks
NB.  mxb =: move extraneous blanks to end of string
NB.  dxb =: delete extraneous blanks
NB.  There are much better ways to do this, but since I'm only using it to process
NB.  the column names, not the column data, this'll suffice for now.
dtb         =:  ' ' & $: : (] {.~ #@:] (~: * ])&>: (= i: 0:))
mxb         =:  ' ' & $: : (] /: 2 ((1 |. </\)&.:-.@:] =/@:,:  *./\) =)
dxb         =:  ' ' & $: : ([ dtb mxb)


NB.  Lower-to-upper and spaces and slashes to underscores.
foldCase    =: ('__',UCALPHA,a.) {~ (' /',LCALPHA,a.) i. ]

NB.  The last column doesn't have a name, because it's just 
NB.  a 1 by N column of carriage returns.  So name it CRs.
normalNames =: [: a: sr ({.;:'CRLFs') foldCase&.> 

NB.  We need to use fully qualified names to map files.
fqn         =: , '_' , '_' ,~ ;@:coname@:(''"_)

fcopy =: 'CopyFile' win32api

create      =:  verb define
	cfg     =. cocreate ''
	ofn     =. getNmdPath y	
	fn      =: getNmdPath fullname__ofn,~([ mkdir) dir__me,basename__ofn,'\'

	fcopy y;path__fn;1
	('Couldn''t copy "',y,'" to "',path__fn,'"') assert fexist path__fn
	tablify fn

)

tablify     =: verb define
	NB. Meta-information about the file: header, trailer, lines.
	(N)           =:  cocreate@:(0&$)&.> N=.;:'hdr tlr lin'

	NB.  Map the file
	JCHAR map_jmf_ b;path__fn;1;~b=. fqn 'B'

	NB.  Boolean cut mask, integer equivalent, length of each line
	lens__lin     =.  +/\^:_1: idx__lin    =. I. LFs__lin =. LF = B	

	NB.  Number of lines before the first blank one.
	ln_ct__hdr    =.  >: 2 i.~ lens__lin

	NB.  Number of 
	nms__hdr      =.  '__hdr' , L:0~ ;: 'preamble colname0 colname1'
	hd            =.  B {.~ bytes__hdr =. 1 + +/  ln_ct__hdr {. lens__lin
	(nms__hdr)    =.  (#nms__hdr) {. hd <;.2~ bytes__hdr {. LFs__lin

	NB.  The column-name header should determine how wide the file is.
	assert. (# colname1__hdr) -: file_width =. >./lens__lin

	NB.  Report sometimes ends with a bunch of blank lines; trim these.
	data_end      =.  idx__lin {~ last__lin =. 1 + 2 (~: i: 1:) lens__lin
	bytes__tlr    =.  +/lens__lin {.~ -ln_ct__tlr =. last__lin  -~ # idx__lin

	NB.  Since we reduced the file, we have to correspdoningly reduce line byte counts.
	NB.  The  (n)=:  method either runs out of memory or crashes.  
	NB.       (n) =: (HEADER_BYTES,HEADER_LINE_COUNT,HEADER_LINE_COUNT) (}.~ ".)&.> n =. ;: 'LFs LINE_LENS LINE_IDX'
	NB.
	NB.  I thought there was special code for  name =: number }. name, but there doesn't appear to be.
	NB.  the best move might be to just recalculate these (after mapping in the reduced data set)..
	'bytes__hdr ln_ct__hdr ln_ct__hdr' ([: 0:@:". ] , '=: ' ,        [       , ' }. ' , ])L: 0 &:;: n=. 'LFs__lin lens__lin idx__lin'
	'bytes__tlr ln_ct__tlr ln_ct__tlr' ([: 0:@:". ] , '=: ' , '(-' , [ , ')' , ' }. ' , ])L: 0 &:;: n

	NB.  Trim file down to this size.
	file_shape    =.  file_width ,~ file_len =. (#idx__lin)-ln_ct__hdr+ln_ct__tlr

	NB.  Create a JMF file just large enough to hold the data portion of the file.
	fnd           =.  getNmdPath path__fn,'.data'
	createjmf_jmf_ path__fnd;1000 + */file_shape   NB. 1000+ For a little JMF header padding.
    (JCHAR;file_width) map_jmf_ path__fnd;~ t=.fqn 'T'

	NB.  Extract only the data portion of the raw file
	T             =:  LFs__lin ];.2 B ];.0~ ,:/ bytes__hdr  ,  _1 + data_end - bytes__hdr

	unmap_jmf_ b
	erase 'n'

	T             =:  (_,file_width) {. T
)

NB.  Todo:  Move all locally defined names in this verb into the locale specified by  y
NB.  that'll be easier for debugging.  This includes mapped names.
NB.  Todo:  Come up with a cleaner file naming strategy (subdirectories?)
NB.  Todo: Normalize naming scheme.
NB.  Todo:  Run this under jstd to figure out which of my personl utilities are needed.
parse       =: verb define

	smoutput path__me   

	
	NB.  Reset.
	unmapall_jmf_''


	NB.  Map the file
	JCHAR map_jmf_ 'B';fn__y;'B';1
	

	NB.  Boolean cut mask, integer equivalent, length of each line
	LINE_LENS     =.  +/\^:_1: LINE_IDX     =. I. LFs =. LF = B

	NB. First  N  lines of file
	HEADER_LS     =.  HEADER_LINE_COUNT__y {.!.({.;:'blank');:'preamble colname0 colname1'
	HEADER        =.  B {.~ HEADER_BYTES =. 1 + +/ HEADER_LINE_COUNT__y {. LINE_LENS
	(HEADER_LS)   =.  (HEADER_BYTES{.LFs) <;._2 HEADER

	NB.  Report sometimes ends with a bunch of blank lines; trim these.
	DATA_ENDS_AT  =:  LINE_IDX  {~  LAST_GOOD_LINE =. 1 + 2 (~: i: 1:) LINE_LENS
	TRAILER_BYTES =:  +/LINE_LENS {.~ TLC =. -TRAILER_LINE_COUNT =. LAST_GOOD_LINE  -~ # LINE_IDX  

	NB.  Remove header and trailer, write new file with just the data portion.
	(fnd =. fn__y,'.data') fwrite~ fread fn__y ; HEADER_BYTES  ,  _1 + DATA_ENDS_AT - HEADER_BYTES 

	NB.  Unmap original (dirty) file.
	unmap_jmf_     'B'

	NB.  Since we reduced the file, we have to correspdoningly reduce line byte counts.
	NB.  The  (n)=:  method either runs out of memory or crashes.  
	NB.       (n) =: (HEADER_BYTES,HEADER_LINE_COUNT,HEADER_LINE_COUNT) (}.~ ".)&.> n =. ;: 'LFs LINE_LENS LINE_IDX'
	NB.
	NB.  I thought there was special code for  name =: number }. name, but there doesn't appear to be.
	NB.  the best move might be to just recalculate these (after mapping in the reduced data set)..
	'HEADER_BYTES HEADER_LINE_COUNT__y HEADER_LINE_COUNT__y' ([: 0:@:". ] , '=. ' ,        [       , ' }. ' , ])L: 0 &:;: n=. 'LFs LINE_LENS LINE_IDX'
	'TRAILER_BYTES TRAILER_LINE_COUNT TRAILER_LINE_COUNT'    ([: 0:@:". ] , '=. ' , '(-' , [ , ')' , ' }. ' , ])L: 0 &:;: n

	NB.  Map in cleaned up file, readonly.
	JCHAR map_jmf_ 'B2';fnd;'B2';1

	NB.  Create JMF to hold cleaned data (as a J noun: a literal with rank 2)
	createjmf_jmf_ (fnc=.,fn__y,'.cln');(1000+ LINE_IDX *&# colname1)
	(JCHAR;#colname1) map_jmf_ 'B3';fnc
	B3            =:  (_,#colname1) {. LFs ];.2   B2

	unmap_jmf_   'B2'
	
	NB.  Now that the line ends are implicit in the shape of B3, we can erase
	NB.  the space-hogging line-related nouns.  If I change  LF  to  LF__y  I'll
	NB.  have to remember to update the definition of  n  .
	erase n


	NB.  This is a report, intended to be printed on paper,
	NB.  so it contains formfeeds (neccesarily after a linefeed,
	NB.  hence only in column 0).  Replace formfeeds with spaces.
	formfeeds     =. ''"_^:(0 = #) 0 <@:,"0~ (12{a.) I.@:= {."1 B3
	space         =.  > ('';' ') {~ * # formfeeds
	B3            =:  space formfeeds } B3 

	NB.  Try to guess the widths of the columsn from the spaces in the column names.
	NB.  Todo: This method is unreliable, so we'll have to hard code the widths,
	NB.  then assert. widths -: +/\^:_1:I.*./' '=B3
	NB.  The words at the end of the line here are supposed to have spaces in them, so
	NB.  don't count those as delimiters.  The 0 _1 }  turns on the first and last boolean;
	NB.  the first so that  ;.1  works an the last to seperate the last column from the 1 by N 
	NB.  column of carriage returns are the end of B3.  See the definition of normalNames.
	colmsk        =.  1 (0 _1) } 1 0 E. (colname1 = ' ') > +./ colname1 E S: 0~ ' ID';' Qty';'Time ';'Entry ';'Action '
	COLMSK        =.  '';colmsk
	
	NB.  Fold the two-line column names into single names.  
	COLS          =.  (colname0,:colname1) <@:(CR sr ' ');.1~ COLMSK
	
	NB.  Normalize the parsed column names into valid J identifiers.
	colnames      =.  ' ' ([ dxb ,@:,.)&.> COLS
	COL_NAMES     =.  normalNames colnames
	assert. _1 = nc COL_NAMES 
	
	NB.  Best guess at column widths, based on non-ignored spaces in the header lines (column names)..
	col_widths    =.  #;.1 colmsk


	NB.  Fix up the guess from Itay's specifications and personal experience.
	NB.	itay          =.  ;:'account 10 last 11 first 11 order_id 11 trader_id 10 status 9 b_s_ss_o_c 12 quantity 10 symbol 8 optionsymbol 13 mkt_lmt 9 tif 5 type 5 time_entered 12 b_s 9 fill_qty 8 price 8 report 14 action_time 6'
	NB.	'ITY_N ITY_L' =.  (,&< ;)/|: ITY =. (normalNames@:[ ,: 0 ".&.> ])/&.:|:_2]\itay
	NB.	col_widths_fixed =: col_widths (COL_NAMES i. itay_corrected_names)}~  ITAY_L {~ ITAY_N i. itay_corrected_names =. ;: 'ACCOUNT TIME_ENTERED B_S FILL_QTY'  NB.  REPORT
	NB.	COLMSKFIXED =: '';(# hh COLMSK) xb 0,+/\col_widths_fixed
	HAND_MUNGE    =.  ;:'first 12 order_id 10 b_s_ss_o_c 10 order_quantity 12 order_status 8 trader_id 11'
	'HND_N HND_L' =.  (,&< ;)/|: HND =. (normalNames@:[ ,: 0 ".&.> ])/&.:|:_2]\HAND_MUNGE 
	
	col_widths_fixed =. col_widths (COL_NAMES i. HND_N)}~  HND_L
	COLMSKFIXED   =. '';(# colmsk) xb 0,+/\col_widths_fixed
	
	NB.  Create one JMF per column
	(400+(#B3)* col_widths_fixed ) (createjmf_jmf_@:,<)"_1~ column_file_names =. fn__y , L: 0 '.' ,&.>COL_NAMES
	(JCHAR ;"_1 col_widths_fixed ) map_jmf_"_1 COL_NAMES ,. column_file_names 
	
	NB.  Create verbs to populate & manipulate the mapped columns.I would use indirect 
	NB.  assignment instead of  3 : 'NAME =: y' but that would involve 
	NB.  large intermediate arrays, and I'd run out of memory.
	TEMPLATE      =. 3 : '< NAME =: y' : (4 : '< NAME =: y x } NAME')
	('`',;:^:_1 'ag_',L:0 COL_NAMES ) =. ASSIGNING_VERBS =. (COL_NAMES ,.~ {.;:'NAME') (rplcTokens~ ,:)~ :: ] L: 1 0"_1 ] 5!:1{.;:'TEMPLATE'

	NB.  Populate mapped columns with data.
	COLMSKFIXED ASSIGNING_VERBS;.1 B3  NB.  BLOTTER =: 

	NB.  Could unmap B3 now, but let's user it to fix some data problems first..
	NB.
	NB.  First problem:  Some lines have a leading space, which pushes each field over 
    NB.  by one character.  Fix it.
    COLMSKFIXED  (({.;:'M') '&' doog ASSIGNING_VERBS);.(1) 1 |."1  B3 {~  M=.  I.1 0 -:"1  ' ' = 2 {."1 ACCOUNT
	unmap_jmf_ 'B3'
	NB.  Second "problem":  The account, first, and last names are not mentioned on every line,
	NB.  they're only mentioned when they change.
	(ASSIGNING_VERBS {~ COL_NAMES i. draggable) Atop drag AcrossBoxed ".&.> draggable =.;: 'ACCOUNT FIRST LAST'
	NB.  Third "problem":  The ADP account column uses the form ABCD-EFGH; we want the form
	NB.  ABCDEFGH.  
	NB.  Only want to remove the middle column if we're SURE we won't lose information thereby.
    assert. '-' = 4 {"1 ACCOUNT  NB.  Don't want to do  
	ACCOUNT       =:  sa {. ACCOUNT #"1~ 4~:i. {:sa=.$ACCOUNT

	NB. ASSIGNING_VERBS AcrossBoxed FLEM (}."_1 ".)&.> COL_NAMES	
    i. 0 0
)



	NB.  I hate the J editor
	NB.  I really do
   
NB.   parse CONFIGURE''