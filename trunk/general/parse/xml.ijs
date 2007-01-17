cocurrent'xml'

NB.  Tokenize XML
tt =: tokenizeTags =: verb define

	NB.  This will also drop everything before the 1st tag
	NB.c          =. y e. TAB,CR,LF
    NB.y          =. c } ' ' ,: y

	(--.{:{:h) }. y <;.1~ +./ 0 _1 |."_1 h=.'<>' =/ y 

)

NB. turn <tag/> into <tag></tag> 
ei =: expandImmediates =: verb define

	
	mask      =.  ('/>') -:"_ _1] _2 {.&> y
	yy        =.  y #~ 1 j. mask
    idx       =.  1 + (i. +/ mask) + old_idx =. I. mask
    tagNames  =.  ({.~ i.&' ')&.> old_idx { y
    closeTags =.  ({. , '/' , }. , '>'"_)&.>  tagNames
    yy        =.  closeTags idx } yy
)

NB. turn FREE_TEXT into FREE_TEXT /FREE_TEXT
eio =: expandImmediates =: verb define

	mask      =.  (<{.;:'FREE_TEXT')= tags =. {:@{.&.> y
	yy        =.  y #~ 1 j. mask
    idx       =.  1 + (i. +/ mask) + old_idx =. I. mask
    tagNames  =.  old_idx { tags
    closeTags =.  ('/' , L: 0 tagNames) ((<0 ;_1)} 1&{.)&.> old_idx {y
    yy        =.  closeTags idx } yy
)


dm =: deleteMeta =: verb define
    y }.~ '<' i.&1@:= {.&> y =. y #~ '<!' -.@:-:"_ _1 ]2 {.&> y
)

pa =: parseAttributes =: verb define

	syn        =. (' ',TAB) ,.~ '<"',:'"/>'
	fl         =. (f=. i.&0@:e. {.) ,: ( l=. i:&0@:e. {:)

	trimSyn    =. ];.0~ :: [ syn fl~ [
	nv         =. {.~ ;&:trimSyn (}.~ >:)
	cutNV      =. nv i.&'='

	attrCutMsk =. [: ((> ~:/\) > 2 | +/\@:]) / ('"' ;&:, ' ',CR,LF,TAB) e.&>~ < 
	cutAttr    =. ] cutNV;.1~ 1: 0} attrCutMsk 
	tagAsAttr  =. (2 {. 'tag' ; {.) , }. 
    attrs      =. [: tagAsAttr cutAttr 
	
	isTag      =. '<' -: {.
	freeTxt    =. ('tag';'FREE_TEXT') ,: ('CONTENT'&;) NB. ('/FREE_TEXT';'') ,&:<~ 'FREE_TEXT'&;
	parse      =. freeTxt`attrs@.isTag&.>

    parse  y
)


NB.  all the adverbial bullshit below is so that
NB.  when I fix (f.) tree, $: refers to the all of
NB.  tree, not just cutNextLevel.  Otherwise I could
NB.  just use normal verbs.
thisLevel     =. (<@:= {.)@:[
cutThisLevel  =. ,&:< <;.1&>~ thisLevel

tossCloseTags =.  _2 {.\ |:

attribs       =. {.&>@:({:"1)
cutNextLevel  =. (&.>) / (@:|:) ([:`) (`(}.&.>)) (`:6)  NB.  Could replace @:|: with "1
recurse       =. cutNextLevel  (,.`) (attribs`) (`:6)

cutTree       =. recurse (@:tossCloseTags) (@:cutThisLevel)

notLeaf       =. 1 < #@:[
tree          =: ($: cutTree(^:notLeaf)) f.

proc       =: verb define

	TAGs      =.  ({:@:{.)&> tokens =. eio pa dm ei tt y
	closers   =.  '/' = {.&>TAGs
	flags     =.  (_1^closers)* 1 + (i.~ ~.) TAGs }.&.>~ closers   
    tokens tree~ (+/\ + <&0)@:* flags
)
