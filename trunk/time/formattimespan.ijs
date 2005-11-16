
	require'dates'

	rank=:#@:$
	merge =: 4 : 'x.}y.'

	NB.  Convert a list of boxes RHA into English, using commas and the word in the LHA (default is 'and')
	NB.  EG:        listToEnglish ;: 'a'	    NB. Returns ,'a'
	NB.  EG:        listToEnglish ;: 'a b'	    NB. Returns  'a and b'
	NB.  EG:        listToEnglish ;: 'a b c'	NB. Returns  'a, b and c'
	NB.  EG:  'or ' listToEnglish ;: 'a b c'    NB. Returns  'a, b or c'
	NB.!  Make this invertible.  use arbCut ', '.  Inside the last element, use LHA&arbCut (e.g. 'and '&arbCut).
	listToEnglish			=:  'and '&$: : ([: ; ;:^:_1@:((,&',' each @:}: , {: )@:}:@:] , <@:[  , each {:@:])^:(1&<@:#@:]))

	NB.  Function to calculate the plurals of a set of words.  Input is an array of boxed strings
	NB.  Output is the plural form of the input words.  If the input is a rank-1 array, the calculated plural forms
 	NB.  of all the words will be returned.  If a rank-2 array, user-specified plurals may by provided
	NB.  (used instead of calculated plural).  In the rank-2 array, the first column is the singular
	NB.  form and the second column is the preferred plural form.  Aces in the second column will be replaced
	NB.  mean there is no preferable plural form, and the calculated value should be used.
	NB.  EG:  pluralize                                     ;: 'apple princess company millenium radius'        NB.  Returns  ;: 'apples princesses companies millenia radii'
	NB.  EG:  pluralize |:(;: 'corps') (<1 ; ,_1) } 2 {. ,: ;: 'apple princess company millenium radius corps'  NB.  Returns <;._1 ' apples princesses companies millenia radii corps'  NB.  The pluraly of corps is corps
	NB.
	NB.  Input expected: 
	NB.  	x. is singular suffixes
	NB.     y. is output of splitRootsFromEndings
	roots						=.  {.@:]  NB.  This is from the output of splitRootsFromEndings
	calculateMergeSpec			=.  (>:@:(i:&1@:="1)&.|: >@:{:)
	mergeSpecPlusRoots			=.  calculateMergeSpec ; roots
	NB.  Input expected:
	NB.  	x. is singular suffixes ,: corresponding plural suffixes 
	NB.     y. is original words ,: custom plurals 
	prefixes					=.  {.@:[
	splitRootsFromEndings		=.  ({.@> ,&<  {:@>)@:((}. ; {.)&.>"0 1~ -@:#&>)~&:{.
	mergeSpecAndRoots			=.  (prefixes mergeSpecPlusRoots splitRootsFromEndings) f.  NB.  Need to f. because I will reuse the name 'roots' and 'prefixes'
	NB.  Input expected:
	NB.  	x. is (original words ,: custom plurals) ,&< plural suffixes
	NB.     y. is merge spec ,&< word roots
	roots						=.  >@:{:@:]
	suffixes					=.  >@:{:@:[
	originalWords				=.  {.@:>@:{.@:[
	customPlurals				=.  {:@:>@:{.@:[
	mergeSpec					=.  >@:{.@:]
	NB.	
	allPossibleSuffixes			=. (|:@:roots  |:@:(,&.>"1) suffixes)
	allPossiblePlurals			=.  customPlurals , allPossibleSuffixes , ,&'s'&.>@:originalWords
	mergeSpecWithCustomization	=.  a:&=@:customPlurals * mergeSpec
	NB.
	calculatePlurals			=.  mergeSpecWithCustomization  merge allPossiblePlurals
	NB.
	NB.  Input expected:
	NB.  	x. is singular suffixes  ,: corresponding plural suffixes 
	NB.     y. is original words ,: custom plurals 
	plurals						=.  ((,&< {:)~ calculatePlurals mergeSpecAndRoots) f.
	NB.
	NB.  Input expected:
	NB.  y. is original words OR (original words ,. custom plurals)
	NB.! Only handles lowercase text.
	NB.! Perhaps put '/s' first, so that all plurals get defaulted to 's', instead of using ,&'s'&.>@:originalWords

	NB.! Make this invertible.  Depend on |."1 LHA.
	transformInputForPluralization	=.  ,.&a:^:(1: = rank)@:(;:^:(2: = 3!:0))
	pluralize			=:  (' /' multiCut 's/ses y/ies ay/ays ey/eys oy/oys uy/uys h/hes th/ths f/ves ium/ia ius/ii')&(plurals&|: transformInputForPluralization) f. 

	NB.  the quantities of the units input.
	NB.! Make this invertible.  Depend on invertible pluralize and invertible listToEnglish.
	getSingularAndPlural		=:  ({."1@:] ,. pluralize@:]) transformInputForPluralization f.
	calculateForm				=:  1&~:@:[ merge |:@:getSingularAndPlural
	joinValuesWithUnits			=:  ([ (,.~ ":&.>)~ calculateForm)
	formatValuesAndUnits		=:  listToEnglish@:(<@:(;:^:_1)"1)
	formatUnitValueTable		=:  formatValuesAndUnits@:joinValuesWithUnits
	NB.  Same as formatUnitValueTable, except that it doesn't include units whose corresponding value was 0
	formatUnitValueTableExcluding0s =:  formatValuesAndUnits@:(0&~:@:[ # joinValuesWithUnits)


	NB.  Given a list of leagues on the right and their value gradation on the left, produce the human-readable
	NB.  breakdown of the value into its component leagues.
	NB.! Find a better word than 'league' .. like 'gradation' or 'components' or 'dissolution' or something.
	NB.  EG:  meters   =. (<'meter') ,&.>~ prefixes =. <;._1 '/yotta/zetta/exa/peta/tera/giga/mega/kilo/hecto/deka//deci/centi/milli/micro/nano/pico/femto/atto/zepto/yocto'  NB.  Note the empty element.
	NB.  EG:  powers   =. 10 ^&x: 3 3 3 3 3 3 3 1 1 1 1 1 1 3 3 3 3 3 3 3
	NB.  EG:  distance =: powers breakdownLeagues meters
	NB.  EG:  distance +/ */\. 1 ,~ powers  NB.  Returns '1 yottameter, 1 zettameter, 1 exameter, 1 petameter, 1 terameter, 1 gigameter, 1 megameter, 1 kilometer, 1 hectometer, 1 dekameter, 1 meter, 1 decimeter, 1 centimeter, 1 millimeter, 1 micrometer, 1 nanometer, 1 picometer, 1 femtometer, 1 attometer, 1 zeptometer and 1 yoctometer'
	NB.
	NB.  EG:  units	   		=.  |: (;: 'corps') (<1;,0) } 2 {. ,: ;: 'corps division regiment battalion company platoon squad team soldier'
	NB.  EG:  attachments	=.  3 #~ # units  NB.  Military heirarchies increase by orders of 3
	NB.  EG:  army			=:  attachments breakdownLeagues units
	NB.  EG:  army ?. 500   NB.  Returns  '2 platoons, 1 squad and 2 soldiers'
	NB.
	NB.  EG:  timeSpans		=.  'Millenium Century Decade Year Month Week Day Hour Minute Second Millisecond'
	NB.  EG:  timeFactors	=.  10 10 10 13 4 7 24 60 60 1000
	NB.  EG:  formatTimeSpan=:  timeFactors breakdownLeagues timeSpans
	NB.  EG:  formatTimeSpan 123901813x  NB.  Returns '1 Day, 10 Hours, 25 Minutes, 1 Second and 813 Milliseconds'
	NB.! Make this invertible; depend on invertible formatUnitValueTable
	createLeagueTable		=:  (<"0@:({.~ -@:#) ,. ]) {."1@:transformInputForPluralization f.
	decomposeIntoLeagues 	=:  (#:~ ;@:({."1))~ formatUnitValueTableExcluding0s {:"1@:[	
	NB.  Convenience conjunction;  inputs same as for createLeagueTable, outputs verb that will breakdown values appropriately.
	breakdownLeagues		=:  2 : '(m. createLeagueTable  n.)&decomposeIntoLeagues'

	NB.!  Make a conjunction that produces a conjunction like &.(m.&#.) or whatever
	NB.!  so that we can do, for example, formatTimeSpan@:(-&.timeToScalar)
	NB.!  Thus the inputs could be in 6!:0 format, and timeToScalar would turn these
	NB.!  vector into a single, scalar number, - would subtract the LHA from the RHA
	NB.!  and timeToScalar^:_1 would expand the difference back into a 6!:0-
	NB.!  compatible vector.  This difference would formatted into an English-
	NB.!  readable string by formatTimeSpan.


	NB.  We're going to convert a 6!:0-style numeric list into a date format.
	NB.  This noun is the expression of that format.
	BASEFORMAT				=.  'YYYYMMDDHHNNSSUUUOOOWWW'

	NB.  Coverta 6!:0-style numeric list into the format given above.
	NB.  EG:  dateToBaseFormat 2003 7 9 15 12 12.85 NB.  Returns '20030709151212850'
	NB.  Note that the */ + and the }.@:": are to handle the case that 0 -: {.@:]
	NB.  which can occur when the user just wants to format a timestamp, instead
	NB.  of a datestamp.
	NB.  The ({. #) in formatNumericTokens is to compensate for the non-numeric tokens in BASEFORMAT:
	NB.  i.e. the numeric tokens in BASEFORMAT come first, and their number is equal to the length of
	NB.  the input (6!:0 format).
	getMonthAbbrv			=.  [: {::&(;: 'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec') <:@:(1&{)
	getWeekdayAbbrv			=.  [: {::&(;: 'Sun Mon Tue Wed Thu Fri Sat')@:weekday 3&{.
	formatNumericTokens		=.  [: }.@:": (10 ^&x: (#;.1~ 1: , 2&(~:/\)) BASEFORMAT)&(({.~ #) (*/@:[ +  #.) ])@:(}: ,&x: (,&<. 1e3&*@:(1&|))@:{:)
	dateToBaseFormat		=.  formatNumericTokens , getMonthAbbrv , getWeekdayAbbrv

	NB.  For each character of a date-format specification, get a list of the indicies in the base format 
	NB.  where that character exists.
	NB.  EG:  indexIntoBaseFormat 'YYYYMMDD'  NB.  Returns 0 1 2 3;0 1 2 3;0 1 2 3;0 1 2 3;4 5;4 5;6 7;6 7
	indexIntoBaseFormat		=.  BASEFORMAT&(<@:bx@:="1 0)

	NB.  Get the reverse occurance number of each element the input.
	NB.  EG:  occurrenceNumber  'mississippi' NB.  Returns 0 0 0 1 1 2 3 2 0 1 3
	NB.  occurrenceNumber=.(<:@:(+/)@:((* +/\)"1)@:=)  NB.  Replaced in favor of Chris Burke's solution of 2001-May-30
	NB.  Note that using Chris' solution means I can no longer share the results of = between occurrenceNumber and itemCount.	
	occurrenceNumber		=.  ((] - {) /:@/:)@:i.~ 

	NB.  Returns an integer list of the same length as the input.
	NB.  An elment of the output is the count (in the input) of the corresponding element of the input
	NB.  EG:  itemCount 'mississippi' NB.  Returne 1 4 4 4 4 4 4 4 2 2 4
	itemCount				=.  (,@:(bx"1)@:|: { +/"1)@:=

	NB.  Indicies need to be picked backwards (see above), so
	NB.  I subtract the item count of each element from the occurance number
	reverseProgressiveIndex	=.  occurrenceNumber - itemCount

	NB.  Function to pretty-print a date.
	NB.  Inputs:   RHA:  Numeric list (in 6!:0 format) specifying time
	NB.            LHA:  Character list (using only elements from BASEFORMAT) specifying output format
	NB.  Outputs:  Character list specifying given time in given format.
	NB.  EG:  'YYMMDD' formatDate 2003 7 9 15 12 12.85 NB.  Returns '030709'
	NB.  EG:  'YYYYMMDD' formatDate 2003 7 9 15 12 12.85 NB.  Returns '20030709'
	NB.  Since I need pick indicies backwards (so that if the year is 2003, 'YY' will result in '03' instead of '20'),
	NB.  I'm using 'reverseProgressiveIndex ((+ #) { ])&> ndexIntoBaseFormat'
	NB.  instead of the simpler '(occurrenceNumber  {&> ndexIntoBaseFormat)'
	formatDate				=.  (reverseProgressiveIndex ((+ #) { ])&> indexIntoBaseFormat)@:[ { dateToBaseFormat@:] 

	NB.  Replace (for example) HHMM with HHNN to make formatDate easier to use.
	NB.  EG:  'YYYYMMDDHHMMSS' smartFormatDate 2003 7 9 16 48 48.313 NB. Returns '20030709164848'
	smartFormatDate			=.  (formatDate~ ;@:(<@:({. , <:@:#@:[ # {&'MN'@:=&'H'@:{.);.1~ 'M'&~:)&.(' '&,))~

	NB.  Like formatDate but ignores characters that don't appear in the BASEFORMAT string.
	NB.  EG:  'YYYY-MM-DD HH:NN:SS.UUU' fullFormatDate 2003 7 9 16 12 22.65 NB.  Returns '2003-07-09 16:12:22.650'
	NB.  Note that I have to put the f. after smartFormatDate because it's in a gerund, and therefore treated as a noun.
	NB.  Consequently any later f. will not resolve this name.
	fullFormatDate			=.  ((smartFormatDate~ f.  #&>/@:[)~ ` (bx@:>@:{.@:[) ` (>@:{:@:[) } ~  (;~ e.&(~. BASEFORMAT)))~ 

	NB.  Like fullFormatDate but default RHA is 6!:0''
	dateToString			=:  ($: 6!:0 bind '') : fullFormatDate f.

	NB.  Takes a number of milliseconds as input, produces a human-readable timespan as output.
	NB.  One quirk is that a month is considered to be exactly 4 weeks, and a year to be exactly 13 months.
	NB.  Therefore its possible to get output that contains the substring '12 months' . 
	NB.  To avoid this problem, use the alternate definition given on the next line.
	NB.  formatTimespan			=:  10 10 10 52 7 24 60 60 1000  breakdownLeagues 'Millenium Century Decade Year Week Day Hour Minute Second Millisecond'  NB.  Doesn't include months
	NB.  EG:  formatTimeSpan 34943619661001x  NB.  Returns '1 Millenium, 1 Century, 1 Decade, 1 Year, 1 Month, 1 Week, 1 Day, 1 Hour, 1 Minute, 1 Second and 1 Millisecond'
	formatTimeSpan			=:  10 10 10 13 4 7 24 60 60 1000 breakdownLeagues 'Millenium Century Decade Year Month Week Day Hour Minute Second Millisecond'
