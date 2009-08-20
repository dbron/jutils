NB.  Test text...
TXT=:'(345 * _2 + +/@:(+/%#) * ]) - ''hello''"_ , <.' 

gTxt           =.  (gn@:".@:]^:[&.>~ [: (('''' = {.) +. (':'~:{:) *. '_0123456789' e.~ {.)@|: 2 {.&> ])@:;:
  gn           =.  (":0) ; <@] NB.  Gerundify a noun


NB.  Concept is to use the  @.(nested boxes) to evoke code
NB.  Text correctness..
WDN=: gTxt TXT
SNEE=:WDN@. (K=:( 1 ; 2 ; 3 ; 4 ; 5 ; 6 ; 7 ; (9 ; 10 ; 11 ; 12) ; 14 ; 15);17;18;19;20;21;22)
".'FLEE =: ',TXT
assert -:&:(5!:1)/ ;:'SNEE FLEE'


NB.  Calculate the nested boxes from the parens
NB.  Convoluted because I want to use ^: instead of $: 
NB.  This makes embeddeding this function (and fixing 
NB.  derived functions) easier, but means I have to cut
NB.  bottom-up rather than recurse top-down.
nestToBox      =.  (;:'()') cleanNest@:cutNest@:idxNest ]  NB.  Don't use  x&$: : here, or fixing the final adverb will break.
  cleanNest    =.  bubble@:rmScaff
    bubble     =.  >@:{.^:(1=#)L:1^:_  NB.  "Bubble up" superfluous boxes
    rmScaff    =.  >@:{.L:1
   cutNest     =.  cutBot L:1^:maxDepth  
     cutBot    =.  ('';1) <@:,;.1 ] noParen;.2&>~ minMask
       noParen =.  <@:(}.@:}:^:(1<#))  NB.  Exclude indexes of paren chars
       minMask =.  (=<./)&.>@:{:      NB.  Cut on minimum depth
     maxDepth  =.  1 + >./@:>@:{:
   idxNest     =.  i.@#@] ,&< nesting
     nesting   =.  (+/\@:(-/))@:(=/)

GEE =: WDN@.(nestToBox WDN)
assert -:&:(5!:1)/ ;:'SNEE GEE'

anon_evoke    =.  (("_) (`'') (<@gn`)) (`(<gn 0)) (`:6) ('@.' ; (,&<&gn nestToBox)@:gTxt`) (`:6) (@.1 0 2)
ae            =: 'anon_evoke' f.

FREE =: TXT ae
assert -:&:(5!:1)/ ;:'SNEE GEE'
   