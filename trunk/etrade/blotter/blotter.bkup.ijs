HORST =: verb define

	drag0  =:  {~ (I. {~ _1: + +/\)@:(+./"1@:~:&' ')
	drag1  =:  (;@:(<@:(# # 1: {. ]);.1)~ (+./"1@:~:&' ')) 
	drag2  =:  (#;.1 # #)~ +./"1@:~:&' '
	drag3  =:  [: > a: (] {~ (I. {~ _1 + +/\)@:~:)&.:s: ]

	require'doog'
	require 'jmf'
	unmapall_jmf_''
	fn =:  'C:\Documents and Settings\dbron\My Documents\blotter\Blotter10172006.txt'
	JCHAR map_jmf_ 'B';fn;'B';1
	
	NB. UNSAFE_ASSUMPTION =: 5000 
	HEADER_LINE_COUNT =: 4
	'preamble colname0 colname1 blank'=:  (HEADER_BYTES{.LFs) <;._2 HEADER =: B {.~ HEADER_BYTES =: 1 + +/ HEADER_LINE_COUNT {. LINE_LENS =: +/\^:_1: LINE_IDX =: I. LFs =: LF = B
	DATA_ENDS_AT =: LINE_IDX  {~ LAST_GOOD_LINE =: 1 + 2 (~: i: 1:) LINE_LENS 
	TRAILER_BYTES =: +/LINE_LENS {.~ TLC =: -TRAILER_LINE_COUNT =: LAST_GOOD_LINE  -~ # LINE_IDX  
	(fnd =: fn,'.data') fwrite~ fread fn ; HEADER_BYTES  ,  _1 + DATA_ENDS_AT - HEADER_BYTES 
	NB. unmapall_jmf_ ''
	unmap_jmf_ 'B'
	
	NB.  The  (n)=:  method either runs out of memory or crashes.  
	NB. 0:(n) =: (HEADER_BYTES,HEADER_LINE_COUNT,HEADER_LINE_COUNT) (}.~ ".)&.> n =. ;: 'LFs LINE_LENS LINE_IDX'
	
	NB.  I thought there was special code for  name =: number }. name, but there doesn't appear to be.
	NB.  the best move might be to just recalculate these (after mapping in the reduced data set)..
	'HEADER_BYTES HEADER_LINE_COUNT HEADER_LINE_COUNT'    ([: 0:@:". ] , '=: ' ,       [        , ' }. ' , ])L: 0 &:;: 'LFs LINE_LENS LINE_IDX'
	'TRAILER_BYTES TRAILER_LINE_COUNT TRAILER_LINE_COUNT' ([: 0:@:". ] , '=: ' , '(-' , [ , ')' , ' }. ' , ])L: 0 &:;: n=. 'LFs LINE_LENS LINE_IDX'
	NB. ". each 'HEADER_LINE_COUNT HEADER_LINE_COUNT' (] , '=: ' , [ , ' }. ' , ])L: 0 &:;: 'LINE_LENS LINE_IDX'
	
	JCHAR map_jmf_ 'B2';fnd;'B2';1
	createjmf_jmf_ (fnc=:fn,'.cln');(1000+ LINE_IDX *&# colname1)
	(JCHAR;#colname1) map_jmf_ 'B3';fnc
	B3=:(_,#colname1) {. LFs ];.2   B2
	formfeeds =. ''"_^:(0 = #) 0 <@:,"0~ (12{a.) I.@:= {."1 B3
	space =. > ('';' ') {~ * # formfeeds
	B3 =: space formfeeds } B3 
	erase n
	unmap_jmf_ 'B2'
	
	hh	=: ;@:({:"1)
	
	
	COLS     =: (colname0,:colname1) <@:(CR sr ' ');.1~ COLMSK=:'';1 (0 _1) } 1 0 E. (colname1 = ' ') > +./ colname1 E S: 0~ ' ID';' Qty';'Time ';'Entry ';'Action '
	
	dtb =: ' ' & $: : (] {.~ #@:] (~: * ])&>: (= i: 0:))
	mxb =: ' ' & $: : (] /: 2 ((1 |. </\)&.:-.@:] =/@:,:  *./\) =)
	dxb =: ' '&$: : ([ dtb mxb)
	
	colnames =: ' ' ([ dxb ,@:,.)&.> COLS
	foldCase =: ('__',UCALPHA,a.) {~ (' /',LCALPHA,a.) i. ]
	normalizeNames =: [: a: sr ({.;:'CRS') foldCase&.> 
	COL_NAMES =: normalizeNames colnames
	assert _1 = nc COL_NAMES 
	
	col_widths=:#;.1 ;{:COLMSK
	
	itay =. ;:'account 10 last 11 first 11 order_id 11 trader_id 10 status 9 b_s_ss_o_c 12 quantity 10 symbol 8 optionsymbol 13 mkt_lmt 9 tif 5 type 5 time_entered 12 b_s 9 fill_qty 8 price 8 report 14 action_time 6'
	'ITAY_N ITAY_L'=: (,&< ;)/|: ITAY =: (normalizeNames@:[ ,: 0 ".&.> ])/&.:|:_2]\itay
	
	col_widths_fixed =: col_widths (COL_NAMES i. itay_corrected_names)}~  ITAY_L {~ ITAY_N i. itay_corrected_names =. ;: 'ACCOUNT TIME_ENTERED B_S FILL_QTY'  NB.  REPORT
	COLMSKFIXED =: '';(# hh COLMSK) xb 0,+/\col_widths_fixed
	
	HAND_MUNGE =. ;:'first 12 order_id 10 b_s_ss_o_c 10 order_quantity 12 order_status 8 trader_id 11'
	'HAND_N HAND_L'=: (,&< ;)/|: HAND =: (normalizeNames@:[ ,: 0 ".&.> ])/&.:|:_2]\HAND_MUNGE 
	
	col_widths_fixed =: col_widths (COL_NAMES i. HAND_N)}~  HAND_L
	COLMSKFIXED =: '';(# hh COLMSK) xb 0,+/\col_widths_fixed
	
	
	
	
	J=:(400+(#B3)* col_widths_fixed ) (createjmf_jmf_@:,<)"_1~ column_file_names =: fn , L: 0 '.' ,&.>COL_NAMES
	K=:(JCHAR ;"_1 col_widths_fixed ) map_jmf_"_1 COL_NAMES ,. column_file_names 
	
	rplcTokens =: 4 : '; (Y,~{:"1 x) {~ (Y,~{."1 x) i. Y=.y <;.1~ 1 0:} (#&>wn) (] +.] (e.~ i.@:#)~ (+ I.)) +./ </\  (w=.= wn) (= +/)~&:((*+/\)"1) (wn =. ;: y) E.&> < y'"2 1
	
	TEMPLATE =: 3 : '< NAME =: y' : (4 : '< NAME =: y x } NAME')
	
	NB.  I would use indirect assignment instead of  3 : 'NAME =: y' but that would involve 
	NB.  large intermediate arrays, and I'd run out of memory.
	('`',;:^:_1 'ag_',L:0 COL_NAMES ) =:ASSIGNING_VERBS =: (COL_NAMES ,.~ {.;:'NAME') (rplcTokens~ ,:)~ :: ] L: 1 0"_1 ] 5!:1{.;:'TEMPLATE'
	
	COLMSKFIXED ASSIGNING_VERBS;.1 B3  NB.  BLOTTER =: 
	NB.  Could unmap B3 now, but let's fix some data problems first..

	NB. BLOTTER =: (COL_NAMES) =: (COLMSKFIXED <;.1] 1 |."1&:> ,.&.>/ BLOTTER #&.>~ <M=.1 0 -:"1 ' ' = 2 {."1 ACCOUNT) (I.M)}&.> BLOTTER
	NB. (<M) (ASSIGNING_VERBS Every '::' doog ]) `:0 COLMSKFIXED <;.(1) 1 |."1 B3{~M=:I.1 0-:"1' '=2{."1 ACCOUNT
    COLMSKFIXED  (({.;:'M') '&' doog ASSIGNING_VERBS);.(1) 1 |."1  B3 {~  M=:  I.1 0 -:"1  ' ' = 2 {."1 ACCOUNT

	NB.  J CRASHES ON THE FOLLOWING LINE
	NB. ((ASSIGNING_VERBS {~ COL_NAMES i. draggable) Atop drag0 Across  ".)&.> draggable =.;: 'ACCOUNT FIRST LAST'
	(ASSIGNING_VERBS {~ COL_NAMES i. draggable) Atop drag0 AcrossBoxed ".&.> draggable =.;: 'ACCOUNT FIRST LAST'

    assert. '-' = 4 {"1 ACCOUNT  NB.  Don't want to do  

	ACCOUNT =: sa {. ACCOUNT #"1~ 4~:i. {:sa=.$ACCOUNT

	NB. ASSIGNING_VERBS AcrossBoxed FLEM (}."_1 ".)&.> COL_NAMES	

    i. 0 0
)

DRAG  =: verb define 
   
   msk =. 0 < lens =. _1 + | 2 -/\ (1+#y),~ good =. 1 + I. +./"1 ' ' ~: y
   runs =. good (+ i.)&.>&:(msk&#) lens
   for_run. runs do.
		fill =. y {~ <: {. r =. ; run
  		y    =. fill r} y
   end.

	y
)


	NB.  I hate the J editor
	NB.  I really do
   
