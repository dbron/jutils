require'qdoj dir strings'

NB.  List of all J scripts in and under the J directory.
scripts  =: {."1 s=: dirtree '*.ijs',~prefix =: '\',~1!:43''

NB.  All lines within scripts
lines    =: LF cut each toJ@:fread each scripts

NB.  All words within lines
words    =: ;: :: ((0$,a:)"_) each each lines

NB.  Script count, line count, word count.
'sc lc wc'  =: (# ; #&> ; [: < #&>&.>) words

NB.  Sanity checks
assert sc -: # lc   NB.  Count of line count is script count
assert lc -: #&> wc NB.  Count of word count is line count

NB.  Recording running sums allow us to work with a single vector 
NB.  of words, rather than scripts[lines[words]]
WC       =: +/\  wcc =: ; wc
LC       =: +/\  lc
SC       =: +/\  sc

NB.  Single vector, for efficiency
W        =: ;; words
L        =:  ; lines
S        =:    scripts
erase 'words lines scripts'  NB.  Now have W L S don't need original data.  

NB.  Uses of  !:  
xenos    =: W I.@:= {. ;:'!:'

NB. Arguments to !:
xArgs    =:  W {~ xenos +/ _1 ^ i. -2

NB.  Unique !: arguments
xaNub    =: ~. xArgs 

NB.  Direct arguments (integers)
direct   =: *./"1 *./@:e.&DIGITS&> xaNub 

NB.  Indirect arguments are names, paren'd expressions, etc.
indirect =: xaNub #~ -. direct

NB. Only work with direct arguments
xaNub    =:  xaNub #~ direct

NB.  I personally don't care about GL or matrix commands
xaNub    =:  xaNub #~ -.  ({."1 xaNub) e. ; ;: each ' ' cut '11'NB. 128'

NB.  0!:xyz where x, y, and z are boolean are not spelled out
NB.  but they are documented.  Hence ignore these.
xaNub    =:  xaNub #~ ((*./@:e.&'01'@:]) *:   -:&(>{.;:'0')@:[ *. 3: = #@:])&>/"1 xaNub

NB.  Sort for ease of display
xaNub    =:  xaNub /: 0&".&> xaNub

NB.  Foriegns to look up
x        =: '!:' <@:;@:(2: A. ;) /"1 xaNub    

NB.  Dictionary xenos pages for each !: family
dx       =:  /:~ _3&({.!.'0') each ~.{."1 xaNub
dx       =: 0 _ & qdoj :: (''"_)&.> 'dx'& , each dx

NB.  Final analysis:  Foriegns used but not documented
unDocd   =: -. x 1&e.@:E.&> < ; dx

NB.  Figure out what scripts and lines use these undocumented foriegns.
word     =:  xenos  {~ xaIdot =: I. xArgs e. xaNub #~ unDocd     
line     =:  word i.&0@:>"_1 _ WC  NB.    SHould be able to say / instead of "_1 _ but I can't
script   =:  line i.&0@:>"_1 _ LC
lineInScript =: line - LC {~ <: script
mentions =:  L {~ line  NB.(<lines) {::&.>~ <@;/"1 ~. script ,. lineInScript

NB.  Table of RHA ; LHA ; Script (relative to 1!:43) ; Line number in script ; Actual Line from script
TABLE    =:  (xaIdot { xArgs ) (,. /: 0&".&>@:[) ('~', each (#prefix) }. each  script { S) ,. (<"> lineInScript) ,. (mentions)

NB.  Format this table for display. 
group    =: 1 : '({."1 (~.@:[ ,.@:-.&a:@:(<@:dtb"1)^:(2: = #@:$)@:(,/^:(2: < #@:$)^:_)@:(tree"_1) <@:u/.) }."1)'
tree     =:  >@:(,.&.>/)@:(] ,~ ,:@:,&':   '@:>@:[ <@:{.~ _: ,~ {.@:(#&>)@:]) [: ({.~ # -@:+ 1: < #)&.> >@:(<@:(,"1&':   ')@:>"1@:|:&.>)
gTABLE   =: ,/ >  ] group group group > ,.&.>/ ,1 <"1 each @:(rjust each `(rjust each)`]`(rjust each )`]);.1 <@:>"1 |: ": each TABLE
colons   =: ': '(*./@:(+./) +/\^:_1@:I.@:*. 0: < +/@:{.)@:(=/) gTABLE
headers  =: }:;, 1 <@(1&(|.!.':'))@(rjust`rjust`]`]`])@>;.1 colons (({.~ #) {.&.> ]) 'x';'y';'  Script';'  Line#';'  Line'
gTABLE   =: _2 }. ' ' ,;(<@:,&CRLF@:dtb@:{.~ i:&0@:=&':')"1 headers , gTABLE 
