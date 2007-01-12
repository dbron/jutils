cocurrent 'bkdw'
coinsert'base'
require 'dates'
 bkdw =:  getNmdPath 'C:\Documents and Settings\dbron\My Documents\proj\cyota\report\data\event_breakdown\etrade_event_breakdown_report????????.txt'
 listFiles 'path' in bkdw
DATEs =: 0 ". (}. 1 j. xb +/\ 4 2 2) #&.|: ( 3 : 'FILES =: y'@:>@:listFiles ];.0~ 0 _ ,. [: (>:@:[ ,: -~)/ _2 {. [: I. 2 ~:/\ '?' = ]) 'path' in bkdw
sp =: ,"_ _1
DATEs_bkdw_ #~ 1 = (,:2006 12 28) I. DATEs_bkdw_ NB. 1 = (2007 01 sp 1 7) I. DATEs
RANGE=:DATEs #~ MASK =: (+. 1&|.) 1 = DATEs I.~ (,:2006 12 28) NB. 2007 01 sp 1 7
DATAA =: <@:toJ@:fread"1 MASK#FILES

NB. Only want every other row, but the report 
NB. is intended to look like this:
NB. TEST =: _2 ,:&.>/\ '|' makeTable >{.DATAA  

ROWS =: (_2 {.\ '|' makeTable ])&.> DATAA

DATA2 =: (<@:>"1@:|:;.1~ a: ~: {."1)@:('|'&makeTable)&.> DATAA NB. ((<@:>"1@:|:);.2~ a: = {."1)@:('|'&makeTable)&.>  DATAA
D =: {. L: 0  DATA2

NB. DO NOT DISPLAY THE FOLLOWING LINE!!!! 
NB. See  http://www.jsoftware.com/jwiki/System/Interpreter/Bugs#head-856be072cac1b4dd156585497239ab1601277f6e
T =: 3 : '(''DATE'';HEADERS) , ; (<"1 RANGE) ,. L: 1"0 Q=:y'  (}.&.>)@:(] ({"1 ,.&a:)&.>~ (i.&.>~ <@:(3 : 'HEADERS =: y')@:/:~@:~.@:;)@:({.&.>)) D

NB. erase'HEADERS'
NB.HEADERS , (] ({"1 ,.&a:)&.>~ (i.&.>~ 3 : 'HEADERS =: y'@:<@:/:~@:~.@:;)@:({.&.>))  D[i.&.> ":"0&.> 3 4;4 2;5 4;3 3