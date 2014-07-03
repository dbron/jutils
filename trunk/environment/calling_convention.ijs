NB.  Require strand and parameterized verbs script
NB.  should be in this same directory
splitPath   =.  ({. ,&< }.)~ (# <. >:@:i:&'\')
'dir file'  =.  splitPath (here =. 3 : '(4!:3$~0) {::~ 4!:4{.;: y') 'here'
require dir ,L:0 '.ijs' ,L:0~ ;:'parameterized_verbs strand'

NB.  Combination of strand notation and parameterized verbs
NB.  allows us to define verbs with formal (named) arguments
NB.  and call them like
NB.        func[value, value, value,   ... fs]
NB.        func[name=value,name=value, ... fs]
NB.
NB.  See bottom of script for examples.

NB.  This whole script is just one extra verb and 
NB.  cover-adverb added to the services of the
NB.  scripts required above.  
NB.
NB.  This verb, paramSyntax, sits on top of strand
NB.  notation, and permits some flexibility in
NB.  calling parameterized J verbs.  It emulates
NB.  the calling conventions of other programming 
NB.  languages.
NB.
NB.  Caveat:  there are some syntactic constraints
NB.  (imposed by J's own grammar), but also freedoms.  
NB.
NB.  For example, in the [value value value] syntax, 
NB.  you couldn't have 2 adjacent numeric parameters
NB.  because they'd run into each other, so you'd 
NB.  have to use parens e.g.  [(1 2 3) (4 5 6)]
NB.
NB.  Or you could use the comma syntax, like
NB.  [1 2 3, 4 5 6]
NB.
NB.  But note that this has the cost that (,',') 
NB.  can never included in the strand (using this calling 
NB.  convention), and therefore ,',' itself can never be 
NB.  a parameter.
NB.
NB.  Further, in the  name=value  syntax, either you
NB.  can quote the name, as in 'name' or you can use
NB.  a bare name, so long as it's unassigned or a proverb.
NB.  Actually, this is true of values, too (for string values,
NB.  anyway).
NB.
NB.  In general, the only parts of speech which can be
NB.  embedded in a strand are nouns and verbs.
NB.  
NB.  The freedoms are provided by the flexibility of 
NB.  the parameterized_verb and strand scripts.
NB.  For example, names can be spelled in many different ways
NB.  theColor='blue' or THE_COLOR='blue' etc. Similarly, the
NB.  strand markers can also be changed, e.g.
NB.  ['blue' fs]  or  |'blue' fs] or <'blue' fs> or #'blue' fs#
NB.  
NB.  Note that paramSyntax only applies if the argument is a scalar or
NB.  a vector.  A fully-qualified name,.value table is left alone.
NB.
NB.  Finally, note that paramSyntax is just a verb of convenience,
NB.  Using strand notation, one could easily write his own 
NB.  specialized syntax (a DSL), so long as it's composed 
NB.  entirely of nouns and verbs.  EG:
NB.
NB.     sql [select FOO where BAR > (99+108) and BAZ e. 'abc' fs]
NB.
NB.!! DJB 2014-07-03:  The third example below (myFunc['c:\file.txt' fs]) 
NB.!! chokes with an index error, because _3 ]\ ,<'file.txt' only has 1 column, 
NB.!! not 3 . Don't know how that ever worked. I also don't understand why 
NB.!! we were dropping off the last row of the table with _1: }. ] (nor why 
NB.!! I didn't just use }: ).  Anyway, leaving the old version commented out 
NB.!! here, in case the changes break something else later (i.e. the _1 }. 
NB.!! ] was adjusting for an edge-case I've forgotten about).
NB.paramSyntax      =: ([`(({.,.{:)@:]"1) @.((fw '=') *./ .= 1 {"1 _1: }. ])   _3 ]\ ])@:-.&(fw ',')^:(2 > #@$)
paramSyntax         =: ([`(({.,.{:)@:]"1) @.((fw '=') *./ .= 1 {"1 ]) _3 ]\ ])^:(2 < #)@:-.&(fw ',')^:(2 > #@$)

NB.  'F'unction 'def'inition:  cover adverb to defn that makes 
NB.  sure paramSyntax is called.  Used as in example
NB.  below.
fdef                =: adverb def '(u defn)&:paramSyntax'


Note 'Example'

	NB.  Can define my own arguments and their default values
	myFunc              =:  verb fdef
	        filename    =  'c:\short.log'
	        max         =  42
	        color       =  'red'
	)
	

		NB.  Note no reference to x or y ... just using
		NB.  my arguments as "expected" or "normal".	

	        smoutput 'Logging to:  ', filename
	        smoutput 'Max is:  '  , ": max

		NB.  Can determine which of my arguments was user-specifed
		NB.  and which defaulted, and do something about it.

	        if. color_is_default do.
	                smoutput 'My favorite color is '  ,color
	        else.
	                smoutput 'Your favorite color is ',color
	        end.
	)
	
	
	NB.  Strand notation
	myFunc['c:\file.txt'  906  'blue' fs]

	NB.  Commas, like other langs
	myFunc['c:\file.txt', 906, 'blue' fs]

	NB.  Unspecified args are defaulted ("optional")
	myFunc['c:\file.txt' fs]

	NB.  Can use named arguments, like eg VB
	myFunc[color='blue'  fs]

	NB.  Often values needn't be quoted
	myFunc[color= blue   fs]

	NB.  Combination of comma syntax and name=value
	myFunc[max=906, color=blue fs]

	NB.  Spelling of names is flexible
	myFunc[MAX=906, COLOR=blue fs]

	NB.  Can use other delimiters, too...
	myFunc<MAX=906, COLOR=blue fs>

)