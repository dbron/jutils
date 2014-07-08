require 'dir printf'  NB. For dirtree and sprintf respectively

P       =:  ; , <@:;:;._2 noun define -. TAB
	!  !. !:      "  ". ":
	#  #. #:      $  $. $:
	%  %. %:      &  &. &: &.: 
	*  *. *:      +  +. +:
	,  ,. ,:      -  -. -:
	.  .. .:      /  /. /:
	:  :. ::      ;  ;. ;:
	<  <. <:      =  =. =:
	>  >. >:      ?  ?.
	@  @. @:      [     [:
	\  \. \:      ] 
	^  ^. ^:      _  _: _.
	`     `:      a. a: A.
	b.            C.
	d. D. D:      e. E.
	f.            H.
	i. i: I.      j.
	L. L:         M.
	o.            p. p: p..
	q:            r.
	s: S:         t. t: T.
	u:            x:
	{  {. {: {::  |  |. |:
	}  }. }:      ~  ~. ~:
)

RESULTS =:  noun define -. TAB
	Number of files processed: %?;@:('c0.0'8!:0])?s
	Total lines: %?;@:('c0.0'8!:0])?s
	Total words: %?;@:('c0.0'8!:0])?s
	Total primitive words: %?;@:('c0.0'8!:0])?s
	------
	%s (%s) appears %d times, giving it rank #%d out of %d primitives. 
	%s represents about about 1 out of every %d primitive words, 
	and 1/%d (%0.2f%%) of all words. 
	------
	Closest neighbors:
)


primitiveStats =: verb define
	y primitiveStats~ {."1 dirtree '/*.ijs' ,~ jpath'~install'
:
	NB. Exclude duplicate files (same name and exact same size)
	filenms =.  (#~ ~:@:(1!:4 ;"0 (}.~ 1+i:&'\')&.>)) x
	files   =.  toJ@:fread&.> filenms
	lines   =:  LF cut&.> files
	words   =.  ;; ;: :: (''"_) L:0 lines
	
	
	pf      =.  (#P) {. _1 + #/.~ P , words
	'p pf'  =.  (<pf) \:~&.> P ,&< pf   NB. Sort by frequency
	
	(hdrs)  =.  i.#hdrs=:;: 'PRIM    RANK            COUNT        PFREQ             WFREQ       WPCT'
	T       =.     hdrs  ,   p    ,. (1+&.>i.#p)  ,. (<"0 pf) ,. ((<@%~ +/) pf) ,. ((;"> 100*%) pf %~ #words)
	
	'nm prm'=.  _2 {. 'The word' ; {.@:;:^:(0=L.) y 
	stats   =.  T {~ idx =. (<prm) i.~ T {~ <a:;PRIM
	R       =.  RESULTS sprintf (#files) ; (+/ #&> lines) ; (#words) ; (+/;T{~<(<0);COUNT) ; nm ; prm ; (COUNT { stats) ,(RANK { stats) , (#p) ; nm ; (PFREQ{stats) , (WFREQ{stats) , (WPCT{stats)
	R , , LF ,.~ (,. ' '&,.)&:>/ (<<1 0) C.&.> '-' ,&.> ({.T) ,&.> 'l,0.0,c0.0,c0.0,c0.0,q<%>0.2' 8!:1 T {~ (i.&.<:#T) -. (i.&.<:#T) -. idx + i:2
)

smoutput primitiveStats ;:'Amend }'
