NB. ===  Distribute Operators Over Gerunds ===
	
NB. Given the formal name of a primitive operator, `doog` will derive an operator of the same class.
NB. The derived operator is related to the one named, except that it is extended to gerunds.  
NB.
NB. Much in the same way thast verbs abstract away the "arrayness" of its noun arguments, 
NB. so `doog` abstracts away the "arrayness" of arguments to operators.  Arrays of operator 
NB. arguments are, of course, gerunds.
NB.
NB. The result of a `doog`-derived operator is always a gerund, and it may optionally be given 
NB. an array argument.  If it is not, its output is simply the atomic representation of the output 
NB. of the primitive operator.

However, if one (or both) of the arguments to the derived operator is a gerund, it applies the operation to each verb in the gerund, or between each pair of verbs in the case of a `doog`-derived conjunction with two gerund arguments. 
   doog =: adverb define
        M    =.  a: 1 : m
        cm   =.  conjunction = ncM =. nc {. ;: 'M'
        lrep =.  '''(u ,&<~ 5!:1{.;:''''u'''') {::~ *./ 3 : (''''y 5!:0'''';''''1'''') :: 0:"0 u'';''{. u`['''
        prmb =.  , ' 1 :  (((noun,verb) i. nc{.;:''' , ')',~ lrep ,~  ''' ) {:: ' ,~ ]
        ncM : (  ( cm# 'u =.' ,prmb 'u' ) ; ((, ' =.' , prmb) uv) ; (cm#'u'), ' ((,' ,(5!:5{.;:'m') , ')' , '<@; <)@,"0 ' , uv =. cm{'uv')
)

   NB.  This adverb emulates the undocumented, 
   NB.  pre-J601c behavior of compositions with gerund:
   NB.  See Test Block A.
   At           =:  '@'  doog
   Atop         =:  '@:' doog


   NB. The adverb  Across  provides a mechanism to apply succesive verbs 
   NB. (a gerund) to a corresponding list of nouns (the gerund will be 
   NB. extended cyclically if required). See Test Block B.
   First        =:  Atop  {.
   Across       =:  First (;.2)~ (`1:) (`:6)
   Ax           =:  1 : 'u Across : (u;._2)'

   NB.  Morever,  doog  extends this behavior (in two ways). Whereas 
   NB.  the J implementation restricted compositions with gerunds to the 
   NB.  forms (m@v u@n m@n), (m@:v u@:n m@:n), (m&:v u&:n m&:n), and  m&n ,
   NB.  doog  can distribute any conjunction. In particular,  '&.' doog 
   NB.  will probably find many uses.  See Test Block C.
   Each         =:  '&.' doog >
   AcrossBoxed  =:  Each Across
   BxAx         =:  (< Atop) Across
   Abx          =:  Each Ax
  
   NB.  The second extension  doog  provides is that it can distribute 
   NB.  adverbs as well as conjunctions.  See Test Block D.
   Over         =:  '/' doog 


   NB.  Put it all together for a nice effect: we can now define
   NB.  a dyadic  Across  (apply successive verbs dyadically between
   NB.  successive item pairs ).  See Test Block E.
   Every        =:  '&:' doog >
   AcrossDyad   =:  Over Every Across ( @:(,&:<"_1) )

NB.  Test cases
testOnLoad      =. 0  NB.  0 disables, 1 enables.
0!:(+:testOnLoad) noun define  

  NB.  Block A:  Emulate pre-J601c compositions with gerund
  1:    At  3:      -:   {. 1:@3:`[    
  1:`2: At  3:      -:      1:@3:`(2:@3:)
  1:    At (3:`4:)  -:      1:@3:`(1:@4:) 
  1:`2: At (3:`4:)  -:      1:@3:`(2:@4:)

  NB.  Block B:  Apply successive verbs to succesive items.
  (  +:`-:`*:`>: Across       i. 4*3 )                  -:   ,( +:0+a ),.( -: 1+a ),.( *: 2+a ),.( >: 3+a=.4*i.3 )

  NB.  Block C:  Distribute arbitrary conjunctions.
  (  +:`-:`*:`%: AcrossBoxed  (1+i.4)  *&.>   <i.3 3 )  -:    ( +:1*a ); ( -: 2*a ); ( *: 3*a ); ( %: 4*a=.i.3 3 )

  NB.  Block D:  Distribute adverbs, too.
  (      +`*     Over Across  i. 4 10x               )  -:    ( +/0+a ), ( */10+a ), ( +/20+a ), ( */30+a=.i.10x )

  NB.  Block E:  Put it all together for a nice effect.
  ( 1 10 *`^     AcrossDyad   5 3                    )  -:    ( 1*5   ), ( 10^3   )
)

NB.  Other uses
0 0$ noun define
  require 'task'
  pc =: shell 'wget http://www.jsoftware.com/svn/DanBron/trunk/environment/primitive_classes.ijs -q -O -'
  0!:0 (#~ [: -. (2# LF) E. ])^:_ (=&CR)`(,:&LF)} pc

  NB.  List of all J verbs, grouped by their rank.
  BY_RANK      =: (~.<"1 n),:(,. PRIM_VERBS) </.~ n=. PRIM_VERBS 'b.' doog (`:0) 0

  NB.  List of all J verbs and their inverses.
  WITH_INVERSE  =: (a~:a:)#PRIM_VERBS  ,. a =. (<'@' doog (PRIM_VERBS 'b.' doog '::' doog (''"_) )) (`:0) _1

  
   NB. Given a description of the columns,  x,  and fixed-width line-delimited data,  yu,  
   NB. the verb  parse  will return a J object (numbered locale) with one name per
   NB. column.  
   NB.
   NB. The relevance is that we can use the definitions in this script
   NB. to apply to each column a verb that knows how to process that column
   NB. (e.g. numeric columns are turned into numbers,  string columns are turned into
   NB. integers using  s: , etc).
   NB.
   NB. This is an efficient method for parsing fixed-width files.  I may make a 
   NB. seperate script for it.
   parse =: dyad define
   	itm              =.  [: <"_1@:|: _3 ]\ ]
   	'nam typ len'    =.  itm , x

   	'vbs tps dfs'    =.  itm   num`(<'#')`(0 ". ])   `str`(<'"')`(6: s: s:)
   	('`',;:^:_1 vbs) =.  dfs

   	vrb              =.  < Atop vbs`] {~  tps i. typ
   	ctr              =.  ( '' ; (<: e.~ [: i. >./) +/\ 1 + ;len  )&$: :(vrb Ax)  NB. 1 + for the field delimiters

   	Q                =.  cocreate ''
   	v__Q             =.  cocreate ''

   	('`' , ;:^:_1 vbs , L: 0 '__v__Q')  =. dfs
   	tbl__Q           =.  ,.&:>/ (nam , L: 0 '__Q') =. ctr (]\~ -@# % [: +/ LF&=) y NB. _ , 1 + {: $ y

    Q
NB. Closing Paren --> )

   NB.  Column spec format is  name;type;width
   columns =.  _3 ]\ 'acct';'#';2   ;'sub';'#';3 ;  'name';'"';6  NB. # means numeric, "  means string. 
   fw_data =.  noun define NB.  Fixed width data, columns correspond to above description.
	 0   0 Dan   
	 1  _1 Henry 
	 2  _2 Oleg  
	 3  _3 Raul  
	 4  _4 Roger 
	10 _10 Lam   
	11 _11 Bjorn 
	12 _12 Tuttle
	13 _13 Eric  
	14 _14 Devon 
NB. Closing Paren -->)
   NB. fw_data =.  , LF ,.~ (,. ' '&,.)&:>/(<@:> ;: 'Dan Henry Oleg Raul Roger Lam Bjorn Tuttle Eric Devon'),~ ":@:,.&.> (; -), 0 10 +/ i. 5

   T  =: columns parse fw_data
   tbl__T
 0   0  1
 1  _1  2
 2  _2  3
 3  _3  4
 4  _4  5
10 _10  6
11 _11  7
12 _12  8
13 _13  9
14 _14 10
   acct__T
0 1 2 3 4 10 11 12 13 14
   name__T
1 2 3 4 5 6 7 8 9 10
   str__v__T^:_1  name__T
+---+-----+----+----+-----+---+-----+------+----+-----+
|Dan|Henry|Oleg|Raul|Roger|Lam|Bjorn|Tuttle|Eric|Devon|
+---+-----+----+----+-----+---+-----+------+----+-----+

)

   NB.  If you're not Dan Bron, ignore these two definitions for now.
   NB.  If you're curious, it's related to the verb parse in the 
   NB.  "other uses" section above.
   Encap        =: adverb define
		4 : (1 |. 'm[(''__m'',L:0~{.x)=. ({:x) BxAx y';'m =. ',5!:5{.;:'m' )
)
   encap        =: dyad define
   x (cocreate '') Encap&|: y
)ye