NB. ===  Distribute Operators Over Gerunds ===
	
NB.  Given the formal name of a primitive operator,  doog  will derive 
NB.  an operator of the same class. When that derived operator is given
NB.  argument(s), it applies the primitive operator to each (pair of) 
NB.  verb(s) in the argument(s), and returns a gerund:
   doog =: adverb define
        M   =. a: 1 : m
        cm  =. conjunction = ncM =. nc {. ;: 'M'
        ncM : (  'g=.{.^:(1 -: #)@:}:' ; (cm#'(g u`[)') , '((,' ,(5!:5{.;:'m') , ')' , '<@; <)@,"0' , '(g ', (cm{'uv') ,'`])'  )
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
   Across       =:  First (;.1)~ (`1:) (`:6)


   NB.  Morever,  doog  extends this behavior (in two ways). Whereas 
   NB.  the J implementation restricted compositions with gerunds to the 
   NB.  forms (m@v u@n m@n), (m@:v u@:n m@:n), (m&:v u&:n m&:n), and  m&n ,
   NB.  doog  can distribute any conjunction. In particular,  '&.' doog 
   NB.  will probably find many uses.  See Test Block C.
   Each         =:  '&.' doog >
   AcrossBoxed  =:  Each Across


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
  (  +:`-:`*:`>: Across       i. 4*3 )                  -:   ,(+:0+a    ),.(-:1+a     ),.(*:2+a     ),.(>:3+a=.4*i.3 )

  NB.  Block C:  Distribute arbitrary conjunctions.
  (  +:`-:`*:`%: AcrossBoxed  (1+i.4)  *&.>   <i.3 3 )  -:    (+:1*a    ); (-:2*a     ); (*:3*a     ); (%:4*a=.i.3 3 )

  NB.  Block D:  Distribute adverbs, too.
  (      +`*     Over Across  i. 4 10x               )  -:    (+/0+i.10x), (*/10+i.10x), (+/20+i.10x), (*/30+i.10x   )

  NB.  Block E:  Put it all together for a nice effect.
  ( 1 10 *`^     AcrossDyad   5 3                    )  -:    (1*5      ), (10^3      )
)


NB.  Other uses
0 0$ noun define
  require 'task'
  pc =: shell 'wget http://www.jsoftware.com/svn/DanBron/trunk/environment/primitive_classes.ijs -q -O -'
  0!:0 (#~ [: -. (2# LF) E. ])^:_ (=&CR)`(,:&LF)} pc

  NB.  List of all J verbs, grouped by their rank.
  (~.<"1 n),:(,. PRIM_VERBS) </.~ n=. PRIM_VERBS 'b.' doog (`:0) 0

  NB.  List of all J verbs and their inverses.
  (a~:a:)#PRIM_VERBS  ,. a =. (<'@' doog (PRIM_VERBS 'b.' doog '::' doog (''"_) )) (`:0) _1
)