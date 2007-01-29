require'keyfiles'

NB.  B(ind).  Conjunction.  Same as bind_z_ .
b =: bind

NB.  Cut names.  Monadic verb.  Convience function. Trivial.
cn        =:  ;:^:(0 = L.)

NB.  Locales.  Monadic verb.  Returns a list of locales, similar to conl.
NB.  If the input is literal or boxed, the output is  cn y ,
NB.  this allows you to specify precisely what locales you want returned.
NB.  If the input is empty  ,  the output is the output of  conl 0 1  .
NB.  If the input is boolean,  the output is the output of  conl  .
NB.  If the input is 2      ,  the output is the output of  conl 0 1 , 
NB.  less the locales defined by the J library, and the locales derived 
NB.  from them (specifically, it's conl 0 1  without  j, z, jijs, or 
NB.  any jijs objects).
locales   =:  cn@:( ($: b 0 1)`( $: b ''   -. (;:'j z') , (#~ ({.;:'jijs') = {."1@:copath)@:conl b 1 )`(  conl^:([: *./ 0 1 e.~ ])  )@.(('';2) i. <) )

NB.  Names list.  Dyadic verb.  Names in locales x of nameclasses y.
namesl    =:  4 : '< nl__x y'"0 _

NB.  Slap.  Dyadic verb.  Names  y  qualified with locales  x .
slap      =:  (] , '_' , [ , '_'"_)^:(*@:#@:]) L: 0 

NB.  Allnames.  Ambivalent verb. Default LHA is '',
NB.  x is input to locales, which becomes the LHA to namesl,
NB.  y is RHA to namesl.  Output is a list of fully qualified 
NB.  names of classes y in locales specified by x.
allnames  =:  ($:~ ''"_) : ( ;@:((] slap namesl~) locales)~ )

NB.  Fully qualified names.  Monadic verb.  Invertible.  Input is a list of names,
NB.  output is those names qualified with their locales.  Names already qualified are left untouched,
NB.  bare names are qualified with their proper locales.
fqn       =:  ((] 4 : 'x}y' [ ,: ] #^:_1 ( ([ slap~ ] {~ [: i.&1"1@:|: [ e. S: 1 (namesl ~.@:nc)~) (, copath)@:coname b '' )@:#~) '_' ~: {:&>) @:cn  :.  nqf
NB.  Inverse of FQN, splits fully qualified names into Nx2 table of bare-name ,. locale.
nqf       =:  (([: ((#~ [: +./\. '_' ~: ])@:[ ; [: coname b '' ^:(0 -: #) ". :: (''"_)@:])&>/  [ split~ 2 i:~ +/\@:])`([: (; -.&'_')&>/ [ split~ 2 i:~ +/\.@:])@.({:@:]) '_' = ])&> :. fqn

NB. lrep      =:  [: toHOST@:; <@:,&LF@:(;:^:_1)"1@((1 0 1 #!.({.;:'=:')^:_1"1 ])@:,. <@(5!:5))@:fqn
NB. bkup      =:  (fwrite~ lrep)~

NB.  UnKnown.  Monadic verb. Input is list of names, output is boolean vector indicating which names were
NB.  not directly defined in a script.
uk        =: _1 = 4!:4

NB.  Immex Names.  Ambivalent verb.  Default x is 2. 
NB.  Inputs the same as allnames .  Output is subset of the 
NB.  output of allnames -- that subset being those names defined
NB.  in a user script (this is different from "not directly defined in 
NB.  any script;  an example is the names defined when you press CTRL+F 
NB.  in the J IDE).
immedNms  =: 2&$: :  (  nqf@:(#~ uk)@:allnames )
immexn    =: <@:;"1@:(,&'_'&.>)@:(#~ (] ([ e. ] #~ (a:,cn tolower 'user temp') e.~ [: , '' ((<@:tolower;.0~ 1 ,: _1 + i.&'\')&>)@:reduce_prefix@:( (4!:4) :: (''"_) { 4!:3 b '')@:({.@:#~ -.@:uk)@:allnames~"1 0 ]) ~.)@:({:"1))@:immedNms

NB.  Since Last.  Monadic verb, argument ignored.  Output
NB.  is a list of names changed since the last invocation
NB.  of this verb.
sinceLast =:  4!:5 b 1

NB.  Unstored.  Dyadic verb.  Input is the same as immexn,
NB.  output is a subset of the output of immexn, that 
NB.  subset being the names which have changed since the 
NB.  last invocation of sinceLast.
unstored  =: immexn  ([ #~ e.) sinceLast 


NB.  Save Names.  Dyadic verb.  x is a list of names,
NB.  y is a filename.  Side-effect output is definitions
NB.  of  x  are stored in keyfile  y.
saveNames =:  ((5!:1)@:] keywrite ,)"0~  (<@:[ keycreate^:(-.@:fexist))

NB.  Load Names.  Monadic verb.  Input is filename.  Output is
NB.  boolean list indicating which names were imported successfully.
NB.  Side effect output is names in keyfile y are defined in the session.
loadNames =: < (] 4 : ('(x) =: y 5!:0';'1') :: 0:&>  keyread"1@:,.) keydir


NB.  Save Delta.  Adverb.  m is a filename. 
NB.  Outpu is a dervied verb with the same inputs 
NB.  ss the same as unstored.  Side effect output
NB.  of derived verb is is names returned by unstored
NB.  are saved in keyfile m  .
saveDelta =:  (saveNames&) (@:unstored)