require 'strings dates printf'

START_TIME      =: 6!:0''

NB.  A table of candidate rankings by person (game player).
GUESSES         =: makeTable noun define
Shawn               	Craig               	Margot              	Rich                	Keith               	Lissette            	Kelly               
Carrie Underwood    	Nadia Turner        	Nadia Turner        	Nadia Turner        	Nadia Turner        	Bo Bice             	Nadia Turner        
Nadia Turner        	Anwar Robinson      	Anthony Federov     	Carrie Underwood    	Carrie Underwood    	Nadia Turner        	Bo Bice             
Mikalah Gordon      	Carrie Underwood    	Carrie Underwood    	Bo Bice             	Jessica Sierra      	Scott Savol         	Carrie Underwood    
Constantine Maroulis	Bo Bice             	Scott Savol         	Anwar Robinson      	Bo Bice             	Carrie Underwood    	Constantine Maroulis
Anwar Robinson      	Anthony Federov     	Constantine Maroulis	Jessica Sierra      	Anwar Robinson      	Jessica Sierra      	Anthony Federov     
Scott Savol         	Vonzell Solomon     	Anwar Robinson      	Constantine Maroulis	Constantine Maroulis	Anwar Robinson      	Anwar Robinson      
Bo Bice             	Constantine Maroulis	Bo Bice             	Scott Savol         	Scott Savol         	Mikalah Gordon      	Scott Savol         
Anthony Federov     	Jessica Sierra      	Nikko Smith         	Vonzell Solomon     	Vonzell Solomon     	Constantine Maroulis	Vonzell Solomon     
Jessica Sierra      	Scott Savol         	Lindsey Cardinale   	Nikko Smith         	Mikalah Gordon      	Vonzell Solomon     	Lindsey Cardinale   
Vonzell Solomon     	Mikalah Gordon      	Mikalah Gordon      	Lindsey Cardinale   	Anthony Federov     	Anthony Federov     	Jessica Sierra      
Lindsey Cardinale   	Nikko Smith         	Jessica Sierra      	Anthony Federov     	Nikko Smith         	Lindsey Cardinale   	Nikko Smith         
Nikko Smith         	Lindsey Cardinale   	Vonzell Solomon     	Mikalah Gordon      	Lindsey Cardinale   	Nikko Smith         	Mikalah Gordon      
)


NB.  The candidates that have been eliminated so far (in past weeks).
ELIMINATED      =: a: -.~ trim each LF arbCut noun define
Lindsey Cardinale
Mikalah Gordon
Jessica Sierra
Nikko Smith
)


NB.  The candidates which have not yet been eliminated.
REMAINING       =:  ELIMINATED -.~ }. , {."1 GUESSES

NB.  Everyone starts with the same score -- the sum of points allocated.
NB.  Since the points given to each candidate is equal to the rank (ordinal number)
NB.  of that candidate, the starting score for each person is the +/i.#CANDIDATES
STARTING_SCORE  =:  +/ i. #GUESSES

NB.  We already know which candidates were eliminated, 
NB.  so we just need to figure out their respective ranks
NB.  and that's the number of points each person lost that week.
NB.  Note we need the ORDINAL rank (i.e. base 1), so i. GUESSES, not i. }. GUESSES
NB.  is right (because the GUESSES table has a header row giving the person's name)
PAST_POINTS     =:  ELIMINATED i."1~ |: GUESSES  

NB.  Figure out how each person ranked the remaining candidates, 
POINTS          =:  REMAINING  i."1~ |: GUESSES

NB.  Calculate all possible future paths of elimination (i.e. the order in which
NB.  all remaining candidates can be eliminated).
PATHS           =:  (A.~&:i.!)@:# REMAINING 

NB.  Figure out how many points each person would lose each week/elimination for every
NB.  possible future path.
FUTURE_POINTS   =:  PATHS {"_ 1 POINTS NB.  Person x possibility x week

NB.  Figure out the total path -- from start to finish.
ALL_POINTS      =:  PAST_POINTS ,"1"_1 FUTURE_POINTS 

NB.  The score at the end of every week/elimination is
NB.  the starting score minus the sum of the ranks of the
NB.  people eliminated (i.e. every wekk you lose a number
NB.  of points equal to the eliminated candidate's rank).
ALL_SCORES      =:  STARTING_SCORE - +/\"1 ALL_POINTS

NB.  The scores at the end are equal to the sum of the scores
NB.  at the end of every week/elimination.
ENDING_SCORES   =:  +/"1 ALL_SCORES

NB.  The winners are the people with the lowest scores after 
NB.  all candidates have been eliminated.
WINNERS         =:  (<@I.@:= <./)"1 |: ENDING_SCORES

NB.  The probability of each person winning.
PROBABS         =:  (% +/)@:([: <: #/.~) (i.@:# ENDING_SCORES ) , ; WINNERS

NB.  ... presented in a nice report.
REPORT          =:  _2 }. ; <@:,&CRLF@:trim"1 (}. ,~ (,: {&('-',TAB)@:(=&TAB))@:{.) ];._2 toJ NVtext ('Name';'Chance of winning (%)') , PROBABS \:~ ({.GUESSES) ,. <"1 rjust '%4.2f' sprintf"1 0 (0.01&round@:*&100) PROBABS

NB.  Three-way ties:
NB.  |: ((<{.GUESSES) {&.>~ mask#WINNERS) ,. REMAINING {~ (i.#REMAINING) A."0 1~ I. mask =. 3 = #&> WINNERS

NB.  Rich wins:
NB.  |: ((<{.GUESSES) {&.>~ mask#WINNERS) ,. REMAINING {~ (i.#REMAINING) A."0 1~ I. mask =. (<,I.(<'Rich')={.GUESSES)=WINNERS

smoutput REPORT

END_TIME        =: 6!:0''

smoutput 'Calculated in:  ', formatTimeSpan END_TIME -&:tsrep START_TIME

NB.  Leave this here in case I press ctrl+shift+up/down in this window and erase the last line.