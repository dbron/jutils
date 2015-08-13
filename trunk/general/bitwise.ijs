require 'strings validate'
coclass 'bdot'

NB. See htmlhelp_j_ 'dictionary/dbdotn.htm'
NB. or http://www.jsoftware.com/help/dictionary/dbdotn.htm
BDOT        =:  TAB cut&> LF cut noun define
	M		 MC		BITWISE		TABLE		NOTATION		
	0		_16		16		0 0 0 0		0:
	1		_15		17		0 0 0 1		*.
	2		_14		18		0 0 1 0		>
	3		_13		19		0 0 1 1		[
	4		_12		20		0 1 0 0		<
	5		_11		21		0 1 0 1		]
	6		_10		22		0 1 1 0		~:
	7		_9		23		0 1 1 1		+.
	8		_8		24		1 0 0 0		+:
	9		_7		25		1 0 0 1		=
	10		_6		26		1 0 1 0		-.@]
	11		_5		27		1 0 1 1		>:
	12		_4		28		1 1 0 0		-.@[
	13		_3		29		1 1 0 1		<:
	14		_2		30		1 1 1 0		*:
	15		_1		31		1 1 1 1		1:
	_		_		32		_ _ _ _		|.
	_		_		33		_ _ _ _		|.!._
	_		_		34		_ _ _ _		signed_shift
)

NB. Parse
'H T'       =:  split BDOT 
(H)         =:  <"1 |: deb&.> T

