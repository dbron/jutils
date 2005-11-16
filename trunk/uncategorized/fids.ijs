NB.  Dependecies:  Table
load 'c:\danielb\projects\work\order_manager\main\dev\table\default\table.ijs'

NB.  Fids fields
ENUMED_FIDS_FIELDS	=:  FieldDefs noun define
"ACRONYM:10         Reuters Field Identifier
"DDE:21             DDE Acronum.  Available in APPB202T.txt but not enumtype.def.  Really should calculate length.
#FID                FID as a number.
"ENUM:4             Locale of enumeration table.   Hope that we get less than 9999 numeric locales.  Could solve this by making field numeric.
)

NB.  Enumeration fields
ENUM_FIELDS		=:  FieldDefs noun define
#NUM                Value as a number
"STR:14             Value as a string
"DESC:57            Description of the value
)

FIDS_FIELDS_NOUN     =:  noun define
"ACRONYM:10
"DDE:21
#FID
"RIPPLES:12
"TYPE:12
#LENGTH
#ENUMLEN
"DESC:$MAX_DESC_LEN$
)

NB.  Given a FieldDef on the left and a table (in external form) on the right, output a Table.
formulate		=:  dyad define
	T =. Table x.
	Insert__T ,: (< 1 { |: x.)  ,  ('#' = ; 0 { |: x.) ,@:(1&{.@:(0&".)"1) apply each (2 { |: x.) {."1 each  <@:>"1|:  y.
	T
)

NB.  Parse Reuter's FIDS definition file.
cooky			=:  trim each LF arbCut CR -.~ fread '\\statarb2\idt_data\Reuters\Docs\Rel2\APPB202T.TXT' NB. '\\rutherford\dfs\Applications\ExchangeFeed\Reuters\enumtype.def'

NB.  Get rid of the useles comments fields (but keep the ones that tell us how to parse the file).
pooky			=:  a: -.~ }. cooky #~ (-:&:(/:~)&'! -'@:~.&> +. ~:&'!'@:head&>) cooky

NB.  Split the file into meta-data and data
'counts things'	=:  <"1|: (({. , [: < }.);.1~ '!'&=@:({.&>)) pooky 

NB.  Using the meta-data, figure out how to parse the data.
cutmasks		=:  ((   hounds =: +/@:(0 1&E.)@:=&' '&> counts) ( (] 1&(|.!.1)@:}.@:*. (> +/\)) each )each (1 0&E.@:(> ~:/\)/@:(="_ 0&' "'))@:,&' ' L: 0 things) 

NB.  Parse the data
lug				=:  > each cutmasks (<@:trim;.2) L:0 things 

NB.  Split the parsed data into fids and enumerations
NB.'fids enums'	=:  <"1 > (2 = hounds) </. lug  NB.  Used when we were reading '\\rutherford\dfs\Applications\ExchangeFeed\Reuters\enumtype.def' instead
'enums fids'	=:  <"1 |: 2&( ] $~ [  ,~ (<.@:%~ #)) lug
NB.  Create a table for each enumeration
locales			=:  enums formulate &.>~ <ENUM_FIELDS

NB.!!!  THe wrong enumerations are being associated with FIDS -- fix this!

NB.  Create a table for the fids, with a foriegn key to the appropriate enumeration table.
FIDS			=:  ENUMED_FIDS_FIELDS	formulate ; fids ,.&.> locales


NB.!!!! ALSO DO '\\statarb2\idt_data\Reuters\Docs\Rel2\APPA202.TXT', APPD202.txt and other '\\statarb2\idt_data\Reuters\Docs\*.txt files

HHH =: LF arbCut CR -.~ fread '\\statarb2\idt_data\Reuters\Docs\Rel2\APPA202.TXT'
HH =: HHH <;.1~ 1 (0}) '!' ~: head&> HHH
'fields descs' =: <"1 |: }. (>@:{. ,&< }.)&> HH
MAX_DESC_LEN =: >./ #&> descs =: trim@:('!' sr ' ')@:; &.> }: descs

FIDS_FIELDS =: FieldDefs doString FIDS_FIELDS_NOUN  NB.  Now that we know how big the desc field is, we can create the field definition.

table =: descs ,.~ _1&(-.&'( )'&.> ,~ ht ])&.:|: -.&a:@:(<;._1~ (1&(, > ht (1&(, +.&:(~:/\"1) ht +./)))) @:((="_ 0&' "()')))&(' ' &,)&> a: -.~ fields


T =: FIDS_FIELDS formulate table  NB.!!! Use this to calculate MAX_ENUM_LEN with 2 + >./ > {: {. 'ENUMLEN' From Extract__T ''  NB.  2 + is for the quotes.


NB.  Thomson -- easier to parse!



THOMSON_FID_FIELDS =: FieldDefs noun define
"ACRONYM:20     Acronym
#FID            Numeric FID
#FORMATID       I don't know .. need to look up
"DESC:65        Description of FID
#ENUMERATED     Boolean indicating whether the field is enumerated
#LEN            Length of FID
"TYPE:22        Type of FID
)

'h thomson' =: 1 split makeTable toJ fread '\\statarbsvr0\D_Drive\Documentation\ILX\thomson_data_works.uncleaned.dtb'
THOM =: THOMSON_FID_FIELDS formulate ((<<<idx) { &.:|: thomson) ,. (poofen ,.&:({:"1) corky) ,.~ <@":"0 (<'Enumerated') =&:(trim @: uc each) {."1 corky=.> _2&{.@(' '&arbCut)@:trim each {."1 poofen =. a: sr (<,'0') ,/-.&'()' L: 0 (split~ i.&'(')&> thomson {"1~ idx =. (;:'TYPE') i.&:(trim@:uc each)~ ,h
'\\statarbsvr0\D_Drive\Documentation\ILX\thomson_data_works.dtb' fwrite~ compressTableText NVtext 'FID	ACRONYM	TYPE	ENUMERATED	LEN	FORMATID	DESC' From Extract__THOM ''


327690 327691 327692 65561 65562 0 65549 0 328045 327699 327697 327698 0 655375 655928 262172 131746 0

APLFIDS =: noun define
 T?T,[1]'last' 6 'ÐÁÛÝ' 327690  ? Last Trade Price. Last recorded transaction price or value for a instrument.
 T?T,[1]'bid' 22 'ÂÍÇ' 327691  ? Best Bid Price.
 T?T,[1]'ask' 25 'ÁÛÏ' 327692
 T?T,[1]'bidsize' 30 'ÂÍÇÛÍõÈ' 65561
 T?T,[1]'asksize' 31 'ÁÛÏÛÍõÈ' 65562
 T?T,[1]'time' 18 'ÝÍÒÈ' 658680    ? Present trade time
 T?T,[1]'volume' 32 'ãÔÐþÒÈ' 65549
 T?T,[1]'dow' 58 'ÇÔì' 655368  ? Dow Jones Story Time.
 T?T,[1]'close' 21 'ÃÐÔÛÈ' 328045
 T?T,[1]'open' 19 'ÔÕÈÓ' 327699
 T?T,[1]'high' 12 'ÌÍËÌ' 327697
 T?T,[1]'low' 13 'ÐÔì' 327698
 T?T,[1]'ltv' 178 'ÐÝã' 65609
 T?T,[1]'trdtime' 379 'ÝÚÇÝÍÒÈ' 655375
 T?T,[1]'qttime' 1025 'ÙÝÝÍÒÈ' 655928
 T?T,[1]'tick' 14 'ÝÍÃÏ' 262172 ? Tick Direction.
 T?T,[1]'tradecond' 118 'ÝÚÁÇÈÃÔÓÇ' 134397 ? Trade Condition Normalized ?   PRIOR Bron:  131746
 T?T,[1]'quotecond' 117 'ÙþÔÝÈÃÔÓÇ' 134396 ? Quote Condition Normalized
)

APLCOLS =: FieldDefs noun define 
"NAME:11
#REUT
#ILX
"DESC:76
) 

APL =: APLCOLS formulate ((('T?T,[1]'&dropIfPrepended&.>@:{. , }.)@:(1 2 4&{) , ht <@:(;:^:_1)@:}.) ~ i.&(<,'?'))"1 ' ' makeTable APLFIDS
FIDStoFIX=: > {: , 'ILX' From  Extract__APL ''

ENUMsToFind=:trim each ~. }. , 'ACRONYM' From 1 Extract__THOM 'ENUMERATED=1 FID=',":FIDStoFIX



'header ohyeah' =. 2 split makeTable toJ fread '\\statarbsvr0\D_Drive\Documentation\ILX\enums.dtb'
  ohyeah =: ohyeah {&.|:~ <<<2
splitted=: ohyeah <;.1~ masky=:a: ~: elnames =: {."1 ohyeah 

IGNORE_STP =:  ;:^:_1 ;: '0       R    RE     CLS  CM   LM   OQ   CQ   AUT  ROT  FAS  DOS  DBS  DBO  BKB  BKA  BKQ'
argle =. >:&.".&.> {: , 'ENUM' From 1 Extract__FIDS 'FID=',":{. ; , }. 'REUT ILX' From 1 Extract__APL 'NAME=''tradecond'''
'\\statarbsvr0\D_Drive\Documentation\ILX\FIDS\Enums\REUTERS_TRADE_CONDITION.dtb' fwrite~ NVtext (#~ 1&(0})@:e.&(;: IGNORE_STP)@:(-.&' "' each)@: (1&{)@:|:) 1 Extract__argle '' 