JT =:0 1 }. TAB makeTable noun define
	flag     	1 mword    	The first byte is one of the following:
	type     	1 mword    	as in 3!:0                             
	#elements	1 mword    	*/$y if dense; 1 if sparse             
	rank     	1 mword    	#$y                                    
	shape    	rank mwords	$y                                     
	value    	? mwords   	the ravelled elements of y             
)

FLAGT =: {.@;:&> 0 1 }. TAB makeTable noun define
	e0	32 bits,	standard
	e1	32 bits,	reverse 
	e2	64 bits,	standard
	e3	64 bits,	reverse 
)
'FLAGCODES FLAGVALS' =: ('';1 1 0) (0 <@". [: ;:^:_1 '16b' ,L:0 ,)`<;.1 FLAGT 
NB. WO    =:  ,./ (<;._2 L:0^:2 '32 64 /standard reverse /') i.&> <"1 |: FLAGVALS

TYPET =: 0 1 }. TAB makeTable noun define
	     1	boolean              	#
	     2	literal              	"
	     4	integer              	#
	     8	floating point       	#
	    16	complex              	#
	    32	boxed                	<
	    64	extended integer     	#
	   128	rational             	#
	  1024	sparse boolean       	$
	  2048	sparse literal       	$
	  4096	sparse integer       	$
	  8192	sparse floating point	$
	 16384	sparse complex       	$
	 32768	sparse boxed         	$
	 65536	symbol               	`
	131072	unicode              	"
)
'TYPECODES TYPENAMES TYPECLASSES' =: ('';1) (0 <@". ;:^:_1@:,)`(<@,)`(<@;);.1 TYPET
'NUMERICS LITERALS BOXES SPARSES SYMBOLS' =: TYPENAMES </.~ '#"<$`' i. TYPECLASSES
REFERENCES =: SPARSES,BOXES,'extended integer';'rational'

NB. Byte Size in bits; Byte Max Value
BS  =: 2 ^. BMV =: #a.
 
jt =: verb define
	NB. Convert from bytestream to structured array, if neccesary
	y                  =. jtLayout y

	NB. First 4 headers are fixed size: 1 machine word each
	FIXEDHEADERS       =.  ;:'flag type count rank'
	'fixedHeader rest' =.  (#FIXEDHEADERS) split y
	(FIXEDHEADERS)     =.  BMV #. fixedHeader

	NB. Word size (32 or 64) and endianness (BE='standard',LE='reverse')
	'b64 boBE'         =.  ('64';'standard') = FLAGVALS {~ FLAGCODES i. flag

	NB. Shape is variable-sized
	'shape data'       =.  rank split rest
	shape              =.  BMV #. shape

	NB. Type information	
	type               =.  TYPENAMES {::~ TYPECODES i. type
	isSparse           =.  'sparse' ([ -: <.&# {. ]) type 
		
	desc               =.  'data type';'is sparse?';'atom count';'rank';'shape' 
	desc               =.  desc ,: type;isSparse;count;rank;shape
	smoutput desc

	select. type
		case. NUMERICS -. 'extended integer';'rational' do.
		case. LITERALS    do.
		case. SYMBOLS     do.
		case. SPARSES	  do.
		case. REFERENCES  do.
			'pointers data' =. data split~ count * 1 + isRat =. type-:'rational' 

			smoutput 'pointers';pointers
			smoutput 'data';data			

			smoutput 'data';data =. data <@jt ::_1:;.1~ (i.#data) e. (-{.) BS %~ BMV #. pointers
			
			if. -.BOXES e.~ <type do.
				NB. extended integer or rational
				data =. (10x ^ b64 { 3 4) p.&>~ BMV #.&.> SMOO=:data
				data =. (-1+isRat) %/\ data
			end.
		case.             do.
			NB. Unknown or unhandled datatype
	end.	

	data
)

jtLayout =: verb define
	if. (2=#$y) *. 'integer'-:datatype y do.
		y
	else.
		assert. (1=#$y) *. 'literal'-:datatype y		

		NB. Chars to bytes
		y    =. a. i. y	  
	
		NB. Don't know word size yet / byte order yet; 
		NB. have to look for first non-zero byte (i.&1@:~: is shortcutted)
		NB. Is this safe for non-noun JAs? Is the first non-zero byte
		NB. in any array always the flag byte?
		flagIdx =. i.&1@:~:&0 {. y  
		flag    =. flagIdx { y

		'b64 boBE' =. ('64';'standard') = FLAGVALS {~ FLAGCODES i. flag

		NB. Break y into machine words in standard byte order 
		NB. (if we're on a big-endian machine, then boBE is 1
		NB. and (boBE-1)&A. is 0&A. which is the identity function;
		NB. contrariwise _1&A. is reverse.)
		y (boBE-1)&A.\~ - BS %~ b64 { 32 64  
	end.
)

jt 3!:1 ] 0123456789101112131415161719202122232425x
jt 3!:1 ] 123456 7891011 12131415x
jt 3!:1 ]  1 1 1 1 3 $ 123r456 78r91011 1213r1415
jt 3!:1 ]  $. ?. 10 10 ?@$ 2
jt 3!:1 ]1; 2; 3 
smoutput jt 3!:1 ] 1.23 4.56