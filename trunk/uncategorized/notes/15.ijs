NB.  Dependency Section
NB.  	'strings'  is for 'rjust' and 'deb'
NB.     'danutils' is for anyone not on my machine

NB.  My location
'MY_PATH MY_FILE'			=: (({. ,&< }.)~ (# <. >:@:i:&'\')) 3 : '(4!:4 {:: 4!:3) <''y''' $0

load 'strings' 
load MY_PATH,'danutils.ijs'
load MY_PATH,'danutils.ijs'


getHTB =: verb define
	
)

lpc=: noun define
	\\rutherford\dfs\J\Utils\J\v406\j.exe "\\rutherford\dfs\j\dev\current\util\default\lunch_participation_calculator.ijs" /jrt
)