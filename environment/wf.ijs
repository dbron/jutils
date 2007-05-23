   isNB           =.  3&(('NB.' -: {.) *. '.:' -.@:e.~ { :: (' '"_))@:>@:{:@:(;: :: (a:"_))
   NB. isNB             =. (4&{ or ' ' e. '.:'"_)  < 'NB.'"_ -: 3&{.  NB.  From startup utils
NB.   dropnb         =.  }.~ isnb * -@:#@:>@:{:@:;:
NB.   isNB    =:  -:&'NB.'@:(3&{.)   
   splitNB =:  ({. ,&boxxopen wf@:}.)~ 3:
   wf      =:  (}: ,&boxxopen splitNB^:isNB@:>@:{:)@:;: :: <
   cutTokens =: 3 : 'y <;.1~ 1 0:} (#&>wn) (] +.] (e.~ i.@:#)~ (+ I.)) +./ </\  (w=.= wn) (= +/)~&:((*+/\)"1) (wn =. wf y) E.&> < y'"2 1 
   cutLines =: LF&(}:^:(a:-:{:)@:(<;._2)@:,~)
