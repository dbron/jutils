NB.  =====================================================================================================================================================
NB.  Bootstrap:  Where am I?
NB.  =====================================================================================================================================================

   	NB.  Split a filename into directory;filename.
	NB.  EG:  splitPath 'c:\temp\test.txt' NB.  Returns 'c:\temp\';'test.txt'
	splitPath				=: (({. ,&< }.)~ # <. >:@:i:&PATHSEP_j_)

	NB.  This will return (directory;filename) of the file which runs it.  Any input is acceptablw
	NB.  Find a name that hasn't been defined.
	getUnassignedName		=. ([ $:^:(_1: ~: nc@:<))@:(5&(] {~ (?@:# #)) bind UCALPHA)
	NB.  Define a previously undefined name, get the filename of the script that defined it, then delete it.
	scriptFile				=. (4!:55@:{. ] {:)@:(, 4!:4 { [: ,&(<'') 4!:3 bind '')&.:<@:([ ".@:,&'=:$~0')@:getUnassignedName
	scriptFile              =. 3 : '(4!:3$~0){::~4!:4{.;:''y'''  NB.  Stolen from Roger
	NB.    Split a script's filename into directory;filename
	NB.!!  Should I use $: and f. in conjunction like this?
	NB.getPath				=:  4!:55@:< ] (({. ; }.)~ >:@: i:&'\')@:>@:(4!:4@:< { 4!:3) [ ".@:(] , '=:'''&,@:(,&'''')@:])
	NB.getPath				=:  ([: (({. ; }.)~ >:@:i:&'\') (4!:55 ] 4!:4 { 4!:3)&.<@:".@:(, '=:'''&,@:(,&'''')))
	getPath					=: (splitPath@:scriptFile) f.


	NB.  The following line saves the path and filename of this script into the variable utilsfile_z_
	utilsfile_z_			=:  ; utilspath =. getPath ''
	utilspath  				=. ({: ,~ ] {.~ PATHSEP_j_ i:~ }:) > {.utilspath

	NB.  Should probably only modify USERFOLDERS_j_, and make references to, eg, ~User
	NB.  instead of ~user.  But why is ~user in SYSTEMFOLDERS in the first place?
	SYSTEMFOLDERS_j_		=: (<utilspath) (<1 ;~ (<'user') i.~ {."1 SYSTEMFOLDERS_j_)} SYSTEMFOLDERS_j_

	
NB.  =====================================================================================================================================================
NB.  Dependencies:  J scripts we need loaded to define the rest of our utilities
NB.  =====================================================================================================================================================

require 'regex'
buildpublic_j_ noun define
yaml         ~user\general\parse\yaml
jf_fmt       ~user\general\format\jf_fmt
qdoj         ~user\uncategorized\qdoj.ijs
hui          ~user\contrib\hui\hui
cmprj        ~user\environment\compare_j_verbs.ijs
loadp        ~user\environment\loadp.ijs
base64       ~system\packages\misc\base64.ijs
PRIM         ~user\environment\primitive_classes.ijs
tara         ~addons\tara\tara.ijs
doog         ~user\general\doog.ijs
)

NB. require'yaml'
NB. require 'loadp'  NB.  Loads a script and prints the names it defined.

NB.  =====================================================================================================================================================
NB.  General Utilities:  Useful items or good examples of how to accomplish tasks.
NB.  =====================================================================================================================================================

	NB.  Noun local to this script so that utilities
	NB.  may adjust their definitions for J5.
	preJ6 =. 6 > 0 ". {. 'j' -.~ 9!:14''

	NB.  These are the elements I'm usually interested in from a.
	QUOTE					=:  ''''	
	UCALPHA					=:  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	LCALPHA					=:  'abcdefghijklmnopqrstuvwxyz'
	ALPHA					=:  LCALPHA,UCALPHA
	DIGITS					=:  '0123456789'
	ALPHANUM				=:	ALPHA,DIGITS
	WHITESPACE				=:  ' ', TAB, CR, LF
	PRINTABLE				=:  WHITESPACE , a. {~ 33 ([ + i.@:>:@:-~) 126

	NB.  I keep having to calculate this, so I'm just going to store it.
	MAXINT					=:  ((<.@<:@(2&^))^:2) 5   NB.  Same as (<. <: 2 ^ <. <: 2 ^ 5) or (<. <: 2 ^ 31)

	NB.  List of words, for research purposes.
	loadWORDS				=:  [: -.&(s:a:)@:	/:~@:~.@:; s:@:(LF&,)@:toupper@:toJ@:fread each bind ('c:\danielb\data\documents\word.lst';'c:\danielb\data\documents\web2.txt')

	NB.  Jose Quintana's adverb for sequential application of dyadic verbs
	NB.  x f seq y is essentially equivalent to ... (2 {:: x) f (1 {:: x) f (0 {:: x) f y
	seq						=:  ((&.>) /) (@:((|.@:[) , (<@:]))) (>@:)

	NB.  An adverb that gives the indicies in the RHA (which can be of any rank) where the
	NB.  verb on the LHS returns true.  The following example finds the indices of the LHA in the RHA
	NB.  E.G. 0&= index 4 4$8 3 9 2 0 5 0 1 10 9 8 5 0 7 6 0	NB.  Return 4 2$1 0 1 2 3 0 3 3
	NB.  E.G. 'z0ert' e.~ index 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' {~ i. 3 4 5  NB.  Returns 5 3$0 0 4 0 3 2 0 3 4 1 1 0 2 2 2
	index					=:  1 : '(# i.@#)@:(u&:,) #:~ $@:]'

	NB.  A 'translate' conjunction.  Has 2 noun arguments, producing a verb.
	NB.  Example:  rot13 =.  'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM' tr 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	NB.  rot13 'Guvf vf fbzr ebgngrq grkg'
	xlat					=:  2 : ('({&(n',d,', a.)) @: ((m',d,', a.)&i.)' [d=.preJ6#'.')

	NB.  Another translate conjuction, only for scalars.  Repalce the scalar LHA to the conjunction with the scalar RHA to the conjunction.
	NB.  EG.  0 scalarReplace _1 ] 5 8 0 0 5 6 0 3 0 4  NB. Returns 5 8 _1 _1 5 6 _1 3 _1 4
	NB.  scalarReplace	=: 2 : '(m&=)`(,:&n) } y'
	sr						=:  scalarReplace			=: 2 : ('(m' , d , '&=)`(,:&n', d ,') }' )

	NB.  A better version of scalarReplace; actually more of a hybrid of scalarReplace and xlat.  It shares the advantages of scalarReplace
	NB.  in that it does not need to know the universe of possible values in advance (meaning it's not restricted to literals and doesn't
	NB.  require explicit code).  It shares the advantage of xlat in that it can replace a list of scalars with another list of scalars, instead
	NB.  of just a single scalars.  Like scalarReplace and xlat, it is restricted to replacing scalars with scalars: it cannot replace arbitrarily
	NB.  shaped data (use replace for that [which has the additional freedom of not requiring the search and replace inputs to be of the same
	NB.  length]).  One drawback of multiScalarReplace is that it needs to create large temporary (ephemeral) data; (#@[ * */@:$@:]) elements to
	NB.  be exact.
	NB.  EG:  abc_to_def 'aZbYcX'       [. abc_to_def	=: 'abc' multiScalarReplace	'def' NB.  Returns 'dZeYfX'
	NB.  EG:  zero_to_one 5 5 5 5 $ 0   [. zero_to_one	=:     0 multiScalarReplace 1     NB.  Returns 5 5 5 5$1
	multiScalarReplace		=: 2 : '((i.~"0 _&m)` (n&(] ,~ ($~"0 1&, $)))) }'

	NB.  The adverb evoke can be used to access global nouns (which can change) from tacit definitions.
	NB.  E.G. lookUpID	=: ((i.~ {."1) { {:"1@:]) 'ID_TABLE' evoke
	evoke					=: ". bind

	NB.  Make LHA copies of RHA
	copy					=:  (* #) $ ]

	NB.  Merge a set of lists based on a merging specification, EG:
	NB.  (0 1 2 1 0 2) mergelists 'ABCDEFG';'0123';'zyxwvutsr'
	NB.  A1x3Eu
	shuffle					=:  mergelists	=:  ([ + #@:] * i.@:(#@:[)) { (,@:|:@:>@:])

	NB.  Replace multiple occurances of a char with a single occurance.
	collapseMultiples		=:  (] #~ (-.@:E.~ 2&#)~)

	NB.  Round RHA to the nearest LHA.
	round					=:  ([ * [: <. 0.5"_ + %~)

	NB.  Scramble the items of y
	scramble				=:  {~ ?~@:#

	NB.  Identify the depth of nested parens at each point in a string
	parenDepth				=:  +/\ @: (-/) @: ('()'&(=/))
	pd						=:  ('()'&$:) : (({: + +/\ @: (-/)) @: (=/))

	NB. Tests if all items in the RHA are equivalent.
	allSame					=:  (1: = #@:~.)

	NB.  Tests if beginning of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
	beginsWith				=:  ,^:(0: -: #@:$)@:] -: ({.~ #)    NB.  ([ -: ({.~ #)~)

	NB.  Tests if end of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
   	endsWith				=:  ,^:(0: -: #@:$)@:] -: ({.~ -@:#)

	NB.  Appends the LHA to the RHA if the RHA doesn't already end with the LHA.
	appendIfNotPresent		=:  ,~^:(-.@:endsWith~)

	NB.  Places the LHA on either side of the RHA.
	NB.  E.G.:  '***' envelope 'hello' NB.  outputs '***hello***'
	envelope				=:  ([ ,~ ,)

	NB.  Takes a scalar as a LHA and an N-dimensional array as a RHA.
    NB.  Completely encloses the RHA with repetitions of the LHA.
	NB.  E.G.:  '*'  trap ,:'hello' NB.  Outputs 3 7$'********hello********'
	trap					=: ([ 0&|:@:, ,~)^:(#@$@:])

	NB.  Get all the possible subsets of a set, including the empty and full sets.
	subsets					=:  <@#~ (2: (#~ #: i.@^) #)

	NB.  Verbs to create binary arrays locating the the elements before after, or between
	NB. the first or last appearance of some element(s) in the set.
	assertBeforeFirst		=:  *./\  @: ~:
	assertAfterFirst		=:  +./\  @: =
	assertBeforeLast		=:  +./\. @: =
	assertAfterLast			=:  *./\. @: ~:
	keepFirst				=:  < /\  @: =
	keepAllButFirst			=:  < /\  @: ~:

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

	NB.  Cut on an arbitrary-length fret.
	NB.  EG:  ' hello ' arbCut 'hi hello how hello are hello you hello today' NB.  Returns ;: 'hi how are you today'
	arbCut					=:  <@:#@:[ }.&.> [ (E. <;.1 ]) ,

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
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map       'Name'      NB.  Returns  <'Daniel'
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map     ,<'Name'      NB.  Returns ,<'Daniel'
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map     ;:'Name Age'  NB.  Returns   'Daniel';'24'
	NB.  Map is invertable, so you can 'unmap' values:               '
	NB.  EG:  (3 2$<;._1 ' Name Daniel Age 24 Gender M') map^:_1 ;:'Daniel 24' NB.  Returns   'Name';'Age
	map						=:  ((i.~&:(tolower&.>@:boxopen) {."1)~ { {:"1@:[) :. ((map~ |."1)~)
	
	NB.  The verb mapWithDefault is like map, but allows the map to specify a default.  The default is defined by
	NB.  an empty name, i.e. by an a: in the name-list ({."1 of the mapping table).  If no default is provided,
	NB.  a: will be used in its stead.  The default value will be returned where from mapWithDefault where an index
	NB.  error would be signaled by map.
	NB.  EG:  (4 2$<;._1 ' Name Daniel Age 24 Gender M  UNKNOWN_PARAMETER') mapWithDefault       'Sex'            NB.  Returns  <'UNKNOWN_PARAMETER'
	NB.  Note that while mapWithDefault does have an inverse, the inverse is not as strict as that of map; the inverse will return a: for unknown value looked up.
	NB.  EG:  (4 2$<;._1 ' Name Daniel Age 24 Gender M  UNKNOWN_PARAMETER') mapWithDefault^:_1 ;:'Daniel 24 Male' NB.  Returns   'Name';'Age';''
	createDefault			=.  (] ((#~ -.) , ({~ i.&1)) =&a:@:({."1))@:,&a:
	mapWithDefault			=:  (((i.~&:(tolower&.>@:boxxopen) [: }: {."1)~ { {:"1@:[)~ createDefault f.)~ :.((mapWithDefault~ |."1)~)
	
	NB.  Cover to map and makemap.
	NB.  EG: 'buy/b sell/s short/t' lookup       'buy' NB.  Retuns <,'b'
	NB.  This verb is also invertable:
	NB.  EG: 'buy/b sell/s short/t' lookup^:_1 <,'b'   NB.  Retuns <'buy'
	lookup					=:  (map~ makeMap)~ :. ((map^:_1~ makeMap)~)
	
	NB.  As mapWithDefault is to map, so lookupWithDefault is to lookup.
	NB.  EG:  'buy/b sell/s short/t /bad_code' lookupWithDefault  'hold' NB.  Returns <'bad_code'
	lookupWithDefault		=:  (mapWithDefault~ makeMap)~ :.((mapWithDefault^:_1~ makeMap)~)
	
	NB.  This verb will show where the LHA is equal to the RHA, ignoring width (i.e. padding with the default fill character).
	NB.  For example, 'ABC' matchIgnoreWidth > ;: 'WXYZ QRST ABC MNOP' NB. Returns 0 0 1 0
	matchIgnoreWidth		=: ({. -:"_ _1 }.)@:,

	NB.  Convert text to uppercase
	uc						=:  (LCALPHA xlat UCALPHA) f.

	NB.  Convert text to lowercase
	lc						=:  (uc^:_1) f.

	NB.  Replace all occurances of some sequence with another sequence.
	NB.  E.G. ('Hello';'Goodbye') replace 'Hello, world!'
	locate					=.  E. <;.1 ]
	matches					=.  (([ locate ,)~ >@{.)~
	remove					=.  #@>@{.@[ }.&.> matches
	replace					=:  ;@({:@[ ({.@] , ((,&.>) }.)) remove) f.

	NB.  Replace more than one sequence
	NB.  E.G. ((<'Hello';'Goodbye'),(<'wonderful';'cruel')) multireplace 'Hello, wonderful world!'
	multireplace			=:  replace seq f.

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

	NB.  Monadic creates random strings; dyadic picks random elements from a set
	randpick				=:  $:&'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' : ((?@:# #) { ])

	NB.  Make a number more readable by delimiting it with commas
	fmt						=: ((({. '-'&,@:]^:(-:&'_'@:[) ({: ;@:,~ ,&',' each @: }:)@:(_3&(<@:|.\)&.|.)@:(-.&'_'))@:{.  , }.)~ i.&'.')@:":
	NB.  Format a list of numbers, and try to put it back in the original shape.
	multifmt				=:  ;:^:_1@:(<@removeTrailingBlanks"1)@:(fmt"0)


	NB.  Return (1 { x) elements from y starting at 0 { x
	NB.  EG:  a. from~ 10 ,~ a. i. '0'  NB. Returns '0123456789'
	from					=:  (];.0~ ,:/)~

	NB.  Apply function on nub, then expand array to original length
	NB.  Just make verbs faster on arguments with small nubs.
	applyOnNub				=:  1 : '((u@:[) {~ i.~) ~.'

	NB.  Like E., this creates a boolean list where the elements of the right match the elements of the left
	NB.  except that E. has ones only where the match begins, whereas this function has ones for the entire
	NB.  match.
	NB.  EG:  'hello' E 'hello how are you?' NB.  Returns 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0
	NB.  Old form: E =. }:@:([: *@:+/\ #@:[ _1:`(+ bx)`(,&0@:]) } E.)
	E						=:  [: ; <@:#@:[ ((}.&.> {.) , }.@:]) #@:[ (#&1@:[ , }.)&.> <;.1~@:([ E. ,)

	NB.  Select;  adverb which takes a verb that produces a boolean; the result of the verb will be selected
	NB.  from the RHA.
	select					=:  1 : 'u # ]'

	NB.  Remove all occurances of the sequence on the LHS from the RHS
	NB.  EG:  'ugly ' remove  'This ugly sentence should ugly be ugly nice'	NB.  Returns 'This sentence should be nice'
	NB. remove					=:  -.@:E select

	NB.  With a list of boxes as a LHA, returns those which contain the sequence in the boxed RHA.
	NB.  E.G. 'A' selectContaining 'ALPHA';'BETA';'GAMMA';'DELTA';'EPISLON';'THETA' NB. Returns  <;._1 ' ALPHA BETA GAMMA DELTA THETA'
	selectContaining		=:  (1&e.@:E.&> select~ <)~
`
	NB.  List the files in a directory.  Outputs a list of boxes, each containing the fully-qualified name of a file matching the query.
	NB.  EG:  listFiles 'c:\temp\*.txt'
	listFiles				=:  (({.~ >:@:i:&PATHSEP_j_)&.> , each {."1@:(1!:0))@:boxopen

	NB.  Box to any level (get around the boxing depth limitation (max L. is supposed to be 270))
	NB.  Doesn't work on boxed data (because it will change everything at L: 0).
	NB.  EG: 271 box $~ 0 NB.  Returns <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<a:
	NB.  box				=: (({.@:[ (<^:270 L: 0)@:]^:[ <@:]^:({:@:[))~ (<.@% , |~)&270)~

	NB.  Replace 0s with last non-zero values.
	NB.  EG:  drag 0 0 1 2 0 0 0 3 0 4 0 0 0 5 6 7 8 0 0 9 0 0 0 0 NB. Returns  drag 0 0 1 2 2 2 2 3 3 4 4 4 4 5 6 7 8 8 8 9 9 9 9 9
	drag					=:  ;@:(<@:(# # {.);.1~ 1&(0 })@:~:&0)

	NB. Util to perform functions inside a string.  Input is literal (character vector), output is literal (character vector).
	NB. Funtions to perform are embedded within dollar signs.  There is no way to include dollar signs in the string itself.
	NB. EG 0:  doString 'hello I am $20 + 4$ years old' NB.  Returns 'hello I am 24 years old'
	NB. EG 1:  doString 'hello I am $twenty_four$ years old' [ twenty_four=.24 NB.  Returns 'hello I am 24 years old'
	doString				=:  ;@:(": each)@:($&0 1@:# ".&.>@:]^:([`[`])"0 ])@:(<;._2)@:,&'$'


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

	NB.  The inverse of  I.  (which was once called  bx  )
	NB.
	NB.  The dyadic form allows the LHA to specific the length 
	NB.  of the resultant vector.
	NB.
	NB.  EG:    xb 5 7 12    NB.  Returns 0 0 0 0 0 1 0 1 0 0 0 0 1
	NB.  EG:    xb 5 5 7 12  NB.  Returns 0 0 0 0 0 2 0 1 0 0 0 0 1
	NB.  EG:  5 xb 1 2 3     NB.  Returns 0 1 1 1 0
	NB.  EG:  In a red-black tree, ensure all the children of black nodes are red:
	NB.       assert (=&'r'@:#~ # {. ([: , 1 2 +/~ +:)&. bx @:=&'b')'brrbbbbrrr'
	NB.  EG:  Strip trailing zeros:
	NB.       assert 1 2 3 -: ]&.bx  1 2 3 , 15 # 0
	NB. xb                  =: 1:`[`] } >:@:(>./) # 0:
    iii                     =. ({:"1@:])`({."1@:])`(0 $~ [) } 
    NB. xb                  =: ((0 >. >:)@:(>./)@:(| - 0&>) iii f. ({. , #)/.~) : ({. $:) :. (bx =: I. :. xb)
    xb                      =: ((] iii f. ({. , #)/.~@:|~) (0 >. >:)@:(>./)@:(| - 0&>)) : ({. $:) :. (bx =: I. :. xb)
	NB.  TODO:  Make a dyad version that works nicely with negative indicies (i.e. _1 in y should be 
	NB.  treated like an instance of (<:x).
	NB. xb                      =: ((] iii f. ({. , #)/.~@:|~) (0 >. >:)@:(>./)@:(| - 0&>)) :  (_1 <:@:{`[`] }  $:@:, ) :. (bx =: I. :. xb)
	NB. xb                      =: ((] iii f. ({. , #)/.~@:|~) (0 >. >:)@:(>./)@:(| - 0&>)) :  (_1 <:@:{`[`] }  $:@:(, <:)~) :. (bx =: I. :. xb)

	
	NB.  Just like ;:^:_1, but can join with any glue.
	NB.  EG:  ', ' join ;: 'a b c d e f'
	join					=:  -@:#@:[ }. ;@:(,&.> boxopen)~

	NB.  Get all anagrams of input
	anagram                 =:  A.~ i.@:!@:#

	NB.  Adverb to evoke names in locales.  
	NB.  EG:
	NB.  'z x__z y__z' =: ({.;:'foo');4;'hello'
	NB.   4          -:    'x'    in z
	NB.  (4;'hello') -: (;:'x y') in z
	NB.  (4;'hello') -: (;:'x y') in z,z
   in  =: 1 : '[: >^:(0 -: #@:$) m &(4 : '' ( x,''''_'''' ([ , ] , [) ;y )~ '' L: 0) '



NB.  =====================================================================================================================================================
NB.  Date/Time Utilities:  Mostly conversions
NB.  =====================================================================================================================================================

	NB.  Like isotimestamp, this verb takes input in the format of 6!:0'' and provides output as a literal in the format YYYY-MM-DD HH:NN:SS.UUU
	NB.  datetimestamp	=:  ;@:([: ({~ /:^:2@:-.@:(2&|)@:i.@:#) (;/'-- ::')&,) @: (4 2 2 2 2 6&((-@:[ <@:({.!.'0') ":@:])"0))
	datetimestamp			=:  [: ;@:|:@:,:&(;/'-- ::')  4 2 2 2 2 6j3&(<@(' ' scalarReplace '0')@":"0)

	NB.  For only the date-portion of datetimestamp
	NB.  EG:  datestamp  3 {. 6!:0 ''
	datestamp				=:  10&{.@:datetimestamp@:( 6&{.)

	NB.  For only the time-portion of datetimestamp
	NB.  EG:  timestamp _3 {. 6!:0 ''
	timestamp				=:  11&}.@:datetimestamp@:(_6&{.)

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

	getNmdPath				=:  verb define
		me                                       =. cocreate''	
		nms                 =.  '__me' , L: 0 ~ ;: 'dir basename ext' 
		(nms)               =.  (; (split~ i:&'.'))&>/ splitPath`getPath@.(0-:#)y
		fullname__me        =.  basename__me , ext__me
	   	path__me            =.  dir__me , fullname__me
		me
)


	NB.  Arbitrary comparison functions.  Use like dyadic <:, >:, <, and > respectively
	lte						=: {:@:/:@:(,&<)
	gte						=: {.@:/:@:(,&<)
	lt						=: -: < lte f.
	gt						=: -: < gte f.

	NB.  Find out in what interval a given item falls
	NB.  EG:  _1 99 7 3 4 interval i. 15  NB.  Returns 0 15 8 4 5
	NB.  EG:  ' AQFR' interval UCALPHA    NB.  Returns 0 1 17 6 18
	interval				=:  (i.&1@:(lt"_1))"_1 _

	NB.  Extract strings of printable characters greater than
	NB.  length x from y  
	NB.  EG:  ;{.strings fread jpath'~binary\j.exe'  NB.  Returns '!This program cannot be run in DOS mode.'
	k						=. ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'   
	strings					=:  7&$: : ([ (] #~ (< #&>)) ] <;._1~ k -.@:e.~ ]) 

	NB.  Encode/decode URIs
	NB.  EG:  'foo' -: uri_decode uri_encode 'foo'
	NB.  TODO: only encode the required characters, instead of all characters.
	NB. uri_encode =: ( ' ' sr '+' ( ((] #~ 1 + *)&>/@:}:@:]) 4 : 'x}y' >@:{:@:] ,:~ (#~ 1 j. *&>/@:}:)) -.@:e.&'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.!~*''() ' ((_1 + %&#~) ; [ ,&< ] (#~,) 1 ,. [ #"0~ _1 + %&#~) [: , '%' ,. '0123456789abcdefABCDEF' {~ 16 #.^:_1 a. i. ])  :. uri_decode =: '%[0-9a-fA-F]{2}'&((a. {~ 16 #. 10 #. 0 16 #: '0123456789abcdefABCDEF' i. ])@:}. rxapply)@:('+' sr ' ') :. uri_encode 
	NB. ' ' sr '+'@:('[^0-9a-fA-F _.!~*''()-]'&(([: , '%' ,. '0-9a-fA-F' {~ 16 #.^:_1 a. i. ]) rxapply)) :.('%[0123456789abcdefABCDEF]{2}'&((a. {~ 16 #. 10 #. 0 16 #: '0123456789abcdefABCDEF' i. ])@:}. rxapply)@:('+' sr ' ') :.uri_encode)
	uri_encode =: ( ' ' sr '+' @: ( ('[^0-9a-zA-Z _.!~*''()-]')&(([: , '%' ,. c {~ h #.^:_1 a. i. ]) rxapply) ) )  :. uri_decode =: ('%[',c,']{',(":#ct),'}')&((a. {~ hx #. (#dg) #. (ct=.0 , hx=.#h=.;c-.uc) #: (c=.;'dg lc uc'=.;:'0123456789 abcdef ABCDEF') i. ])@:}. rxapply)@:('+' sr ' ') :. uri_encode 	
    erase 'c ct dg hx uc'




NB.  =====================================================================================================================================================
NB.  Environment Utilities: Mostly covers for foreigns.
NB.  =====================================================================================================================================================

	NB.  Maps integer returned from 9!:12 onto human-readable string.
	PLATFORM				=:  ({::~ ] i. 9!:12 bind '')&>/ 0 1 2 3 4 5 6 7 _1 ,&<~ <;._1 '|PC|PC386|Windows|Macintosh|OS2|Unix|Windows32 (95/98/2000/NT)|Windows CE|Other|Unknown'
	JVERSION				=:  9!:14''
	ENVIRONMENT				=:  JVERSION , ' on ' , PLATFORM

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
	NB.  that value is null (0=#y), in which case the default parameter table will be
	NB.  used in its entirety, with no caller-defined values.

		if. '3 :' beginsWith~ verbBody =. 5!:5<'v' do.
		NB.  If this is an explicit monadic verb, then redefine it appropriately.

			NB.  Drop off the '3 : 0' (or '3 : ''')
	 		verbBody		=.  5 }. verbBody

			NB.  We need to build up a verb that will massage the input to v

			NB.  Box the input iff it's not boxed and it's not null.  This way it's convenient to pass in one parameter, or
			NB.  none, just allowing all the defaults to take effect.
			normalizeInput	=.  <^:(# 2 b.&* L.)

			NB.  Determines if the input's rank is at least 2.  That is, if it's 'less than' a table.
			isList			=.  2&>@:#@:$@:]

			NB.  Stiches on the first N parameter names to the input list (where N = # list),  allowing the user to pass in a
			NB.  list of parameters without names so long as they're in the correct order (the correct order is as defined by
			NB.  the default parameters).
			paramListToTable=. ([: ({."1@:[ ,. ,@:])&>/ <.&# {.&.> ,&<)^:isList

			NB.  Appends the default param name/value pairs onto the end of the parameter table.
			appendDefaults	=. paramListToTable , [

			NB.  For convenience, normalizeNames lowercases and removes spaces, dashes, and underscores from parameter names.
			NB.  This is so that, for example, 'someParameter', 'Some Parameter', 'some-parameter', 'SOME_PARAMETER' are
			NB.  treated equivalently.  Doing this may result in name conflicts.  Note that the names defined, in the end,
			NB.  are in the same format as specified by the default parameter table.
			normalizeNames	=. tolower@:-.&' _-'&.>@:({."1)

			NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
			NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to
			NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
			NB.  access).
			createParameterTable	=.  m&([ ({."1@:[ ,. i.~&normalizeNames { {:"1@:]) (appendDefaults normalizeInput)) f.

			NB.  We will add these lines to the top of v, thereby redefining it.

			NB.  Apply createParameterTable to y (the input to v)
	        newHeading		=.  'NB.  Create parameter name/value table from input and default table.', CRLF, 'params =. ', (5!:5<'createParameterTable') , ' y'
			NB.  Define some local names from the parameter table we just created.
			newHeading 		=.  newHeading , CRLF, 'NB.  From the parameter name/value input table, define local names from column 0 to values from column 1' , CRLF , '({."1 params) =. {:"1 params'
			NB.  Erase the noun 'params', so we don't interfere with globals of that name.
			newHeading 		=.  newHeading , CRLF, 'NB.  Erase the noun ''params'', so we don''t interfere with globals of that name.' , CRLF , '4!:55 ,<''params'''

			NB.  Drop off the trailing ')' (or '''') from v, add our new heading, and output the redefined verb.
			3 : (<;._2 toJ newHeading, CRLF, CRLF, ,&CRLF^:(LF&~:@:{:) _1 }. verbBody)
		else.
		NB.  If v isn't an explicit monadic verb, don't do anything to it.
	 		v
		end.
)

	findNames				=: verb define
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
	NB.  Output: A 2 by N matrix of boxes, with N = to the number of locales searched (which will always be >: 1).
	NB.  The first box in each row contains the literal name of a locale searched, and the second box of each
	NB.  contains a list of boxes (possibly with # = 0) each containing a name in that locale matching the search
	NB.  pattern.

		NB.  This complicated line is just to make sure that we default correctly.  That is, x must always be a list of 2 boxes,
		NB.  the second containing conl$0 if no locale names were provided.
		locales				=.  1 {:: x =. ({. , ((conl$0)"_^:(0: -: #))@:(;:^:(-.@:*@:L.))&.>@:{:)@:(2&{.)@:boxopen x

		NB.  This creates a verb which will negate our search function if and only if the first character of
		NB.  the search string is '!'.  It also updates the search string by removing the '!' if it's present.
		negate				=.  -.^: ( 1 {:: 'y z' =. ((}.~ ; ]) '!'&-:@:(0&{)@:(1&{.)) y )

		NB.  If no proper search type is specified, the default, '|' or 'match anywhere in the name',
		NB.  is used.
		y					=.  (,~ {.&'|'@:-.@:(e.&'=|^$~')@:{.~&1) trim y

		NB.  These are our search verbs - they correspond to the search type in the following line.
		verbs				=.  -:`(+./@:E.)`(beginsWith~)`(endsWith~)`rxin

		NB.  This will select the correct search verb from the list.  5!:0 turns the result of the
		NB.  pick from the gerund into a verb.
		searchVerb			=.  (verbs {~ '=|^$' i. searchType =. 0 { 1 {. y) 5!:0

		NB.  Require regexes for the '~' operator, i.e., only load 'regex' if I'm actually going to use it.
		require^:(searchType -: '~') 'regex'

		NB.  Default the name list to an empty list of boxes.
		nameList			=. 0 2 {. a:

		for_locale. locales do.
	 		nameList		=. nameList , locale , < y (] #~ (negate@:searchVerb&lc~ }.)~ &>&boxopen) nl__locale 0 {:: x
		end.
)
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

	NB.  Close J.  No 'Are you sure?' dialog.
	exit					=:  2!:55 bind ''

	NB.  Toggle Linedraw: Switch between ASCII-char box drawing and DOS lines box drawing.
	toggleLD				=:  (empty 9!:7@:>@:('+'&e.@:(9!:6) { (('|-',~9#'+');(218 194 191 195 197 180 192 193 217 179 196{a.))"_))

	NB.  Set the print precision
	pp						=:  [: (i. 0 0)"_ (9!:11)

	NB.  Paste clipboard contents
	paste					=:  wdclipread

	NB.  Copy RHA to clipboard
	clip					=:  wdclipwrite

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
	ntt						=:  nounToText	=:  verb   def '5!:5 < ''y'' '

	NB.  Turn a verb into text.  EG: (+/ % #) verbToText NB.  Returns '(+/ % #)'
	vtt						=:  verbToText	=:  adverb def '5!:5 < ''u'' '
	NB.  Like verbToText, but applies f. first.
	vtt2					=:  verbToText2	=:  vtt f.

	NB.  Turn a call into text.  EG:  1 2 3 4 ({.~ +/)~ callToText 'HELLO'  NB. Returns '(1 2 3 4)(({.~ +/)~)(''HELLO'')'
	ctt						=:  callToText	=:  adverb def '(, ,~&(parenclose u verbToText))&>/@:{.~&_2@:,~&a:@:,&:(<@:parenclose@:nounToText)'
	NB.  Like callToText, but without the enclosing parens.  Prettier at the expense of fidelity.
	ctt2					=:  callToText2	=:  adverb def '(, ,~&(           u verbToText))&>/@:{.~&_2@:,~&a:@:,&:(<@:            nounToText)'

	NB.  Wrap a line of text to the window width
	wrap					=:  ($:~ screenSize) : ((]\~ -)~) 

	NB.  Wrap in parenetheses.  EG:  parenclose 'Hi there' NB.  Returns '(Hi there)'
	parenclose				=:  '('&,@:,&')'

	NB.  Boxed list of the filenames of all open scripts
	scriptsOpen				=:  (#~ -.@:endsWith&'.ijx'&>)@:(<;._2@:wd bind 'qsmall')

	NB.  Pretty-print formatted list of open scrips
	listScripts				=:  ls@:scriptsOpen

	NB.  Minimize all open windows
	minimizeAll				=:  wd @: ('smsel '&,)@:,&'; smshow sw_minimize' each @: scriptsOpen 

	NB.  The minimum of the window width and the maximum line length
	screenSize				=:  {.@:wcsize bind '' <. 1: { 9!:36 bind ''



NB.  =====================================================================================================================================================
NB.  Execution section: Run at startup
NB.  =====================================================================================================================================================


	NB.  Figure out directory in which J is working, using a combination
	NB.  of '..' directory syntax, 1!:0, and the sequence adverb ^:a:
	NB.  Also good example of the use of ;.0 to extract subarrays
	NB.  instead of having to do things like }.@:}:@:{:@:|:

	NB.   require 'winapi'
	NB.   gd =. 'GetCurrentDirectory' win32api
	NB.   gd =. (('GetCurrentDirectory';'GetCurrentDirectoryA') stringreplace^:(0 < #@:$@:])  L: 1 0]5!:1{.;:'gd')5!:0
	NB.   wai =: ([: ({.~ 0 >. <:)~&>/@:}.@: pt >@:{.@: pt =. [: gd f. (;#&' '))@:0:
	NB.   (1!:43 -: wai)''

	extractDirs    =.  ;;.0~ 1 1  ,: 1 ,~ _1 + #
	recurseUpDirs  =.  ((,&'\..' ,&< 1!:0)@:>@:{.)^:(0: < */@:($&>)@:{:)^:(<_)
	whereAmI       =:  extractDirs @: recurseUpDirs @: < bind '.' f.
	I_AM_HERE      =:  PATHSEP_j_&join@:|.@:,~&a:  {."1  whereAmI '' 


NB.  =====================================================================================================================================================
NB.  Execution section: Run at startup
NB.  =====================================================================================================================================================

NB.  Require this so we can use comman line options in all our programs.
load '~user\OS\commandLineParser.ijs'

NB.  Require this so that we can save/load workspaces
load '~user\environment\jworkspace.ijs'

NB.  Require this so that we use formatTimeSpan
load '~user\time\formattimespan.ijs' 

NB.  Require this so that we can shorten the path in "recent files"
load '~user\environment\reduce_prefix.ijs' 

NB.  Require this so that we can shorten the path in "recent files"
load '~user\environment\nameScope.ijs'

NB.  Load all of Oleg's useful utils.
load (#~ endsWith&'x') listFiles '..\contrib\oleg\*.ijs'
load '~user\contrib\millers\fw2dl.ijs'

NB.  Turn on debugging if requested
3 : 0 ^: # $ getOption 'djbdebug'
	load 'debug'
	NB.dbr 1
	if. stops =. getParam 'djbdbss' do.
		dbss stops , ; (< ' *:*') #~ -. ':' e. stops
	end.
)

NB.  For the convenience of fread, fwrite, etc.
require 'files'

NB.  Print out J version and timestamp
NB.  It appears that this startup script is run before the IJX window is created,
NB.  so 'smoutput' won't work.  So I just create a verb to print the prompt
NB.  and call it from a later script (newuser.ijs specificially)
printPrompt_z_ =: verb define

	version =. ( ('vb' {~1 e. 'beta' E. ]) , 4 {.!.'?' ]) }. (i. {. [)&>/ ('_' ;~ 1!:1) :: ('/' ;~ 9!:14@:(''"_))  <jpath'~bin/installer.txt'
	smoutput 'New J (' , version ,  ') session started on ' , ((i.&' ') ({. , ' at '"_ , }.@:}.) ]) _4 }. datetimestamp_base_ 6!:0 ''

	if.  you_want_regex_loaded_and_the_random_seed_changed =. 1 do.  NB.  Usually when you restart J ? wil give the same results in the same order as the last time.  This changes when you reset the randoms edd.
	require 'regex'
	
	NB.  Set random seed to time, so we don't always get the same line from the same file
	NB.  2006-Dec-01:  Changed  <@:^.  to [: ^. <.  because the interpreter now tries to 
	NB.  special case  <.@:f  in addition to <.@f  , which introduces a nonce error.  
	(?@:[ 9!:1)/ 2032 12 31 23 59 59 999x  (((<.<:2^31)&(] #:~ [ #~ 1: + [: <. ^.)@:#.)&.|. <.@:(, *&1000@:(1&|)@:{:))  6!:0''

    or               =. 2 : 'u :: (n"_)'
    orNada           =. or (i.0)
	randFile         =.  toJ@:(1!:1 :: (''"_))@:({ orNada~ ?@:#)@:listFiles@:jpath 
    isNB             =. (4&{ or ' ' e. '.:'"_)  < 'NB.'"_ -: 3&{.

	NB.  Live code (livecode):  ('NB.[^.:]';'''')&( ((] +. +./\@:>)(+. ~:/\))/ @:(rxE&>))@:<   NB.  Mask where code is 'dead' (in quotes or after NB.)
    containsCode     =. (0: ~: # - (isNB@:>@:{:))@:;:&>

    randNonEmptyLine =. (>@:{ orNada~ (({ orNada~ ? @:#)@:bx@:containsCode))  @: (LF&cut)  NB.  Do NOT use  {:: in place of >@:{  because ''&{:: is NOT the same as ''&(>@:{) 
    clean            =. ('NB.[^.:]';'''')&(>@:] #~ =&' '@:>@:]  (*./\.@:+. (j. 1 0&E.)@:= ]) ((] < +./\@:>)(+. ~:/\))/@:(rxE :: 0: &>))@:<^:(0: -.@:e. $)   NB.  Have to use S: instead of &> because 'boxed' -: datatype > 0 $ a: and rxE is sensitive to 'boxed' -: datatype

	smoutput '   ' & , @: clean @: randNonEmptyLine  @: randFile  orNada '~system\examples\phrases\*.ijs'  NB.  :: ((13!:11 ,&< 13!:12)@:empty "_)
	end.

	smoutput ''
)

PROMPT =: noun define
New J $VERSION$ session started on $DT$
Help     :  
Binary   :
Library  :
Platform :
Profile  :



)

NB.  If workspace provided on command line, load it.
NB.  Make sure we don't reload the workspace if this script is reloaded
(0 = nc<'WORKSPACE_z_') loadWorkspace@:]^:(+: 0&-:) getParam 'workspace'

NB.  If 'j' option given on the command line, get the original command line and execute everything following /j, then exit.
NB.  base36 =: (encoding -&# lc_alpha) ([ #. | + (#dec_digits) * <:)  (encoding=.;'dec_digits uc_alpha lc_alpha'=.;:'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz') i. ]

NB.  Memoize for arbitrary inputs, not just small integers
NB.  EG:     3 : 'y [ smoutput y' memo&.> 'aa'  NB.  Only calls verb once;
NB.      2
NB.      +-+-+
NB.      |a|a|
NB.      +-+-+

memo =: M. ("0) (&.((6 s: s:)@:<@:(3!:1)))
