load 'files dates'
NB. load 'addons\sfl\sfl'


NB.  =====================================================================================================================================================
NB.  General Utilities:  Useful items or good examples of how to accomplish tasks.
NB.  =====================================================================================================================================================

	compareVerbs		=:  1 : 0
	:
	NB.  Cliff Reiter's [reiterc@mail.lafayette.edu] verb comparison adverb.
	NB.  Use the adverb to modify a gerund, and it will produce as output a table
	NB.  of N rows x 4 columns, where N is the number of verbs in the gerund.
	NB.  The columns are as follows:
	NB. 	Column 0: Verb definition as provided in the gerund.
	NB. 	Column 1: Time of execution (6!:2).
	NB. 	Column 2: Use of memory  (7!:2).
	NB. 	Column 3: Output.
	NB.
	NB.  Example of use:
	NB.    10 +`-`*`% compareVerbs 100

		mx=:  x
		my=:  y
		z=.i.0 4
		for_f. m do.
			'`mt mg'=:[`f
			z=.z,(5!:5 <'mg');(6!:2;7!:2;".) 'mx mg my'
		end.
		z
)

	NB.c	over =:  2 : 0
	NB.c		verb =.  u
	NB.c		data =.  n
	NB.c
	NB.c		verb /^:(#@$@])  data
	NB.c)

	NB.  From phrases: Apply a set of verbs across the columns of a table
	NB.  eg:  Verb1`Verb2`Verb3 across table
	across				=:  adverb def '(# # 1:) (}.@$ $ ,)@:u;.1 ]'

	NB.  Jose Quintana's adverb for sequential application of dyadic verbs
	NB.  x f seq y is essentially equivalent to ... (2 {:: x) f (1 {:: x) f (0 {:: x) f y
	seq					=:  ((&.>) /) (@:((|.@:[) , (<@:]))) (>@:)

	NB.  Kirk B. Iverson's de-raveller adverb (ravels argument, applies verb, unravels argument).
	rav					=:  1 : 'u@, $~ $'

	NB.  An adverb that gives the indicies in the RHA (which can be of any rank) where the
	NB.  verb on the LHS returns true.  The following example finds the indices of the LHA in the RHA
	NB.  E.G. 0&= index 4 4$8 3 9 2 0 5 0 1 10 9 8 5 0 7 6 0	NB.  Return 4 2$1 0 1 2 3 0 3 3
	NB.  E.G. 'z0ert' e.~ index 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' {~ i. 3 4 5  NB.  Returns 5 3$0 0 4 0 3 2 0 3 4 1 1 0 2 2 2
	index				=:  1 : '(# i.@#)@:(u&:,) #:~ $@:]'

	NB.  A 'translate' conjunction.  Has 2 noun arguments, producing a verb.
	NB.  Example:  rot13 =.  'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM' tr 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	NB.  rot13 'Guvf vf fbzr ebgngrq grkg'
	xlat				=:  2 : '({&(n , a.)) @: ((m , a.)&i.)'

	NB.  Another translate conjuction, only for scalars.  Repalce the scalar LHA to the conjunction with the scalar RHA to the conjunction.
	NB.  EG.  0 scalarReplace _1 ] 5 8 0 0 5 6 0 3 0 4  NB. Returns 5 8 _1 _1 5 6 _1 3 _1 4
	scalarReplace	=: 2 : '(m&=)`(,:&n) } y'

	NB.  A better version of scalarReplace; actually more of a hybrid of scalarReplace and xlat.  It shares the advantages of scalarReplace
	NB.  in that it does not need to know the universe of possible values in advance (meaning it's not restricted to literals and doesn't 
	NB.  require explicit code).  It shares the advantage of xlat in that it can replace a list of scalars with another list of scalars, instead
	NB.  of just a single scalars.  Like scalarReplace and xlat, it is restricted to replacing scalars with scalars: it cannot replace arbitrarily
	NB.  shaped data (use replace for that [which has the additional freedom of not requiring the search and replace inputs to be of the same
	NB.  length]).  One drawback of multiScalarReplace is that it needs to create large temporary (ephemeral) data; (#@[ * */@:$@:]) elements to
	NB.  be exact.
	NB.  EG:  abc_to_def 'aZbYcX'       [. abc_to_def	=: 'abc' multiScalarReplace	'def' NB.  Returns 'dZeYfX'
	NB.  EG:  zero_to_one 5 5 5 5 $ 0   [. zero_to_one	=:     0 multiScalarReplace 1     NB.  Returns 5 5 5 5$1
	multiScalarReplace	=: 2 : '((i.~"0 _&m)` (n&(] ,~ ($~"0 1&, $)))) }'

	NB.  The adverb evoke can be used to access global nouns (which can change) from tacit definitions.
	NB.  E.G. lookUpID	=: ((i.~ {."1) { {:"1@:]) 'ID_TABLE' evoke
	evoke				=: ". bind
	
	pad					=:  dyad define
	NB.  Pads a string to a greater length.  If the length given is less
	NB.  than the length of the string, the string is truncated.
	NB.
	NB.  Parameters:  y is the string to be padded.
	NB.
	NB.               x is a list of 3 boxes:
	NB.
	NB.               0 {:: x is a numeric length to pad the string
	NB.
	NB.               1 {:: x is the string character with which to pad
	NB.                        the string
	NB.
	NB.               2 {:: x is a boolean which indicates the side on
	NB.                        which the string will be padded: 0
	NB.                        indicates pad on the right, 1 indicates
	NB.                        pad on the left.

		'size filler side'	=.  x

		> side { (size{.y,size#filler);(|. size {. |. (size#filler),y)
)

	to						=:  verb define

	'first last by includeLower includeUpper' =:  5 {. y, 1 1 1
	(}.^:(-.includeLower)) first + ((_1^(first > last)) * by) * i. (>:^:includeUpper) | (first - last)%by
:
	y (] + (* * i.@:>:@:|)@:-) x
)


	NB.  Make LHA copies of RHA
	copy				=:  (* #) $ ]

	NB.  Merge a set of lists based on a merging specification, EG:
	NB.  (0 1 2 1 0 2) mergelists 'ABCDEFG';'0123';'zyxwvutsr'
	NB.  A1x3Eu
	shuffle				=:  mergelists	=:  ([ + #@:] * i.@:(#@:[)) { (,@:|:@:>@:])

	NB.  Replace multiple occurances of a char with a single occurance.
	collapseMultiples	=:  (] #~ (-.@:E.~ 2&#)~)

	NB.  Example of how to construct a simple regex in J:
	NB.  This is a regex to remove all space characters preceding commas.
	NB.  The equivalent Perl regex is:     s/ +,/,/g
	NB.  EG:  trimToComma 'h    i, how are    you      ,?' NB.  Returns 'h    i, how are    you,?';  note that only the spaces preceding a ',' were removed - all other spaces remain.
	trimToComma			=: ' ,'&(] #~ -.@:E.)^:_ 

	NB.  Round RHA to the nearest LHA.
	round				=:  ([ * [: <. 0.5"_ + %~)

	NB.  Numerify a literal if possible, if not, return original literal
	cn					=:  ((__&e.@:] >@{ ;~) __&".)

	NB.  Scramble the items of y
	scramble			=:  {~ ?~@:#

	NB.  Sort a 2-d array by columns
	sortcolumns			=:  ] /: ([ {"1  ] )

	NB.  Identify the depth of nested parens at each point in a string
	NB.  Note: I came up with this all on my own, but it matches Kirk's solution exactly!
	parenDepth			=:  +/\ @: (-/) @: ('()'&(=/))

	NB.  Find the maximum indentation level for some text, where the indentation level 
	NB.  for a line is defined as the number of contigous tabs at the beginning of that line.
	maxIndentLevel		=: >./@:(i.&1@:~:&TAB;._1~ (LF, TAB)&E.) 

	NB. Tests if all items in the RHA are equivalent.
	NB.  Old form:  ([: *./ 2&(-:/\))
	allMatch			=:  (1: = #@:~.)

NB.	NB.  Insert 1 pick x into y starting at the index specified in 0 pick x
NB. Removed because it's useless and conflicts with a name in the trader side of the OMS.
NB.	insert				=:  ((0&pick@:[ {. ]) , 1&pick@:[ , (0&pick@:[ }. ]))

	NB.  Tests if beginning of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
	beginsWith			=:  ,^:(0: -: #@:$)@:] -: ({.~ #)    NB.  ([ -: ({.~ #)~)

	NB.  Tests if end of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
   	endsWith			=:  ,^:(0: -: #@:$)@:] -: ({.~ -@:#)

	NB.  Appends the LHA to the RHA if the RHA doesn't already end with the LHA.
	appendIfNotPresent	=:  ,~^:(-.@:endsWith~)

	NB.  Finds the prime number closest to the input.  If the input is a midpoint between two primes, the lower
	NB.  prime is selected.
	closestPrime		=: ((i. <./)@:|@:- { ]) p:@:(,~ <:)@:(p:^:_1)  

	NB.  Replaces each element in the array by the count og the occurnaces of that element up to that point.
	NB.  E.G:  occuranceCount 'mississippi' NB. Returns 0 0 0 1 1 2 3 2 0 1 3
	occuranceCount		=:  (<:@:(+/)@:((* +/\)"1)@:=)

	NB.  Places the LHA on either side of the RHA.
	NB.  E.G.:  '***' envelope 'hello' NB.  outputs '***hello***'
	envelope			=:	([ ,~ ,)

	NB.  Takes a scalar as a LHA and an N-dimensional array as a RHA.  
    NB.  Completely encloses the RHA with repetitions of the LHA.
	NB.  E.G.:  '*'  trap ,:'hello' NB.  Outputs 3 7$'********hello********'
	trap				=: ([ 0&|:@:, ,~)^:(#@$@:])

	NB.  r is my analog to j. (sort of like an r.) which takes its two arguments and returns a rational
	NB.  with x as the numerator and y as the denominator. Useful if precision is more important
	NB.  than space/time considerations (that is, store all your calculations with full precision and only
	NB.  evaluate them to a floating point at the end).
	NB.  E.G. 3 r 4 produces 3r4 and _2 r/\ 2 3 4 5 6 7 produces 2r3 4r5 6r7
	NB.  Note that this can be done with x:@:%, but I'm not convinced true precision is maintained this way.
	NB.  The inverse of this function is 2&x:
	r					=:  (, 'r'&,)&.":

	NB.  Kirk B. Iverson's nested structure boxing algorithm
	NB.  Cut on spaces, box and recurse on braces
	bracelevel			=.  +/\@(-/)@('{}'&(=/))
	cutmask				=.  ' '&= *. 0: = bracelevel
	isbraced			=.  '{'&=@{.@(1&{.)
	stripbrace			=.  }.@}:
	cutter				=:  (cutmask <`(<@$:@stripbrace)@.isbraced;._1 ])@(' '&,) f.

	NB.  Get all the possible subsets of a set, including the empty and full sets.
	subsets				=:  <@#~ (2: (#~ #: i.@^) #)

	NB.  Verbs to create binary arrays locating the the elements before after, or between
	NB. the first or last appearance of some element(s) in the set.
	assertBeforeFirst	=:  *./\  @: ~:
	assertAfterFirst	=:  +./\  @: =
	assertBeforeLast	=:  +./\. @: =
	assertAfterLast		=:  *./\. @: ~:
	keepFirst			=:  < /\  @: =
	keepAllButFirst		=:  < /\  @: ~:

	NB.  Remove leading and trailing whitespace from a string.
	trim				=:  removePadding		=:  #~ (+./\. *. +./\)@:(-.@:(e.&(9 32 { a.)))

	NB.  Remove trailing spaces from a string.
	removeTrailingBlanks=:(#~ (+./\.)@:~:&' ')

	NB.  Partition a literal by spaces (multiple spaces count as a single space).
	NB.  slice 'When eras die, their legacies are left to strange police.  Professors in New England guard the glory that was Greece.'
	NB.slice	=: (<;._2~ ' '&=)@:(#~ ([: -. '  '&E.))@:(,&' '^:(~:&' '@:{:))
	NB.  Actually, since we reduce all multiple spaces to a single space, we don't need to test if the last character is a space.		
	NB.slice	=: (<;._2~ ' '&=)@:(#~ ([: -. '  '&E.))@:,&' '
	slice				=:  ' '&$: : ((}.^:(a:&-:@:(0&{)@:(1&{.)))@:([ (= <;._2 ]) [ collapseMultiples ,~))
	
	

	NB.  Rotate text by 13 characters (useful for decoding newsgroup postings)
	rot13				=:  ('nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM' xlat 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ') f.
	NB.  Convert text to uppercase
	uc					=:  ('ABCDEFGHIJKLMNOPQRSTUVWXYZ' xlat 'abcdefghijklmnopqrstuvwxyz') f.
	NB.  Convert text to lowercase
	lc					=:  (uc^:_1) f.

	NB.  Replace all occurances of some sequence with another sequence.
	NB.  E.G. ('Hello';'Goodbye') replace 'Hello, world!'
	locate				=.  E. <;.1 ]
	matches				=.  (([ locate ,)~ >@{.)~
	remove				=.  #@>@{.@[ }.&.> matches
	replace				=:  ;@({:@[ ({.@] , ((,&.>) }.)) remove) f.

	NB.  Replace more than one sequence
	NB.  E.G. ((<'Hello';'Goodbye'),(<'wonderful';'cruel')) multireplace 'Hello, wonderful world!'
	multireplace		=:  replace seq f.

	NB.  Get all the anagrams of RHA
	anagrams			=:  (i.@!@#@]) A. ]

	NB.  This is a slightly modified version of comb dyad that appears in 
	NB.  the documentaion for "for." in the J dictionary.  It produces all
	NB.  the size x combinations of the elements of y  For example,
	NB.  3 comb 'abcde' NB.  Returns 10 3$'abcabdabeacdaceadebcdbcebdecde'
	comb=: ((] {~ ((4 : 0) #)) ~.)
	 	z=.1 0$k=.i.#c=.1,~(y-x)$0
	 	for. i. x do. 
			z=.; k ,.&.> (-c=.+/\.c) {.&.> <1+z 
		end.
)

	NB.  This verb produces all the possible combinations of a set.
	combos				=: (({^:2)@:(<"_1)@:|:)
	NB.  This verb produces all the 'slots' of a set (like a slot machine);  that is, every element in column 0 of the table
	NB.  by every element in column 2 of the table by every element in column 2 of the table, etc.
	slots				=: (({^:2)@:(<"0)@:|:)



	NB.  Monadic form plots the frequency of each unique item in a set using the asterisk character
	NB.  Dyadic form allows you to specify your own character.
	graphfreq			=:  '*'&$: : (4 : '((] (;"0 1 x&(#~)@:]"0) +/@:(=/)) ~.) y')

	NB.  Pick the prime elements from a list
	primepicker			=:  {~ ((> # ]) p:@:i.)@:#

	NB.  Monadic creates random strings; dyadic picks random elements from a set
	randpick			=:  $:&'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' : ((?@:# #) { ])

	NB.  Make a number more readable by delimiting it with commas
	fmt					=: ((({. '-'&,@:]^:(-:&'_'@:[) ({: ;@:,~ ,&',' each @: }:)@:(_3&(<@:|.\)&.|.)@:(-.&'_'))@:{.  , }.)~ i.&'.')@:":
	NB.  Format a list of numbers, and try to put it back in the original shape.
	multifmt			=: ;:^:_1@:(<@removeTrailingBlanks"1)@:(fmt"0)

	NB.  Sum of the first N integers, where N is the RHA
	sumInts				=: -:@:(* <:)

	NB.  Sum of the squares of the first N integers, where N is the RHA
	sumSquares			=: %&6@:(* >: * >:@:+:)

	NB.  Sum of the cubes of the first N integers, where N is the RHA
	sumCubes			=: *:@:sumInts

	NB.  Given a list of probabilities (between 0 and 1), provides combined probability.
	NB.  EG:  combProb 0.72 0.60 NB.  Returns 0.794118
	combProb			=: ([ % +)&:(*/) 1&-

	NB.  Convert a dot-delimited IP string into its equivalent integer representation.
	NB.  EG:  convertIP '134.22.167.089'	NB.  Returns 2223377474
	NB.  The inverse also works,
	NB.  EG:  convertIP^:_1 ] 2223377474    NB.  Returns '134.22.167.89'
	convertIP			=: (255&#.@:".@:('.'&=`(,:&' ') })) :. ((' '&=`(,:&'.') })@:":@:((255&#.)^:_1))

	NB.  Converts a dictionary into the appropriate letter-tree.  
	NB.  E.G. dictionary <;._2 'arriving cares coerciveness commenting denigrates dextro greenflies pinfish pocketknives resettled '
	NB.  Returns: 6 2$(<,'a'),(<,:(<,'r'),<,:(<,'r'),<,:(<,'i'),<,:(<,'v'),<,:(<,'i'),<,:(<,'n'),<,<'g'),(<,'c'),(<2 2$(<,'a'),(<,:(<,'r'),<,:(<,'e'),<,<'s'),(<,'o'),<2 2$(<,'e'),(<,:(<,'r'),<,:(<,'c'),<,:(<,'i'),<,:(<,'v'),<,:(<,'e'),<,:(<,'n'),<,:(<,'e'),<,:(<,'s'),<,<'s'),(<,'m'),<,:(<,'m'),<,:(<,'e'),<,:(<,'n'),<,:(<,'t'),<,:(<,'i'),<,:(<,'n'),<,<'g'),(<,'d'),(<,:(<,'e'),<2 2$(<,'n'),(<,:(<,'i'),<,:(<,'g'),<,:(<,'r'),<,:(<,'a'),<,:(<,'t'),<,:(<,'e'),<,<'s'),(<,'x'),<,:(<,'t'),<,:(<,'r'),<,<'o'),(<,'g'),(<,:(<,'r'),<,:(<,'e'),<,:(<,'e'),<,:(<,'n'),<,:(<,'f'),<,:(<,'l'),<,:(<,'i'),<,:(<,'e'),<,<'s'),(<,'p'),(<2 2$(<,'i'),(<,:(<,'n'),<,:(<,'f'),<,:(<,'i'),<,:(<,'s'),<,<'h'),(<,'o'),<,:(<,'c'),<,:(<,'k'),<,:(<,'e'),<,:(<,'t'),<,:(<,'k'),<,:(<,'n'),<,:(<,'i'),<,:(<,'v'),<,:(<,'e'),<,<'s'),(<,'r'),<,:(<,'e'),<,:(<,'s'),<,:(<,'e'),<,:(<,'t'),<,:(<,'t'),<,:(<,'l'),<,:(<,'e'),<,<'d'
	dictionary			=:  [: ,@:(-.&a:"1) L: 1 ((;/@:~.@:[ ,&<&> [: (]`($:)@.(*@:#))@:(-.&a:) each (<@:(}.&.>)/.) )~ {.&>)

	NB.  Converts a boxed noun into a literal that represents the noun as parenthesized text
	NB.  EG:  boxToParen <(<'a'),<(<'b'),<(<'c'),<'d';'e' NB.  Returns '((a)((b)((c)((d)(e)))))'
	boxToParen			=: ([: ; (('('&, <@:, ')'"_)@:$:)&>)`":@.(0: -: L.)
   
	NB.  Uses J's tree-display functionality to print out the tree representation of a noun (as opposed to a verb train)
	NB.  EG:   treeIt <(<'a'),<(<'b'),<(<'c'),<'d';'e'
	NB.		  +- a
	NB.		--+   +- b
	NB.		  +---+   +- c
	NB.		      +---+   +- d
	NB.		          +---+- e
	NB.  Another example:  treeIt dictionary <;._2 'arriving cares coerciveness commenting denigrates dextro greenflies pinfish pocketknives resettled '
	treeIt				=: 5!:4 bind (<'some_name') [ ([: ".@:('some_name=:'&,) ('()';'NULL')&replace@:boxToParen)

	NB.  Return (1 { x) elements from y starting at 0 { x
	NB.  EG:  a. from~ 10 ,~ a. i. '0'  NB. Returns '0123456789'
	from				=:  (];.0~ ,:/)~

	NB.  Apply function on nub, then expand array to original length
	NB.  Just make verbs faster on arguments with small nubs.
	applyOnNub			=:  1 : '((u@:[) {~ i.~) ~.'

	NB.  Like E., this creates a boolean list where the elements of the right match the elements of the left
	NB.  except that E. has ones only where the match begins, whereas this function has ones for the entire
	NB.  match.
	NB.  EG:  'hello' E 'hello how are you?' NB.  Returns 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0
	NB.  Old form: E =. }:@:([: *@:+/\ #@:[ _1:`(+ bx)`(,&0@:]) } E.)
	E					=: [: ; <@:#@:[ ((}.&.> {.) , }.@:]) #@:[ (#&1@:[ , }.)&.> <;.1~@:([ E. ,)

	NB.  Select;  adverb which takes a verb that produces a boolean; the result of the verb will be selected
	NB.  from the RHA.
	select				=: 'u # ]'

	NB.  Remove all occurances of the sequence on the LHS from the RHS
	NB.  EG:  'ugly ' remove  'This ugly sentence should ugly be ugly nice'	NB.  Returns 'This sentence should be nice'
	remove				=: -.@:E select

	NB.  This is just a cover name for the quote cheracter, so that it can be more easily embedded in strings
	QUOTE				=: ''''

	NB.  These are the elements I'm usually interested in from a.
	ALPHANUM			=: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

	NB.  This is a function that emulates {iota} in APL; it generates a matrix of boxes the same shape as its input
	NB.  with each box containing the full index of its corresponding element in the input.  Note that (-: ] {~ aplIota)
	NB.  is a tautology.  This verb is good for seeing what elements of a matrix a verb operate upon:
	NB.  EG:  (<_1 0) |: aplIota 3 4 NB.  Returns 0 0;1 1;2 2
	aplIota				=:  [: { <@:i."0

	NB.  With a list of boxes as a LHA, returns those which contain the sequence in the boxed RHA.
	NB.  E.G. 'A' selectContaining 'ALPHA';'BETA';'GAMMA';'DELTA';'EPISLON';'THETA' NB. Returns  <;._1 ' ALPHA BETA GAMMA DELTA THETA'
	selectContaining	=:  (1&e.@:E.&> select~ <)~

NB.  =====================================================================================================================================================
NB.  Date/Time Utilities:  Mostly conversions
NB.  =====================================================================================================================================================

	getGMTime			=:  3 : 0
	NB.  This converts the number of seconds since Epoch into
	NB.  UTC/GMT time.  Relies upon the standard function library add-on

		timer			=.  y
		date			=.  ": > {. timer_to_date_jsfl_ timer
		time			=.  ": > {. timer_to_time_jsfl_ timer
		time			=.  (8;'0';1) pad time
		date			=.  (8;'0';1) pad date

		year			=.  4 {. date
		month			=.  (4 5) { date
		day				=.  (6 7) { date
		hour			=.  2 {. time
        minute			=.  (2 3) { time
		second			=.  (4 5) { time

		year,'-',month,'-',day,' ',hour,':',minute,':',second
)

	NB.  Converts seconds since epoch to local time (very much like getGMTime)
	secondsToTime		=:  _4&}."1@isotimestamp @ (1: tsrep 5364662400000"_ + 1000"_ * ])

	NB.  Like isotimestamp, this verb takes input in the format of 6!:0'' and provides output as a literal in the format YYYY-MM-DD HH:NN:SS.UUU
	NB.  datetimestamp	=:  ;@:([: ({~ /:^:2@:-.@:(2&|)@:i.@:#) (;/'-- ::')&,) @: (4 2 2 2 2 6&((-@:[ <@:({.!.'0') ":@:])"0))
	datetimestamp		=: [: ;@:|:@:,:&(;/'-- ::')  4 2 2 2 2 6j3&(<@(' ' scalarReplace '0')@":"0)

	NB.  Just a cool way of producing YYYY-MM-DD
	datestamp			=: 3 : '; 1 0 1 0 1 expandby (<''-'') 4 2 2 (-@:[ <@:({.!.''0'') ":@:])"0 ]3 {. 6!:0 y'




NB.  =====================================================================================================================================================
NB.  File Utilities:  Utils to manipulate files and the file system.
NB.  =====================================================================================================================================================
	treeWalker			=:  verb define
	NB.  Verb to recursively walk a directory structure, listing the directories and files within it.
		'dirs files'	=.  ((, ^: (*@:#@:])) L: 0 ({."1 each @: dirsAndFiles)) @: appendSlash y

		ans				=.  $0

		for_dir. dirs do.
			ans			=.  ans, < dir , < treeWalker dir
		end.

		ans				=.  ans,files
)

	NB.  Create an arbitrary-depth directory
	NB.  (1!:5 will die if you try to create a subdir in a dir that doesn't exist)
	NB.  e.g. mkdir 'c:\d\e\f\g\'

	appendSlash			=.  '\'&(,~ ^:([ ~: {:@])) @: >
	dirs				=.  (<@;\) @: (<;.2) @: appendSlash
	existing			=.  1!:0@:}:&.>@:}.
	notexistlist		=.  (< i. 0 5)&= @:]
	hashout				=.  (0: , notexistlist) # [
	nonexisting			=.  hashout existing
	create				=.  1!:5
	mkdir				=:  *./ @: , @: (create @: ,: @: nonexisting @: dirs) f.


	NB.  This will return (directory;filename) of the file which runs it.	Its input is any literal that can be a valid J identifier.
NB.	getPath				=:  4!:55@:< ] (({. ; }.)~ >:@: i:&'\')@:>@:(4!:4@:< { 4!:3) [ ".@:(] , '=:'''&,@:(,&'''')@:])
	getPath				=:  ([: (({. ; }.)~ >:@:i:&'\') (4!:55 ] 4!:4 { 4!:3 bind '')&.<@:".@:(, '=:'''&,@:(,&'''')))


	NB.  dirsAndFiles takes as input a directory name, and returns as output
	NB.  list of 2 boxes; the first contains all the subdirectories within tbe directory
	NB.  and the second contains all the files within the directory.
	ls					=.  (1!:0)@:(<@:,&'*')
	prependKeyer		=.  (2 5$<;._1 '|dir|0000 0 0 0 0 0|00000|---|----d-|file|0000 0 0 0 0 0|00000|---|------')&,
	findDirs			=.  ([: 'd'&= _2&{)&>@:{:"1
	split				=.  (<@:}./.~  findDirs)
	dirsAndFiles		=:  split @: prependKeyer @: ls f.

	NB.  Verbs to parse (and conditionally numerify) tab-delimited files:.  Perhaps I should generalize these to adverbs
	NB.  so that they can parse files delimited by any char.

	NB.  Parse a completely homogeneous DTB: Either the DTB is text or it is numeric.
	homdtb				=:  (__&".@:((];._2@(,&TAB)@}:);._2))^:([: *./e.&('-_.,0123456789',TAB,CRLF))
	NB.  Parse a DTB that has homogeneous columns.  Each column is either entirely text or entire numeric.  Box columns.
	homcdtb				=:  (<@:((__&e.@:] >@{ ;~) __&".)@:>"1@:|:@:(<;._2@(,&TAB)@}:;._2))
	NB.  Parse a completely heterogeneous DTB.  Each item can be text or numeric.  Box items.
	htrdtb				=:  (((__&e.@:] { ;~) __&".);._2@(,&TAB)@}:;._2)

	NB.  Converts any path into a J-style path
	toJPath				=.  '/' scalarReplace PATHSEP_j_ 

	NB.  Gets the entire contents of a directory
	dirAll 				=.  1!:0@:(,&'*'@:(PATHSEP_j_&appendIfNotPresent)@:toJPath&.>)@:boxopen
	NB.  Gets only the files (and not the subdirectories) from a directory listing
	getFiles			=.  #~  (<'d')&((-.@:(1&e.)@:E.&>)  {:"1)
	NB.  Gets the filenames of a directory listing
	getFilenames		=.  {."1 @: getFiles
	NB.  Gets the extensions of a list of files (and lowercases them for consistancy)
	getExtensions		=.  (lc@:}.~ >:@:i:&'.')&.>
	NB.  Gets the count of each unique item of a list	
	frequency			=.  ({. , <@:#)/.~
	NB.  Gets the count of each file type in a directory
	extensionFreq		=.  frequency@:sort@:getExtensions@:getFilenames@:dirAll
	NB.  Removes the odd elements from an array
	removeOddIndicies	=.  (#~ 2&|@:>:@:i.@:#)
	NB.  Removes boxing characters from a string
	removeFormatChars	=.  [: (9!:6 bind '' e.~ ])`(,:&' ') }  ,@:(,&CRLF"1)
	NB.  Converts a box array into a string
	listToText			=.  removeFormatChars@:}.@:}:@:removeOddIndicies@:":

	NB.  Verb to list (as text) the number of each type of filr in a directory
	NB.  Less obscure form:  listExtFreqs 		=:  _5&$: : (_2&}.@:listToText@:(-@:|@:[ <\ extensionFreq@:]))
	NB.  EG:   listExtFreqs 'b:\temp'     NB. Defaults to listing 5 rows of extensions
	NB.  EG2:  10 listExtFreqs 'b:\temp'  NB. Lists 10 rows of extensions
	listExtFreqs		=:  _5&$: : (  (_2&}.@:listToText@:(<\ extensionFreq)~ -@:|)~  )	f.

NB.  =====================================================================================================================================================
NB.  Environment Utilities: Mostly covers for foreigns.
NB.  =====================================================================================================================================================

	defineAndDefaultParams =:  2 : 0
	NB.  This conjunction takes a noun as a LHA and a explicit monadic verb as a RHA.
	NB.  When used, it will allow the verb to be called with a parameter table, where
	NB.  the elements of column 0 are the names of the parameters and the elements of
	NB.  column 1 are  the values of the parameters.  The parameters are then defined
	NB.  as local names (assigned  to their respective values) which the explicit verb
	NB.  can use at its convenience.
	NB.
	NB.  The definer of the verb must provide a  default parameter table to be used in
	NB.  lieu of user-defined parameters (that's the noun LHA).
	NB.
	NB.  For his convenience, instead of passing in a 2xN parameter table, the caller
	NB.  may use a list of boxes. These values will be assigned to the first N names in
	NB.  the default parameter table.  If the caller passes in an unboxed value, that
	NB.  value will be assigned to the first name in the default parameter table, unless
	NB.  that value is null (0=#y), in which case the default parameter table will be
	NB.  used in its entirety, with no caller-defined values.

		if. '3 :' beginsWith~ verbBody =. 5!:5<'v' do.
		NB.  If this is an explicit monadic verb, then redefine it appropriately.

			NB.  Drop off the '3 : 0' (or '3 : ''')
	 		verbBody		=.  5 }. verbBody

			NB.  We need to build up a verb that will massage the input to v
			
			NB.  Box the input iff it's not boxed and it's not null.  This way it's convenient to pass in one parameter, or
			NB.  none, just allowing all the defaults to take effect.
			normalizeInput			=.  <^:(# 2 b.&* L.)

			NB.  Determines if the input's rank is at least 2.  That is, if it's 'less than' a table.
			isList					=.  2&>@:#@:$@:]

			NB.  Stiches on the first N parameter names to the input list (where N = # list),  allowing the user to pass in a
			NB.  list of parameters without names so long as they're in the correct order (the correct order is as defined by
			NB.  the default parameters).
			paramListToTable		=. ([: ({."1@:[ ,. ,@:])&>/ <.&# {.&.> ,&<)^:isList

			NB.  Appends the default param name/value pairs onto the end of the parameter table.
			appendDefaults			=. paramListToTable , [

			NB.  For convenience, normalizeNames lowercases and removes spaces, dashes, and underscores from parameter names.  
			NB.  This is so that, for example, 'someParameter', 'Some Parameter', 'some-parameter', 'SOME_PARAMETER' are
			NB.  treated equivalently.  Doing this may result in name conflicts.  Note also that this will force me to use
			NB.  names that don't conform to my naming convention (i.e. I have to use someparameter as opposed to 
			NB.  someParameter).  
			notmalizeNames			=. (tolower@:-.&' _-' each @:({."1) ,. {:"1)

			NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
			NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to 
			NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
			NB.  access).
			createParameterTable	=.  m&([ (] {~ i.~&:({."1))&:notmalizeNames (appendDefaults normalizeInput)) f.

			NB.  We will add these lines to the top of v, thereby redefining it.

			NB.  Apply createParameterTable to y (the input to v)
	        newHeading 		=.  'NB.  Create parameter name/value table from input and default table.', CRLF, 'params =. ', (5!:5<'createParameterTable') , ' y'
			NB.  Define some local names from the parameter table we just created.
			newHeading 		=.  newHeading , CRLF, 'NB.  From the parameter name/value input table, define local names from column 0 to values from column 1' , CRLF , '({."1 params) =. {:"1 params'
			
			NB.  Drop off the trailing ')' (or '''') from v, add our new heading, and output the redefined verb.
			3 : (<;._2 toJ newHeading, CRLF, CRLF, ,&CRLF^:(LF&~:@:{:) _1 }. verbBody)
		else.
		NB.  If v isn't an explicit monadic verb, don't do anything to it.
	 		v
		end.
)

	renew_z_			=:  verb define
	NB.  Reset state of the J session, without having to close and restart J.
	NB.  Closes and unlocks
		require 'files jmf socket'

		1!:22"0 (>0{"1 (1!:20 ''))
		unmapall_jmf_ ''
		sdreset ''
		wd 'reset'
		4!:56 ''
		7!:4 ''

		18!:4<'base'
		0!:0 <'system\extras\config\profile.ijs',~1!:40''
)

	findNames			=: verb define
	NB.  Monadic case of findNames:  Same as dyadic with an empty LHA.
	NB.  Example (monadic):  findNames '^r' 
	NB.  Example (dyadic) :  (0 3;'base z') findNames '^r'
		'' findNames y
:
	NB.  Utility to find named entities:  
	NB.  findNames allows searching for names of any type (noun, verb, etc.), or all types, in any or all locales.
	NB.  Name searches are case-insensitive, and some basic search patterns are allowed.  Specifically, the first
	NB.  character of the search string specifies the type of matching to do.
	NB.
	NB.  Input:  		x can be either empty, numeric or boxed, and it specifies the types and locales of named
	NB.                 entities to find. 
	NB.					
	NB.					If 0 -: # x then all names in all locales will be searched.
	NB.
	NB.                 If x is numeric, all locales are searched, and only those names whose type is
	NB.                 an element of x will be searched (as for names_z_ or nl_z_).  
	NB.
	NB.					If x is boxed, then only the first two boxes matter.
	NB.						0 { 2 {. x is a numeric type list as described above.
	NB.						    If 0 -: # 0 {:: 2 {. x then all types will be searched.
	NB.						1 { 2 {. x is literal or boxed, and specifies what locales to search.
	NB.						    If 0 -: # 1 {:: 2 {. x then all locales will be searched.
	NB.
	NB.					y is literal, and provides the search pattern.
	NB.						}. y is the search string
	NB.						{. y is the type of search to perform.  The possible values of {. y are as follows 
	NB.						(if {. y is not one of the following, a default of '|' is assumed, and all of y 
	NB.						is used as the search string):
	NB.							'=' means 'exactly match the name'. 
	NB.							'|' means 'match anywhere in the name'. 
	NB.							'^' means 'match at the beginning of the name'.  
	NB.							'$' means 'match at the end of the name'.
	NB.							'~' means 'match regular expression'.
	NB.					Note that if '!' -: {. y, then the  search is negated (i.e. the names that do NOT match the
 	NB.					pattern are returned), and }. y is considered the search pattern.
	NB.
	NB.  Output: A 2 by N matrix of boxes, with N = to the number of locales searched (which will always be >: 1).  Each box contains a list of 2 boxes, 
	NB.  The first box in each row contains the literal name of a locale searched, and the second box of each contains a list of boxes (possibly with # = 0)
	NB.  each containing a name in that locale matching the search pattern.

		NB.  Require regexes for the '~' operator (do I want to require this selectively?  So that I only load it in if I'm actually going to run a regex?)
		require 'regex'

		NB.  This complicated line is just to make sure that we default correctly.  That is, x must always be a list of 2 boxes,
		NB.  the second containing conl$0 if no locale names were provided.
		locales			=. 1 {:: x =. ({. , ((conl$0)"_^:(0: -: #))@:(;:^:(-.@:*@:L.))&.>@:{:)@:(2&{.)@:boxopen x

		NB.  This creates a verb which will negate our search function if and only if the first character of 
		NB.  the search string is '!'.  It also updates the search string by removing the '!' if it's present.
		negate			=. -.^: ( 1 {:: 'y z' =. ((}.~ ; ]) '!'&-:@:(0&{)@:(1&{.)) y )

		NB.  If no proper search type is specified, the default, '|' or 'match anywhere in the name',
		NB.  is used.
		y				=. (,~ {.&'|'@:-.@:(e.&'=|^$~')@:{.~&1) y

		NB.  These are our search verbs - they correspond to the search type in the following line.
		verbs			=. -:`(+./@:E.)`(beginsWith~)`(endsWith~)`rxin

		NB.  This will select the correct search verb from the list.  5!:0 turns the result of the
		NB.  pick from the gerund into a verb.
		searchVerb		=.  (([: {&verbs [: '=|^$'&i.@:{. 1&{.) y) 5!:0

		NB.  Default the name list to an empty list of boxes.
		nameList		=. 0 2 {. a:

		for_locale. locales do. 
	 		nameList	=. nameList , locale , < y (] #~ (negate@:searchVerb&lc~ }.)~ &>&boxopen) nl__locale 0 {:: x
		end.
)
	NB.  ls is just like list only it wraps to the maximum line length instead of the window size, avoiding the ...ed list problem.	
	ls					=: list~ {.@:wcsize bind '' <. 1: { 9!:36 bind ''

	NB.  Like findNames, but with pretty printing output (like names_z_)
	listNames			=: ([: ls@:, (1&{:: , each '_'&envelope&.>@:{.)"1) @: findNames

	NB.  Return a list of all names in all locales.
	allNames			=: 3 : ' y&(4 : ''y , < nl__y x [ y =. boxopen y'')&> conl $0'

	NB.  Mesaure time of execution of a sentence (format num_times time 'sentence')
	time 				=:  6!:2
	NB.  Measure memory usage for a sentence
	space				=:  7!:2

	ts					=:  time , space@:]

	hide				=:  wd bind 'smmfshow sw_hide'
	exit				=:  2!:55 bind ''

	NB.  Toggle Linedraw: Switch between ASCII-char box drawing and DOS lines box drawing.
	toggleLD			=:  (empty 9!:7@:>@:('+'&e.@:(9!:6) { (('|-',~9#'+');(218 194 191 195 197 180 192 193 217 179 196{a.))"_))

	NB.  Set the print precision
	pp					=:  [: (i. 0 0)"_ (9!:11)

	NB.  Bident/Trident train table from appendix F. of the J dictionary
	FTRAINS				=:  _4 }:\ <@:	removePadding;._2  'N0 V1 N2   |noun    |x V1 y||V0 V1 V2|verb|(x V0 y) V1 (x V2 y)||V0 V1 C2|conj|V0 V1 (x C2 y)||A0 V1 V2|adv|(x A0) V1 V2||C0 V1 V2|conj|(x C0 y) V1 V2||C0 V1 C2|conj|(x C0 y) V1 (x C2 y)||A0 A1 V2|conj|(x A0) (y A1) V2||A0 A1 A2|adv|((x A0) A1) A2||C0 A1 A2|conj|((x C0 y) A1) A2||N0 C1 N2|verb|x (N0 C1 N2) y||N0 C1 V2|verb|x (N0 C1 V2) y||N0 C1 A2|adv|N0 C1 (x A2)||N0 C1 C2|conj|N0 C1 (x C2 y)||V0 C1 N2|verb|x (V0 C1 N2) y||V0 C1 V2|verb|x (V0 C1 V2) y||V0 C1 A2|adv|V0 C1 (x A2)||V0 C1 C2|conj|V0 C1 (x C2 y)||A0 C1 N2|adv|(x A0) C1 N2||A0 C1 V2|adv|(x A0) C1 V2||A0 C1 A2|conj|(x A0) C1 (y A2)||A0 C1 C2|conj|(x A0) C1 (x C2 y)||C0 C1 N2|conj|(x C0 y) C1 N2||C0 C1 V2|conj|(x C0 y) C1 V2||C0 C1 A2|conj|(x C0 y) C1 (y A2)||C0 C1 C2|conj|(x C0 y) C1 (x C2 y)||N0 A1|verb|x (N0 A1) y||N0 C1|adv|N0 C1 x||V0 N1|noun|V0 y||V0 V1|verb|x (or y) V0 V1 y||V0 A1|verb|x (V0 A1) y||V0 C1|adv|V0 C1 x||A0 V1|adv|(x A0) V1||A0 A1|adv|(x A0) A1||A0 C1|adv|(x A0) C1 x||C0 N1|adv|x C0 N1||C0 V1|adv|x C0 V1||C0 A1|conj|(x C0 y) A1||'

	NB.  Dyadic verb to look up a particular train; takes the lookup type (either 'definition' or 'produces') as a LHA and a lookup specification as a RHA
	NB.  Verb is case-insensitive, only cares about the first letter of the LHA ('d' vs 'p'), and only compares the first letter of each of the types in the RHA 
	NB.  and the FTRAINS table.  So, for example, for searching purposes, 'c' is equivalent to both 'conj' and 'conjunction' (and, incidentally, 'coun', 'cerb', 'cadverb', 'camera' ...).
	NB.  E.G. 'def'  ftrain 'A C A' 		NB.  Returns ,:  <;._1 '|A0 C1 A2|conj|(x A0) C1 (y A2)'
	NB.  E.G. 'prod' ftrain 'verb'			NB.  Returns 8 3$<;._1 '|V0 V1 V2|verb|(x V0 y) V1 (x V2 y)|N0 C1 N2|verb|x (N0 C1 N2) y|N0 C1 V2|verb|x (N0 C1 V2) y|V0 C1 N2|verb|x (V0 C1 N2) y|V0 C1 V2|verb|x (V0 C1 V2) y|N0 A1|verb|x (N0 A1) y|V0 V1|verb|x (or y) V0 V1 y|V0 A1|verb|x (V0 A1) y'
	ftrain				=:  FTRAINS&([ #~ ([ {"1~ 0&{::@:]) =&:((uc@:{.;._2@:appendIfNotPresent~&' ') each ) 1&{@:])@:((;~ 'DP'&i.@:{.)~&:uc&(' '&collapseMultiples)&,) 
	
	NB.  Noun types, in order, by powers of two, from appendix A., conversion section of the dictionary.
	nountypes			=:  <;. _2 'boolean|literal|integer|floating point|complex|boxed|extended integer|rational|||sparse boolean|sparse literal|sparse integer|sparse floating point|sparse complex|sparse boxed|symbol|unicode|'

	NB.  Paste clipboard contents
	paste				=:  wdclipread

	NB.  Copy RHA to clipboard
	clip				=:  wdclipwrite

	NB.  Gives the noun type of the RHA
	nt					=:  nountype =:  ({&nountypes) @: (2: ^. 3!:0)

	NB.  Gives the full type of the NAME specified in the RHA.  E.G. <'verb' or <'conjunction' or <'noun:  boolean'
	ft					=:  fulltype =:  (((('noun: '&,) each @:nountype@:".@:>@:boxopen@:[) ^: ((<'noun')&-:@:]) ) type)	NB.  Gives the full type of the NAME specified in the RHA (full type is type, and noun + nountype if noun)

	NB.  Wrap a line of text to the window width
	wrap				=:  (]\~ (-@:(<./)@:(3 : '({. wcsize'''') , (1 { 9!:36'''')')))

	NB.  Linear definition of a verb
	deff				=:  5!:5 @ boxopen

	NB.  Linear representation of data; not a name.
	nounToText			=: 3 : '5!:5<''y'''

	NB.  Linear representation of a verb; not a name.
	verbToText			=: 1 : '5!:5<''u'''

	NB.  Parse strings passed on command line (including filenames and filenames in spaces).  Gets rid of any empty parameters. (E.G. "" or " ")
	NB.  Obsoleted by commandLineParser.ijs
	NB.  cmdlnParse =:  (#~ (' '&(*./@:=) +: # = 0:)&>)@:('"'&= <;._2 ])@:(wd)@:('qcmdline'"_)

	NB.  Opens the files specified on the command line.
	NB.  Obsoleted by openCommandLine.ijs
	NB.  openCmdlnFiles =:  open@:}.@:cmdlnParse

	openVerb			=:  open@:(4!:4 { 4!:3)@:boxopen

	NB.  Boxed list of the filenames of all open scripts
	scriptsOpen			=: [: <;._2 wd bind 'qsmall'

	NB.  Pretty-print formatted list of open scrips
	listScripts			=: ls@:scriptsOpen

NB.  =====================================================================================================================================================
NB.  Execution section: Run these verbs at startup
NB.  =====================================================================================================================================================

NB.  The following line saves the path and filename of this script into the variable utilsfile_z_
utilsfile_z_	=:  ; getPath 'madeUpString'
smoutput 			'New J (' , (({.~ i.&'/') 9!:14 '') ,  ') session started on ' , ((i.&' ') ({. , ' at '"_ , }.@:}.) ]) _4 }. isotimestamp 6!:0 ''