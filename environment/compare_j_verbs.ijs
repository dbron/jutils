   NB.  Dependencies
   require 'numeric'  NB.  For 'round'

   NB.  Utils
   sr         =:  2 : '(m.&=)`(,:&n.) } y.'
   arbCut     =:  <@:#@:[ }.&.> [ (E. <;.1 ]) ,
   multiCut   =:  arbCut&>/@:(<"_1^:(L. = 0:)@:|.@:[ , <@:])
   strip_loc  =:  (}.~ ({: * # -~ i:&1@:(1 0&E.))@:=&'_')&.>@:(;:^:(0: -: L.))
   compare    =:  (;: 'Algo Time Space')&,@: ((,. [: <"> (0.01&round@:%"1 <./)) /: ])
   nvtext     =:  }:@:,@:(,.&LF)@:   sqr=:     ((,. TAB&,.)&:>/)@:            (<@:>"1)@:|:@:(":&.>)
   nvtextb    =:  }:@:,@:(,.&LF)@:((<0 1)&C.)@:((,. TAB&,.)&:>/)@:('-'&,&.>)@:(<@:>"1)@:|:@:(":&.>)

NB.  Describe agreement	
   describe   =: verb define
     'type rank shape numtrue true added missing'=.y.
     if. -.type-:'failure' do.
        z   =.(':',&.>~'Type';'Rank';'Shape';'Number of true';'True bits') ,. ]&.".each ;: 'type rank shape numtrue true'
        z,'WRT majority:  ' (~:&0@:#@:] # ,:@:(,&< sqr@:(a:&,)) ) ((~:&a:@:] # (,.~ ,&':'&.>)~) ]&.".each) ;: 'added missing'
     else.
        NB.  Max 10 chars on the details
        z =. (':',&.>~'Type';'Err #';'Err') ,. type;(":rank);((<:rank){::9!:8'') 

NB. Commented out because 'Detail' is always the same:  'data=.algo'.  IE the 128!:2 line I execute above.
NB.     z =. z , 'Detail' ,&< 10 {. (deb;.0~ ({. ,: -~/)@:(2 0&+)@:(2&{.)@:I.@:=&LF) shape 
     end.
)

   agree      =:  dyad define
     algos      =.  x.
     smallInput =.  y.
     data       =.  algos (0: ,&< 128!:2) :: ((13!:11 ,&< 13!:12) bind '') &> <smallInput
     msk        =.  ;{."1 data
     idx        =.  (({."1 data) ,. (,.~ 3!:0&.>) {:"1 data) </. i. # algos  NB.!  DO NOT DO THIS in this manner!  (See ** later)
     data       =.  idx  {&.> < data

     NB.  Sort order is:
	 NB.  Non errors first, followed by errors.
     NB.  Within these two groups, sort by # of algos returning that result.
     NB.  The final sort within the error group amoung equally-numberd result sets is error number
     'data idx' =.  (data  ,&< idx) {&.>~ < \: 2 A.&.|: (#&> idx ) ,. (=&0 ,. -) msk {~ {.&> idx

     rslts      =.  ((datatype;#@:$;$;+/;I.)@:]`((('failure'&;)@:;))@.(~:&0@:[)&>)/ |: {.&> data

     copy       =.  (3!:3^:_1)@:(3!:3)  NB.  Need to do this because there's a bug in J
     rslts      =.  (,. ((-.~ ; -.)&:copy&>"1~ {.)@:({:"1) ) rslts
     descrip    =.  <@describe"1 rslts

NB.!  The
NB.!       idx        =.  data </. i. # algos  NB. **
NB.!  Doesn't jibe with the ~:/  here.  For example,  </. treats a boolean  1 0
NB.!  The same as an integer 1 0, but this ~:/ doesn't because 'type' is one of the aspects
NB.!  being compared
     idx ,&< ({. , {. (] #~ (,&< i.&.> <@])&:({."1) ~:/ @:({&>)   (,&<)&:(,&a:@:({:"1)) )&.>"1 }.) descrip
)



   
   mkRk2       =.  ,:^:(2: - #@:$) 
   y           =.  mkRk2  each
   mxShp       =.  {  @:  ((;&:(>./) |:)/)  @:  (1 0&|:)   @:  ($&>)
   rshpnv      =.  ({.&.>~ mxShp) @: y
   nvj         =.  (,. ' '&,.)&.>/"1
   nvnew       =.  nvj@:rshpnv   
   remsk       =.  (i.@:(+/) e. 0: , +/\)   @:   (#&>)
   redist      =.  remsk  <@:;;.1  nvnew@:; 

   rslt        =:  ({. |.@;~ redist f.@:>@:{:)@:agree"1

   algons      =.  ({.@:;:&>) 
   maj         =.  '[Majority]'&;&.>@:{. , }.
   Ns          =.  ({.~ __ 15"_ >. $)@:> each @: maj
   algs        =.  >@:{.@:] Ns@:({&.>) <@:algons@:[

   algXrslt    =.  algs ,. >@:{:@:]

   rzSpc       =.  [: ; ((+ #) {. ])&.>
   rpt         =.  1 & rzSpc@:nvnew

   rpts        =:  < @: rpt f. @: ([ algXrslt f. rslt) "1 

   topMid      =.  [`(0: <@:; <.@:-:@:{:@:$@:])`]}  NB.  From 'jf_fmt'
   addBar      =.  '  |    '&,"1   

   catRpts     =: 2&rzSpc @: ((topMid&.|: addBar)&.>) f.












NOTES          =: noun define
	This was 'catRpts' before I reimplemented it:
	NB.!  This is REALLY ugly, REALLY redundant and needs to be cleaned up.
	NB.    metaAgree  =: dyad define 
	NB.      'algos inputName' =.x.
	NB.      'idx agreement'   =. y.
	NB.
	NB.      NB. Make deb handle TABs.
	NB.      notSpace   =. ' '&~:
	NB.      spaceNorTab=.-.@:e.&(' ',TAB)
	NB.      ".'debt    =.','deb' ({:@:] ;@:}.@:,@:,. (arbCut~ >@:{.))&:(  (5!:5)@:{.@:;: L: 0  ) ;: 'notSpace spaceNorTab'
	NB.
	NB.      algoNs     =. {.@:;:&>algos 
	NB.      Q          =. ((1: 0} ~:) 4 : 'x.}y.' (,:~ {:@:(,&' ')&.>)) "1 &.|: >@:(,&.>/)@:((({.~ #) ,. TAB&,.@:])&.>/"1) @: (,:^:(2: - #@:$) each) @:(({."1 each ~ >./@:({:@:$&>)) "1 &.|: ) each agreement
	NB.      Q          =. ((<''),>each ((<'[Majority]')&,&.>@:{. , }.) idx {&.><algoNs)  ,. inputName , Q
	NB.      Q          =.  (LF,'|   ',LF)&join@:((LF&join@:('|   '&,&.>)@:(#~ ([: +./\. a:&~:))@:(({.~ #) <@:debt"1@:,. TAB&,.@:])&.>)/"1)@: ((({. each ~ <@:+&2@:(>./)@:($&>)) "1 &.|: ))@:(,:^:(2: - #@:$) each)@:}.   Q
	NB.      <nvtext (>inputName) (({.&.>~5: >. >./@:(#&>))@:(((,&< >.@:-:)   4 : ' ({.x.) ({:x.)}y.' #&(<' ')@:]) #) ,. ])LF cut  Q
	NB. )
)