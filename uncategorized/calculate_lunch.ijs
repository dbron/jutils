NB.  Dependencies:  strings is for rjust
load 'strings'

NB.  Enter lunch data here
ORDERS			=: '=' makeTable noun define
	Bron     =	7.59
	Meyer    =	7.59
	Egge     = 	6.49
	Sargent  = 	3.79
	Saracino =	2.19 5.79 0.29 1.29
)

QUOTE			=:  40.20
TIP				=:  2

NB.  Calculation section
'names orders'	=. ({. ,&< [: 0&". each {:) |:  ORDERS
total			=.  QUOTE + TIP
smoutput 'The following payments must be made by the participants:'
smoutput names (,.&TAB@:>@:[ ,. [: rjust ('$'&,)@:(0j2&":)"0@:]) payments =. 0.25 round total * ((%~ +/)~&>  +/@:;) orders
smoutput ' on this deal (because payments are rounded to the nearest quarter).' ,~ 'The lunch coordinator ' , ((;: 'made lost') {::~ difference > 0) , ' $', ":, | difference =. total - +/ payments