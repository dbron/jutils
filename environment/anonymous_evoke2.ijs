NB.  Anonymous Evoke (ae), take 2
NB.
NB.  Anonymous evocation means executing a string and returning its result
NB.  tacitly.  The original ae relied on  :  which is explicit by 
NB.  definition, which is why it's called "anonymous" rather than tacit.
NB.
NB.  This version is an attempt to evade that reliance, and produce a 
NB.  completely tacit adverb that evokes its string argument.
NB.
NB.  The adverb  ae  is analogous to the verb  ".  .  But since verbs are 
NB.  restricted to returning nouns,  ".  cannot return verbs, adverbs, 
NB.  etc.  The adverb  ae  can.
NB.
NB.  For example  '+' ae  returns  +  ,  + '@:' ae -   returns  +@:-  etc.
NB.
NB.
NB.  The basic mechanism leverages an obscure feature of the conjunction
NB.  @.  .  Namely, in  m@.n  then "if n is boxed, the train is
NB.  parenthesized accordingly."
NB.
NB.  So  ae  breaks its string argument into words, discards the comment 
NB.  (if any), transforms anonymous nouns into the equivalent gerund (i.e.
NB.  their atomic rep), locates the parens in the list of words, nests the
NB.  word (indices) accordingly, and returns  (word-list)@.(nested-boxes)  .
NB.  That is,  ae  reverse-engineers the parenthesized sentence into a 
NB.  nested list of boxes, and  (word-list)@.(nested-boxes)  reverses this
NB.  back into a parenthesized expression.
NB.
NB.  Hence,  ae  is a completely tacit string evocation adverb.  It's 
NB.  useful in (A) proving adverbial programming is complete in the sense 
NB.  that J is complete, and (B) where you want to evoke a string to produce
NB.  a non-noun, but need to rely on locally-defined names (where eg  
NB.  + 1 : string  would block access to these names). More generally it's 
NB.  useful in that it is tacit (functional); you don't have to worry where 
NB.  you use it.  Evoking a string with  ae  is exactly the same as if the 
NB.  string were a statement in its place (except for copulae, control 
NB.  words, and other punctuation).
NB.
NB.  See the original anonymous evoke in this directory:
NB.     anonymous_evoke.ijs
NB.  See original announcement:
NB.     http://www.jsoftware.com/pipermail/programming/2007-November/008816.html
NB.  See announcement of this script (take 2) 
NB.     http://www.jsoftware.com/pipermail/general/2009-August/033219.html
NB.  Which is truncated -- full text available at 
NB.     http://www.jsoftware.com/pipermail/general/2009-August/033221.html

NB.  Test sentence.
TXT            =.  '(345 * _2 + +/@:(+/%#) * ]) - ''hello''"_ , <.' 

NB.  Tokenize, discard any comment, convert anonymous nouns to gerundial form 
NB.  (atomic rep).  Anonymous nouns are detected by their first character:
NB.  literals start with ' and numbers start with an underscore or digit
NB.  (and don't continue with a colon).
gTxt           =.  (gn@:".@:]^:[&.>~ [: (('''' = {.) +. (':'~:{:) *. '_0123456789' e.~ {.)@|: 2 {.&> ])@:(}.~ _1 * 'NB.' ( ('.:'e.~{:@]) < (-: }:) ) 4 {.&> {:)@:;:
  gn           =.  (":0) ; <@]    NB.  Gerundify a noun

NB.  Concept is to use the  words@.(nested boxes) to evoke code
NB.  For example:
WDN            =.  gTxt TXT       NB. Below is word indices, nested equivalent to parenthesization
K              =.  ( 1 ; 2 ; 3 ; 4 ; 5 ; 6 ; 7 ; (9 ; 10 ; 11 ; 12) ; 14 ; 15);17;18;19;20;21;22

NB.  Prove that the nesting reproduced the parenthesization
SNEE           =.  WDN@.K         NB.  words@.(nested boxes) method
".'FLEE =: ',TXT                  NB.  Original sentence
assert -:&:(5!:1)/ ;:'SNEE FLEE'  NB.  Prove the results are identical


NB.  Calculate the nested boxes from the parens
NB.  Convoluted because I want to use ^: instead of $: 
NB.  This makes embeddeding this function (and fixing 
NB.  derived functions) easier, but means I have to cut
NB.  bottom-up rather than recurse top-down.
nestToBox      =.  (;:'()') cleanNest@:cutNest@:idxNest ]  NB.  Don't use  x&$: : here, or fixing the final adverb will break.
  cleanNest    =.  bubble@:rmScaff
    bubble     =.  >@:{.^:(1=#)L:1^:_   NB.  "Bubble up" superfluous boxes
    rmScaff    =.  >@:{.L:1
   cutNest     =.  cutBot L:1^:maxDepth  
     cutBot    =.  ('';1) <@:,;.1 ] noParen;.2&>~ minMask
       noParen =.  <@:(}.@:}:^:(1<#))   NB.  Exclude indexes of paren chars
       minMask =.  (=<./)&.>@:{:        NB.  Cut on minimum depth
     maxDepth  =.  1 + >./@:>@:{:
   idxNest     =.  i.@#@] ,&< nesting
     nesting   =.  (+/\@:(-/))@:(=/)

NB.  Prove that the nested-boxing calculator works.
GEE =: WDN@.(nestToBox WDN)
assert -:&:(5!:1)/ ;:'SNEE GEE'   NB.  Prove the results are identical

NB.  End result: adverb to evoke arbitrary sentence 
NB.  (excluding punctuation like copulae, control words, etc)
anon_evoke     =.  (("_) (`'') (<@gn`)) (`(<gn 0)) (`:6) ('@.' ; (,&<&gn nestToBox)@:gTxt`) (`:6) (@.1 0 2)
ae             =:  'anon_evoke' f.

NB.  Prove  ae  works.
FREE           =.  TXT ae
assert -:&:(5!:1)/ ;:'SNEE GEE'   NB.  Prove the results are identical

