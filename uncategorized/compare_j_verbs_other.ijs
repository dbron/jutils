noun define
	   NB.  Some utils first -- see my past JForum messages for documentation
	   sr               =:  2 : '(m.&=)`(,:&n.) } y.'
	   arbCut           =:  <@:#@:[ }.&.> [ (E. <;.1 ]) ,
	   join             =:  -@:#@:[ }. ;@:(,&.> boxopen)~


	   NB.  Conj. to extract the fields from the input,
	   NB.  Apply a user-defined function, and then
	   NB.  expand back.
	   mutateFields     =:  2 : 'u.&.(n.&arbCut :. (n.&join))'

	   NB.  Replace empty fields (comma-delimited) with the word 'NULL'
	   bron             =:  emptiesToNulls =:  a: sr (<'NULL') mutateFields  ','

	   day              =:  nrpl =: 3 : 0
		     }.;(<',NULL')(I.@((<,',')&=)@])}<;.1',',y.
	   )

	   burke            =:  rplc&(',,';',NULL,')@:(rplc&(',,,';',NULL,NULL,'))

	   chene            =:  verb define
	   	     w =: y. , ','
	   	     y=. (w=',') < ;.2 w
	   	     }: ; {."1 (y = < , ',') |."0 1 y ,. < 'NULL,'
	   )

	   algos            =:  bron`burke`day`chene

	   smallInput       =:  'wild,,,world,,,is,,here'
	   bigInput         =:  1e4 $ smallInput

	   NB.  Make sure all outputs are the same
	   assert (-: 1&|.) algos 128!:2 each <smallInput


	   smallInputs      =: algos 1e4 &ts @:, &> < 5!:5 <'smallInput'
	   bigInputs        =: algos      ts @:, &> < 5!:5 <'bigInput'

	   require 'numeric'
	   compare          =:   (,. [: <"> (0.01&round@:%"1 <./)) /: ]
	   smoutput algos compare smallInputs
	   smoutput algos compare bigInputs

)


noun define
	   NB.  4!:5  [ 1

	   lanzavecchia  =:  3&(  {. -@i.@#  |.!.0"0 1  ]           )
	   holmes        =:  3&(  (|."1@(}.@]^:[ |.)~ i.)~          )
	   lam           =:  3&(  -@i.@[ |.!.0"0 1 ]                )

	   bron0         =:      (3&{.)@:(]\.)&.:(|."1)
	   bron1         =:      >@:(3&{.)@:(<\.)&.:(|."1)
	   bron2         =:  3&( |."1@:>@:({. <\.@:|.)              )
	   bron3         =:  3&( (] {."0 1~ #@:] -~ i.@:[)&.:(|."1) )
       bron4         =:  3&(4 : '({. y.) (<0 #~ >: # $ y.) } 0 (((; i.)&.> i.&.<: x.) ) } (- i. x.) |."_1 x. $ ,: y.')
       bron5         =:  3&(4 : ('z =. 0 (((; i.)&.> i.&.<: x.) ) } z =. (- i. x.) |."_1 x. $ ,: y.';'z =. ({. y.) (<0 #~ # $ z) } z'))
       bron6         =:  3&(4 : ('z =. (- i. x.) |."_1 x. $ ,: y.';'z =. 0 (((; i.)&.> i.&.<: x.) ) } z';'z =. ({. y.) (<0 #~ # $ z) } z'))
       bron7         =:  3&(4 : ('z =. x. $ ,: y.';'z =. (- i. x.) |."_1 z';'z =. 0 (((; i.)&.> i.&.<: x.) ) } z';'z =. ({. y.) (<0 #~ # $ z) } z'))
	   bron8         =:  3&(-@:#@:] {.&> -@:[ |.@:{. <\@:])
	   bron9         =:  3&(-@:#@:] >@:({.&.>) -@:[ |.@:{. <\@:])

	   hui           =:  3&( 4 : '(#y.) {."1 (x.,_1+x.+#y.) $ y.,x.$0')
	   huiTacit      =:  3&(#@:] {."1 ([ , <:@ (+ #)) $ ] , [ $ 0: )

	   NB. algos     =:  0 {:: 4!:5&.> i. _2
	   NB.  ger      =:  1 : '(< S: 0) 5!:2{.;:''u.'''
	   NB.  algos    =:  (lanzavecchia holmes lam bron0 bron1 bron2 bron3 bron4 bron5 bron6 bron7 bron8 bron9 hui) ger

	   algos         =:  lanzavecchia`holmes`lam`bron0`bron1`bron2`bron3`bron4`bron5`bron6`bron7`bron8`bron9`hui`huiTacit
	   algos         =:  lam`huiTacit`hui`bron3


	   smallInput    =:  1 1 2 3 4
	   bigInput      =:  600  $ smallInput
	   hugeInput     =:  6000 $ smallInput


	   assert (-: 1&|.) algos 128!:2 each <smallInput

	   smallInputs   =:  algos 1e4 & ts @:, &> < ' ' , 5!:5 <'smallInput'
	   bigInputs     =:  algos 100 & ts @:, &> < ' ' , 5!:5 <'bigInput'
	   hugeInputs    =:  algos  10 & ts @:, &> < ' ' , 5!:5 <'hugeInput'


	   require 'numeric'
	   compare       =:   (;: 'Algo Time Space')&,@: ((,. [: <"> (0.01&round@:%"1 <./)) /: ])

	   NVtext algos compare smallInputs  NB.  Scaled comparison: lower is better, 1 is best.
	   NVtext algos compare bigInputs
	   NVtext algos compare hugeInputs
)

