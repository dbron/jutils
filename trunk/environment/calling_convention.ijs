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
paramSyntax         =: ([`(({.,.{:)@:]"1) @.((fw '=') *./ .= 1 {"1 _1: }. ])   _3 ]\ ])@:-.&(fw ',')^:(2 > #@$)

NB.  'F'unction 'def'inition:  cover adverb to defn that makes 
NB.  sure paramSyntax is called.  Used as in example
NB.  below.
fdef                =: adverb def '(u defn)&:paramSyntax'


Note 'Example'
	NB.  ===========     EXAMPLE SECTION    =========== 
	NB.  Define a parameterized verb.  A noun-define is used to create the default parameter table,
	NB.  to enhance readability.
	myFunc              =:  verb fdef
	        filename    =  'c:\short.log'
	        max         =  42
	        color       =  'red'
	)
	
			NB.  Ignore this line; I just use it to avoid cluttering the session window.
	        print       =. 'r=.LF,~(r"_ ::]$0),'".@,3 :'5!:5<''y'''
	
	        print LF,'======='
	
	        print 'Logging to:  ', filename
	        print 'Max is:  '  , ": max  NB.  Note the format;  we're expecting this parameter to be numeric (but this is not checked).
	
	        if. color_is_default do.
	                print 'My favorite color is '  ,color
	        else.
	                print 'Your favorite color is ',color
	        end.
	
	        print '======='
	)
	
	
	myFunc['c:\file.txt' 906   fs]
	myFunc['c:\file.txt',906   fs]
	myFunc[color='blue'        fs]
	myFunc[color= blue         fs]
	myFunc[max=906, color=blue fs]
	myFunc[MAX=906, COLOR=blue fs]
	myFunc<MAX=906, COLOR=blue fs>

)