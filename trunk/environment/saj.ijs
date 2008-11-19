NB.  Single-assigment J


NB.=== Requirements ===
jsystemdefs 'hostdefs' [ require 'dll'


NB.=== Implementation ===
NB.  Adverb.  Argument is either a noun representing a name (as a string or boxed string) or 
NB.  a name (which means an unassigned name or a proverb [but not one of the special ones, 
NB.  i.e. not u or v in an explicit operator]): basically, anything that's stacked by name.
name             =.  (`'') ("_) ((<^:(0=L.))`)  (`(<'0';i.0)) (`:6)

NB.  Stolen from JMF.  Converted to tacit so namescope doesn't become an issue.
AFRO             =.  1
SZI              =.  IF64{4 8     NB. sizeof integer - 4 for 32 bit and 8 for 64 bit
NB.  Dyadic verb.  Makes the name given as the RHA readonly or not as determined by the boolean LHA.
Readonly         =.  [ (] memw~ (AFRO * 0~:{.@:[) 23 b.~ ( (26 b.) AFRO ) 17 b.~ memr@:]) (0 1 , JINT) ,~ Getflagsad@:] 
  NB.  Verb.  Get flags from header of name.  Same inputs as Fullname.
  Getflagsad     =.  SZI + 1 { [: memr (0 4, JINT) ,~ symget@:<

NB.  Adverbs.  Permanent global & local (respectively) assigment.  That is, the names assigned cannot be reassigned.
is               =.  name (`({.;:'=:')) ("_) (` ( ((] [ 1 Readonly 0 {:: [ ) ".@:;)@:([ 3 assert  unassigned             @:{.)@:,)) (`(3 : '<5!:5{.;:''y''')) (`:6)
isL              =.  name (`({.;:'=.')) ("_) (` ( ((] [ 1 Readonly 0 {:: [ ) ".@:;)@:([ 3 assert (unassigned +. isGlobal)@:{.)@:,)) (`(3 : '<5!:5{.;:''y''')) (`:6)
  NB.  Monadic verb.  Determines whether name input is unassigned.
  unassigned     =.  _1 = nc
  NB.  Monadic verb.  Determines whether name input is global.
  NB.  See http://www.jsoftware.com/pipermail/beta/2006-July/001544.html
  NB.  or use http://www.jsoftware.com/svn/DanBron/trunk/environment/namescope.ijs
  isGlobal       =.  ] e. globalNames
    NB.  Ambivalent verb; returns all global names accessible from here without locale qualifier
    globalNames  =.  ;@:(3 : '<nl__y$0'"0)@:(, |.@:copath)@:coname@:(''"_)


NB.=== Interface ===
NB.  Global & local permanent assignment
is_z_            =:  'is' f.
isL_z_           =:  'isL' f.


NB.=== Usage ===
Note 'examples of use'

	NB. Simple use:  define a name.
	   G              NB.  Undefined
	|value error: G

	   G is 22        NB.  Define it
	22

	   G              NB.  Now it's 22.
	22

	   G =: 55        NB.  But it can't be redefined
	|read-only data
	|   G    =:55
	   	

	NB.  Similarly for local assignment
	   3 : ('L isL y';'L + 1') 8   
	9

	   L                             NB.  L only available within local scope
	|value error: L

	   3 : ('L isL y';'L =. 1') 8   NB.  Can't be redefined within local scope
	|read-only data
	|   L    =.1
	

	NB.  The adverbs try to protect you from overwriting previous assignments 
	NB.  which used the normal copulae
	   avg  =: +/ % #
	   avg is 45
	|domain error
	|       avg is 45


	NB.  And are even smart about allowing you to shadow globals with locals
	NB.  as you'd expect...
	   3 : 'avg isL 45' ''
	45

	   avg
	+/ % #
	   
	NB.  But because they're just adverbs, and not meta-syntactic, they can't
	NB.  protect you from everything...
	   msg =: 'hello'
	   msg is 'goodbye'
	goodbye

	   msg
	hello
	   hello
	goodbye

	   erase'msg hello'
	   
	NB.  So when you want to be absolutely safe, use the quoted form:
	   msg  =: 'hello'
	   'msg' is 'goodbye'
	|domain error
	|       'msg'is'goodbye'
	|[-0] 
	   
	   msg
	hello
	   hello
	|value error: hello
	   
	
	NB.  The boxed form also works
	   (<'msg') is 'goodbye'
	|domain error
	|       (<'msg')is'goodbye'
   
	NB.  But multiple assigments, evocations, etc, will almost certainly fail. 
	
	NB.  Also, while I believe the verbs should be entirely locale-safe
	NB.  (because I wrote them tacitly and used ". rather than some other
	NB.  mechanism), I haven't tested any cases.
)