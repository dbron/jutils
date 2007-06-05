NB.  Dependencies:  strings is for rjust
load 'strings'

NB.  Enter lunch data here
ORDERS			=: '=' makeTable noun define
	Itay     =	8.00
	Liad     =	8.00
	Adi      = 	6.75 3.50
	Kim      = 	8.00
	Dan      =	4.50
)

QUOTE			=:  41.45
TIP				=:  2

NB.  Calculation section
'names orders'	=. ({. ,&< [: 0&". each {:) |:  ORDERS
total			=.  QUOTE + TIP
smoutput 'The following payments must be made by the participants:'
smoutput names (,.&TAB@:>@:[ ,. [: rjust ('$'&,)@:(0j2&":)"0@:]) payments =. 0.25 round total * ((%~ +/)~&>  +/@:;) orders
smoutput ' on this deal (because payments are rounded to the nearest quarter).' ,~ 'The lunch coordinator ' , ((;: 'made lost') {::~ difference > 0) , ' $', ":, | difference =. total - +/ payments