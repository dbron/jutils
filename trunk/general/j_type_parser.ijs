JT =:0 1 }. TAB makeTable noun define
	flag	1 mword	The first byte is one of the following:
	type	1 mword	as in 3!:0
	#elements	1 mword	*/$y if dense; 1 if sparse
	rank	1 mword	#$y
	shape	rank mwords	$y
	value	? mwords	the ravelled elements of y
)

FLAGT =: {.@;:&> 0 1 }. TAB makeTable noun define
	e0	 32 bits,	standard
	e1	 32 bits,	reverse
	e2	 64 bits,	standard
	e3	 64 bits,	reverse
)
'FLAGCODES FLAGVALS' =: ('';1 1 0) (0 <@". [: ;:^:_1 '16b' ,L:0 ,)`<;.1 FLAGT 
NB. WO    =:  ,./ (<;._2 L:0^:2 '32 64 /standard reverse /') i.&> <"1 |: FLAGVALS

TYPET =: 0 1 }. TAB makeTable noun define
	1	boolean	#
	2	literal	"
	4	integer	#
	8	floating point	#
	16	complex	#
	32	boxed	<
	64	extended integer	#
	128 	rational	#
	1024	sparse boolean	#
	2048	sparse literal	"
	4096	sparse integer	#
	8192	sparse floating point	#
	16384	sparse complex	#
	32768	sparse boxed	<
	65536	symbol	`
	131072 	unicode	"
)
'TYPECODES TYPENAMES TYPECLASSES' =: ('';1) (0 <@". ;:^:_1@:,)`(<@,)`(<@;);.1 TYPET
'NUMERICS LITERALS BOXES SYMBOLS' =: TYPENAMES </.~ '#"<`' i. TYPECLASSES
SPARSES                           =: TYPENAMES #~ 'sparse' -:"1 (#'sparse'){.&> TYPENAMES 
REFERENCES						  =: BOXES,'extended integer';'rational'

NB. Byte Size in bits; Byte Max Value
BS  =: 2 ^. BMV =: #a.
 
jt =: verb define
	NB. First 4 headers are fixed size: 1 machine word each
	FIXEDHEADERS           =.  ;:'flag type count rank'
	'fixedHeader rest'     =.  (#FIXEDHEADERS) split y
	(FIXEDHEADERS)         =.  BMV #. fixedHeader  

	NB. Shape is variable-sized
	'shape data'           =.  rank split rest
	shape                  =.  BMV #. shape

	NB. Type information	
	type     =.  TYPENAMES {::~ TYPECODES i. type
	isSparse =.  'sparse' ([ -: <.&# {. ]) type 


		
	desc =. '64 bit?';'big endian?';'data type';'is sparse?';'atom count';'rank';'shape' 
	desc =. desc ,: b64;boBE;type;isSparse;count;rank;shape

	smoutput desc

	select. type
		case. NUMERICS -. 'extended integer';'rational'  do.
			smoutput 'numberz' 		
			smoutput^:isSparse '... but sparse'

		case. LITERALS    do.
			smoutput 'letters n things!'
			smoutput^:isSparse '... but sparse'

		case. SYMBOLS     do.
			smoutput 'symbols!'
			smoutput^:isSparse '... but sparse'

		case. REFERENCES  do.
			smoutput 'indirect yo'
			'pointers data' =. count split data
			smoutput 'pointers'; pointers
			smoutput HOOBAR=:data <@jt ::_1:;.1~ (i.#data) e. (-{.) BS %~ BMV #. pointers

			if. BOXES e.~ <type do.
				smoutput 'HI!!!' ,":(<type) e. BOXES 
				smoutput 'boxes!'
			else. NB. extended precision integers & rationals
				smoutput 'big old numbers!'
			end.

		case.             do.
			smoutput '???'
	end.	

	data
)

host2JT =: 	verb define

	if. (1=#$y) *. 'literal'-:datatype y do.
		NB. Chars to bytes
		y    =. a. i. y	  
	
		NB. Don't know word size yet / byte order yet; 
		NB. have to look for first non-zero byte (i.&1@:~: is shortcutted)
		flagIdx =. i.&1@:~:&0 {. y  
		flag    =. flagIdx { y
	

		y =. y (-boLE)&A.\~ - BS  %~ b64 { 32 64  

	else.
		assert. (2=#$y) *. 'integer'-:datatype y

		flag    =. BMV #. {. y
	end.




		'WORDSIZE ENDIANNESS' =. FLAGVALS {~ FLAGCODES i. flag
		b64  =. '64'       -: WORDSIZE
		smoutput boLE =. -. boBE =. 'standard' -: ENDIANNESS
	
		NB. Break y into machine words in standard byte order 
		NB. (if we're on a big-endian machine, then boLE is 0
		NB. and (-boLE)&A. is 0&A. which is the identity function;
		NB. contrariwise _1&A. is reverse.)

)

smoutput jt 3!:1 ] 0123456789101112131415161719202122232425x
smoutput jt 3!:1 ] 123456 7891011 12131415x
smoutput jt 3!:1 ]  1 1 1 1 3 $ 123456 7891011 12131415x