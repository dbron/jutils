NB.  =====================================================================================================================================================
NB.  Initialization section:  Puts us in the proper locale, etc.
NB.  =====================================================================================================================================================

NB.	cocurrent 'dan'
NB.!  Fix all the NB.!s in here.
NB.!  Make shorter (single-letteR) names for most-used functions.
NB.!  Try to find more idioms (automatically), like ^:_1 and $&0 1@:# and give them names.

NB.  =====================================================================================================================================================
NB.  Dependencies:  J scripts we need loaded to define the rest of our utilities
NB.  =====================================================================================================================================================

	NB.  WinAPI for getTemporaryFileName etc.
	NB.  Dates for dateToString.
	NB.  Files for the convenience of fread, fwrite, etc.
	NB.  Sprintf for formatString
	load 'winapi dates files printf'

NB.  =====================================================================================================================================================
NB.  General Utilities:  Useful items or good examples of how to accomplish tasks.
NB.  =====================================================================================================================================================

	NB.  These are the elements I'm usually interested in from a.
	QUOTE					=:  ''''	
	UCALPHA					=:  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	LCALPHA					=:  'abcdefghijklmnopqrstuvwxyz'
	ALPHA					=:  LCALPHA,UCALPHA
	DIGITS					=:  '0123456789'
	ALPHANUM				=:  ALPHA,DIGITS
	WHITESPACE				=:  ' ', TAB, CR, LF
	PRINTABLE				=:  WHITESPACE , a. {~ 33 ([ + i.@:>:@:-~) 126  NB.  a. ];.0~ 33 ,: 94
	PRIMITIVES				=:  ;: '! !. !: " ". ": # #. #: $ $. $: % %. %: & &. &.: &: * *. *: + +. +: , ,. ,: - -. -: . .. .: / /. /: 0: 1: 2: 3: 4: 5: 6: 7: 8: 9: : :. :: ; ;. ;: < <. <: = =. =: > >. >: ? ?. @ @. @: A. C. D. D: E. H. L. L: S: T. [ [. [: \ \. \: ] ]. ]: ^ ^. ^: _1: _2: _3: _4: _5: _6: _7: _8: _9: _: ` `: a. a: b. c. d. e. f. i. i: j. m. n. o. p. p: q: r. s: t. t: u. u: v. x. x: y. { {. {: {:: | |. |: } }. }: }:: ~ ~. ~: NB.'

	NB.  I keep having to calculate this, so I'm just going to store it.
	MAXINT					=:  ((<.@<:@(2&^))^:2) 5   NB.  Same as (<. <: 2 ^ <. <: 2 ^ 5) or (<. <: 2 ^ 31)


	NB.  Calculate the frequency of use in the OMS of each of the primitives.
	NB.	primitive_frequency		=:  NVtext PRIMITIVES ([ ((,. 0j2&":&.>@:(0.01&round)@:(% +/ % #)) \: ]) (<:@:(#/.~))@:,) (#~ e.&PRIMITIVES) ; ; ;: ::(a:"_) L: 0 LF&arbCut@:toJ@:fread&.> {."1 dirtree '\\rutherford\dfs\j\dev\current\*.ijs' [ load 'dir'

	NB.  Jose Quintana's adverb for sequential application of dyadic verbs
	NB.  x. f seq y. is essentially equivalent to ... (2 {:: x.) f (1 {:: x.) f (0 {:: x.) f y.
	seq						=:  ((&.>) /) (@:((|.@:[) , (<@:]))) (>@:)


	NB.  Left-middle-right.  Takes 3 verbs (l m r) as arguments.  Makes a fork:  (l@:[ m r@:])
	NB.  EG:  (1: 2: lmr 3:)  NB.  Returns (1:@:[ 2: 3@:])
	lmr						=:  1 : '2 : (''u.@:[('', (5!:5 fw ''u.'') , '')v.@:]          	'') ' NB. 1 : ' ([.@:[)  u.  (].@:])'

	NB.  Conjunction that takes a noun LHA and a dyadic verb RHA.
	NB.  Derived verb is ambivalent; if no LHA specified, the conjunction's LHA
	NB.  is used.
	dl						=:  defaultLHA	=:  2 : 'm.&$: : v.' NB. [.&$: : ].

	NB.  An adverb which coerces its RHA to the rank of the LHA
	NB.  It's an adverb because ,:@:]^:([ - rank@:]) doesn't work 
	NB.  on arguments where (< rank) because ,:@:] isn't invertible.
	NB.  EG:  3 :'rank 2 rankN ,:^:y. 0'&.> i. 4  NB. Returns 2;2;2;2
	rankN					=:  ((&-)(@:rank))(,:^:)

	NB.  An adverb that gives the indicies in the RHA (which can be of any rank) where the
	NB.  verb on the LHS returns true.  The following example finds the indices of the LHA in the RHA
	NB.  E.G. 0&= index 4 4$8 3 9 2 0 5 0 1 10 9 8 5 0 7 6 0	NB.  Return 4 2$1 0 1 2 3 0 3 3
	NB.  E.G. 'z0ert' e.~ index 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' {~ i. 3 4 5  NB.  Returns 5 3$0 0 4 0 3 2 0 3 4 1 1 0 2 2 2
	index					=:  1 : '(# i.@#)@:(u.&:,) #~ $@:]'NB. (# i.@#)@:(&:,) #:~ $@:]

	NB.  A conjunction like ::, but which produces verbs with the same rank as the LHA.
	NB.  EG:  q: adverse 0: i. 3 NB.  Returns ,. 0 0 2
	adverse					=:  :: " [.

	NB.  Adverb that applies u. to the sequences of equal elements in the input.
	NB.  EG:  >./ # plateaus 0 1 1 3 5 5 5 6 _1 _1 2 _1 0 _1  NB.  Returns 3
	plateaus 				=:  ((;.1)~) 1: , 2&(~:/\)
	
	NB.  A 'translate' conjunction.  Has 2 noun arguments, producing a verb.
	NB.  Example:  rot13 =.  'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM' tr 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	NB.  rot13 'Guvf vf fbzr ebgngrq grkg'
	xlat					=:  ({&(2 :'m.,a.')) @: ((2 :'n.,a.')&i.)  NB.  Old form:  2 : '({&(n. , a.)) @: ((m. , a.)&i.)'

    NB.  The conjunction 'xl' is like 'xlat', but works on any type of argument, not just literals, because
	NB.  it doesn't need to know the set of all possible inputs in advance.  It's slower than xlat and is not
	NB.  automatically invertible.
	NB.
	NB.  Redefine 'merge' to make the 'xl1' work on any rank input (including scalar).
	NB.  merge=: {"0 1 (0&|:)
	NB.
	NB.  Could replace (, fillElement) with ({.~ >:@:#).
	NB.
	NB.  Easier to read and understand, but the derived verb won't
    NB.  be evaluated until it's actually passed an argument.
    xl0  =:  2 : '(idxs ~: # m.) } y. ,: (idxs =. m. i. y.) { (, fillElement) n.'
	
    NB.  This is harder to understand, but will immediately output a tacit
    NB.  verb when both arguments to the conjunction are specified.
	xl1  =:  2 : '(((#m.)&~:@:>@:{.@:] ({"0 1 (0&|:)) (,: >@:{:)) (,&< {&((, fillElement) n.))@:(m.&i.)) f.'
	  
	NB.  Like xl1, but is invertible.
	xl2  =:  2 : 'm. xl1 n. :. (n. xl1 m.)'

	NB.  Another translate conjuction, only for scalars.  Repalce the scalar LHA to the conjunction with the scalar RHA to the conjunction.
	NB.  EG.  0 scalarReplace _1 ] 5 8 0 0 5 6 0 3 0 4  NB. Returns 5 8 _1 _1 5 6 _1 3 _1 4
	NB.  scalarReplace	=: 2 : '(m.&=)`(,:&n.) } y.'
	sr						=:  scalarReplace			=: (&=)`(,:&) }
	s						=:  2 : ('(m. sr n.) :. (n. sr m.)')

	NB.  A better version of scalarReplace; actually more of a hybrid of scalarReplace and xlat.  It shares the advantages of scalarReplace
	NB.  in that it does not need to know the universe of possible values in advance (meaning it's not restricted to literals and doesn't
	NB.  require explicit code).  It shares the advantage of xlat in that it can replace a list of scalars with another list of scalars, instead
	NB.  of just a single scalars.  Like scalarReplace and xlat, it is restricted to replacing scalars with scalars: it cannot replace arbitrarily
	NB.  shaped data (use replace for that [which has the additional freedom of not requiring the search and replace inputs to be of the same
	NB.  length]).  One drawback of multiScalarReplace is that it needs to create large temporary (ephemeral) data; (#@[ * */@:$@:]) elements to
	NB.  be exact.
	NB.  EG:  abc_to_def 'aZbYcX'       [. abc_to_def	=: 'abc' multiScalarReplace	'def' NB.  Returns 'dZeYfX'
	NB.  EG:  zero_to_one 5 5 5 5 $ 0   [. zero_to_one	=:     0 multiScalarReplace 1     NB.  Returns 5 5 5 5$1
	find					=:  i.~"0 _&
	overlay					=:  &(] ,~ ($~"0 1&, $))
	msr						=:  multiScalarReplace	=: (find ` overlay) }
	m						=:  2 : ('(m. msr n.) :. (n. msr m.)')

	NB.  First attempt at creating a generalized translation function.
	NB.  It should handle as many cases as I can come up with, in the 
	NB.  fastest manner I can discover for each.
	X 						=:  conjunction define

		NB.  Could require 'translate.ijs' here
		NB.  and use its definitions.

		NB.  If we're just replacing a scalar by a scalar,
		NB.  use scalar replace.
		if. *./ 0 = #@:$&> m. ,&:< n. do.
			m. s n.	
		NB.  If we're replacing a list of items by the same
		NB.  element (N-to-1 mapping), use e. instead of i.
		NB.  This is not invertible.
		elseif. (-: 1&|.) n. do.
			(e.&m.) ` (,:&({. n.)) }
		NB.  Else do the general case.
		elseif. 1 do.
			m. m n.
		end.
)

	NB.  The adverb evoke can be used to access global nouns (which can change) from tacit definitions.
	NB.  E.G. lookUpID	=: ((i.~ {."1) { {:"1@:]) 'ID_TABLE' evoke
	evoke					=:  ". bind

	NB.  Adverb to produce dyadic verb which applies u. to y. x. times.
	NB.  Equivalent to u.^:x. y.
	NB.  EG:  5 (, 2: + 3: * {:) apply 0  NB.  Returns 0 2 8 26 80 242 (see JForum message from Zhe Fu on 2003-Jan-04).
	apply					=:  (@:[) (&'')

	NB.  Make LHA copies of RHA
	copy					=:  (* #) $ ]

	NB.  Workarounds for the index errors raised by {. and {: on arguments with #=0
	head					=:  {.@:( 1&{.)
	tail					=:  {:@:(_1&{.)

	NB.  Returns the rank of the input.  
	NB.  EG:  3 :'rank ,:^:y. 0'&.> i. 4  NB. Returns ;/i.4
	rank					=:  #@:$	

	NB.  Merge the RHA by the specification of the LHA
	NB.! Find some way to say this tacitly.
	NB.  EG:  0 1 2 3 mergelists 'abcd','ABCD','efgh',:'EFGH'  NB.  Returns 'aBgH'
	merge					=:  4 : 'x.}y.'

	NB.  Merge a set of lists based on a merging specification
	NB.  EG:  0 1 2 1 0 2 mergelists 'ABCDEFG';'0123';'zyxwvutsr'  NB.  Returns A1x3Eu
	mergelists				=:  ([ + #@:] * i.@:(#@:[)) { (,@:|:@:>@:])

	NB.  Shuffle two lists together.
	NB.  E.G. (shuffle -) i. 9  NB.  Returns 

	NB.  Replace multiple occurances of a char with a single occurance.
	collapseMultiples		=:  (] #~ (-.@:E.~ 2&#)~)

	NB.  Round RHA to the nearest LHA.
	round					=:  ([ * [: <. 0.5"_ + %~)

	NB.  Scramble the items of y.
	scramble				=:  {~ ?~@:#

	NB.  Identify the depth of nested parens at each point in a string
	NB.  parenDepth				=:  +/\ @: (-/) @: ('()'&(=/))
	parenDepth					=: '()'&$: : (({. -~ +/\@:(-/))@:(=/))  NB.  Modified so both open & closing parens are at the same depth.

	NB.  Turn a character vector with nested parens into an isomorphic boxed representation.
	NB.  nestingToBoxing  '(here is some) (stuff (nes(t)ed)) and (things)'  NB.  Returns (<,<'here is some'),(<,' '),(<,<'stuff '),(<,<,<'nes'),(<,<,<,<,'t'),(<,<,<'ed'),(<,<''),(<' and '),<,<'things'
	pd							=.  (+/\@:(-/) + {:)@:('()'&(=/))
	removeParens				=.  -.&'()' L: 0
	nestingToBoxing				=:  removeParens@:((] (({~ _1&(|.!.0)@:(+/\)@:(#&>)) <@:-.&'()' apply"0 ]) (<;.1~ 1: , 2&(~:/\))) pd) f.
	

	NB. Tests if all items in the RHA are equivalent.
	allSame					=:  (1: = #@:~.)

	NB.  Tests if beginning of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
	beginsWith				=:  ,^:(0: -: #@:$)@:] -: ({.~ #)    NB.  ([ -: ({.~ #)~)

	NB.  Tests if end of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
   	endsWith				=:  ,^:(0: -: #@:$)@:] -: ({.~ -@:#)

	NB.  Appends the LHA to the RHA if the RHA doesn't already end with the LHA.
	appendIfNotPresent		=:  ,~^:(-.@:endsWith~)

	NB.  Drops the the LHA from the beginning of the RHA iff the RHA begins with the LHA.
	dropIfPrepended			=:  (}.~ #)~^:(beginsWith~)

	NB.  Drops the LHA from the end of the RHA iff the RHA ends with the LHA.
	dropIfAppended_base_		=:  removeIfTrailing =:  (}.~ -@:#)~^:(endsWith~)

	NB.  If all or part of the LHA is a prefix the RHA, then that prefix is dropped off the RHA.
	NB.  EG:  'abc'  dropPrefix 'abcDEF'  NB.  Returns 'DEF'
	NB.  EG:  'abc'  dropPrefix 'abDEF'   NB.  Returns 'DEF'
	NB.  EG:  'abc'  dropPrefix 'aDEF'    NB.  Returns 'DEF'
	dropPrefix				=:  (] }.~ ({.~ #) i.&0@:= ])

	NB.  Places the LHA on either side of the RHA.
	NB.  E.G.:  '***' envelope 'hello' NB.  outputs '***hello***'
	envelope				=:  ([ ,~ ,)

	NB.  Takes a scalar as a LHA and an N-dimensional array as a RHA.
    NB.  Completely encloses the RHA with repetitions of the LHA.
	NB.  E.G.:  '*'  trap ,:'hello' NB.  Outputs 3 7$'********hello********'
	trap					=: ([ 0&|:@:, ,~)^:(#@$@:])

	NB.  Get all the possible subsets of a set, including the empty and full sets.
	subsets					=:  <@#~ (2: (#~ #: i.@^) #)

	NB.  Remove leading and trailing whitespace from a string.
	trim					=:  #~ (+./\. *. +./\)@:(-.@:(e.&(9 32 { a.)))

	NB.  Remove trailing spaces from a string.
	removeTrailingBlanks	=:  (#~ (+./\.)@:~:&' ')

	NB.  Partition a literal by spaces (multiple spaces count as a single space).
	NB.  slice 'When eras die, their legacies are left to strange police.  Professors in New England guard the glory that was Greece.'
	NB.slice	=: (<;._2~ ' '&=)@:(#~ ([: -. '  '&E.))@:(,&' '^:(~:&' '@:{:))
	NB.  Actually, since we reduce all multiple spaces to a single space, we don't need to test if the last character is a space.
	NB.slice	=: (<;._2~ ' '&=)@:(#~ ([: -. '  '&E.))@:,&' '
	slice					=:  ' '&$: : ((}.^:(a:&-:@:(0&{)@:(1&{.)))@:([ (= <;._2 ]) [ collapseMultiples ,~))
	NB.  Make this adverb .. also make it take abitrary (non-scalar) delimiter, like arbCut

	NB.  Just like ;:^:_1, but can join with any glue.
	NB.  EG:  ', ' join ;: 'a b c d e f'
	join					=:  -@:#@:[ }. ;@:(,&.> boxopen)~

	NB.  Cut on an arbitrary-length fret.
	NB.  EG:  ' hello ' arbCut 'hi hello how hello are hello you hello today' NB.  Returns ;: 'hi how are you today'
	ac						=:  [ (E. <;.1 ]) ,
	arbCut					=:  <@:#@:[ }.&.> ac f.

	NB.  Dyad to do nested cuts on multiple frets.  Left hand argument is list of (possibly boxed) frets.  If LHA is unboxed,
	NB.  its elements become the frets.  RHA is data to cut.  Output is array of boxes with a rank equal to the number of frets.
	NB.  EG:  ( <  ' ') multiCut 'a.q/b.r c.s/d.y e.u/f.v g.w/h.x'  NB.  Returns                'a.q/b.r'      ;'c.s/d.y'      ;'e.u/f.v'      ;'g.w/h.x'
	NB.  EG:  (;/ ' /') multiCut 'a.q/b.r c.s/d.y e.u/f.v g.w/h.x'  NB.  Returns 4 2   $        'a.q'  ;'b.r'  ;'c.s'  ;'d.y'  ;'e.u'  ;'f.v'  ;'g.w'  ;'h.x'
	NB.  EG:  (;/' /.') multiCut 'a.q/b.r c.s/d.y e.u/f.v g.w/h.x'  NB.  Returns 4 2 2 $ , each 'a';'q';'b';'r';'c';'s';'d';'y';'e';'u';'f';'v';'g';'w';'h';'x'
	NB.  EG:     ' /.'  multiCut 'a.q/b.r c.s/d.y e.u/f.v g.w/h.x'  NB.  Equivalent to last expression.
	NB.  Another form, less readble:  arbCut&>/@:((, <)~ <"_1^:(L. = 0:)@:|.)~
	multiCut				=:  arbCut&>/@:(<"_1^:(L. = 0:)@:|.@:[ , <@:])
	
	NB.  Turn a space- and slash-delimited string into a 'map' compatiable noun.
	NB.  EG: makeMap 'Name/Daniel Age/24 Gender/M' NB.  Returns 2 3$<;._1 ' Name Age Gender Daniel 24 M'
	makeMap					=:  ' /'&multiCut
	
	NB.  Turning a noun into a table is a common operation.  This automates it.
	NB.  LHA input is the fret that will determine the second dimension (i.e. how the rows are cut into elements).
	NB.  default fret is TAB.
	NB.  RHA is the noun (from a noun define)
	NB.  EG:  '|' makeTable noun define NB. Returns 2 3$<;._1 ' A B C D E F'
	NB.       A|B|C
	NB.       D|E|F
	NB.       )
	makeTable				=: TAB&$: : (trim each @: (LF&;@:[ multiCut }:@:]))
	
	NB.  With a mapping-noun on the left and elements to lookup on the left, returns the results of the lookup.
	NB.  Unboxed inputs result in scalar outputs.  Should I make this invertible?
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map       'Name'      NB.  Returns  'Daniel'
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map     ,<'Name'      NB.  Returns ,<'Daniel'
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map     ;:'Name Age'  NB.  Returns   'Daniel';'24'
	NB.  Map is invertable, so you can 'unmap' values:               '
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map^:_1 ;:'Daniel 24' NB.  Returns   'Name';'Age
	map						=:  (-.@:*@:L.@:] >@:]^:([`]) (i.~&:(tolower&.>@:boxopen) {."1)~ { {:"1@:[) :. ((map~ |."1)~)
	multiMap				=:  map~ seq~ 
	
	NB.  The verb mapWithDefault is like map, but allows the map to specify a default.  The default is defined by
	NB.  an empty name, i.e. by an a: in the name-list ({."1 of the mapping table).  If no default is provided,
	NB.  a: will be used in its stead.  The default value will be returned where from mapWithDefault where an index
	NB.  error would be signaled by map.
	NB.  EG:  (4 2$<;._1 ' Name Daniel Age 24 Gender M  UNKNOWN_PARAMETER') mapWithDefault       'Sex'            NB.  Returns  'UNKNOWN_PARAMETER'
	NB.  Note that while mapWithDefault does have an inverse, the inverse is not as strict as that of map; the inverse will return a: for unknown value looked up.
	NB.  EG:  (4 2$<;._1 ' Name Daniel Age 24 Gender M  UNKNOWN_PARAMETER') mapWithDefault^:_1 ;:'Daniel 24 Male' NB.  Returns   'Name';'Age';''
	createDefault			=.  (] ((#~ -.) , ({~ i.&1)) =&a:@:({."1))@:,&a:
	mapWithDefault			=:  (-.@:*@:L.@:] >@:]^:([`]) (((i.~&:(tolower&.>@:boxxopen) [: }: {."1)~ { {:"1@:[)~ createDefault f.)~) :.((mapWithDefault~ |."1)~)
	
	NB.  Cover to map and makemap.
	NB.  EG: 'buy/b sell/s short/t' lookup       'buy' NB.  Retuns <,'b'
	NB.  This verb is also invertable:
	NB.  EG: 'buy/b sell/s short/t' lookup^:_1 <,'b'   NB.  Retuns <'buy'
	lookup					=:  (map~ makeMap)~ :. ((map^:_1~ makeMap)~)
	
	NB.  As mapWithDefault is to map, so lookupWithDefault is to lookup.
	NB.  EG:  'buy/b sell/s short/t /bad_code' lookupWithDefault  'hold' NB.  Returns <'bad_code'
	lookupWithDefault		=:  (mapWithDefault~ makeMap)~ :.((mapWithDefault^:_1~ makeMap)~)

	NB.  Like lookupWithDefault, lookupSelfDefault takes a mapping string on the left and a
	NB.  list of boxed to lookup in the right.  Unlike lookupWithDefault, this function leaves an element as-is unless it can be mapped.
	NB.  EG:  'buy/b sell/s short/t'           lookupSelfDefault  'hold' NB.  Returns 'hold'
	lookupSelfDefault		=: -.@:*@:L.@:] >@:{.@:]^:([`]) ((] (=&(<'__DEFAULT__')@:] {"_1 ,.~)&, (lookupWithDefault~ ,&' /__DEFAULT__')~) boxopen)
	
	NB.  This verb will show where the LHA is equal to the RHA, ignoring width (i.e. padding with the default fill character).
	NB.  For example, 'ABC' matchIgnoreWidth > ;: 'WXYZ QRST ABC MNOP' NB. Returns 0 0 1 0
	miw						=:  matchIgnoreWidth		=: ({. -:"_ _1 }.)@:,

	NB.  Convert text to uppercase
	uc						=:  (UCALPHA xlat LCALPHA) f.

	NB.  Convert text to lowercase
	lc						=:  (uc^:_1) f.

	NB.  Replace all occurances of some sequence with another sequence.
	NB.  E.G. ('Hello';'Goodbye') replace 'Hello, world!'
	NB.! Note that replace is broken.  Try ('\\';'<DSLASH>') replace '\\'
	NB.! Use 'arbCut' in re-implementation.
	locate					=.  E. <;.1 ]
	matches					=.  (([ locate ,)~ >@{.)~
	remove					=.  #@>@{.@[ }.&.> matches
	replace					=:  ;@({:@[ ({.@] , ((,&.>) }.)) remove) f.

	NB.  Replace more than one sequence
	NB.  E.G. ((<'Hello';'Goodbye'),(<'wonderful';'cruel')) multireplace 'Hello, wonderful world!'
	multireplace			=:  replace seq f.

	NB.  This is a slightly modified version of comb dyad that appears in
	NB.  the documentaion for "for." in the J dictionary.  It produces all
	NB.  the size x. combinations of the elements of y.  For example,
	NB.  3 comb 'abcde' NB.  Returns 10 3$'abcabdabeacdaceadebcdbcebdecde'
	comb=: ((] {~ ((4 : 0) #)) ~.)
	 	z=.1 0$k=.i.#c=.1,~(y.-x.)$0
	 	for. i. x. do.
			z=.; k ,.&.> (-c=.+/\.c) {.&.> <1+z
		end.
)

	NB.  Monadic creates random strings; dyadic picks random elements from a set
	randpick				=:  $:&'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' : ((?@:# #) { ])

	NB.  Make a number more readable by delimiting it with commas
	fmt						=: ((({. '-'&,@:]^:(-:&'_'@:[) ({: ;@:,~ ,&',' each @: }:)@:(_3&(<@:|.\)&.|.)@:(-.&'_'))@:{.  , }.)~ i.&'.')@:":
	NB.  Format a list of numbers, and try to put it back in the original shape.
	multifmt				=:  ;:^:_1@:(<@removeTrailingBlanks"1)@:(fmt"0)


	NB.  Format a decimal number.
	NB.  Inputs:  
	NB.  	RHA:  Floating point number to format
	NB.  	LHA:  List of two ints:  number-of-digits-before-decimal , number-of-digits-after-decimal
	NB.  Outputs:  
	NB.		Character vector representation of the floating point number with the correct number of
	NB.  	digits preceding & succeeding the decimal point (leading zeros as spaces).
	NB.  Example:
	NB.  	2 4 fmtDbl 4.522 NB.  Returns ' 4.5220'
	fmtDbl						=:  (({.@:[ (-@:[ {. (,~ #&' ')~) (":~ ({. j. {:) )~)~ (,~ >:@:(+/)))~

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

	NB.  This combination of listToEnglish and pluralize produces a human-readable sentence describing
	NB.  the quantities of the units input.
	NB.! Make this invertible.  Depend on invertible pluralize and invertible listToEnglish.
	getSingularAndPlural		=:  ({."1@:] ,. pluralize@:]) transformInputForPluralization f.
	calculateForm				=:  1&~:@:[ merge |:@:getSingularAndPlural
	joinValuesWithUnits			=:  ([ (,.~ ":&.>)~ calculateForm)
	formatValuesAndUnits		=:  listToEnglish@:(<@:(;:^:_1)"1)
	formatUnitValueTable		=:  formatValuesAndUnits@:joinValuesWithUnits
	NB.  Same as formatUnitValueTable, except that it doesn't include units whose corresponding value was 0
	formatUnitValueTableExcluding0s =:  formatValuesAndUnits@:(0&~:@:[ # joinValuesWithUnits)

	NB.  Convert numbers to English
	NB.  EG:  numberToEnglish 3141671008 NB. Returns 'three billion, one hundred forty one million, six hundred seventy one thousand and eight'. NB.  We could pass this to output 'speak' and have the computer say numbers.
	NB.  
	NB.  (<;._1 '//thousand/million/billion/trillion/quadrillion/quintillion') {.~ # a=.1000 #.^:_1] 999999999
	NB.  (10 #.^:_1"0 a) {"1 > 0 1 0 { <;._1&.> '//one/two/three/four/five/six/seven/eight/nine';'//teen/twenty/thirty/fourty/fifty/sixty/seventy/eighty/ninety'
	NB.  numberToEnglish  =: 
	NB.
	NB.  A basic start at numbers-to-English
	NB.  Should combine fmt, listToEnglish, breakDownLeagues, and something like roman (to create the prefixes (mill bill trill ...) by counting in Greek.
	NB.  (<;._1 '//thousand/million/billion/trillion/quadrillion/quintiliion/sextillion/septillion/octillion/nontillion') (|.@:] trim@:listToEnglish@:,@:(<@:(' '&join)"1)@:|.@:,. ({.~ #)) ',' arbCut fmt (#UCALPHA,DIGITS) ^&:x: 8+3

	NB.  Return (1 { x.) elements from y. starting at 0 { x.
	NB.  EG:  a. from~ 10 ,~ a. i. '0'  NB. Returns '0123456789'
	from					=:  (];.0~ ,:/)~

	NB.  Apply function on nub, then expand array to original length
	NB.  Just make verbs faster on arguments with small nubs.
	applyOnNub				=:  ((@:[) {~ i.~) ~.

	NB.  Cuts tables into columns.  Uses ;.2 with boxed LHA.  LHA can be boolean mask or integer indicies.
	NB.  Field lengths can be converted to indicies with +/\&.(_1&,) on the LHA.
	NB.! Lots of problems with edge conditions (losing the last column, etc).  
	NB.! Also length errors with non-square matricies (like 1 2 3 cutColumns i. 5 5 vs 1 2 3 cutColumns i. 5 6 or 1 2 3 cutColumns i. 6 5).
	NB.  EG:           0 1 0 1 1  parseFixedWidthText 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' {~ i. 5 5  NB.  Returns (5 2$'ABFGKLPQUV');(5 2$'CDHIMNRSWX');,.'EJOTY'
	NB.  EG:       (bx 0 1 0 1 1) parseFixedWidthText 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' {~ i. 5 5  NB.  Returns (5 2$'ABFGKLPQUV');(5 2$'CDHIMNRSWX');,.'EJOTY'
	NB.  EG:  (+/\&.(_1&,) 2 2 1) parseFixedWidthText 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' {~ i. 5 5  NB.  Returns (5 2$'ABFGKLPQUV');(5 2$'CDHIMNRSWX');,.'EJOTY'
	parseFixedWidthText		=:  cutColumns =:  }.@:([ (''&;@:(1&,)@:`) (1:`[`] } #&0@:{:@:$)@.(1: ~: 3!:0@:[) <;.2 (,.~ fillElement)@:])

	NB.  Another fixed-width parsenator.
	NB.  Good for chopping up structs/objects serialized by other languages.
	NB.  EG if you had the definition of a struct from C++, and had a file
	NB.  of a bunch of those structs catenated, you could parse the struct def
	NB.  and use this function to get the struct array.
	NB.  EG:  fieldSizes  =. 4 4 4 4 2 2 2 4 4 1 1 4 4 10 2
	NB.       donkey      =. ;  400 copy UCALPHA (] #&.> ({.~ #)) fieldSizes
	NB.       fieldSizes tryAgain donkey
	tryAgain				=:  ((''&;@:}.@:xb@:] <;.2 (]\~ -@:{:)) +/\)~



NB. parseulator	=: (_2 ]\ 'data';'';'cutpoints';'';'cuttype';'sizes') defineAndDefaultParams (verb define)
NB. 	   'types descriptions' =. <"1 |: _2 ]\ ' ' ([ (] <;._2~ = *. 0&=@:parenDepth@:]) ,~) 'boolean (a boolean mask) indicies (a list of indicies) sizes (a list of field sizes) unknown (the user upfucked)'
NB. 	  (types) =. i.#types
NB.    	   type =. cuttype i.&:(tolower&.>)&:boxopen~ }:types
NB. 		select. type
NB. 			case. boolean do.
NB. 				cutpoints =. bx cutpoints 
NB. 			case. indicies do.
NB. 				cutpoints =. | 2 -/\ cutpoints
NB. 			case. sizes do.
NB. 				NB.  Nominal case -- do nothing,
NB. 			case. unknown do.
NB. 				0 assert~ 'The cutpoints can only be ', '.',~'or ' listToEnglish '()' -. L: 0 ~ }:descriptions
NB. 		end.
NB.
NB. 	cutpoints tryAgain data
NB. )
NB.
NB. noun define
NB. boolean:  a boolean mask
NB. indicies: a list of indicies
NB. sizes: a list of field sizes
NB. unknown: the user upfucked
NB. )


NB.type  types =. 'boolean indicies sizes'
NB.	types =. 'boolean indicies sizes'
NB.	ohma


	NB.  Select;  adverb which takes a verb that produces a boolean; the result of the verb will be selected
	NB.  from the RHA.
	NB.  select					=:  ]: # ]

	NB.  Remove all occurances of the sequence on the LHS from the RHS
	NB.  EG:  'ugly ' remove  'This ugly sentence should ugly be ugly nice'	NB.  Returns 'This sentence should be nice'
	remove					=:  -.@:E # ] NB.  -.@:E select

	NB.  With a list of boxes as a LHA, returns those which contain the sequence in the boxed RHA.
	NB.  E.G. 'A' selectContaining 'ALPHA';'BETA';'GAMMA';'DELTA';'EPISLON';'THETA' NB. Returns  <;._1 ' ALPHA BETA GAMMA DELTA THETA'
	sc						=:  selectContaining	=:  ((1&e.@:E.&> # ])~ <)~ NB.  (1&e.@:E.&> select~ <)~

	NB.  List the files in a directory.  Outputs a list of boxes, each containing the fully-qualified name of a file matching the query.
	NB.  EG:  listFiles 'c:\temp\*.txt'
	listFiles				=:  (({.~ >:@:i:&PATHSEP_j_)&.> , each {."1@:(1!:0))@:boxopen

	NB.  Like the unix utility 'which'; finds files on the path that match the input pattern.
	NB.! Make this tacit (which is easy, but I didn't want to do it at the time I wrote it)
	NB.  EG:  which 'ping.exe'  NB.  Returns ,<'C:\WINNT\system32\'
	NB.  EG:  which 'word.*'	NB.  Returns ,<'c:\danielb\shortcuts\ms\'
	which					=:  3 : '(<y.) (] #~ *@:#@:(1!:0)@:,~&>) ''\'' appendIfNotPresent&.> a: -.~ '';'' slice 2!:5''PATH'''

