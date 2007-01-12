require'jmf doog winapi'

coclass 'blotter'
coinsert'base'

NB. Application directory of this script
me                   =: getNmdPath ''
me                   =: getNmdPath@:([ mkdir) dir__me ,'data\' NB.  Place to put data

NB.  Replace fills in a list with the last non-fill item.
NB.  First item must not be a fill.w
NB.  EG:  (drag  1 0 0 2 0 0 3 0 0 0 0 4 5 6 7 0 0 0 0 0 0 8)  -: (3 3 5 1 1 1 7 1#>:i.8)
NB.	 drag0           =:  {~ (I. {~ _1: + +/\)@:(+./"1@:~:&' ')
NB.	 drag1           =:  (;@:(<@:(# # 1: {. ]);.1)~ (+./"1@:~:&' ')) 
NB.	 drag2           =:  (#;.1 # #)~ +./"1@:~:&' '
NB.	 drag3           =:  [: > a: (] {~ (I. {~ _1 + +/\)@:~:)&.:s: ]
drag                 =:  ((_1 + +/\)@] { #~)  [: -. ] -:"_1 _ [: {. 0 {. ]  NB.  Thanks to Powell & Nitikin

NB.  Faithful token-replacer.  Given a literal y comprising a sentence or definition 
NB.  (simple literal, LF-delimiter literal, or literal table) and a replacement specification x
NB.  (simple literal, vector of boxes, 2-column table of boxes), will replace {."1 x with {:"1 x
NB.  in the definition, preserving the layout and whitespace in the original definition.
NB.  Replacing strings of tokens is not yet possible (because of the intervening whitespace).
NB.  EG: 
NB.     X            =.'x0 x1 x2'=.(< 'NAME OTHER'),(<;:'NAME OTHER'                   ),(< ,:;:'NAME OTHER'             )
NB.     Y            =.'y0 y1 y2'=.(< 'NAME =: 4' ),(<  'NAME =: 4',LF,'more ... stuff'),(< 'NAME =: 4',:'more ... stuff')
NB.     *./ 'OTHER' -:&:{.&:,&:;: S: 0 rplcTokens&>/&.> { X ,&:< Y
rplcTokens           =:  dyad def '; (Y,~{:"1 x) {~ (Y,~{."1 x=._2 ]\^:(2 < #@$@]) ;:^:(0 -: L.) x) i. Y=.y <;.1~ 1 0:} (#&>wn) (] +.] (e.~ i.@:#)~ (+ I.)) +./ </\  (w=.= wn) (= +/)~&:((*+/\)"1) (wn =. ;: y) E.&> < y'"2 1

NB.  dtb =: delete trailing blanks
NB.  mxb =: move extraneous blanks to end of string
NB.  dxb =: delete extraneous blanks
NB.  There are much better ways to do this, but since I'm only using it to process
NB.  the column names, not the column data, this'll suffice for now.
dtb                  =:  ' ' & $: : (] {.~ #@:] (~: * ])&>: (= i: 0:))
mxb                  =:  ' ' & $: : (] /: 2 ((1 |. </\)&.:-.@:] =/@:,:  *./\) =)
dxb                  =:  ' ' & $: : ([ dtb mxb)


NB.  Lower-to-upper and spaces and slashes to underscores.
foldCase             =: ('__',UCALPHA,a.) {~ (' /',LCALPHA,a.) i. ]

NB.  The last column doesn't have a name, because it's just 
NB.  a 1 by N column of carriage returns.  So name it CRs.
normalNames          =: [: a: sr ({.;:'CRLFs') foldCase&.> 

NB.  We need to use fully qualified names to map files.
fqn                  =: , '_' , '_' ,~ ;@:coname@:(''"_)

NB.  Faster than t (fwrite~ fread) s
fcopy                =: 'CopyFile' win32api

create               =:  verb define

	NB.  File paths:
	NB.
	NB.  Original file
	fno              =: getNmdPath y	
	NB.  My subdirectory of the blotter application dir
	fn               =: getNmdPath ([ mkdir) dir__me,basename__fno,'\' 
	NB.  A subdir of that, where I'll keep a copy of the original, plus	
	NB.  the trimmed down file.
	mycopy__fn       =. getNmdPath fullname__fno,~([ mkdir) dir__fn,'source\'

	NB. Get copy of source data.
	fcopy y;path__mycopy__fn;1  NB.  1 means don't clobber a pre-existing file.
	assert. fexist path__mycopy__fn

	NB.  When I return  hdr ,&:< T from tablify, and assign
	NB.  'hdr T=:  <"> tablify fn
	NB.  J crashes.  So, just in this case, pass T around as a global (which it is anyway)
	hdr             =. tablify mycopy__fn  
	meta            =: hdr get_meta T

	NB.  Now cut T into columns
	T cutcols~  meta ,&:< fn

	NB.  Cleanup
	NB.  Have the columns now, no longer require T.
	unmap_jmf_ fqn'T'
	NB.  Non-useful locales
	coerase hdr  NB.  Could save  preamble__hdr ..

	i. 0 0
)

tablify             =:  verb define
	NB. Meta-information about the file: header, trailer, lines.
	(N)             =.  cocreate@:(0&$)&.> N=.;:'hdr tlr lin'

	NB.  Map the file
	JCHAR map_jmf_ b;path__y;1;~b=. fqn 'B'

	NB.  Boolean cut mask, integer equivalent, length of each line
	lens__lin       =.  +/\^:_1: idx__lin    =. I. LFs__lin =. LF = B	

	NB.  Number of lines before the first blank one.
	ln_ct__hdr      =.  >: 2 i.~ lens__lin

	NB.  Number of 
	nms__hdr        =.  '__hdr' , L:0~ ;: 'preamble colname0 colname1'
	hd              =.  B {.~ bytes__hdr =. 1 + +/  ln_ct__hdr {. lens__lin
	(nms__hdr)      =.  (#nms__hdr) {. hd <;.2~ bytes__hdr {. LFs__lin

	NB.  The column-name header should determine how wide the file is.
	assert. (# colname1__hdr) -: file_width =. >./lens__lin

	NB.  Report sometimes ends with a bunch of blank lines; trim these.
	data_end        =.  idx__lin {~ last__lin =. 1 + 2 (~: i: 1:) lens__lin
	bytes__tlr      =.  +/lens__lin {.~ -ln_ct__tlr =. last__lin  -~ # idx__lin

	NB.  Since we reduced the file, we have to correspdoningly reduce line byte counts.
	NB.  The  (n)=:  method either runs out of memory or crashes.  
	NB.       (n) =: 'bytes__hdr ln_ct__hdr ln_ct__hdr' }.&:".&.>&:;: n =. 'LFs LINE_LENS LINE_IDX'
	NB.
	NB.  I thought there was special code for  name =: number }. name, but there doesn't appear to be.
	NB.  the best move might be to just recalculate these (after mapping in the reduced data set)..
	'bytes__hdr ln_ct__hdr ln_ct__hdr' ([: 0:@:". ] , '=: ' ,        [       , ' }. ' , ])L: 0 &:;: n=. 'LFs__lin lens__lin idx__lin'
	'bytes__tlr ln_ct__tlr ln_ct__tlr' ([: 0:@:". ] , '=: ' , '(-' , [ , ')' , ' }. ' , ])L: 0 &:;: n

	NB.  Trim file down to this size.
	file_shape      =.  file_width ,~ file_len =. #idx__lin

	NB.  Create a JMF file just large enough to hold the data portion of the file.
	fnd             =.  getNmdPath path__fn,'.data'
	createjmf_jmf_ path__fnd;1000 + */file_shape   NB. 1000+ For a little JMF header padding.
    (JCHAR;file_width) map_jmf_ path__fnd;~ t=.fqn 'T'

	NB.  Extract only the data portion of the raw file and expand each 
    NB.  row to the maximum line length (to make the array rectangular).
	T               =:  LFs__lin ];.2 B ];.0~ ,:/ bytes__hdr  ,  _1 + data_end - bytes__hdr
	T               =:  file_shape {. T

	unmap_jmf_ b
	coerase lin,trl

	T               =: clean T  

	hdr
)

clean               =: verb define
	NB.  Normalize file (at the table level; column-specific transformations
	NB.  are not in this verb)

	NB.  This is a report, intended to be printed on paper,
	NB.  so it contains formfeeds (neccesarily after a linefeed,
	NB.  hence only in column 0).  Replace formfeeds with spaces.
	formfeeds       =: ''"_^:(0 = #) 0 <@:,"0~ (12{a.) I.@:= {."1 y
	space           =.  > ('';' ') {~ * # formfeeds
	y               =.  space formfeeds } y


	NB.  Some lines have a leading space, which pushes each field over 
    NB.  by one character.  Fix it.
	M               =.  I. 1 0 -:"1  ' ' = 2 {."1 y 
	c               =.  1 |."1 M { y
    y               =.  c M } y
    
)

get_meta            =:  dyad define
	NB.  Try to guess the widths of the columsn from the spaces in the column names.
	NB.  Todo: This method is unreliable, so we'll have to hard code the widths,
	NB.  then assert. widths -: +/\^:_1:I.*./' '=B3
	meta            =.  cocreate ''

	NB.  The words at the end of the line here are supposed to have spaces in them, so
	NB.  don't count those as delimiters.  The 0 _1 }  turns on the first and last boolean;
	NB.  the first so that  ;.1  works an the last to seperate the last column from the 1 by N 
	NB.  column of carriage returns are the end of B3.  See the definition of normalNames.
	mask__meta      =.  1 (0 _1) } 1 0 E. (colname1__x = ' ') > +./ colname1__x E S: 0~ ' ID';' Qty';'Time ';'Entry ';'Action '
	
	NB.  Fold the two-line column names into single names.  
	cols            =.  ('';mask__meta) <@:(e.&CRLF`(,:&' ') });.1 colname0__x,:colname1__x
	
	NB.  Normalize the parsed column names into valid J identifiers.
	colnames        =.  ' ' ([ dxb ,@:,.)&.> cols
	names__meta     =.  normalNames colnames
	assert. _1 = nc names__meta
	
	NB.  Best guess at column widths, based on non-ignored spaces in the header lines (column names)..
	widths__meta    =.  #;.1 mask__meta

	NB.  Fix up the guess from Itay's specifications and personal experience
	NB.  with this specific data.
	h               =.  hand__meta  =.  cocreate''

	munge__h        =.  ;:'first 12 order_id 10 b_s_ss_o_c 10 order_quantity 12 order_status 8 trader_id 11'
	'names__h widths__h' =.  (,&< ;)/|: (normalNames@:[ ,: 0 ".&.> ])/&.:|:_2]\ munge__h
	
	fwidths__meta   =.  widths__h (names__meta i. names__h)} widths__meta
	fmask__meta     =.  (# mask__meta) xb 0 , +/\ fwidths__meta
	
	count__meta     =. #y

	meta
)

cutcols             =:  dyad define
	NB. proc    =:  cocreate ''
	'meta me' =. x

	NB.  Create one JMF per column.  400&+  for JMF header & fluff.
	(400+fwidths__meta * count__meta) (createjmf_jmf_@:,<)"_1~ fncs =. dir__me , L: 0 names__meta
	(JCHAR ;"_1 fwidths__meta) map_jmf_"_1 names__meta ,. fncs

	NB.  Create verbs to populate & manipulate the mapped columns.I would use indirect 
	NB.  assignment instead of  3 : 'NAME =: y' but that would involve 
	NB.  large intermediate arrays, and I'd run out of memory.
	TEMPLATE        =.  3 : '< NAME =: y' : (4 : '< NAME =: y x } NAME')
	verbs__meta     =.  '`' , ;:^:_1 'm_' , L:0 names__meta 
	mutators__meta  =.  (verbs__meta) =. (names__meta ,.~ {. ;:'NAME') (rplcTokens~ ,:)~ :: ] L: 1 0"_1 (5!:1) {. ;: 'TEMPLATE'

	y mutators__meta;.1~ '';fmask__meta

    cleancols meta
)

cleancols           =:  verb define
	NB.  The ACCOUNT, FIRST, and LAST names are not mentioned on every line,
	NB.  they're only mentioned when they change.
	(mutators__y {~ names__y i. draggable) Atop drag AcrossBoxed ".&.> draggable =.;: 'ACCOUNT FIRST LAST'

	NB.  The ADP account column uses the form ABCD-EFGH; we want the form ABCDEFGH.
	NB.  Only want to remove the middle column if we're SURE we won't lose information thereby.
    assert. '-' = 4 {"1 ACCOUNT 
	ACCOUNT       =:  sa {. ACCOUNT #"1~ 4~:i. {:sa=.$ACCOUNT
	
	i. 0 0
)