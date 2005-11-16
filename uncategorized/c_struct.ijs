NB.  Utility functions.

	NB.  Wrap in RHA in LHA.  LHA can be one or two elements long.
	NB.  EG:  '()' enclose 'parenthetical comment' NB.  Returns '(parenthetical comment)'
	NB.  EG:  '"'  enclose 'A Quote'               NB.  Returns '"A Quote"'
	enclose					=:  <"_1@:(2&$)@:[ ;@:}:@:,@:,. <@:]	

	NB.  Conjuction that produces a verb that permutes y. in the same way m. is permuted from n.
	NB.  EG:  cdab =: 'ABCD' permute 'CDAB' 
	NB.       3 4 1 2 -: cdab 1 2 3 4  NB.  Returns 1
	permute                       =:  2 : '(A. m. i. n.)&A. '

	NB.  Across - apply gerund left to array on right (from system\packages\publish\web.ijs).
	across                        =:  (]&.":  4 -~ 0 ". {. 0 {:: '/' slice 'j' -.~ 9!:14'') 1 : 'if.  m. do. 1 : ''1: (}.@$ $ ,)@:u.;.1 ]'' else. ((}.@$ $ ,)@:)(;.1)~ (# # 1:) end.'

	NB. Turn 5!:5 rep into 5!:1 rep.
	atomicFromLinear              =:  3 : ('". n=.''y.=.'',y.';'5!:1{.;:n')

	NB.  Another fixed-width parsenator.
	NB.  Good for chopping up structs/objects serialized by other languages.
	NB.  EG:  fieldSizes  =. 4 4 4 4 2 2 2 4 4 1 1 4 4 10 2
	NB.       donkey      =. ;  400 copy UCALPHA (] #&.> ({.~ #)) fieldSizes
	NB.       fieldSizes parsenate donkey
	parsenate                     =:  ((''&;@:}.@:xb@:] <;.2 (]\~ -@:{:)) +/\)~


