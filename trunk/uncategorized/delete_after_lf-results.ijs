   text=: LF sr '.' 0 : 0
#((
#abc
#defg
#)
#lmn
#)
)
   q        =. '.'

   rmcol1   =:  #~ _1 |. ~:&q

   t        =.  =&q
   s        =.  2 1  1 1    0 2  1 2    2 2  1 2
   fsm      =.  1 ; (_2 ]\^:2 s) ; t a.
   
   ijrd     =.  1 , 0 , 1 ,~ t f.@:{.
   FSM      =.  ;:~ fsm (,<) ijrd

   rmcol2   =:  FSM^:(1 < #) f.

   rmcol3   =:  (#~ [: -. (0 1 E. q = ])&.|.)&.(q&,)

   assert (rmcol2 -: rmcol3) text
