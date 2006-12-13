xenos30             =: ,&.>/ ( (0&".&>@:{. ; [: < <@:trim"1@:>@:((,. ' '&,.)&.>/)@:}.);.1~ __&~:@:;@:({.!.__@:(__&".)@:{.@:,&.>) ) (#~ 0&<@:(*/@:$&>)) (<@:(trim"1);.2~ ''&;@:(*./)@:=&' ') > LF cut noun define
1   boolean            1024   sparse boolean 
2   literal            2048   sparse literal 
4   integer            4096   sparse integer 
8   floating point     8192   sparse floating point
16  complex            16384  sparse complex 
32  boxed              32768  sparse boxed 
64  extended integer   65536  symbol 
128 rational           131072 unicode
)

NB.  |. because \: 1 2 3;'456' returns '456',1 2 3, so 'ordered' in the sentence below means 'ascending ordered'.
class_order         =: |. (;: 'and or empty') -.~ ;a: -.~ ' ' cut each (#~ ({: +: ~:/\@:(+./))@:('()'&(=/)))&.> ',' cut (}.~ >:@:i.&':')@:>@:{. LF cut noun define
The types: numeric or empty, symbol, literal (1 byte or 2 byte characters), and boxed, 
are so ordered; within them, a lower rank precedes a higher, and arrays to be compared are padded with fills if necessary to have the same shape. Complex arguments are ordered by real part, then by imaginary. 
Boxed arrays are ordered according to the opened elements.
)

numeric_order       =: |. (>@:{. ({:"1@:] {~  ((] i. [ #~ e.) ;@:({."1))) _2&(]\)@:;@:((<'     ')&((] (trim each)@:('-'&cut)@:}.~ i:&1@:E.)&.>))) LF cut noun define
   |  B  I  X  Q  D  Z
---+------------------
B  |  B  I  X  Q  D  Z     B - boolean
I  |  I  I  X  Q  D  Z     I - integer
X  |  X  X  X  Q  D  Z     X - extended integer
Q  |  Q  Q  Q  Q  D  Z     Q - rational
D  |  D  D  D  D  D  Z     D - floating point
Z  |  Z  Z  Z  Z  Z  Z     Z - complex
)

literal_order       =: trim each ',' cut > {. LF cut  noun define  NB.  I arbitratrily decided that unicode is 'higher' than ascii
unicode, literal
)

CLASSES             =:  (;: each (;@:({."1)@:] 4 : 'x}y' (,: {:"1)) ((noun"_ -: 4!:0)@:< ; <@:". )@:(,&'_order')&>  ) class_order  

noun define

	xenos30         =. 1 2 4 8 16 32 64 128 1024 2048 4096 8192 16384 32768 65536 131072 
	xenos30         =. (<xenos30),<deb each LF cut noun define
	boolean
	literal
	integer
	floating point
	complex
	boxed
	extended integer
	rational
	sparse boolean
	sparse literal
	sparse integer
	sparse floating
	sparse complex
	sparse boxed
	symbol
	unicode
	)
	
	CLASSES         =.  {: |: trim L: 0 ({."1 ,. ','&cut&.>@:({:"1)) ':' cut &> LF cut noun define
	boxed    :  boxed
	symbol   :  symbol
	literal  :  unicode, literal
	numeric  :  complex, floating point, rational, extended integer, integer, boolean
	)
)

	TYPE_ORDER      =.  (> {. xenos30)  {~ (> {: xenos30) i. ; CLASSES
	SPARSE_TYPES    =.  'sparse' (>@:{.@:] #~ (=&:({.@:(' '&cut)&>)&:boxopen >@:{:)) xenos30 NB. (>@:{. #~ 1&e.@:('sparse'&E.)@:tolower&>@:>@:{:) xenos30


se                  =.  'sparse types not supported by promoting_raze'
domain_err          =.  >:@:i.&(<'domain error')@:(9!:8) bind ''
no_sparse           =.  se&(13!:8)@:(domain_err)^:(+./@:e.&SPARSE_TYPES)
	
sort_by_type        =.  /: TYPE_ORDER&i.@:no_sparse@:(3!:0&>)
promoting_raze      =:  >@:(,&.>/)@:($&.> $&.> [: 0&$@:,&.>@:{. sort_by_type)
	
raze                =:  ;`(promoting_raze f.)@.(0: *./@:= */@:$&>)

smoutput datatype raze (<0$a:),<''
smoutput datatype raze (<''),<i.0
smoutput datatype raze (<0$a:),(<i.0),<''