NB.  Functions to convert C types to J types.

	NB.! Dealing with SIGNED integers here.

	NB.  Assuming a bit is a boolean value (implied by the 2 ^)
	maxByteValue                  =:  2 ^ bitsPerByte =:  8
	NB.  Pattern of how ints are stored as bytes in this architecture.
	bytesPerInt                    =:  # intByteRep   =:  'DCBA'  NB.!  Generalize this
	NB.  A permutation function from MSB down to LSB to machine architecture (and back)
	byteOrder                     =:  (/:~ intByteRep) permute intByteRep 

	NB.  Maximum value of a signed integer.
	NB.! I use -: <: here because we're dealing with SIGNED integers,
	NB.! so we reserve a bit (a factor of 2 (because we assume a bit is a boolean)) for the sign.
	NB.! This is an assumption.
 	NB. MAXINT                    =:  <. -: <: maxByteValue #. bytesInInt # <: maxByteValue 
	NB.
	NB.  Some sample data:  5 integers
	NB. originalData              =:  <. ?. MAXINT #~ numInts =: 5

	NB.  Get the machine-internal representation of the data,
	NB.  using 3!:1 (assuming data is trailing in this representation).
	NB.! Could actually use this information to calculate intByteRep, instead
	NB.! of the other way around.
	NB. machineRepresentationOfInt   =:  (- bytesInInt * numInts ) {. a. i. 3!:1 originalData

	NB.   Each int stored from MSB to LSB
	NB.   maxByteValue  #.^:_1 originalData

	NB.  Function to use the machine rep to get the original integers back.
	NB.!  I do this '(-something)&(function\)' 3 times in this script.  Abstract!
	decodeFromMachineRep          =:  maxByteValue&#.@:((-bytesPerInt)&(byteOrder\)) f.

	NB. Make sure we know how to decode machine-representation signed integers.
	NB. assert originalData -: decodeFromMachineRep machineRepresentationOfData  

	NB.  Data is read in as characters.  Indexing chars into a. and decoding them from
	NB.  machine format will turn them into J integers.
	int                           =:  decodeFromMachineRep@:(a.&i.) f.
	
	NB.  Single C chars are equivalent to J chars.
	char                          =:  ]

	NB.  C strings are stored as null-delimited lists of chars.
	NB. char_N                    =: }:  	NB.  Just strip the null.
	char_N                        =:  ] NB.   char_N is identity

	NB.  Given some information about a C type (type, qualifiers, width, array-ness)
	NB.  figures out what function will turn the C data into J data.
	getCtoJfunction               =:  dyad define
	NB.  We want to process some C data.  This data has a type (int, char, etc), and we expect names to deal with
	NB.  these types to be defined.  Howeever, C declarations can have fundamental types (int, char, etc) preceded by
	NB.  qualifiers (unsigned, register, etc).  If we want to process some C data, we'd like specialized functions to
	NB.  deal with these more specific types.  Thus we need to create an array of function names and choose the 'best' or 
	NB.  most appropriate name from this array to apply to the data.  Thus we must be able to specify prefernce somehow.
	NB.  I do this by making a vector of boxed functions in the order I prefer them, and then choose the first existing
	NB.  name.  

	NB.  We prefer to use the more specific over the more general types 
	NB.  (unsigned_int is prefered over int), so make sure these appear first in the typearray.
	'qualifiers type'             =.  _1 (}. ; {.) > y.
	typearray                     =.  <@:('_'&join)\. qualifiers,<type

	NB.  Prefer the array processing functions (suffixed with _N, eg char_N) iff we're dealing with array data.
	NB.  Thus, for 'unsigned int foo[4]' prefer: unsigned_int_N, int_N, unsigned_int, int
	NB.  If we're only dealing with scalar data (eg 'unsigned int foo'), elide the array processing names.
	'repetitions width'           =.  x.
	typearray_N                   =.  typearray ((# ,&'_N'&.>)~ , [) repeated =. repetitions ~: 1

	NB.  We now have the array of all the possible names we'd like to use.  We must figure out which of these names
	NB.  to apply, and how.
	NB.
	NB.  We have several cases:
	NB.  #0:  No appropriate function has been defined:  just use ]
	NB.
	NB.  #1:  We're dealing with scalars and an appropriate function has been defined:  use function"1&.>
	NB.
	NB.  #2:  We're dealing with arrays and an appropriate array function (with the suffix _N) has been defined:
	NB.       This is the same as case #1:  use function_N"1&.>
	NB.
	NB.  #3:  We're dealing with arrays and no appropriate array function has been defined, but an appropriate scalar function 
	NB.       has been:  use (-width)&(function\)"1&.>

	NB.  We can reduce this to two classes of cases:
	NB.  #0:   We have no appropriate function.  In this case use ]
	no_appropriate_name           =.  ']'"_

	NB.  #1:   We have an appropriate function.  Apply this function "1&.>
	rank1underopen                =.  ,&'"1&.>'

	NB.      #1a  We have a function defined to work natively on the input.  Just use the unadorned name.
	unadorned                     =.  >
	
	NB.      #1b  We have a scalar function but array input.  Then use (-width)&(scalar_function\).
	scalarFunctionOnArray         =.  ;@:(('\)' ;~ '&(' ,~ ": -width)&enclose)

	NB.  Thus, we have rank1underopen@:appropriate@:{`no_appropriate
	appropriate_function          =.  (unadorned f.) ` (scalarFunctionOnArray f.)
    functionTypes                 =.  (rank1underopen f.)@:appropriate_function@:{`(no_appropriate_name f.)

	NB.  We can figure out which of these cases apply by defining boundaries:
	NB.
	NB.  This is the array typearray_N:
	NB.
	NB.  B0            B1             B2
	NB.  ^-------------^--------------^-
	NB.    array names   scalar names  
	NB.
	NB.  We find index of the first valid name in typearray_N using nameclass.
	NB.
	NB.  	If this index is >: B2, then no appropriate name is defined, so we'll use ].
	NB.  	If this index is in the range B1-B2, then we use (-width)&(scalar_function\).
	NB.  	If this index is in the range B0-B1, then we use the unadorned name.
	NB.
	NB.  We define B0 B1 B2 such that if we're dealing with scalar data (-. repeated), the range B1-B2 is empty
	NB.  and the index will never fall in it (so if we're dealing with scalars we'll never use the -width form).
	checkBoundary                 =.  i.&1@:(< (,~ %&(2^repeated))@:#)
	
	NB.  Use the boundary check to determine the function type.
	function                      =.  (functionTypes@.checkBoundary~ i.&1@:=&3@:nc) typearray_N

	NB.  Now we have a little bit of J code (as a string):  Turn this into an atomic (gerund) representation:
	atomicFromLinear function
)


NB.  Implementation:  Take a specific C struct and generate code to convert it to J data.

	NB.  SYMBOLSIZE is #defined to 10 in the C code.
	SYMBOLSIZE                    =:  10

	NB.  The C structure represented in the file.
	C_STRUCT                      =:  noun define
	int QTim;                     //(1025 = QUOTIM)      Cumulative number of seconds since midnight
	int BID;                      //(22   = BID)         Bid price per share (5 implied decimal places)
	int ASK;                      //(25   = ASK)         Ask price per share (5 implied decimal places)
	int QSeq;                     //(1021 = SEQNUM)      MDS (Market Data Systems sequence number for NYSE only; zero otherwise)
	unsigned short BIDSIZE;       //(30   = BIDSIZE)     Bid size
	unsigned short ASKSIZE;       //(31   = ASKSIZE)     Ask size
	unsigned short Mode;          //(118  = PRC_QL_CD)   Quote condition
	char BidMmid[4];              //(293  = BID_MMID1)   NASDAQ market maker for NASD quotes
	char AskMmid[4];              //(296  = ASK_MMID1)   THIS IS TEMPORARY AND IS HERE FOR DEBUGGING PURPOSES ONLY!
	unsigned char Ex;             //(4    = RDN_EXCHID) This holds the RAW value of the exchange
	char Padding1;
	unsigned int Prev;            //Offset of previous record for this symbol
	unsigned int Next;            //Offset of next record for this symbol
	char Symbol[SYMBOLSIZE];      //Record.Name
	char Padding2[2];
)
	SYM2SIZE=:20
	C_STRUCT=:TAB sr ' ' noun define
	unsigned int Vwap;
	unsigned int RTVwap;
	char symbol[SYM2SIZE];
	unsigned int bid;
	unsigned int bidsize;
	unsigned int ask;
	unsigned int asksize;
	unsigned int lastprice;
	unsigned int open;
	unsigned int high;
	unsigned int low;
	unsigned int volume;
	unsigned int prev_close;
	unsigned int turnover;		// Split adjusted prev_close
	unsigned int tCount;
	unsigned int qCount;
	unsigned int symdetail; //struct SymDetail *symdetail;
	unsigned int openTradeSeq;
	unsigned int lastTradeSeq;
	unsigned int highTradeSeq;
	unsigned int lowTradeSeq;
	unsigned int publishCollection;  // class PublishCollection * publishCollection;
	char cusip[9];	//00846U101
	char instrument_type;
	char tradingstatus;
	unsigned char RTStatus;
	unsigned char Mode;
)

	NB.  Given a C-style struct definition, get the functions
	NB.  to transform the fields of the struct.
    getFunctionsForStruct             =:  verb define	
	
	NB.  Parse the C structure's textual definition.
	NB.  Strip comments, split into statements (delimited by ;), split into names and types.
	'names types'                 =.  <"1  |: ' ' _1&split@:arbCut &> ';' slice ; {."1 '//' makeTable C_STRUCT =. y.
	names                         =.  ; names

	NB.  Split names into barenames and array specifications.
	'names repeats'               =:  <"1 |: ']' -. L: 0~ '[' arbCut &> names
	repeated			          =.  a: ~: repeats

	NB.  Figure out which names are arrays and which are scalars.
	repeats				          =.  repeated } repeats ,:~ <,'1'

	NB.  Figure out how many repeititions of each type we have
	repetitions			          =.  ". :: (1&".) :: 1: &> repeats

	NB.   Figure out how many bytes each name consumes.  
	NB.!  Note int/4 is redundant WRT to the definition bytesPerInt, above.
	sizes				          =.  repetitions * widths =: 1 ". ;:^:_1 'char/1 short/2 int/4' lookup {:&> types

	NB.  Get a gerund of functions that will convert these C types to J types.
	functions                     =.  types getCtoJfunction"_1~ repetitions ,. widths

	sizes ,&< functions
)

	NB.  Turn an array of structs into a table (list of boxed columns).
	NB.  Struct def on the left, array of structs (as a list of literals) on the right.
    structArrayToTable            =:  dyad define

	NB.  Get the functions to transform the fields of the structs.
	'sizes functions'             =.  getFunctionsForStruct x.

	NB.  Split file into columns (each column is a homogenous C type)
	Qp                            =.  sizes parsenate (1e4 * +/ sizes) {. y.

	NB.  Apply our C-to-J conversion functions to the C data.
	Q                             =.  functions across Qp
)

	NB.  Read the file & turn it into a table
    structFileToTable             =:  4 : 'x. structArrayToTable fread y.'

	NB.  Parse a quotes file
	quotesFileToTable             =:  C_STRUCT&structFileToTable

NB.  Execution:  Take a file full of the C struct defined above and convert it to J data.
	NB.'PPPP QQQQ'                   =:  quotesFileToTable&.>  'D:\DailyTAQ\DailyTAQ.20050224.CQ.' <@:;@:,&boxopen"_ 0 ;:'bin log'   NB. 'C:\DailyTAQ\DailyTAQ.20050202.CQ.bin'
	NB. P =: quotesFileToTable 'D:\DailyTAQ\20050224\DailyTAQ.20050224.CQ.bin.small.sorted' NB. 'D:\DailyTAQ\DailyTAQ.TODAY.CQ.log'
	NB. smoutput _5 {.&.> P #&.>~ < -. ' @TIME@ ' e.~&s: P {::~ names i.&:(trim@:tolower L: 0&boxopen) 'Symbol'