noun define
	   4!:5  [ 1

	     nub_sieve  =: ~:
	     djb        =: ~: _1&|.
	     bb         =: 1:,2&(~:/\)
	     partition  =: 1: , [: -. }. -:"_1 }:
	     reb        =: 1: , }. ~: }:

	   algos      =:  ({.~ -:&'_'@:{: * i:&1@:(1 0&E.)@:=&'_')&.> 0 {:: 4!:5&.> i. _2 NB. nub_sieve`djb`bb`partition`reb


	   smallInput  =:  3 3 3 3 6 6 6 8 8 4 4 1 1 1 1 1
	   bigInput    =:  /:~ 600 $ smallInput

	   assert (-: 1&|.) algos 128!:2 each <smallInput

	   smallInputs =:  algos 1e4 & ts @:, &> < ' ' , 5!:5 <'smallInput'
	   bigInputs   =:  algos 100 & ts @:, &> < ' ' , 5!:5 <'bigInput'

	   require 'numeric'
	   compare     =:   (;: 'Algo Time Space')&,@: ((,. [: <"> (0.01&round@:%"1 <./)) /: ])

	   NVtext algos compare smallInputs  NB.  Scaled comparison: lower is better, 1 is best.
	   NVtext algos compare bigInputs
)

noun define
	   require 'numeric'  NB.  For 'round'


	   NB.  Utils
	   strip_loc  =:  (}.~ ({: * # -~ i:&1@:(1 0&E.))@:=&'_')&.>@:(;:^:(0: -: L.))
	   compare    =:  (;: 'Algo Time Space')&,@: ((,. [: <"> (0.01&round@:%"1 <./)) /: ])
	   nvtext     =:  }:@:,@:(,.&LF)@:((<0 1)&C.)@:((,. TAB&,.)&:>/)@:('-'&,&.>)@:(<@:>"1)@:|:@:(":&.>)



   	   4!:5  [ 1  NB.  Collect algorithms

   	   nub_sieve  =: ~:
   	   djb        =: ~: _1&|.
	   rdm        =: ~: _1&(|.!.0)
NB.	   djb_fix0   =:  1: 0} djb f.
NB.	   djb_fix1   =:  1: 0} ::] djb f.
NB.	   djb_fix2   =: 3 : ('y. =. djb y.';'y. =. 1 (0}) y.')
   	   bb         =: 1:,2&(~:/\)
   	   partition  =: 1: , [: -. }. -:"_1 }:
   	   reb        =: 1: , }. ~: }:

        NB. nub_sieve`djb`bb`partition`reb
   	   algos      =:  strip_loc 0 {:: 4!:5&.> i. _2



   	   smallInput  =:  3 3 3 3 6 6 6 8 8 4 4 1 1 1 1 1
   	   bigInput    =:  /:~ 600 $ smallInput    NB.  Input is expected sorted.
       #hugeInput  =: (# i.) <.2^11

   	   assert (-: 1&|.) algos 128!:2 each <smallInput  NB.  Ensure agreement

   	   smallInputs =:  algos 1e4 & ts @:, &> < ' ' , 5!:5 <'smallInput'
   	   bigInputs   =:  algos 100 & ts @:, &> < ' ' , 5!:5 <'bigInput'
	   hugeInputs  =:  algos 1 & ts :: 0: @:, &> < ' ' , 5!:5 <'hugeInput'



   	   smoutput nvtext algos compare smallInputs  NB.  Scaled comparison: lower is better, 1 is best.

   	   smoutput nvtext algos compare bigInputs

	   smoutput nvtext algos compare hugeInputs
)

