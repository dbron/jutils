cocurrent'jmf'

NB.  B(ind).  Conjunction.  Same as bind_z_ .
b         =:  bind

NB.  Cut names.  Monadic verb.  Convenience function. Trivial.
cn        =:  ;:^:(0 = L.)

NB.  Locales.  Monadic verb.  Returns a list of locales, similar to conl.
NB.  If the input is literal or boxed, the output is  cn y ,this allows 
NB.  you to specify precisely what locales you want returned.
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

NB.  Allnames.  Ambivalent verb. Default LHA is '',  x is input to 
NB.  locales, whose output becomes the LHA to  namesl .  
NB.  y is RHA to namesl.  Output is a list of fully qualified names 
NB.  of classes y in locales specified by x.
allnames  =:  ($:~ ''"_) : ( ;@:((] slap namesl~) locales)~ )


NB.  Given an argument  u  (either noun or verb), returns
NB.  the atomic rep of  u"_ .
norv =: 1 : '(<(<,''"''),<(5!:1{.;:''u''),<(<,''0''),<_)'

NB.  Given a noun y, get its pointer (pointer of header to data).
NB.
NB.  Right now, you can only  use it to get pointers to nouns, not 
NB.  verbs, adverbs or conjs. In the future, I may create an adverb 
NB.  (with the same interface as 'fixlocals') to get pointers to those
NB.  other parts of speech.
NB.
NB.  A further restriction is that I know the verb works for unmapped nouns 
NB.  and for directly mapped nouns  (where the JMF file contains both the 
NB.  header and the data) but I'm not positive that it works for indirectly
NB.  mapped nouns (where the symbol table points to a header in main memory
NB.  which points to the data).  Using it against indirectly mapped nouns
NB.  may crash J.  Using on bad arguments may crash J.  I'm not sure
NB.  what those bad arguments would be, but you've been warned;  15!:6 is 
NB.  undocumented.
get_ref =: 3 : '{. memr JINT ,~ 4 1 ,~ 15!:6 ;:''y''' : ($:@:])

NB.  Conjunction to work on nouns embedded in atomic reps.
NB.  u  is  verb to act on embedded nouns, v is verb to handle
NB.  leaves which are not nouns (primitives).  Derived verb
NB.  is monadic and y is the atomic rep of an entity (5!:1 style)
NB.  x will always be  (,'0')
NB.
NB.  In a future version you may be able to work on any embedded type
NB.  (verbs, operators, trains, bidents, bonded conjs, trains of adverbs...
NB.  )
NB.
NB.  Could use a  S: (L. m) strategy like in isRefTo, but then we'd lose
NB.  the ability to modify the noun reference in-place.
nouner =: 2 : 'v`($:`(u&>/)@.((<,''0'') -: {.))@.(0 < L.)' 

