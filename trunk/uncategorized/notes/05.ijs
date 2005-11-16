'MY_PATH MY_FILE'			=: (({. ,&< }.)~ (# <. >:@:i:&'\')) 3 : '(4!:4 {:: 4!:3) <''y.''' $0
require MY_PATHo,'..\util\default\general.ijs'
require MY_PATH,'..\util\default\email_sender.ijs'

arbCut			=:  <@:#@:[ }.&.> [ (E. <;.1 ]) ,
scramble		=:  {~ ?~@:#
trim			=:  #~ (+./\. *. +./\)@:(-.@:(e.&(9 32{a.)))
   
   

PARTICIPANTS	=: a: -.~ LF arbCut noun define
Daniel Bron
Richard Meyer
Richard Newton
Damon Perry
Brian Egge
)

DAYS			=:  a: -.~ LF arbCut noun define
Monday
Tuesday
Wednesday
Thursday
Friday
)

subject			=:  'Lunch lineup for the week of ' , nextMonday =: 'YYYY-MM-DD' dateToString 0 0 0 ,~ todate@:(+ >:@:(7&|)@:(7&-)@:weekday@:todate)@:todayno 3  {. 6!:0 ''
body			=:  doString noun define
Lunchers,

The following is the lunch lineup for the week of $nextMonday$:
$}. NVtext (<3#' ') ,. DAYS ,. (i. # DAYS) { scramble PARTICIPANTS$

	
-Lunch Meister	
)