noun define
	   require 'numeric'  NB.  For 'round'


	   NB.  Utils
	   strip_loc  =:  (}.~ ({: * # -~ i:&1@:(1 0&E.))@:=&'_')&.>@:(;:^:(0: -: L.))
	   compare    =:  (;: 'Algo Time Space')&,@: ((,. [: <"> (0.01&round@:%"1 <./)) /: ])
	   nvtext     =:  }:@:,@:(,.&LF)@:((<0 1)&C.)@:((,. TAB&,.)&:>/)@:('-'&,&.>)@:(<@:>"1)@:|:@:(":&.>)



   	   4!:5  [ 1  NB.  Collect algorithms

   	   fE         =:  verb : '- y.'
   	   FT         =:  -
   
   	   algos      =:  strip_loc 0 {:: 4!:5&.> i. _2



   	   smallInput  =:  i. 100
   	   bigInput    =:  6e4 $ smallInput

   	   assert (-: 1&|.) algos 128!:2 each <smallInput  NB.  Ensure agreement

   	   smallInputs =:  algos 1e4 & ts @:, &> < ' ' , 5!:5 <'smallInput'
   	   bigInputs   =:  algos 100 & ts @:, &> < ' ' , 5!:5 <'bigInput'



   	   smoutput nvtext algos compare smallInputs  NB.  Scaled comparison: lower is better, 1 is best.

   	   smoutput nvtext algos compare bigInputs
)


noun define
	   require 'numeric'  NB.  For 'round'


	   NB.  Utils
	   strip_loc  =:  (}.~ ({: * # -~ i:&1@:(1 0&E.))@:=&'_')&.>@:(;:^:(0: -: L.))
	   compare    =:  (;: 'Algo Time Space')&,@: ((,. [: <"> (0.01&round@:%"1 <./)) /: ])
	   nvtext     =:  }:@:,@:(,.&LF)@:((<0 1)&C.)@:((,. TAB&,.)&:>/)@:('-'&,&.>)@:(<@:>"1)@:|:@:(":&.>)

   	   p          =.  ?. 10 # 10 [ob=.10 10 $ 0


   	   4!:5  [ 1  NB.  Collect algorithms

   	   bron       =:  p&(4 : 'x. (<"1 x. ,.~ i. # x.) } y.')
   	   miller     =:  p&([`(i.@#@[ <@,"0 [)`]})
	   rich       =:  p&([`[`]}"0 1)
   
   	   algos      =:  strip_loc 0 {:: 4!:5&.> i. _2



   	   smallInput  =:  ob
   	   bigInput    =:  6e3 $"1 ob

   	   assert (-: 1&|.) algos 128!:2 each <smallInput  NB.  Ensure agreement

   	   smallInputs =:  algos 1e4 & ts @:, &> < ' ' , 5!:5 <'smallInput'
   	   bigInputs   =:  algos 100 & ts @:, &> < ' ' , 5!:5 <'bigInput'



   	   smoutput nvtextb algos compare smallInputs  NB.  Scaled comparison: lower is better, 1 is best.

   	   smoutput nvtextb algos compare bigInputs
)


   NB.  Load in the J comparison utils
   require'cmprj'

   NB.  Subfuncs for algorithms

   NB.  Subfunc for mill2
   next        =.  (_1: ^ {.@[) * {:@[ + (| + 0: <. *)@>@]

   NB.  Subfunc for rich1
   require 'hui'  NB.  I. :(Roger's J model of dyad I.)
NB.   I           =.  Idot f.

   NB.  Subfuncs for day0
   NB. this works on I. x and I.y and returns (eg) I. x hui0 y
   NB. tagging on #x and #y to correct for possible end errors
   h =: /:@ NB. sort order of the join of the two index arrays
   NB. <#[ later picks out the indices of x from this ordering
   k =: * (> (0: ,~ }.)) NB. select only last ones,

	NB.  Collect algorithms
   4!:5  [ 1



   hui0        =:  ; @ (<@(</\&.|.);.2)~
   hui1        =:  (+. # {. 1:)@] ;@(<@(</\);.1)&.|. [
   hui2        =:  (+. # {. 1:)@] ;@(<@(</\);.2)&.|. [

   mill0       =:  1: < 4&{"1@((5;2{."0(4#4)#:6 103 6 119)&;:@(+ +:))&.|.
   mill1       =:  1: < 4&{"1@((5;2{."0(4#4)#:4$6 103)&;:@(+ +:))&.|.
   mill2       =:  0: |.@(> {.@>) [: (next f. {:@])&.>/&|.\ |.@:(<"1@,.)

   rich0       =:  1: ` ((#  |.!.0@(>./\)@(* i.@#))~) ` (#@[ $ 0:) } "1
   rich1       =:  1: ` ((<:@(Idot  <:) { [)&Idot ) ` (#@[ $ 0:) } "1

   day0        =: 13 : '}:((I.x.),#x.)([ {~ h (k@:< # [) #@[) (I.y.),#y.' f.

   hell0       =:  4 : 0
     g=. +/\ y.
     i=. x. # g
     j=.(# i )$( 2 (~:/)\ i ),1
     x. #^:_1 j
)
  

   NB.  Finished collecting
   algoNs      =:  strip_loc 0 {:: 4!:5&.> i. _2
   algos       =:  algoNs ,&.> <'&:>/"1'


   NB.  Some data.  Boolean lists.  Just wrapped so the mailer won't.
   require 'jf_fmt'  NB.  For jf_parse
   smallInput  =:  ({:"1)@:>@:({:"1) input =:  jf_parse }: noun define
A:
		  x              y
	00100100101001 00010010010010
	01010101001000 00100000010001	
	10001000000000 00010000000001
	10000001000100 00010010001001
 
B:
          x              y
	00000000001001 00000000000100
	00010101000100 10001010100010
	01000101010100 00100010101010
	10000001000100 01001000100010
)

   NB.  Record differences in results of algorithms
   RPT         =:  ({.&> {."1 input) catRpts algos rpts smallInput 
   smoutput RPT


   NB.  Record various aspects of the algorithms.
   NB.  (time, space, etc.)
   NB.smallAspects=:  algos 1e4 & ts :: (_ _"_) @:, &> < ' smallInput'
smallAspects=:  algos 12 & ts :: (_ _"_) @:, &> < ' smallInput'

NB.   bigInput    =:  4e4 $ each smallInput
NB.   bigAspects  =:  algos  10 & ts :: (_ _"_) @:, &> < '  bigInput'


   NB.  Compare aspects to scale.  The best scores a 1; all worse 
   NB.  are reported as multiples of the best.  Hence lower is better, 
   NB.  1 is best.
   smoutput nvtext algoNs compare smallAspects
   smoutput ''
   smoutput nvtext algoNs compare bigAspects