require 'task'

NB.  Get the URL from qdoj
NB.  Actually, modify qdoj so that  qodj '3!:' gets this url,
NB.  and qdoj '3!:1' gets the table row for 3!:1, etc.
NB.  and if I ask for a vocab page, I should be able to ask for "monadic", "dyadic", "ranks", "examples", "example code", etc.
NB.  qdoj should return the text as nested tables, like I do here.
PORK                   =.  shell 'c:\app\cygwin\bin\w3m -dump -cols  500                 http://www.jsoftware.com/books/help/dictionary/dx003.htm'      
BAM                    =.  > 3 : ' PRKf <;._1~ (;&:(1 , 2 </\ *./)~ |:) '' '' = PRKf=.'' '' , '' '' ,. y'^:(1 < #) L: 0^:2 <3 }. _3 }. ];._1 LF ,PORK
tbl                    =.  3 {. , (<5;1) {:: BAM

normalize              =.  ' ' sr '_'@:tolower :. ]
normalize_byte_order   =.  [: (6 s: s:) normalize each@:(]&.s:)

col_processors         =. (0&".)`(0 ". {.&.;:)`normalize_byte_order  ,. ;: 'x word_size byte_order' 
col_process            =. ({."1 col_processors) {~ ({:"1 col_processors)&i. 

'nms vals'             =.  1 <@:(normalize each`])@{.;.1 deb"1&.> |: split&> (TAB sr ' ')&.> tbl 

verbs                  =. col_process  nms

xwb                    =. |: > (nms) =. 1 < @: verbs @:>@:{.;.1 vals

assert 'integer' -: datatype int =. 2

HOST_nms               =. 'HOST_' , L: 0 nms
(HOST_nms)             =: xwb {~ x (3!:1&.> i. 3!:1&.>@:]) int
 
BYTE_ORDER_ENUM        =: ~. byte_order
BYTE_ORDER_nms         =. 'BYTE_ORDER_',L: 0 normalize_byte_order^:_1 BYTE_ORDER_ENUM
(BYTE_ORDER_nms)       =: <"_1 BYTE_ORDER_ENUM

WORD_SIZE_ENUM         =: ~. word_size
WORD_SIZE_nms          =. 'WORD_SIZE_',L: 0 ":&.> WORD_SIZE_ENUM
(WORD_SIZE_nms)        =: <"_1 WORD_SIZE_ENUM

HOST_CONVERT           =: 1 : ' (  lookup111 f. ^:_1 ) : (  (3!:m~ $:)~ )  :.  lookup111  =. (}."1 xwb) {~ ({."1 xwb)&i. '

NB.  If we define the byte order enum such that
NB.     1  means standard  and  2  means reverse, then
NB.  lookup111 turns out to be equivalent to 
NB.               (2 2 #. 5 0 -~ 2 ^. ])   
NB.  The  2 2  is important:  you cannot use   2 #.  
NB.  or  mondic  #.  because the latter doesn't invert correctly
NB.  for any input and the latter doesn't invert correctly for  0  or  1  .
NB.  Hmm, maybe more general is   (n #~ # x) #. (x=.5 0) -~ (n=.2) ^. ]

HOST_CONVERT_bytes     =: 1 HOST_CONVERT
HOST_CONVERT_hex       =: 3 HOST_CONVERT

IF64_z_                =: HOST_word_size = 64




aabbaa=.3 : ' PRKf <;._1~ (;&:(1 , 2 </\ *./)~ |:) '' '' = PRKf=.'' '' , '' '' ,. y'^:(1 < #) L: 0^:2
bbaabb=.3 : ' PRKf <;._1~ (;&:(1 , 2 </\ *./)~ |:) (~. ''+'' (] {~ [: i.&1 e."1) BOXES_jijs_) e.~ PRKf=.''+'' , ''+'' ,. y'^:(1 < #) L: 0^:2
BAM2  =:((1 <@:( 0 0 1 { ({:@:>@:{.@:,@:(0&{))`([: , 1&{))@:>@:{.;.1 ])@:{. , }.)> each >,.&.>/}:@:aabbaa each }:}.{.bbaabb > 0 { 0 { > 0 { 1 { 8 { BAM
tbl2  =: 0 1 3 { > {: {. BAM2  

require 'convert'
flag_processor =. dfh@:toupper  :. (tolower@:hfd)
bbo =: |: > 'flag bits order' =: 1 <@:( flag_processor ` (}. verbs))@:>@:{.;.1  tbl2
assert ({."1 bbo) -: a. i. int {.@HOST_CONVERT_bytes"_1 _~   }."1 bbo


NB. HOST_CONVERT           =: 1 : ' (  lookup111 f. ^:_1 ) : (  (3!:m~ $:)~ )  :.  lookup111  =. (}."1 bbo) {~ ({."1 bbo)&i. '
bbo_lookup =. (}."1 bbo) {~ ({."1 bbo)&i.
assert (HOST_word_size,HOST_byte_order) -: bbo_lookup HOST_flag =: a. i. {.3!:1 int   

FLAG_ENUM              =: ~. flag
FLAG_nms               =. 'FLAG_',L: 0 <"_1 flag_processor^:_1 FLAG_ENUM
(FLAG_nms)             =: <"_1 FLAG_ENUM


  q=. 224 -~ a. i. [: {. 3!:1
  j=. 2 2 #. 5 0 -~ 2 ^. ]
  b =. j^:_1@:q