NB.  Verb to copy a noun BY VALUE.  That is, ]y may have special code such that
NB.  (-:&get_ref ]) y .  This is also true of other  f y  .  But, as of J6.01c,
NB.  a:{ y  always takes a copy of y .  This is useful for safely copying mapped
NB.  nouns, so you can manipulate them as data without clobbering the underlying 
NB.  file.  This non-optimization is undocumented and may be changed in any future
NB.  release.  If that happens, change this verb.
copyByVal =: a:&{


NB.  Adverb:  given a noun argument m, derive a verb which indicates whether its
NB.  argument  y  refers to the same block of memory as  n  .
NB.
NB.  In a future version, this may not be restricted to noun arguments.
isRefTo =: 1 : '(get_ref m) e.~ get_ref S: (L.m)'    NB.  (,get_ref m) -: get_ref

NB.  Adverb like isRefTo, but works on a (list of) atomic rep(s),
NB.  recursively, indicating whether a reference to the noun  m  
NB.  is embedded therein.
mapRefr =: 1 : '+./@:          (m isRefTo   nouner 0:)& >'
   
NB.  Adverb like mapRefr, but takes a user-defined action 
NB.  on the embedded reference to  m  within a (list of) atomic reps.
NB.  The noun argument  m  is either  uh_COPY  or   uh_CHANGE;u  .  
NB.  If it's simple  uh_COPY, then the references are copied-by-value, 
NB.  leaving the atomic rep unchanged except that it no longer refers 
NB.  to the noun  n .
NB.
NB.  If m is  uh_CHANGE;u  then if  u  is the atomic rep of a verb, the references 
NB.  to n are replaced the result of that verb on that reference 
NB.  (which, in certain cases, may leave the reference unchanged.  
NB.  The verb  ]  is such a special case).  
NB.  If u is any other noun, it is  treated as the verb u"_ so references 
NB.  to n are replaced by that noun (not yet implemented).
mapChng =: conjunction define
 'N R'=. 2{.boxopen n
  v =. (<R)`copyByVal@.(N-:uh_COPY)  NB.  Very important to name this v

  (,&< v^:(m isRefTo)) nouner ]  &.>
)


NB.  DO NOT USE uh_COPY or uh_CHANGE yet. 
NB.  J has bugs that cause uh_COPY to crash the interpreter
NB.  and uh_CHANGE to hang it.  
NB.  
NB.  Even if J did not have bugs, the current implementation
NB.  is limited.  
NB.
NB.    If it encounters (recusively) the atomic rep of a boxed 
NB.    noun which itself isn't mapped, but one of component boxes 
NB.    is or recursively contanis such a reference, that reference 
NB.    will not be touched (i.e. not replaced with a copy).
NB.
NB.  In a future version, I may do something like:
NB.  (boxed_noun_name) =: (3 : 'a:{y' path {:: boxed_noun_name~) }:: boxed_noun_name~

NB.  *******************************************************
NB.  Public names start here.  Will be exported to locale z
4!:5&.> i.2

NB.  Enumeration of LHAs to unmaphard and unmapallhard
(       uhs=.'uh_'   ,L:0 uh_ENUM)  =: uh_RC =: i.#uh_ENUM =: ;:'LEAVE COPY CHANGE ERASE'
uh_type                             =: ;:^:(0 = L.) ,. uh_ENUM {~ uh_RC i. ]
uh_DEFAULT                          =: uh_ERASE


NB.  Like unmap, but tries to identify and remove aliases
NB.  of the mapped noun named in y.
unmaphard =: uh_DEFAULT&$: : (dyad define"0 1)
   y  =. fullname_jmf_ > {. cn y

   NB.! Report this bug (?)
   NB.  For some reason (#~ [: y~ mapRefr 5!:1) an=. ...  gives different 
   NB.  results from   an #~ y~ mapRefr 5!:1 an=. ...  
   NB.  and  (#~ y~ mapRefr)  5!:1 an =.   gives a domain error when it shouldn't.
   NB.
   NB.  DO NOT assign  5!:1 an  to anything -- that'll create a new reference
   NB.  to  y  .   Maybe that's not a problem if you erase the name assigned
   NB.  before you do unmap_jmf_  (but it's not worth finding out.)
   NB.  
   NB.  This cavaet applies equally well to any names local to definitions
   NB.  downstack:  if you have a local refernce to a mapped array
   NB.  this function will fail to delete it (I know of no way to interrogate
   NB.  local namespaces).
   an =. ({.;:y) -.~ an #~ (y~ mapRefr) 5!:1 an=.allnames ''   

   select. x [ 'x r' =. 2 {. boxopen x
       case. uh_LEAVE do.
       case. uh_ERASE do.
          erase an
       case. uh_COPY  do.
          (an) =: y~ mapChng uh_COPY 5!:1 an
       case. uh_CHANGE do.
          (an) =: y~ mapChng (x;<r norv) 5!:1 an
       case. do.
            assert. 0 [ x e. uh_ENUM
   end.


   (unmap_jmf_^:(-.x-:uh_LEAVE) y) ,&< an
)

NB.  The  unmaphard  analog of unmapall_jmf_  
unmapallhard =: uh_DEFAULT&$: : (4 : '> x unmaphard each 0{"1 mappings')

'exportable blah'=.4!:5&.> i._2
('`',;:^:_1 '_z_' ,L:0 ~ ({.~ 2 i:~ +/\.@:=&'_')&.>exportable)=:exportable


NB.  Public names end here. 
NB.  *******************************************************