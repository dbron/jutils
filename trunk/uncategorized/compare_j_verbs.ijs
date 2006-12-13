magic =: 4 : 0"0 _
y		=.  y  NB.'x y' =. y
tvb =. x`:6
exv =. 5!:5 <'tvb'
exs =. '(' , exv , ') y'
exv ; (6!:2 exs) ; (7!:2 exs) ;< ". exs
)

compare		=:  dyad define
	NB.  Should be able to specify input/output sets
	NB.  EG: a little set, a medium set, and a big set.
	NB.  Each set should have an associated LHA for 6!:2,
	NB.  so for the little set it would be 100 6!:2,
	NB.  for the medium, it'd be 10 6!:2, and for the large
	NB.  1 6!:2.
	NB.
	NB.  Each set of input should come with an expected output.
	NB.  One of the columns output from here would be whether
	NB.  the actual output matched the expected output.
	NB.  The actual output would be returned also.
	NB.
	NB.  Another set of columns to output are the the timings/spacings
	NB.  normalized to the smallest value and the respective ranks.
	NB.  EG:
	NB.  	timeNormalizedAndRank =. (/:@:/: ,: (% <./))  time
	NB.  	spaceNormalizedAndRank =. (/:@:/: ,: (% <./)) space
	NB.  Maybe also output should be sorted by some function of
	NB.  time and space metrics for the various inputs;
	NB.  but it's better, perhaps, to preserve original input order.
	(;: 'Definition Time Space Output') , output /: ; 1 {"1 output =. x magic y
)

NB.  Compare extended integer creating functions
('`',;:^:_1' 'sr'_'each{.functionTable) =: functions =: ". '`' join parenclose each {: functionTable =: |: '=' makeTable noun define
Dan Bron Arithmetic 0 =  10&(] #.~ [ ^ [: >: <.@^.)@:x:
Dan Bron Arithmetic 1 =  10&([ #. ;@:(<@(#.^:_1"0)))@:x:
Dan Bron String 0     =  0&".@:,&'x'@:-.&' '@:":
Roger Hui String 0    =  ,&'x'@(-.&' ')&.":
)

NB.  Maybe I should replace the first column of output from compare
NB.  with the NAME of the function (from table above), instead of
NB.  its definition.
countdown	=:  (}: i. - >:) ats
smoutput t idxs }~&.|: hdrs, <">@:(% <./)@:;"1&.|: }. t {"1~ idxs =. (hdrs=.;: 'Time Space') i.&:(lc each)~ {. t=.('Name' ; {. functionTable) ,.  functions compare countdown 82

NB.  Not makeTable; will break defs containing '=
NB.  
NB.  Two functions:
NB.  'compare' (boxed input & boxed data output) and  'reportComparison' (string input & pretty textual report output)
NB.  
NB.  Compare:
NB.  
NB.  Perhaps generalize metrics (as input?):
NB.  Time
NB.  Space
NB.  Success
NB.  Numeric error function
NB.  Etc.
NB.  
NB.  Wrqp all ". In try./catch. & provide 
NB.  ReturnCode;Retrn
NB.  
NB.  reportComparison:
NB.  
NB.  Each case in a separate block
NB.  Each case sorted by success/fail then time winner then space winner
NB.  
NB.  All time/spc nmbrs rpted to 0.01 & round
NB.  Cases preceded by name (vertical middle judtified).
NB.  
NB.  Successes rpted as SUCCESS
NB.  Failures (non conforming output) rpted as FAIL
NB.  Errors report as ERROR
NB.  
NB.  Function config example:
NB.  A = +
NB.  B = 4 : 'x + y'
NB.  
NB.  Case config example
NB.  [Little]
NB.  X=3  NB.  Can put arbitrary J code here
NB.  Y=4
NB.  Z=7
NB.  Repeats=10