NB. Normalization utilities
nota2Geru   =:  3 : '{. +1 :y `'''' '
normRank0   =:  3 : '{. ( (y 5!:0) 1 : ''if. -. 0 0 -: _2 {. u b. 0 do. u =. u"0 end. u'') ` '''' '
normRotGer  =:  ({. |.!._`'') [^:(1 1 1 0 -: -:S:0)^:(-:&:{::)"0 ]

NB. Normalize
(nh)        =:  0&".&>@:".&.> nh =. H -. ;:'NOTATION'
GERUND      =:  normRank0@nota2Geru"0 NOTATION
T           =:  GERUND ,.~ |: boxopen"_1@:".&> H 
tidx        =.  < a: ; H i. {.;:'TABLE'
T           =:  T tidx}~ <"2 TABLE =: 2 2 $ S:0 tidx { T

bw          =:  adverb define
	try.
		NB. Convert verbs just as we do nouns.
		NB. In the end, they'll be scalar, 
		NB. so we'll return a verb, as expected.
		if. verb=nc<'u' do.
			u =. {. u`''
		end.

		NB. Lookups depend on type
		'bln num lit box' =. (*./@:(0 1 e.~ ,) ; isnumeric ; ischaracter ; isboxed) u
		rank =. #$u

		NB. lookup by "TABLE" (truth table)
		if. bln *. ((rank>1) *. 2 2 -: _2{.$u) +. degenr=.((rank<3) *. 4 = {:$u) do. 
			NB. Permit "degenerate" vectors (i.e. 1x4s instead of 2x2s)
			NB. for the convenience of typing 1 0 1 0 bw or a table of such rows.
			u =. 2 2 $"1^:degenr u          
			r =. T {~ TABLE i. u	

		NB. lookup by "M","MC","BITWISE" (b. code)
		elseif. (num *. -. bln) +. (bln *. -. (0 4,:2 2) e.~ _2{.$u)  do. 
			r =. (T,T,T) {~ (M,MC,BITWISE) i. u

		NB. lookup by "GERUND" (derived from "NOTATION") 
		elseif. lit +. box   do. 
			NB. Convert notation to a.r.
			NB. Normalize |.!.n to |.!._
			NB. Normalize 1:"0 to 1: etc (1"0 doesn't work)
			u =. <^:lit u
			u =. normRank0@normRotGer"0 nota2Geru^:(ischaracter@>)"0 u
			r =. T {~ GERUND i. u

		elseif. 1  do.
			assert. 0
		end.

		if. (1=#$r) do.
   			bwidx =. H i. {.;:'BITWISE'

			NB. If u is already bitwise
			if. u >: :: 0: T {::~ <0;bwidx do.
				({:r) 5!:0       NB. return J verb (gerund is last col)
			else.
				(bwidx {:: r) b. NB. return bitwise b. verb
			end.
		else.
			r
		end.
	catch.
		u
	end.

)

bw_z_ =: bw_bdot_

Note 'EXAMPLES'

The primary use case is being able to express  bitwise operations using
J notation, easily. So:
	
	   2b1010 *. bw 2b0101
	0
	   2b1010 +. bw 2b0101
	15
	   2b1010 -.@] bw 2b0101
	_6
	   2b1010 -.@[ bw 2b0101
	_11
	   1 |. bw 2b0101
	10
	   _1 |. bw 2b0101
	_9223372036854775806
	   0: bw 999 
	0
	   1: bw 999
	_1

Similarly, rather than the verb itself, we can use its linear
representation:
	
	   2b111000 '~:' bw 2b111010 
	2
	   2b111000 '=' bw 2b111010 
	_3
	   2b111000 '|.!.7' bw 2b111010 
	4179340454199820288

or its atomic represention:

	   ({. 0:"0`'') bw 2b111111   
	0

It's also possible to convert "standard" b. numeric codes to their 
bitwise equivalents. For example the "standard" b. code for *. is 1, and
the bitwise code is 17:

	   1 bw 
	17 b.

and the "complementary" standard b. code for *. is _15, which is
also equivalent to 17 bitwise:

	   _15 bw
	17 b.

Finally, it's possible to look up a bitwise function using the 
"truth table" of that function. For example, logical or (+.) has the
truth table 0 1,:1 1 :

	   (0 1 ,: 1 1) bw
	23 b.

	   (+./~i.2) bw
	23 b.

For convenience of typing, we can also look-up using the ravelled (1D)
truth table:

	   0 1 1 1 bw
	23 b.

The utility is also self-inverse; given a bitwise operation expressed as
an integer n I.~ 15 34 (that is, between  sixteen and thirty-four 
inclusive), it will return the  corresponding J verb:
	   ~: bw
	22 b.

	   22 bw
	~:

Thus, the input to bw may be any of:
	- verb
	- linear rep of verb
	- gerund (atomic rep of verb)
	- truth table (2D)
	- ravelled truth table (1D)
	- standard b. codes
	- complementary b. codes
	- bitwise b. codes themselves (returns J verb)

A secondary usage is being able to look up the meanings of various b. 
operations.  This can be done the same way as above, except you must pass
in non-scalar nouns. 

So long as the noun is non-scalar, you'll get a bitwise lookup table 
back, with the columns:
	- "standard" b. code
	- "complementary" b. code
	- bitwise b. code
	- truth table (2x2)
	- J linear rep (simplified)
	- J function atomic rep (gerund)

For example (note that >:`'' is a vector, not a scalar):

	   >:`'' bw
	+--+--+--+---+--+--+
	|11|_5|27|1 0|>:|>:|
	|  |  |  |1 1|  |  |
	+--+--+--+---+--+--+

Similarly for larger arrays:

	   -.@]`*. bw
	+--+---+--+---+----+----------------------+
	|10|_6 |26|1 0|-.@]|+-+------------------+|
	|  |   |  |1 0|    ||"|+----------+-----+||
	|  |   |  |   |    || ||+-+------+|+-+-+|||
	|  |   |  |   |    || |||@|+--+-+|||0|0||||
	|  |   |  |   |    || ||| ||-.|]|||+-+-+|||
	|  |   |  |   |    || ||| |+--+-+||     |||
	|  |   |  |   |    || ||+-+------+|     |||
	|  |   |  |   |    || |+----------+-----+||
	|  |   |  |   |    |+-+------------------+|
	+--+---+--+---+----+----------------------+
	|1 |_15|17|0 0|*.  |*.                    |
	|  |   |  |0 1|    |                      |
	+--+---+--+---+----+----------------------+

And similarly for other kinds of inputs:

	   11 _9 20 bw
	+--+---+--+---+--+--+
	|11|_5 |27|1 0|>:|>:|
	|  |   |  |1 1|  |  |
	+--+---+--+---+--+--+
	|7 |_9 |23|0 1|+.|+.|
	|  |   |  |1 1|  |  |
	+--+---+--+---+--+--+
	|4 |_12|20|0 1|< |< |
	|  |   |  |0 0|  |  |
	+--+---+--+---+--+--+

	   (3 2 2 ?.@$ 2) bw
	+-+---+--+---+--+--------------+
	|0|_16|16|0 0|0:|+-+----------+|
	| |   |  |0 0|  ||"|+--+-----+||
	| |   |  |   |  || ||0:|+-+-+|||
	| |   |  |   |  || ||  ||0|0||||
	| |   |  |   |  || ||  |+-+-+|||
	| |   |  |   |  || |+--+-----+||
	| |   |  |   |  |+-+----------+|
	+-+---+--+---+--+--------------+
	|8|_8 |24|1 0|+:|+:            |
	| |   |  |0 0|  |              |
	+-+---+--+---+--+--------------+
	|6|_10|22|0 1|~:|~:            |
	| |   |  |1 0|  |              |
	+-+---+--+---+--+--------------+
)