cocurrent 'bkdw'
coinsert'base'
require 'dates'
 bkdw =:  getNmdPath 'C:\Documents and Settings\dbron\My Documents\proj\cyota\report\data\event_breakdown\etrade_event_breakdown_report????????.txt'
 listFiles 'path' in bkdw
DATEs =: 0 ". (}. 1 j. xb +/\ 4 2 2) #&.|: ( 3 : 'FILES =: y'@:>@:listFiles ];.0~ 0 _ ,. [: (>:@:[ ,: -~)/ _2 {. [: I. 2 ~:/\ '?' = ]) 'path' in bkdw
sp =: ,"_ _1
DATEs_bkdw_ #~ 1 = (,:2006 12 28) I. DATEs_bkdw_ NB. 1 = (2007 01 sp 1 7) I. DATEs
RANGE=:DATEs #~ MASK =: (+. 1&|.) 1 = DATEs I.~ ,:2007 03 01  NB. 2007 01 12 NB. (,:2006 12 28) NB. 2007 01 sp 1 7 
NB. (*. 8 > +/\) 
DATAA =: <@:toJ@:fread"1 MASK#FILES
NB.  2007 3 30 2007 3 31 2007 4  1 2007 4  2 2007 4  3 2007 4  4 2007 4  5

((wkd) =: s: wkd =: ;:'Mon Tue Wed Thu Fri Sat Sun') i.~ s: 'WWW' dateToString"1 DATEs

power =: verb define

	sRANGE=: DATEs #~ MASK =. DATEs e. y NB. (+. 1&|.) 1 = DATEs I.~ ,:2007 03 05  NB. 2007 01 12 NB. (,:2006 12 28) NB. 2007 01 sp 1 7


    DATAA =. <@:toJ@:fread"1 MASK#FILES

	NB. Only want every other row, but the report 
	NB. is intended to look like this:
	NB. TEST =: _2 ,:&.>/\ '|' makeTable >{.DATAA  

	ROWS   =. (_2 {.\ '|' makeTable ])&.> DATAA

	DATA2  =. (<@:>"1@:|:;.1~ a: ~: {."1)@:('|'&makeTable)&.> DATAA NB. ((<@:>"1@:|:);.2~ a: = {."1)@:('|'&makeTable)&.>  DATAA
	D      =. {. L: 0  DATA2

	T =. 3 : '(''FILEDATE'';HEADERS) , ; (<"1 sRANGE) ,. L: 1"0 Q=.y'  (}.&.>)@:(] ({"1 ,.&a:)&.>~ (i.&.> <@:(3 : 'HEADERS =: y')@:/:~@:~.@:;)@:({.&.>)) D
	T =. T,.(<'DATE'),8 {.&.> (}.T) {"1~ ({.;:'Time') i.~ {.T
	T
)

NB. erase'HEADERS'
NB.HEADERS , (] ({"1 ,.&a:)&.>~ (i.&.>~ 3 : 'HEADERS =: y'@:<@:/:~@:~.@:;)@:({.&.>))  D[i.&.> ":"0&.> 3 4;4 2;5 4;3 3


rower =: verb define
	'f s' =. ({. ,&:< }.) y NB. T_bkdw_
	_2 }. ; (<0 1) C. <;.2 NVtext ,: (<;/'---'), 1 {.`([: {. rjust&.>)`([: {. rjust&.>);.1 <@:>"1|:(;:'Activity #  avg') , (<'c0.1') ({.@:(8!:2)) &.> (~.  {. FEEG) ,. (<">-:;SLURRD),.~ SLURRD=.<@:([: +/ 0 ". ;:^:_1)/./ FEEG=.|: s {"1~ f i. <;._1 ' Activity COUNT(*)'
   
)




NB.  WEEK =: todate (i.7) + 1 + todayno LAST_DATE_COVERED =: 2007 04 26
T =: power   todate (i.7) + 1 + todayno LAST_DATE_COVERED =: 2007 05 03

NB.clip CRLF join <@:}:@:;"1 TAB (,~ trim@:":) L: 0  (a:,.~}. T) {"1~ ({. T) i.&:(-.&(a. -. UCALPHA)@:toupper @:trim L: 0) TAB cut 'Activity                      	Type      	Time       	Count	Date'
NB.  _2 }. NVtext (<'0.1') ({.@:(8!:2)) &.> (~.  1{"1 T_bkdw_) ,. (<">-:;SLURRD),.~ SLURRD=:<@#/.~ 1{"1 T_bkdw_

NB.  Or...

NB.RET=:1 0 0 0 0 1 0 (] <;.1~ ,:@:[ ((,@:$~ {.) , 1 {.~ {:@:]) (#:~ 0 , ])&#~) RR =: R }.~ Mon i.~ s: 'WWW' dateToString"1 R =: RANGE {.~ 4 i.~ 1 {"1 RANGE  NB.+Sun i:~ s: 'WWW' dateToString"1 RANGE NB.+Sun i:~ s: 'WWW' dateToString"1 RANGE
NB.RET=:1 0 0 0 0 1 0 (] <;.1~ #@:] {. ,:@:[ ,@:$~ >.@:%&#~) RR =: R }.~ Mon i.~ s: 'WWW' dateToString"1 R =: RANGE {.~ 4 i.~ 1 {"1 RANGE  NB.+Sun i:~ s: 'WWW' dateToString"1 RANGE NB.+Sun i:~ s: 'WWW' dateToString"1 RANGE

NB.SOUR =: rower@:power each RET

NB. clip _8 }. ;<@:,&(,2$,:CRLF)@:;"1 ,&(,2$,:CRLF)&.>(':  ',L:0~;:'Week Wkend') ,&.>"1]_2 ]\ SOUR ,&.>~ (CRLF ,~ CRLF ,~ [ , '  <==> ' , ] )/&.> 'WWW, MM/DD' dateToString"1 L:0  ({.,:{:)&.> RET 