NB.	files =. splitPath &> ; listFiles @: ,&'*' each /:~ '\'&appendIfNotPresent@:lc each a: -.~ ';' slice 2!:5 'PATH'
NB.	;"1 F #~ 'vim' =&:(s:@:(lc&.>)@:boxopen) 1 {"1 F =: ({. ,. '.'&(i.~ splitup ])&>@:{:)@:|: files

	NB.  Box to any level (get around the boxing depth limitation (max L. is supposed to be 270))
	NB.  Doesn't work on boxed data (because it will change everything at L: 0).
	NB.  EG: 271 box $~ 0 NB.  Returns <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<a:
	NB.  box				=: (({.@:[ (<^:270 L: 0)@:]^:[ <@:]^:({:@:[))~ (<.@% , |~)&270)~

	NB. Returns the fill element of the input.
	fillElement				=:  {.@:(1&{.)@:(0&$)

	NB.  Replace fill elements with last non-fill values.
	NB.  EG:  drag 0 0 1 2 0 0 0 3 0 4 0 0 0 5 6 7 8 0 0 9 0 0 0 0 NB. Returns  drag 0 0 1 2 2 2 2 3 3 4 4 4 4 5 6 7 8 8 8 9 9 9 9 9
	NB.  drag				=:  ;@:(<@:(# # {.);.1~ 1&(0 })@:~:&0)  NB.  Used to only work on numeric arrays, i.e. replace 0s with last non-zero values.
	drag					=:  ;@:(<@:(# # {.);.1~ 1&(0 })@:(~: fillElement f.)) 

	NB.  Treat the fill element of an array like a 'window' through which you can
	NB.  'see' the first non-fill element.  Compresses an array, reducing its rank by one,
	NB.  and fills in 'empty' elements with the first non-empty element in the corresponding
	NB.  column, if possible.
	NB.!  Replace {.@:(1&{.)@:(0&#)@:, with fillElement
	NB.  EG:  squeeze 1 2 3 0 0 0 7 , 8 9 10 11 0 0 14 ,: 15 16 17 18 19 0 21  NB.  Returns 1 2 3 11 19 0 7
	squeeze					=:  ((i.&0@:="1 {.@:(1&{.)@:(0&#)@:,)@:|: )`({.~ >:@:#) }

	NB.  Kind of like drag, kind of like squeeze, the rank and shape of the output is the same as that of the input,
	NB.  but all fill elements have been filled in (if possible) with the "next" non-empty element.  Next means the first
	NB.  non-fill element along the corresponding column.  Squeeze could be reformulated as {.@:fillEmpties
	fillEmpties				=:  drag&.|."1&.|: 

	NB. Util to perform functions inside a string.  Input is literal (character vector), output is literal (character vector).
	NB. Funtions to perform are embedded within dollar signs.  There is no way to include dollar signs in the string itself.
	NB. EG 0:  doString 'hello I am $20 + 4$ years old' NB.  Returns 'hello I am 24 years old'
	NB. EG 1:  doString 'hello I am $twenty_four$ years old' [ twenty_four=.24 NB.  Returns 'hello I am 24 years old'
	doString				=:  ;@:(": each)@:($&0 1@:# ".&.>@:]^:([`[`])"0 ])@:(<;._2)@:,&'$'

	NB.  The dyad formatString is like both doString and sprintf - basically it's a sprintf with named
	NB.  substitutions that takes a name/value mapping as a LHA.  The substitution names may optionally have 
	NB.  a sprintf-compatible formatting command appended (preceded by a colon).
	NB.  EG:  '\\$HOST$\c_drive\oms\$OMS$\$DATE$\' formatString~ _2 ]\ <;._1 ' HOST oem2k OMS oms.prod1.live DATE 20040404'  NB.  Returns '\\oem2k\c_drive\oms\oms.prod1.live\20040404\'
	NB.  EG:  '$NUMBER:X$' formatString~ 1 2 $ 'NUMBER';255  NB.  Returns 'FF'
	NB.!  Fix problem with empty RHAs causing index errors
	parseFormat			=.  '$'&arbCut
	NB.
	placeHolders		=.  #~ $&0 1@:#
	splitOn				=.  1 : '(({. ,&< (}.~ >:)~)~ i.&m.)'
	phAndFormats		=.  ':' splitOn &> @: placeHolders
	mapValues			=.  map {."1
	valuesAndPHF		=.  (mapValues ,&< ]) phAndFormats
	NB.	
	defaultFormat		=.  ({.;:'j')"_ NB.  Could make this a lookup table based on 3!:0 of mapped values
	formats				=.  ({:"1)@:>@:(1&{)@:]
	formattingStrings	=.  (a:&= merge (,: defaultFormat))@:formats
	fStrings			=.  '%'&,&.>@:formattingStrings
	NB.	
	parsedAndMask		=.  (,&< $&0 1@:#)@:[
	parsed				=.  >@:{.
	mask				=.  >@:{:
	NB.	
	expandedFS			=.  (expand~ mask)
	mergeFStrings		=.  mask@:[ merge parsed@:[ ,: expandedFS~
	results				=.  parsedAndMask mergeFStrings fStrings f.
	NB.	
	values				=.  >@:{.@:] 
	fmtResults			=.  values  4 : 'x. sprintf~ y.' ;@:results   NB.  4  : '...' to hide sprintf from f.
	NB.
	hideSlashes			=.   '\' s '|'  
	formatStringx		=.  (] fmtResults valuesAndPHF) parseFormat
	formatString		=:  hideSlashes^:_1@:(formatStringx hideSlashes) f.

	NB.  The adverb formatStringA produces a verb like formatString, but will 'default' the LHA to formatStringD with the LHA
	NB.  to the adverb (using combineMaps).
	NB.  The adverb formatStringA produces verb that defaults both arguments to formatStringA, allowing one to replace values in 
	NB.  a 'template', using default values as neccesary.
	NB.
	NB.  EG:  fmtOMSPath	=.  (_2 ]\ <;._1 ' HOST oem2k OMS oms.prod1.live DATE 20040404') formatStringC '\\$HOST$\c_drive\oms\$OMS$\$DATE$\'
	NB.  EG:  fmtOMSPath  ''                                   NB.  Returns '\\oem2k\c_drive\oms\oms.prod1.live\20040404\'
	NB.  EG:  fmtOMSPath   _2 ]\ <;._1 ' OMS oms.brooke.test'  NB.  Returns '\\oem2k\c_drive\oms\oms.brooke.test\20040404\'
	NB.
	NB.!  The use of combineMaps precludes the user of these operators from changing the formatting of any of the values -
	NB.!  that is, if the default table specifies a NUMBER field, the user can't over-ride and use NUMBER:X.  If
	NB.!  I made combineMaps an adverb (or conjunction) that took normalizeNames as an argument, I could solve this problem.
	formatStringA		=:  1 : '(0 2 $ a:)&$: : ((formatString~  m.&combineMaps_base_)~)'
	formatStringC		=:  ([. formatStringA) & ]. 
	
	NB.  Boolean function utilities
	NB.  The results for all possible functions with two inputs.
	NB.  Might be easier to see as:  _2 ]\ _2 <\ _2 ;/\ BOOLEAN_TABLES
	BOOLEAN_TABLES			=: 2 0 1 |: (i. 16) b./~ i. 2

	NB.  A list of functions (mostly primitives) that is equivalent to (i. 16) b. 
   	BDOT_EQUIVALENTS		=: (0:"0) ` *. ` > ` (["0) ` < ` (]"0) ` ~: ` +. ` +: ` = ` (-.@]"0) ` >: ` (-.@["0) ` <: ` *: ` (1:"0)

	NB.  A function to produce the atomic representation of a boolean function that will produce the input boolean tables (tables are rank-2 boolean arrays, optionally boxed).
	NB.  EG:  getBooleanFunction 1 0 ,: 1 1                   NB.  Returns {. ;: '>:'
	NB.  EG:  getBooleanFunction (1 1 ,: 0 1) ,: (1 0 ,: 1 1) NB.  Returns ;: '<: >:'
	NB.  EG:  getBooleanFunction (1 1 ,: 0 1)  ; (1 0 ,: 1 1) NB.  Same as above
   	getBooleanFunction		=: BDOT_EQUIVALENTS&({~ #.@:,"2@:>)

	NB.  First word. Essentially {. ;: y.
	fw				=:  head@:;:

	NB.  Verbs to create binary arrays locating the the elements before after, or between
	NB. the first or last appearance of some element(s) in the set.
	assertBeforeFirst		=:  *./\  @: ~:
	assertAfterFirst		=:  +./\  @: =
	assertBeforeLast		=:  +./\. @: =
	assertAfterLast			=:  *./\. @: ~:
	keepFirst				=:  < /\  @: =
	keepAllButFirst			=:  < /\  @: ~:


	NB.  Adverb that produces a conjunction.   Essetially a 3-argument operator that
	NB.  produced a verb train.  Given verbs (f g h) produces (f@:[ g h@:]).
	k						=:  fork  =:  1 : '2 : (''u.@:[ '' , (parenclose 5!:5<''u.''), '' v.@:]'')'

	NB.  Pair the items of the arguments, boxing if the types are not compatible.
	NB.  I should really maintain a list of 'compatible' types and only box if
	NB.  ,&:(3!:0) -.@:e. 3 : 'COMPATIBLE_TYPES'
	stitch					=:  ,.&:>/@:(-.@:-:&:(3!:0) (<"_1 apply &.>) ,&:<)

	NB.  Adverb like /., but also gives the nub of the LHA.
	nubAndKey				=:  1 : '~.@:[ stitch u./.'


	NB.  Like E., this creates a boolean list where the elements of the right match the elements of the left
	NB.  except that E. has ones only where the match begins, whereas this function has ones for the entire
	NB.  match.
	NB.  EG:  'hello' E 'hello how are you?' NB.  Returns 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0
	NB.  Old form: E =. }:@:([: *@:+/\ #@:[ _1:`(+ bx)`(,&0@:]) } E.)
	NB.  E						=:  [: ; <@:#@:[ ((}.&.> {.) , }.@:]) #@:[ (#&1@:[ , }.)&.> <;.1~@:([ E. ,)

	NB.  Given a boolean list as input, "fills the gaps" between the 1s.  
	NB.  EG:  matchMask 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0  NB.  Returns 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0
	NB.  matchMask			=:  ({. , _2&((#&1@:>:@:#@:>@:{. <@:, }.&>@:{:)\)@:}.)&.(<;.1)&.(1&,)
	NB.  Replaced by the superior 'fillGaps'

	NB.  Given two boolean lists as input, "fills the gaps" between the 1s of the first and the second list.  
	NB.  EG:  fillGaps 2 16$0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1  NB.  Returns 0 0 0 1 1 1 1 1 0 0 0 1 1 1 1 1
	NB.  fillGaps 				=:  ~:/\@:+./ +. {:

	NB.  Removes elements contained between pairs of delimiters
	NB.
	NB.  Now use fillGaps instead of matchMask.
	NB.  removeBetween 		=:  ] #~ (-.@:matchMask@:((>@:{: {~ i.&1@:<"0 1&>/)@:(<@bx"1) 1:`[`]} {.)@:(E.&>) boxopen)
	NB.
	NB.  Removed the whole closest-matching-delimiter thing; it didn't really help with the unbalanced delimiters, 
	NB.  had undesirable results on edge conditions, and slowed down the verb.  
	NB.  removeBetween 		=:  ] #~ -.@:fillGaps@:({. ,: #&0@:{:@:$ 1:`[`] }~ (>@:{: {~ i.&1@:<"0 1&>/)@:(<@bx"1))@:(E.&> boxopen)
	NB.
	NB.  Changed algorithm to depend on parenDepth instead of fillGaps; removeBetween now handles nested delimiters.  Still doesn't
	NB.  handle unbalanced parens.
	NB.  removeBetween 		=:  ] #~ -.@:fillGaps@:(E.&> boxopen)
	NB.
	NB.  EG: ('<';'>') removeBetween 'this <is> a <test> of <the> emergency <broadcast> system'  NB.  Returns 'this  a  of  emergency  system'
	rb						=:  removeBetween		=:  ] #~ (0&~:@:(+/\@:(-/)) +: {:)@:(E.&> boxopen)

	NB.  Removes data contained between multiple sets of delimiters.
	NB.  EG:  (_2<\<">'`''<>') multiRemoveBetween '`this'' <is> `a'' <test> `of'' <the> `emergency'' <broadcast> `system'''  NB.  Returns 8#' '
	mrb						=:  multiRemoveBetween  =:  removeBetween seq

	NB.  Function to to identify and remove parts of vectors between some delimiters.
	NB.  See also 'fillGaps' which does something similar, only in a worse way.  
	NB.  I always seem to forget the idiom '~:/\' (or '~:/\.').
	NB.  In general, to find a boolean scan that has the desired output (which is how I developed rq),
	NB.  do:  
	NB.  	Q       =: '"' = 'Some things "in quotes" are "to be removed"'                                     NB.  The input
	NB.  	A       =:  0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1  NB.  The desired output
	NB.  
	NB.  	   CLOOG   =: (          <'';<@":">2 _2    ),(<     (3 : '<y. 5!:0 vtt')"0 BDOT_EQUIVALENTS     ),(<      '/' (<@:;@:,"_ 0&:;:) '\\.'      )  NB.  All useful boolean scans.
	NB.  	   FOOG    =: { CLOOG
	NB.  	   NOOG    =: FOOG , each <{.;:'Q'
	NB.  	   ROOG    =: ;:^:_1 each NOOG
	NB.  	   KLOOG   =: ". each ROOG
	NB.  	   CLOOG {&>"1~ KLOOG ($@:] #: (bx@:= ,))~ <A
	NB.  	++--+---+
	NB.  	||~:|/\.|
	NB.  	++--+---+
	NB.
	NB.  EG:  rq 'Some things "in quotes" are "to be removed"'  NB.  Returns 'Some things  are '
	rq						=:  removeQuoted  =:  '"' dl (] #~ -.@:(+. ~:/\.)@:=)

	NB.  Given a lists as input, "fills the gaps" between pairs of 1s in the input.
	NB.
	NB.x This was the old form of fillGaps, that took 2 boolean lists as input, which was used by an old version of removeBetween.
	NB.x EG:  fillGaps 2 16 $ 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1  NB.  Returns 0 0 0 1 1 1 1 1 0 0 0 1 1 1 1 1
	NB.x fillGaps 	=:  ~:/\@:+./ +. {:  
	NB.
	NB.  EG:  fillGaps 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1  NB.  Returns 0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1
	fillGaps				=:  +. ~:/\.

	NB.  Parse by quotes and spaces, and with quotes taking precedence over spaces.  I'd like to generalize this so I can
	NB.  give an arbitrary heirarchy of delimiters, and cut text by those delimiters taking precedence into account.
	NB.  This would be useful, e.g., in commandLineParser (and parseAccessLog, below).
	NB.
	NB.  The best solution would be to somehow implement a BNF parser generator using dyadic ;: in J5.
	NB.  I could use this in FQL, in TLW-, FIX-, and Factory-protocol socket parsing, in parsing TLW's transattrs.txt,
	NB.  in parsing the myriad "noun define" inline constants I have (like FieldDefs-style field definitions)
	NB.  in parsing the command line, in parsing access logs, etc etc etc.  Defining mini-languages and inlining data seems
	NB.  to me a very good way to program.  Easy to write, read, and maintain.  I could probably do a find and replace of ;. with
	NB.  the bnf adverb with the appropriate BNF noun LHA.
	NB.  
	NB.  EG:  pqs 'you smell like "cheese and bolonga", but mostly cheese'  NB.  Returns <;._1 '|you|smell|like|"cheese and bolonga",|but|mostly|cheese'
	NB.
	andNot					=.  >  	NB.  x and not y
	isUnquotedSpace			=.  (andNot	fillGaps)/
	pqs						=:  parseBySpaceAndQuote	=:  ' "' dl ([ (] <;._1~ isUnquotedSpace@:(=/)) (,~ {.)~) f.

	NB.  Function to parse a webserver access log.
	isInBrackets			=.  fillGaps@:(+./)
	palMask					=.  (' "',:'[]')&((isUnquotedSpace andNot lmr isInBrackets)/@:(=/))
	pal						=:  parseAccessLog  =:  (<;._2~ palMask)&.(,&' ')&> @: (LF&arbCut@:toJ@:fread) f.

	NB.  Adverb that will extract elements at the provided indicies, perform the provided function upon those elements,
	NB.  and then put the elements back at the indicies.
	NB.  See 'xb' for an example of use
	modifyIndicies			=:  (@{) (`[) (`]) }

	NB.  The inverse of bx
	NB.  EG:  xb 5 7 12 NB.  Returns 0 0 0 0 0 1 0 1 0 0 0 0 1
	NB.  xb					=: 1:`[`] } >:@:(>./) # 0:
	NB.  xb					=: 1: modifyIndicies >:@:(>./) # 0:
	NB.  xb					=:  $.^:_1@:(4 : '1 x.}y.' (1: $. >:@:(>./) ; 0: ; 0:))  NB.  Could use 1: modifyIndicies here
	xb						=: e.~ i.@:>:@:(>./)

	NB.  Word wrap text at column given in LHA (which defaults to 80)
	NB.  EG:  30 wordWrap 'It was the best of times, it was the worst of times. So',CRLF,'starts the Dickens novel "A Tale of Two Cities".'
	wordWrap				=:  80&$: : (;@:(,&CRLF@:}.@:;&.>)@:((] <;.1~ 1: , 2&(>/\)@:(| +/\@:(#&>))) ' '&ac@:(LF sr ' ')@:-.&CR))

	NB.  Function to format an FactoryMessage-style error message into human-readable form.
	NB.  EG:   errMsg 'Unknown user:  %1';'Bob'  NB.  Returns 'Unknown user:  Bob'
	safeCut					=.  (<;._2~ 1&(_1 }))~&:({.~ >:@:#)
	cutMsgText				=.  (safeCut~  [: +./ (> { '%';'0123456789')&(E."1))@:>@:{.
	getParamNums			=.  ((_&".@:{. ; }.)~ i.&0@:e.&'0123456789')&>
	injectParams			=.  ({:"1@:] ({.@:[ , ,@:(,. }.)~) [ {~ ;@:({."1)@:])
	formatErrMsg			=.  ;@:(injectParams getParamNums@:cutMsgText)
	errMsg					=:  formatErrMsg :: ('Invalid error message format'"_) f.

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
	breakdownLeagues		=:  ([. createLeagueTable  ].)&decomposeIntoLeagues

	NB.  Select columns named in LHA from RHA
	NB.  EG:  'b c' getColumns 'b c' getColumns 3 3$(,'a');(,'b');(,'c');0;1;2;3;4;5 NB.  Returns 2 2$1;2;4;5
	getColumns				=:  }.@:(] {"1~ ;:^:(0&=@:L.)@:[ i.~ {.@:]) 

	NB.  Wrap a line of text to the window width
	wrap					=:  ($:~ screenSize) : ((]\~ -)~) 

	NB.  Wrap in RHA in LHA.  LHA can be one or two elements long.
	NB.  EG:  '()' enclose 'parenthetical comment' NB.  Returns '(parenthetical comment)'
	NB.  EG:  '"'  enclose 'A Quote'               NB.  Returns '"A Quote"'
	enclose					=:  <"_1@:(2&$)@:[ ;@:}:@:,@:,. <@:]	

	NB.  Wrap in parenetheses.  
	NB.  EG:  parenclose 'Hi there' NB.  Returns '(Hi there)'
	parenclose				=:  '()'&enclose 

	NB.  Lists the parts of speech used in a definition, from least common to most common.
	NB.  EG:  partsOfSpeech partsOfSpeech vtt2 NB.  Returns 'adverb noun conjunction punctuation verb'
	partsOfSpeech			=:  (({: /:~ {&(;:'? punctuation noun adverb conjunction verb locale')@:{.)@:((~.@:] ,: #/.~)) 2&+@:(3 : 'nc <''ff'' [ ". :: ] ''ff=.'',y.'&>))&.;:

	NB.  Takes a rank-one numeric list as input, and outputs a rank-one literal list.  The output is the 'shorthand' for the input.  
	NB.  That is, all sequences of equal elements longer than MAXIMUM_REPETITIONS are replaced by (count # element).  The output is 
	NB.  formatted such that (-: ".@:shorthand) is a tautology.
	NB.  EG:  shorthand | 2 -/\ }. bx 0 = !^:_1 :: 0:"0 - i. 1000x  NB.  Returns '3 1 7, (6#1), 4 4 2, (49#1), 4 6 8 7 9 3 2 6 2 3 8 9 1 5 2 1 1 14 7, 821#1'
	MAXIMUM_REPETITIONS		=.  3
	elementRepetitions		=.  (# , {.) plateaus
	shortForm				=.  (<@:(','&enclose)@:('()'&enclose)@:, '#'&,)&":
	longForm				=.  ":@:#
	selectForm				=.  >&MAXIMUM_REPETITIONS@:({."1) {"_1 (longForm ; shortForm)/"1
	NB.  Make sure the output doesn't end with ', (x#y)'; use ', x#y' instead)
	fixLastForm				=.  (}: , ({. , -.&'()'@:}.)&.>@:{:) 			
	NB.  We can get duplicate commas when we get two groups in sequence, e.g. ',(3#4),, (5#6),'
	removeDuplicateCommas	=.  ','&collapseMultiples
	NB.  If the first or last elements are groups, we could get extraneous commas.
 	NB.  Could use ','&dropIfPrepended@:(','&dropIfAppended) or (#~ (+. (1: |. (> </\)))@(','&~:)) instead
	removeExtraneousCommas	=.  #~ ~:&','@:({. , {:) 0 _1} #&1@:#
	NB.  Make sure the short forms look like ', (x#y),' instead of ' ,x#y,'
	transposeCommaAndSpace	=.  {~ i.@:# + (+ -@:(_1&|.))@:(' ,'&E.)
	fixCommas				=.  removeExtraneousCommas@:removeDuplicateCommas@:transposeCommaAndSpace
	formatShorthand			=.  fixCommas@:(;:^:_1)@:fixLastForm
	shorthand				=:  formatShorthand@:selectForm@:elementRepetitions f.

	NB.  When I copy a stacktrace from Visual Studio .NET I can just call formatStackTrace
	NB.  to display it visually in J.  
	NB.  LHA noun used to be 'n',LF,'r',CR,'t',TAB,'\\'.  
	NB.  Main verb used to be under (('\\';'<SLASH>')&(replace :. ((replace~ |.)~ )))
	NB.! Note that fst is broken because replace is broken.  Try ('\\';'<DSLASH>') replace '\\'
	fst						=:  formatStackTrace	=:  (_2 (<@:;~ '\'&,)~/\ '\\','t',TAB,'r',CR,'n',LF)&multireplace@:paste bind ''

	NB.  Dyadic verb:  Takes a numerator & denominator, produces a rational of x.%y.
	NB.  EG:  22 r 7 NB.  Returns 22r7
	r						=:  (, 'r'&,)&.":

	psql					=:  parseSQLOutput  =:  verb define
		(i.0) psql y.
:

		NB.  Note I assume here that te SQL output has a single trailing space on each line.
		TABs =. ' ' = sqlOutput {~ (>:@:[ + i.@:<:@:-~)/ 2 {. bx LFs =. LF = sqlOutput =. y. -. CR

		NB.  Put any indicies for exclusion (like _2 or whatever for 'rows effected:  N') 
		NB.  in the first noun on the following line.  I have excluded the 2nd row because
		NB.  that consists entirely of '-'s.
		|: (dtb@:{. ; }.)&> (<^:4 x.,1) {&.> ('';TABs) <;._2 sqlOutput ];._2~ ] 1 (_1}) LFs
)

	NB.  Adverb to apply a list of functions (as a gerund) to the columns of the input.
NB.	across		=:	(((}.@$ $ ,)@:) (;.1) ~) (# # 1:)
	NB.  Adverb, like across, which takes a gerund as a LHA.  The derived verb takes indicies into the 
	NB.  gerund as a LHA and the data as a RHA.
NB.	acrost		=:  1 : ' m.&(4 : ''(x. {~ > {. y.) across > {: y.'')@:(,&<)'

	NB.  Given a nested box input, returns an N by 2 table of leaf ,. path-to-leaf.
	NB.  EG:  describeTree  5!:2<'describeTree'  NB.  Returns 19 2$(<,'>'),(<(,0);(,0);(,0);,0),(<,'@'),(<(,0);(,0);(,0);,1),(<'{.'),(<(,0);(,0);(,0);,2),(<,'"'),(<(,0);(,0);,1),(<1),(<(,0);(,0);,2),(<',.'),(<(,0);,1),(<'{:'),(<(,0);(,2);,0),(<,'"'),(<(,0);(,2);,1),(<1),(<(,0);(,2);,2),(<'@:'),(<,<,1),(<,'<'),(<(,2);(,0);,0),(<'L:'),(<(,2);(,0);,1),(<0),(<(,2);(,0);,2),(<',.'),(<(,2);(,1);,0),(<'&:'),(<(,2);(,1);,1),(<,'<'),(<(,2);(,1);(,2);,0),(<'S:'),(<(,2);(,1);(,2);,1),(<1),(<(,2);(,1);(,2);,2),(<'{::'),<(,2);,2
	describeTree			=:  (>@{."1 ,. {:"1)@:(<L:0 ,.&:(< S: 1) {::) 

	NB.  Sorts a list of boxed strings lexically (i.e. ignoring length and case).
	NB.  (sortStrings -: |.@:/:~)  'a';'A'  NB.  Returns 1
	sortStrings				=:  /: (*./\.@:=&' '"1 lc@:merge ,:&(0{a.))@:>

	NB.  Insert elements.  At the moment not very general, but here as ane example for generalization.
	NB.  3 2 ie '20040903'  NB.  Returns '2004-09-03'
	ie						=:  insertElements	=:  (] #!.'-'~ 1&j.@:((+/\)@:[ (e.~ _1} xb@:,) <:@:#@:]))



NB.  =====================================================================================================================================================
NB.  Date/Time Utilities:  Mostly conversions
NB.  =====================================================================================================================================================

	NB.!  Make a 'date understander' that can convert various date formats to a canonical style
	NB.!  and a 'date ourputter' (i.e. formatDateStamp) that can output various versions.
	NB.!  That way I could say 'YYYY-MM-DD' dateConvert 'YYYYMMDD' '20040903' NB.  Returns '2004-09-03'
	NB.!  Also, a generalized date added/subtracter, like datediff in VB.
	NB.!  Add calendar functionality with recurrence logic so I can mark & query weekends, holidays, etc.
	NB.!  That would make writing 
	NB.!     'YYYY-MM-DD' dateConvert^:_1 nextBusinessDay 'MM/DD/YY' dateConvert LF arbCut toJ fread 'fileOfDatesInWeirdFormat.txt'
	NB.!  so easy!

	NB.  Like isotimestamp, this verb takes input in the format of 6!:0'' and provides output as a literal in the format YYYY-MM-DD HH:NN:SS.UUU
	NB.  datetimestamp	=:  ;@:([: ({~ /:^:2@:-.@:(2&|)@:i.@:#) (;/'-- ::')&,) @: (4 2 2 2 2 6&((-@:[ <@:({.!.'0') ":@:])"0))
	datetimestamp			=:  [: ;@:|:@:,:&(;/'-- ::')  4 2 2 2 2 6j3&(<@(' ' scalarReplace '0')@":"0)

	NB.  For only the date-portion of datetimestamp
	NB.  EG:  datestamp  3 {. 6!:0 ''
	datestamp				=:  10&{.@:datetimestamp@:( 6&{.)

	NB.  For only the time-portion of datetimestamp
	NB.  EG:  timestamp _3 {. 6!:0 ''
	timestamp				=:  11&}.@:datetimestamp@:(_6&{.)

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

	NB.  Utility to visually compare vectors
	NB.
	NB.  My original version:
	NB.  
	NB.  enumerate			=.  ;@:(<@:i.@:#;.1)@:~:
	NB.  markElements		=.  (  mark =. ((, '.'&,)&:":&.>"_1 enumerate)@:/:~ ) :. unMark =. ({.~ i:&'.')&.>
	NB.  
	NB.  
	NB.  sortedNub			=.  /:~@:~.@:,
	NB.  expand				=.  (i. { ({.~ >:@:#)@:[)
	NB.  
	NB.  lineEmUp			=:  (,&< expand&> <@:sortedNub)&.(s:@:markElements) f.
	NB.
	NB.  EG:  lineEmUp&:>/ ({~ ?.~@:#)@:;:&.> 'A B B C D E F G H I I';'A B C D E H H H I I'  NB.  Returns 2 13$<;._1 ' A B B C D E F G H   I I A B  C D E   H H H I I'
	NB.
	NB.  Version due to R.E. Boss <r.e.boss@PLANET.NL> on Sun, 29 Aug 2004 17:38:15 +0200
	NB.  in a message to the J Forum with the subject matter "Re: [Jforum] Utility to visually compare vectors"
	NB.
	NB.  EG:   cv <"1(]#~#?~##~[:?.10"_);/'ABCDE'  NB.  Returns 6 19$(0$0);(0$0);(0$0);(0$0);'B';'B';(0$0);'C';'C';'C';'C';'D';(0$0);(0$0);(0$0);'E';'E';'E';(0$0);'A';(0$0);(0$0);(0$0);'B';'B';(0$0);(0$0);(0$0);(0$0);(0$0);'D';'D';'D';(0$0);'E';'E';'E';'E';'A';'A';(0$0);(0$0);'B';'B';'B';(0$0);(0$0);(0$0);(0$0);'D';'D';'D';'D';'E';(0$0);(0$0);(0$0);'A';(0$0);(0$0);(0$0);'B';'B';(0$0);'C';'C';'C';'C';'D';'D';'D';(0$0);(0$0);(0$0);(0$0);(0$0);'A';'A';'A';'A';(0$0);(0$0);(0$0);'C';(0$0);(0$0);(0$0);'D';'D';'D';(0$0);'E';'E';(0$0);(0$0);'A';'A';(0$0);(0$0);'B';(0$0);(0$0);'C';'C';'C';(0$0);(0$0);(0$0);(0$0);(0$0);'E';'E';'E';'E'
	cv						=:  verb define
		NB. displays items of y. to compare them visually
		snr=./:~ ~. ; y.

		NB. sorted nub of razed y.
		snc=.(<snr)([:+/"1=/)&>y.

		NB. sorted nub count in items of y.
		snr #~ snc j.(-"1~>./)snc
)


	NB.  Conjuction that produces a verb that permutes y. in the same way m. is permuated from n.
	NB.  EG:  cdab =: 'ABCD' permute 'CDAB' 
	NB.       3 4 1 2 -: cdab 1 2 3 4  NB.  Returns t
	permute					=:  2 : '(A. m. i. n.)&A. '
NB.  =====================================================================================================================================================
NB.  File Utilities:  Utils to manipulate files and the file system.
NB.  =====================================================================================================================================================

	NB.  Create an arbitrary-depth directory
	NB.  (1!:5 will die if you try to create a subdir in a dir that doesn't exist)
	NB.  e.g. mkdir 'c:\d\e\f\g\'
	NB.!  Does not handle '.' or '..' correctly.
	NB.!  Unpredictable about relative-directory creation.
	NB.!  Won't work on Win95 or NT4 with IE3 or earlier (or, obviously, any non-windows OS).

	NB.  Put a slash on if it's not there already
	appendSlash				=.  '\'&appendIfNotPresent @: ('/' scalarReplace '\') @: >
	NB.  Make a list of directories to be created (the }. is to make this work with the '\\' syntax of Windows network shares)
	dirs					=.  (}.~ # (~: * >:@:]) i:&(<'\\')) @: (<@;\) @: (<;.2) @: appendSlash
	NB.  DLL call to check if a path exists.  NB.!! Won't work on Win95 or NT4 with IE3 or earlier.
	NB.  I don't use 1!:0 because 1!:0 '\\host\share\' fails, even though 1!:0 '\\host\share\sub\' works
	existing				=.  >@:{.@:('shlwapi.dll PathFileExistsA i *c'&(15!:0))"0
	NB.  Find the first directory that doesn't exist, then grab it and everthing after it for creation.
	nonExistant				=.  (a:"_`(}.~ >:)@.((~: #)~) i:&1@:existing)
	NB.  Make a nested directory
	mkdir					=:  *./ @: , @: (1!:5 @: nonExistant @: dirs) f. :: 0:

   	NB.  Split a filename into directory;filename.
	NB.  EG:  splitPath 'c:\temp\test.txt' NB.  Returns 'c:\temp\';'test.txt'
	splitPath				=: (({. ,&< }.)~ # <. >:@:i:&PATHSEP_j_)

	NB.  A fuller, but less consistant definition of splitPath.
	NB.  EG:  ('foo\';'') -: sp 'foo'
	NB.  EG:  ('foo\goo\';'')-: sp 'foo\goo'
	NB.  EG:  ('';'foo.ext') -: sp 'foo.ext'
	NB.  EG:  ('goo\';'foo.ext')-: sp 'goo\foo.ext'
	sp						=:  (;&''@:(,&PATHSEP_j_^:(*@:#)))`(''&;)`splitPath@.(({. * +/)@:(('.',PATHSEP_j_)&e.))

	NB.  This will return (directory;filename) of the file which runs it.  Any input is acceptablw
	NB.  Find a name that hasn't been defined.
	getUnassignedName		=. ([ $:^:(_1: ~: nc@:<))@:(5&(] {~ (?@:# #)) bind UCALPHA)
	NB.  Define a previously undefined name, get the filename of the script that defined it, then delete it.
	scriptFile				=. (4!:55@:{. ] {:)@:(, 4!:4 { [: ,&(<'') 4!:3 bind '')&.:<@:([ ".@:,&'=:$~0')@:getUnassignedName
	NB.    Split a script's filename into directory;filename
	NB.!!  Should I use $: and f. in conjunction like this?
	NB.getPath				=:  4!:55@:< ] (({. ; }.)~ >:@: i:&'\')@:>@:(4!:4@:< { 4!:3) [ ".@:(] , '=:'''&,@:(,&'''')@:])
	NB.getPath				=:  ([: (({. ; }.)~ >:@:i:&'\') (4!:55 ] 4!:4 { 4!:3)&.<@:".@:(, '=:'''&,@:(,&'''')))
   	getPath					=: (splitPath@:scriptFile) f.

	NB.  Arbitrary comparison functions.  Use like dyadic <:, >:, <, and > respectively
	lte						=: {:@:/:@:(,&<)
	gte						=: {.@:/:@:(,&<)
	lt						=: -: < lte f.
	gt						=: -: < gte f.

	NB.  Find out in what interval a given item falls
	NB.  EG:  _1 99 7 3 4 interval i. 15  NB.  Returns 0 15 8 4 5
	NB.  EG:  ' AQFR' interval UCALPHA    NB.  Returns 0 1 17 6 18
	interval				=:  (i.&1@:(lt"_1))"_1 _

	NB.  Cover adverb to string-related win32api functions.
	NB.  Just tacks the buffer onto the end of the argument list, then picks it out of the results
	NB.  and trims it.
	NB.  EG:  'GetTempFileNameA' winapiAsString ''
	winapiAsString			=.  ({.~ i.&(0 { a.))@:>@:{:@:win32api@:,&(<255 # ' ')@:boxopen
	
	NB.  Creates a temporary file, with the prefix given as the argument.
	NB.! Note that this call actually creates the file.
	NB.  EG:  getTemporaryFile 'OMSDBUPLOAD_'  NB.  Creates a .tmp file in the user's temp direcotry whose name starts with 'OMSDBUPLOAD_'.
	NB.       getTemporaryFile ''	           NB.  No user-specified prefix
	getTemporaryFile		=:  'GetTempFileNameA' winapiAsString@:(('GetTempPathA' winapiAsString 255)&;)@:;&0  f.

	NB.  Copies a file using the win32 API.  LHA is source file, RHA is destination file. Result is boolean indicator of success
	NB.  Example:  'c:\temp\source.txt' fcopy 'c:\temp\destination.txt'  NB.  Returns 1 iff successful
	fcopy					=:  0: -.@:-: ('CopyFileA' win32apir @: (; ;&1)) :: 0:

	NB.  Moves a file using the win32 API.  LHA is source file, RHA is destination file. Result is boolean indicator of success
	NB.  Example:  'c:\temp\source.txt' fmove 'c:\temp\destination.txt'  NB.  Returns 1 iff successful
	fmove					=:  1: = 'MoveFileA' win32apir @: ;



NB.  =====================================================================================================================================================
NB.  Environment Utilities: Mostly covers for foreigns.
NB.  =====================================================================================================================================================

	saveNamespace				=: 3 : 0
	NB.  Utility to save all names to a J key file, which can later be loaded into another J session
	NB.  The RHA (y.) is the name of the file to which the namespace will be saved.
	NB.! At this time no file checks are done (i.e. file is writable, doesn't exist, etc)
		localeList			=. findNames''
		nameList			=. 0 $ a:
		currentLocale		=. coname''
		for_locale. localeList do.
		  cocurrent {. locale
		  nameList			=. nameList , < (,: 5!:1"0) > {: locale
		end.
		cocurrent currentLocale
		require'keyfiles'
		keycreate y.
		(nameList) keywrite y.;<{."1 localeList
		i. 0 0
)
	
	loadNamespace				=: 3 : 0
	NB.  Utility to load all names which were previously saved to a J key file by a call to saveNameSpace
	NB.  The RHA (y.) is the name of the file in which the namespace is saved.
	NB.! At this time no file checks are done (i.e. file exists, is non-empty, is in the right format, etc)
	NB.! It appears copaths are not restored on loadNamespace.  Perhaps I should save and restore these explicitly with 18!:2.
		require'keyfiles'
	    localeList			=. keydir y.
	    nameList			=. keyread y.;<localeList
		failedAssignments	=. 0 2 $ a:
		currentLocale		=.  coname''
		for_locale. localeList ,. nameList do.
			cocurrent {. locale
			failedAssignments  =. failedAssignments  , ({. locale) , < a: -.~ ({. 4 : ('(x.) =: y. 5!:0';'a:') :: [ "0 {:) > {: locale
		end.
		cocurrent currentLocale
		(#~ [: a:&~: {:"1) failedAssignments
)

	NB.!! I need to consolidate ALL my mapping functions, from here, the OMS, commandLineParser, ini.ijs, oleg's contrib,
	NB.!!  EVERYWHERE.  
	NB.
	NB.  Box the input iff it's not boxed and it's not null.  This way it's convenient to pass in one parameter, or
	NB.  none, just allowing all the defaults to take effect.
	normalizeInput			=.  <^:(# 2 b.&* L.)
	NB.
	NB.  Determines if the input's rank is at least 2.  That is, if it's 'less than' a table.
	isList					=.  2&>@:#@:$@:]
	NB.
	NB.  Stiches on the first N parameter names to the input list (where N = # list),  allowing the user to pass in a
	NB.  list of parameters without names so long as they're in the correct order (the correct order is as defined by
	NB.  the default parameters).
	paramListToTable		=. ([: ({."1@:[ ,. ,@:])&>/ <.&# {.&.> ,&<)^:isList
	NB.
	NB.  Appends the default param name/value pairs onto the end of the parameter table.
	appendDefaults			=. paramListToTable , [
	NB.
	NB.  For convenience, normalizeNames lowercases and removes spaces, dashes, and underscores from parameter names.
	NB.  This is so that, for example, 'someParameter', 'Some Parameter', 'some-parameter', 'SOME_PARAMETER' are
	NB.  treated equivalently.  Doing this may result in name conflicts.  Note that the names defined, in the end,
	NB.  are in the same format as specified by the default parameter table.
	NB.! Make combineMaps an adverb with this verb as the parameter (or maybe a conjunction with a handle-missing-names-verb as the other parameter)
	normalizeNames			=. tolower@:-.&' _-'&.>@:({."1)
	NB.
	NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
	NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to
	NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
	NB.  access).
	combineMaps				=:  ([ ({."1@:[ ,. i.~&normalizeNames { {:"1@:]) (appendDefaults normalizeInput)) f.

	defineAndDefaultParams	=:  2 : 0
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
	NB.  that value is null (0=#y.), in which case the default parameter table will be
	NB.  used in its entirety, with no caller-defined values.

		if. '3 :' beginsWith~ verbBody =. 5!:5<'v.' do.
		NB.  If this is an explicit monadic verb, then redefine it appropriately.

			NB.  Drop off the '3 : 0' (or '3 : ''')
	 		verbBody		=.  5 }. verbBody

			NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
			NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to
			NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
			NB.  access).
			createParameterTable	=.  m.&combineMaps f.

			NB.  We will add these lines to the top of v., thereby redefining it.

			NB.  Apply createParameterTable to y. (the input to v.)
	        newHeading		=.  'NB.  Create parameter name/value table from input and default table.', CRLF, 'params =. ', (5!:5<'createParameterTable') , ' y.'
			NB.  Define some local names from the parameter table we just created.
			newHeading 		=.  newHeading , CRLF, 'NB.  From the parameter name/value input table, define local names from column 0 to values from column 1' , CRLF , '({."1 params) =. {:"1 params'
			NB.  Erase the noun 'params', so we don't interfere with globals of that name.
			newHeading 		=.  newHeading , CRLF, 'NB.  Erase the noun ''params'', so we don''t interfere with globals of that name.' , CRLF , '4!:55 ,<''params'''

			NB.  Drop off the trailing ')' (or '''') from v., add our new heading, and output the redefined verb.
			3 : (<;._2 toJ newHeading, CRLF, CRLF, ,&CRLF^:(LF&~:@:{:) _1 }. verbBody)
		else.
		NB.  If v. isn't an explicit monadic verb, don't do anything to it.
	 		v.
		end.
)
	NB.  Make readable parameterizations.
	NB.  EG:
	NB.	useless			=:  (verb define) defineAndDefaultParams (makeParamTable noun define)
	NB.		name        =  'horst horsterson'
	NB.		cheese_pick =  'cheddar'
	NB.		age         =  22
	NB.	)
	NB.		smoutput doString '$name$ is $": age$ years old, and prefers $cheese_pick$'
	NB.	)
NB.	makeParamTable          =:  ((deb@:{. ,&:< ".@:}.@}.)~ i.&'=')&>@:(LF&arbCut)@:(TAB scalarReplace ' ')@:}:

	iedit					=:  adverb define
	NB.  Adverb that will append the full definition of a multiline explicit verb to the IJX window.
	NB.  EG:  function iedit NB. Appends full definition of verb 'function'.
		name	=. 5!:5<'u.'
		val		=. u. f. vtt_base_
		wd 'smselout'
		wd @:('smappend *'&,)@:,&LF each PORK_z_ =: LF arbCut_base_ toJ name , '=: ', val
		i. 0 0
)

	findNames				=: verb define
	NB.  Monadic case of findNames:  Same as dyadic with an empty LHA.
	NB.  Example (monadic):  findNames '^r'
	NB.  Example (dyadic) :  (0 3;'base z') findNames '^r'
		'' findNames y.
:
	NB.  Utility to find named entities:
	NB.  findNames allows searching for names of any type (noun, verb, etc.), or all types, in any or all locales.
	NB.  Name searches are case-insensitive, and some basic search patterns are allowed.  Specifically, the first
	NB.  character of the search string specifies the type of matching to do.
	NB.
	NB.  Input:  		x. can be either empty, numeric or boxed, and it specifies the types and locales of named
	NB.                 entities to find.
	NB.
	NB.					If 0 -: # x. then all names in all locales will be searched.
	NB.
	NB.                 If x. is numeric, all locales are searched, and only those names whose type is
	NB.                 an element of x. will be searched (as for names_z_ or nl_z_).
	NB.
	NB.					If x. is boxed, then only the first two boxes matter.
	NB.						0 { 2 {. x. is a numeric type list as described above.
	NB.						    If 0 -: # 0 {:: 2 {. x. then all types will be searched.
	NB.						1 { 2 {. x. is literal or boxed, and specifies what locales to search.
	NB.						    If 0 -: # 1 {:: 2 {. x. then all locales will be searched.
	NB.
	NB.					y. is literal, and provides the search pattern.
	NB.						}. y. is the search string
	NB.						{. y. is the type of search to perform.  The possible values of {. y. are as follows
	NB.						(if {. y. is not one of the following, a default of '|' is assumed, and all of y.
	NB.						is used as the search string):
	NB.							'=' means 'exactly match the name'.
	NB.							'|' means 'match anywhere in the name'.
	NB.							'^' means 'match at the beginning of the name'.
	NB.							'$' means 'match at the end of the name'.
	NB.							'~' means 'match regular expression'.
	NB.					Note that if '!' -: {. y., then the  search is negated (i.e. the names that do NOT match the
 	NB.					pattern are returned), and }. y. is considered the search pattern.
	NB.
	NB.  Output: A 2 by N matrix of boxes, with N = to the number of locales searched (which will always be >: 1).
	NB.  The first box in each row contains the literal name of a locale searched, and the second box of each
	NB.  contains a list of boxes (possibly with # = 0) each containing a name in that locale matching the search
	NB.  pattern.

		NB.  This complicated line is just to make sure that we default correctly.  That is, x. must always be a list of 2 boxes,
		NB.  the second containing conl$0 if no locale names were provided.
		locales				=.  1 {:: x. =. ({. , ((conl$0)"_^:(0: -: #))@:(;:^:(-.@:*@:L.))&.>@:{:)@:(2&{.)@:boxopen x.

		NB.  This creates a verb which will negate our search function if and only if the first character of
		NB.  the search string is '!'.  It also updates the search string by removing the '!' if it's present.
		negate				=.  -.^: ( 1 {:: 'y. z' =. ((}.~ ; ]) '!'&-:@:(0&{)@:(1&{.)) y. )

		NB.  If no proper search type is specified, the default, '|' or 'match anywhere in the name',
		NB.  is used.
		y.					=.  (,~ {.&'|'@:-.@:(e.&'=|^$~')@:{.~&1) trim y.

		NB.  These are our search verbs - they correspond to the search type in the following line.
		verbs				=.  -:`(+./@:E.)`(beginsWith~)`(endsWith~)`rxin

		NB.  This will select the correct search verb from the list.  5!:0 turns the result of the
		NB.  pick from the gerund into a verb.
		NB.! Maybe I could use @. here.  EG verbs@.] '=|^$' i. searchType =. 0 { 1 {. y.
		searchVerb			=.  (verbs {~ '=|^$' i. searchType =. 0 { 1 {. y.) 5!:0

		NB.  Require regexes for the '~' operator, i.e., only load 'regex' if I'm actually going to use it.
		require^:(searchType -: '~') 'regex'

		NB.  Default the name list to an empty list of boxes.
		nameList			=. 0 2 {. a:

		for_locale. locales do.
	 		nameList		=. nameList , locale , < y. (] #~ (negate@:searchVerb&lc~ }.)~ &>&boxopen) nl__locale 0 {:: x.
		end.
)

	NB.  Print the prompt (given in the RHA) in the session manager and read a single line of input from the user
	NB.  If the user erases (backspaces over) part or all of the prompt, the output of the function is unchanged..
	NB.  This holds true even if extra spaves have been added to the prefix by the session manager's line recall
	NB.  function.
	NB.  sminput					=:  smprompt	=:  (dropIfPrepended (1!:1 bind 1) @: wd @: ('smprompt *'&,))
	sminput					=:  smprompt	=:  (dropPrefix&trim (1!:1 bind 1) @: wd @: ('smprompt *'&,))

	NB.  Conjunction that helps set up a console-like interaction with the user via the session manager.
	NB.  RHA is the text with which to prompt the user. LHA is the monadic verb to perform on each line
	NB.  of the user's input, the output of which will be printed. Interaction is ended when the first
    NB.  character of the user's input is ')'
	NB.
	NB.  TODO:  0.  Allow function to update prompt (i.e. pass back prompt;output)
	NB.         1.  Pass into function whether this is a session-ender (i.e. pass in session-ends;input)
	NB.
	NB.         2.  Maybe allow user to access J directly with data follwoing the )
	NB.             EG:  If user types just ')' then session ends, but if he types ')i.2' then '0 1' gets passed
	NB.             to the function.
	NB.  EG:  ;: smconsole '>  ' '' NB.  Will show the J tokenization of each line of input (prompt is '>  ')
	smconsole				=:  2 : '($:@:[ smoutput@:(u. :: lastErr))`empty@.(-:&'')''@:head@:trim)@:sminput bind n.'
	smc						=:  smconsole '      '

	NB.  Assign the (character vector) argument to a name, then pass that name as an argument to the function.
	NB.  Good for dereferencing data, encapsulation, higher-order operators, etc.
	passArgAsName			=:  1 : ' ''name''&(u.@:[ [ ".@:(, '' =. ''&,)) '

	NB.  Just like smconsole but allows the LHA to detect the end of input (i.e. the ')') and handle it.
	smconsoleDetectEOI		=:  2 : '($:@:[ smoutput@:(u. :: lastErr))@:sminput bind n.`empty@.(-:&'')''@:head@:trim)'

	NB.  A simple dos shell.  Depends on Oleg's 'shell' verb (in .\oleg\task.ijs).
	NB.  Keep in mind:
	NB.  	0)  Each line is executed _independently_, so 
	NB.  	    	cd c:\ 
	NB.  	    	dir *.*
	NB.  	    won't do what you expect).
	NB.
	NB.  	1)  There is no way to interact with STDIN, that is, commands that would be interactive in 
	NB.  	    a real shell will not be interactive in J.	
	NB.
	NB.  	2)  Results don't stream; the command must complete before any results will be displayed.
	NB.
	NB.  	3)  Results will be truncated to the length and width defined by }. 9!:36 ''
	NB.
	NB.  	4)  The ('>  ',~1!:40'') prompt is just sugar; it doesn't change depending on the working directory of 
	NB.  	    the shell.
	dos						=:  shell smconsole ('>  ',~1!:40'')


	NB.  ls is just like list only it wraps to the maximum line length instead of the window size, avoiding the ...ed list problem.
	ls						=: list~ screenSize

	NB.  Like findNames, but with pretty printing output (like names_z_)
	ln						=: listNames =: ([: ls@:, (1&{:: , each '_'&envelope&.>@:{.)"1) @: findNames

	NB.  Mesaure time of execution of a sentence
	time 					=:  6!:2
	NB.  Measure memory usage of execution of a sentence
	space					=:  7!:2
	NB.  Give time & spece measurements for execution of a sentence.
	ts						=:  time , space@:]

	NB.  Time a sentence; will prompt for sentence, and time its execution.
	NB.  Saves the effort of putting an entire sentence in quotes, double quoting literals, etc.
	NB.  RHA is same as LHA to 'time'.
	tsn						=: timeSentence  =:  1:^:(e.&1 4@:(3!:0) *: *@:#) time smprompt bind '' 

	NB.  SMConsole session, output is time,space of input sentence.  LHA is LHA to 6!:2, RHA is prompt.
	NB.  Default LHA is 1, default RHA is 6 # ' '.
	tm						=:  timeinate	=:  1&$: : (4 : '(1:^:(e.&1 4@:(3!:0) *: *@:#) x.)&ts smconsole ((*@:# {:: (6#'' '')&;) y.)$~0')

	NB.  Close J.  No 'Are you sure?' dialog.
	exit					=:  2!:55 bind ''

	NB.  Toggle Linedraw: Switch between ASCII-char box drawing and DOS lines box drawing.
	toggleLD				=:  (empty 9!:7@:>@:('+'&e.@:(9!:6) { (('|-',~9#'+');(218 194 191 195 197 180 192 193 217 179 196{a.))"_))

	NB.  Set the print precision
	pp						=:  [: (i. 0 0)"_ (9!:11)

	NB.  Paste clipboard contents
	paste					=:  wdclipread :. wdclipwrite

	NB.  Copy RHA to clipboard
	clip					=:  paste^:_1

	NB.  Bident/Trident train table from appendix F. of the J dictionary
	FTRAINS					=:  _4 }:\ <@:	trim;._2  'N0 V1 N2   |noun    |x V1 y||V0 V1 V2|verb|(x V0 y) V1 (x V2 y)||V0 V1 C2|conj|V0 V1 (x C2 y)||A0 V1 V2|adv|(x A0) V1 V2||C0 V1 V2|conj|(x C0 y) V1 V2||C0 V1 C2|conj|(x C0 y) V1 (x C2 y)||A0 A1 V2|conj|(x A0) (y A1) V2||A0 A1 A2|adv|((x A0) A1) A2||C0 A1 A2|conj|((x C0 y) A1) A2||N0 C1 N2|verb|x (N0 C1 N2) y||N0 C1 V2|verb|x (N0 C1 V2) y||N0 C1 A2|adv|N0 C1 (x A2)||N0 C1 C2|conj|N0 C1 (x C2 y)||V0 C1 N2|verb|x (V0 C1 N2) y||V0 C1 V2|verb|x (V0 C1 V2) y||V0 C1 A2|adv|V0 C1 (x A2)||V0 C1 C2|conj|V0 C1 (x C2 y)||A0 C1 N2|adv|(x A0) C1 N2||A0 C1 V2|adv|(x A0) C1 V2||A0 C1 A2|conj|(x A0) C1 (y A2)||A0 C1 C2|conj|(x A0) C1 (x C2 y)||C0 C1 N2|conj|(x C0 y) C1 N2||C0 C1 V2|conj|(x C0 y) C1 V2||C0 C1 A2|conj|(x C0 y) C1 (y A2)||C0 C1 C2|conj|(x C0 y) C1 (x C2 y)||N0 A1|verb|x (N0 A1) y||N0 C1|adv|N0 C1 x||V0 N1|noun|V0 y||V0 V1|verb|x (or y) V0 V1 y||V0 A1|verb|x (V0 A1) y||V0 C1|adv|V0 C1 x||A0 V1|adv|(x A0) V1||A0 A1|adv|(x A0) A1||A0 C1|adv|(x A0) C1 x||C0 N1|adv|x C0 N1||C0 V1|adv|x C0 V1||C0 A1|conj|(x C0 y) A1||'

	NB.  Dyadic verb to look up a particular train; takes the lookup type (either 'definition' or 'produces') as a LHA and a lookup specification as a RHA
	NB.  Verb is case-insensitive, only cares about the first letter of the LHA ('d' vs 'p'), and only compares the first letter of each of the types in the RHA
	NB.  and the FTRAINS table.  So, for example, for searching purposes, 'c' is equivalent to both 'conj' and 'conjunction' (and, incidentally, 'coun', 'cerb', 'cadverb', 'camera' ...).
	NB.  The default LHA (used when called monadically) is 'd'.
	NB.  E.G. 'def'  ftrain 'A C A' 		NB.  Returns ,:  <;._1 '|A0 C1 A2|conj|(x A0) C1 (y A2)'
	NB.  E.G. 'prod' ftrain 'verb'			NB.  Returns 8 3$<;._1 '|V0 V1 V2|verb|(x V0 y) V1 (x V2 y)|N0 C1 N2|verb|x (N0 C1 N2) y|N0 C1 V2|verb|x (N0 C1 V2) y|V0 C1 N2|verb|x (V0 C1 N2) y|V0 C1 V2|verb|x (V0 C1 V2) y|N0 A1|verb|x (N0 A1) y|V0 V1|verb|x (or y) V0 V1 y|V0 A1|verb|x (V0 A1) y'
	ftrain					=:  'd'&$: : (  FTRAINS&([ #~ ([ {"1~ 0&{::@:]) =&:((uc@:{.;._2@:appendIfNotPresent~&' ') each ) 1&{@:])@:((;~ 'DP'&i.@:{.)~&:uc&(' '&collapseMultiples)&,)  )

	NB.  Noun types, in order, by powers of two, from appendix A., conversion section of the dictionary.
	NOUNTYPES				=:  <;._2 'boolean|literal|integer|floating point|complex|boxed|extended integer|rational|||sparse boolean|sparse literal|sparse integer|sparse floating point|sparse complex|sparse boxed|symbol|unicode|'

	NB.  Name types (or name classes), from the 4!:x section of the documentations of foreigns in the dictionary.
	NAMETYPES				=:  <;._2 'invalid unused noun adverb conjunction verb locale '

	NB.  Gives the name class of the RHA, in human-reable form.
	nmt						=:  nametype	=:  {::&NAMETYPES@:+&2@:nc@:boxopen

	NB.  Gives the noun type of the RHA
	nt						=:  nountype	=:  {::&NOUNTYPES@:(2: ^. 3!:0)

	NB.  Gives the full type of the name specified in the RHA (fulltype is nametype, plus nountype if noun)
	NB.  E.G. <'verb' or <'conjunction' or <'noun:  boolean'
	ft						=:  fulltype	=:  ]`((, ': '&,@:nountype@:".@:;)~)@.(-:&'noun'@:]) nametype

	NB.  Turn a noun into text.  EG: nounToText <'NUMBERS';1 2 3 NB.  Returns '(<''NUMBERS'';1 2 3)'
	ntt						=:  nounToText	=:  verb   def '5!:5 < ''y.'' '

	NB.  Turn a verb into text.  EG: (+/ % #) verbToText NB.  Returns '(+/ % #)'
	vtt						=:  verbToText	=:  adverb def '5!:5 < ''u.'' '
	NB.  Like verbToText, but applies f. first.
	vtt2					=:  verbToText2	=:  f. vtt 

	NB.  Turn a call into text.  EG:  1 2 3 4 ({.~ +/)~ callToText 'HELLO'  NB. Returns '(1 2 3 4)(({.~ +/)~)(''HELLO'')'
	ctt						=:  callToText	=:  adverb def '(, ,~&(parenclose u. verbToText))&>/@:{.~&_2@:,~&a:@:,&:(<@:parenclose@:nounToText)'
	NB.  Like callToText, but without the enclosing parens.  Prettier at the expense of fidelity.
	ctt2					=:  callToText2	=:  adverb def '(, ,~&(           u. verbToText))&>/@:{.~&_2@:,~&a:@:,&:(<@:            nounToText)'


	NB.  Unfold is like another 5!: representation.  It splits definitions out onto lines by their depths.
	NB.
	NB.  EG: unfold'unfold'
	NB.  0 ,.&:>/@:(      )@:|:@:(                                             )@:(                                                                                                                                         )@:;:@:(    )@:(          )
	NB.  1          <@:>"1        ,.~<@,&' '"1@:(                             )    (          )@:(                                 )@:(           )@:(                                                                     )        5!:5    <^:(     )
	NB.  2                                       (                        )@:#      <:@:#}."1>    }:#^:_1&.>~i.@:<:@:#<"1@(  )>@:{:    </.~&:>/,{:    (                                   )(             )@:(             )                     L.=0:
	NB.  3                                        i.":"0~j.&0@:>.@:(     )                                                 =/                          ,&<,&.>~(           )@:i.@:(   )@:]  {.-~+/\@:(  )    (      )&(  )
	NB.  4                                                          10&^.                                                                                       ,&<~#&a:@:#        >./                -/      ;:'()'   =/	
	NB.
	NB.! There is a small error in formatting - primtives are smushed together, which is inaccurate in cases involving . and : 
	NB.! I tried replacing <@:>"1@:|: with ;:^:_1 to solve the problem, but that screwed up the code alignment.
	NB.! This isn't a big problem - it just means this representation isn't 1-to-1 and doesn't have an inverse.
	NB.! I could fix this by replacing (;:'. :') with (<;.1 ' . :') in the boxed matrix.  Or maybe I should just add a leading
	NB.! space to every column.  That would make the output more readable.
	NB.!
	NB.!  I could generalize this a bit.  Since 'depth' can be replaced by any verb that determines how 'deep' each word is,
	NB.!  I could also abstract the 'word formation' function and its inverse, such that the input can be parsed,
	NB.!  heirarchical-ized, and regrouped according to user functions, of which 'unfold' would only be on implementation.
	NB.!  (using parendepth and ;:).
	depth					=.  (;:'()')&parenDepth
	groupByDepth			=.  (<:@:# }."1 >)  @:  (}: #^:_1&.>~ i.@:<:@:# <"1@:(=/) >@:{:) @: (</.~&:>/  , {:)  @:  ((,&< ,&.>~ (,&<~ #&a:@:#)@:i.@:(>./)@:]) depth)
	NB.
	formattedCount			=.  (i. ":"0~ j.&0@:>:@:#@:":)@:#                         NB.  (i. ":"0~ j.&0@:>.@:(10&^.))@:#  NB.  #@:": is a more correct question than 10&^. 
	reformat				=.  ,.&:>/@:(<@:>"1)@:|:@:(,.~ <@,&' '"1@:formattedCount) NB.  This really should be based on ;:^:_1 somehow.
	NB.
	parse					=.  ;:@:(5!:5)@:({.@:;:^:(L.=0:)) :. reformat  NB.  ;:@:(5!:5)@:boxopen :. reformat
	NB.
	unfold					=:  groupByDepth&.parse f.  NB.  Do I want to say reformat@groupByDepth@parse?

	NB.  Boxed list of the filenames of all open scripts
	scriptsOpen				=:  (#~ -.@:endsWith&'.ijx'&>)@:(<;._2@:wd bind 'qsmall')

	NB.  Pretty-print formatted list of open scrips
	listScripts				=:  ls@:scriptsOpen

	NB.  Minimize all open windows
	minimizeAll				=:  wd @: ('smsel '&,)@:,&'; smshow sw_minimize' each @: scriptsOpen 

	NB.  The minimum of the window width and the maximum line length
	screenSize				=:  {.@:wcsize bind '' <. 1: { 9!:36 bind ''

	NB.  Get last error message
	NB.  EG:  3 : ('try. 3 + y. catch. lastErr$0 end.') '3' NB.  Returns '³domain error' , LF , '³   3    +y.'
	lastErr			=:  (}: @: (13!:12) @: empty)

	NB.  Debug - Show name
	NB.  EG: dbsn 'Insert y.'
	dbsn			=:  0 7&{"1@:dbstk bind '' multiMap_base_ ;:^:(0: -: L.)

	NB.  Head-tail splitter.  Adverb that produces a conjunction.
	NB.  Argument to adverb is stitching function (to put the head & tail back together)
	NB.  Arguments to derived conjunction are the functions to perform on the head & tail.
	NB.  The conjunction partition defaults the stitching function to box-and-catenate.
	NB.  The verb split defaults the processing functions to lev and dex.
	NB.  Note that the derived verbs are dyadic, whose monadic case are defaulted to splitting
	NB.  the data in half (if (1: -: 2: | #) then head gets the smaller list).
    ht						=:  1 : '2 : (''($:~ <.@:-:@:#) : (u.@:{. ('' , u. vtt2_base_  , '') v.@:}.)'')'
    partition				=:  ,&:< ht f.
	split					=:  [ partition ] f.



NB.  =====================================================================================================================================================
NB.  Notes section: Not useful in everyday life, but good examples of how to do things, so that I don't have to constantly reinvent the wheel.
NB.  =====================================================================================================================================================

	NB.  Any error in the FQL results in empty output (i.e. the correct rank and shape, but with no items)
	handleFQLError				=.  (0 3 $ a:)"_

	NB.  The frets is FQL are the first spaces before one of the comparison characters
	NB.  That is, find the comparison chars, then search backwards for the first space
	identifyFrets				=.  1&(0})@:;@:(e.&'=<>:|' <@:(</\&.|.);.2 ' '&=)
	locateFrets					=.  (# {. identifyFrets)

	NB. For each filter in the query, find the comparitor, and check whether the comparison is negated
	findComparitor				=.  i.&1@:e.&'=<>:|'    NB.  Monadic: Input is filter string
	locationAndNegation			=.  ] , ('~'&=@:{~ <:)  NB.  Input is filter string on left and result of 'findComparitor' on right

	NB.  Each of thess functions has the filter string as a LHA and the comparitor index and negation flag as a RHA.
	extractData					=.  }.~ >:@:{.
	extractComparitor			=.  ];.0~ (- ,: >:@:])/
	extractFieldName			=.  {.~ -/
	getFilterClauses			=.  extractFieldName ; extractComparitor ; extractData

	NB.  Cut a filter into its three component clauses:  Field name, comaparitor, and comparison data
	cutFilter					=.  ([ getFilterClauses locationAndNegation) findComparitor

	NB.  Function to parse OMS-style FQL strings.  Output is a N by 3 table of boxes, the columns of which are FIELD, COMPARITOR, DATA
	NB.  EG:  parseFQL 'TICKER=IBM DELL MSFT SHARES~<400 ACCOUNT:STATARB'  NB.  Returns 3 3$<;._1 '|TICKER|=|IBM DELL MSFT|SHARES|~<|400|ACCOUNT|:|STATARB'
	NB.  EG:  parseFQL ''                                                  NB.  Returns 0 3$a:
	parseFQL					=:  (cutFilter@:}.;.1~ locateFrets)@:(' '&,) :: handleFQLError f.


	NB.  Not real 'run length encoding' but I don't know what else to call it.  This function partitions a string that 
	NB.  is self-specifying.  That is, the string must specify the length of each sub-string.  Makes use of limit: ^:_
	NB.  Could have used recusrion, but that has a max. depth (substring count) of 511.
	NB.  EG:  runLengthEncoding '5 abcde3 abc12 abcdefghijkl5 abcde8 abcdefgh16 abcdefghijklmnop3 abc4 abcd'  NB.  Returns <;._1 ' abcde abc abcdefghijkl abcde abcdefgh abcdefghijklmnop abc abcd'
	runLengthEncoding			=:  [: > ([ ({:@:] ,~^:(*@:#@:>@:[) <@:(, {.))  ((_&".@:{. ({. ; }.) }.)~ >:@:i.&' ')@:])&>/^:_@:((0 $ a:)&;)

	NB.  A cool way to reimplement nub (monadic ~.)
	nub0							=:  #~ i.@:# = i.~
	nub1							=:  {.;.1~ ~:

	NB.  A cool way to reimplement key (dyadic /.)
	key							=:  (@(#~)) =

	NB.  Formula for generating "do-able" numbers of single-quote characters,
	NB.  That is, generates a number of ''''s which, when applied to "., generate
	NB.  another, smaller number of ''''s that can also be passed to ".
	NB.  (<\ -: ([: }. ".&.>)&.>^:(i. -N)@:<) QUOTE #&.>~ 2 -~ 2 ^ >: i. N =. 5

	NB.  Roger Hui's fibonacci calculator.  Uses the dyadic form of n&v in
	NB.  place of ^: .  The verb fibonacciN calculates the Nth Fibonacci Number.
	NB.  The verb fibonacciSequence calculates first N fibonacci numbers.
	fibonacciN					=: [: {:"1 (0 1,:1 1)&(+/ .*)&0 1
	fibonacciSequence			=: fibonacciN@i.

NB.  Progressive index; stolen & translated from the Finnish APL Idiom list (# 1)
NB.  See http://www.pyr.fi/apl/texts/Idiot.htm (URI available as of 2004-May-28)
NB.	progIDX						=:  ($@:[ $ [: /:@:/: [ i. ,) i. ($@:] $ [: /:@:/: [ i. ,~)

	NB.  Just a cool arithmetic identity:
	NB.  Just the output:   (+ 8: * 10&#.\) >: i. 9 
	NB.  Input and output:  ((] ,: (+ 8&*)) 10&#.\) >: i. 9
	NB.  In normal notation:
	NB.  1 x 8 + 1 = 9
	NB.  12 x 8 + 2 = 98
	NB.  123 x 8 + 3 = 987
	NB.  ... 
	NB.  123456789 x 8 + 9 = 987654321

	NB.  An adverb that satisfies Paul Graham's 'accumulator generator' challenge. 
	NB.  See:  http://www.paulgraham.com/accgen.html  and http://www.paulgraham.com/accgensub.html (URLs available as of 2004-Mar-31)
	NB.
	NB.  The only problem might be that Graham says the function shouldn't 
	NB.  "store the accumulated value or the returned functions in a way that could cause them to be inadvertantly modified by other code.", 
	NB.  but since J doesn't have persistable local variables, acc must use globals (there's no other choice).
	NB.
	NB.  Also, I haven't put in an assert. (or other) statement that prevents people from passing in anything other than scalar numbers to either
	NB.  acc or its derived verbs.
	NB.  
	NB.  EG: foo =. 0 acc  NB. 'foo' is a new acumulating verb
	NB.      foo 3 NB.  Returns 3
	NB.      foo 3 NB.  Returns 6
	NB.      foo 0 NB.  Returns 6
	NB.      foo 5 NB.  Returns 11
	NB.  acc	=:  1 :('n=.":<:#N_z_=:(3 :''N_z_''::((i.0)"_)''''),m.';'3 :(n,''{N_z_=:'',''(y.+'',n,''{N_z_)'',n,''}N_z_'')')
	NB.  acc	=:  1 :('((n)=:m.[n=.''xxx'',''_z_'',~":N_z_=:>:3 :''{N_z_''::_1:'''')';'3 :(n,''=:'',n,''+y.'')')

	NB.  A re-implementation of expand (#:^:_1)
	NB.  Note that, unlike #^:_1, +/@:[ can be less than #@:]
	NB.  The price of that is that no error is raised if (+/@:[ > #@:]);
	NB.  the extra values will just be fill elements.
	NB.  EG:  0 0 1 0 1 1 0 1 0 0 0 1 0 0 0 0 1 expand 100 * >: i. 50  NB.  Returns 0 0 100 0 200 300 0 400 0 0 0 500 0 0 0 0 600
	NB.  expand						=:  ({.~ >:@:#)@:] {~ <:@:([ merge >:@:#@:]  ,: ((* +/\))@:[)
	
	NB.  Adverb to insert elements at specified locations.
	NB.  Locations is specified as an indices.  Positive indicies insert elements AFTER those indicies,
	NB.  negative indicies insert elements BEFORE those indicies (i.e. neg. indices do NOT index backwards
	NB.  from the end of the vector).
	NB.  Inserted element is given as an argument to the adverb.  If it has no length, the normal fill element 
	NB.  will be used.
	NB.  EG:   2 3  '/' insurt  'hello'  NB.  Returns 'hel/l/o'
	NB.	 EG:  _2 3  '/' insurt  'hello'  NB.  Returns 'he/ll/o'
	NB.  EG:   2 3   '' insurt  'hello'  NB.  Returns 'hel l o'
   
	NB.  Named insurt because insert is too common.
	insurt                      =:  1 : ' if. -. * # m. do. ex =. #  else. ex =. #!.m. end.  (] ex f.~ 1: j. i.@:#@:] e. (| - <&0)@:[ )'
NB.  =====================================================================================================================================================
NB.  Execution section: Run at startup
NB.  =====================================================================================================================================================

	NB.  The following line saves the path and filename of this script into the variable utilsfile_z_
	utilsfile_z_				=:  ; 'MY_PATH MY_FILE' =. getPath ''
	utilsdir_z_					=:  MY_PATH

	NB.  Define function for F2 key.
	F2							=:  load bind (MY_PATH , 'favorites.ijs')

	NB.  Require this so we can use comman line options in all our programs.
	load MY_PATH, 'commandLineParser.ijs'

	NB.  Require this so that we can save/load workspaces
	load MY_PATH , 'jworkspace.ijs'
	
	NB.  Load all of Oleg Kobchenko's utils (they're very useful).
	load listFiles MY_PATH,'contrib\oleg\*.ijs'

	NB.  Load all of Paul Chapmans's contribution (ats)
	NB.  and fix his definitions to work with J4.
	load listFiles MY_PATH,'contrib\paul_chapman\*.ijs'
	load MY_PATH,'contrib\paul_chapman\ats.ijs'
   	replaceWords				=.  2 : '(y.,~;:n.) {~ y. i.~ (y.,~;:m.)'
   	(toFix)						=:  2 : (('H=.{.@:(1&{.) :{.';'T=.{:@:(_1&{.) :{:') , <@:(('{. {:' replaceWords 'H T')&.;:)"1 ('';;/3#1) {:: 5!:1 toFix=.<'conjs')


	NB.  Put us back in the base locale, but adjust the classpath to include my utils
NB.	'dan' (, copath)&:({.@:;:^:(0: = L.))  'base' 

	NB.  Turn on debugging if requested
	3 : 0 ^: # $ getOption 'djbdebug'
		load 'debug'
		dbr 1
		if. stops =. getParam 'djbdbss' do.
			dbss stops , ; (< ' *:*') #~ -. ':' e. stops
		end.
)

	NB.  Print out J version and timestamp
	smoutput 'New J (' , (({.~ i.&'/') 9!:14 '') ,  ') session started on ' , ((i.&' ') ({. , ' at '"_ , }.@:}.) ]) _4 }. datetimestamp 6!:0 ''

	NB.  If workspace provided on command line, load it.
	NB.  Make sure we don't reload the workspace if this script is reloaded
   