
TEMPLATES =: noun define
    a	A string with arbitrary binary data, will be null padded.
    A	A text (ASCII) string, will be space padded.
    Z	A null terminated (ASCIZ) string, will be null padded.


    b	A bit string (ascending bit order inside each byte, like vec()).
    B	A bit string (descending bit order inside each byte).
    h	A hex string (low nybble first).
    H	A hex string (high nybble first).


    c	A signed char value.
    C	An unsigned char value.  Only does bytes.  See U for Unicode.


    s	A signed short value.
    S	An unsigned short value.
	  (This 'short' is _exactly_ 16 bits, which may differ from
	   what a local C compiler calls 'short'.  If you want
	   native-length shorts, use the '!' suffix.)


    i	A signed integer value.
    I	An unsigned integer value.
	  (This 'integer' is _at_least_ 32 bits wide.  Its exact
           size depends on what a local C compiler calls 'int',
           and may even be larger than the 'long' described in
           the next item.)


    l	A signed long value.
    L	An unsigned long value.
	  (This 'long' is _exactly_ 32 bits, which may differ from
	   what a local C compiler calls 'long'.  If you want
	   native-length longs, use the '!' suffix.)


    n	An unsigned short in "network" (big-endian) order.
    N	An unsigned long in "network" (big-endian) order.
    v	An unsigned short in "VAX" (little-endian) order.
    V	An unsigned long in "VAX" (little-endian) order.
	  (These 'shorts' and 'longs' are _exactly_ 16 bits and
	   _exactly_ 32 bits, respectively.)


    q	A signed quad (64-bit) value.
    Q	An unsigned quad value.
	  (Quads are available only if your system supports 64-bit
	   integer values _and_ if Perl has been compiled to support those.
           Causes a fatal error otherwise.)


    j   A signed integer value (a Perl internal integer, IV).
    J   An unsigned integer value (a Perl internal unsigned integer, UV).


    f	A single-precision float in the native format.
    d	A double-precision float in the native format.


    F	A floating point value in the native native format
           (a Perl internal floating point value, NV).
    D	A long double-precision float in the native format.
	  (Long doubles are available only if your system supports long
	   double values _and_ if Perl has been compiled to support those.
           Causes a fatal error otherwise.)


    p	A pointer to a null-terminated string.
    P	A pointer to a structure (fixed-length string).


    u	A uuencoded string.
    U	A Unicode character number.  Encodes to UTF-8 internally
	(or UTF-EBCDIC in EBCDIC platforms).


    w	A BER compressed integer (not an ASN.1 BER, see perlpacktut for
	details).  Its bytes represent an unsigned integer in base 128,
	most significant digit first, with as few digits as possible.  Bit
	eight (the high bit) is set on each byte except the last.


    x	A null byte.
    X	Back up a byte.
    @	Null fill to absolute position, counted from the start of
        the innermost ()-group.
    (	Start of a ()-group.


)

0 : 0
The following rules apply:

Each letter may optionally be followed by a number giving a repeat count. With all types except a , A , Z , b , B, h , H , @ , x , X and P the pack function will gobble up that many values from the LIST. A * for the repeat count means to use however many items are left, except for @ , x , X , where it is equivalent to 0 , and u , where it is equivalent to 1 (or 45, what is the same). A numeric repeat count may optionally be enclosed in brackets, as in pack 'C[80]', @arr .

One can replace the numeric repeat count by a template enclosed in brackets; then the packed length of this template in bytes is used as a count. For example, x[L] skips a long (it skips the number of bytes in a long); the template $t X[$t] $t unpack()s twice what $t unpacks. If the template in brackets contains alignment commands (such as x![d] ), its packed length is calculated as if the start of the template has the maximal possible alignment.

When used with Z , * results in the addition of a trailing null byte (so the packed result will be one longer than the byte length of the item).

The repeat count for u is interpreted as the maximal number of bytes to encode per line of output, with 0 and 1 replaced by 45.

The a , A , and Z types gobble just one value, but pack it as a string of length count, padding with nulls or spaces as necessary. When unpacking, A strips trailing spaces and nulls, Z strips everything after the first null, and a returns data verbatim. When packing, a , and Z are equivalent.

If the value-to-pack is too long, it is truncated. If too long and an explicit count is provided, Z packs only $count-1 bytes, followed by a null byte. Thus Z always packs a trailing null byte under all circumstances.

Likewise, the b and B fields pack a string that many bits long. Each byte of the input field of pack() generates 1 bit of the result. Each result bit is based on the least-significant bit of the corresponding input byte, i.e., on ord($byte)%2. In particular, bytes "0" and "1" generate bits 0 and 1, as do bytes "\0" and "\1" .

Starting from the beginning of the input string of pack(), each 8-tuple of bytes is converted to 1 byte of output. With format b the first byte of the 8-tuple determines the least-significant bit of a byte, and with format B it determines the most-significant bit of a byte.

If the length of the input string is not exactly divisible by 8, the remainder is packed as if the input string were padded by null bytes at the end. Similarly, during unpack()ing the "extra" bits are ignored.

If the input string of pack() is longer than needed, extra bytes are ignored. A * for the repeat count of pack() means to use all the bytes of the input field. On unpack()ing the bits are converted to a string of "0" s and "1" s.

The h and H fields pack a string that many nybbles (4-bit groups, representable as hexadecimal digits, 0-9a-f) long.

Each byte of the input field of pack() generates 4 bits of the result. For non-alphabetical bytes the result is based on the 4 least-significant bits of the input byte, i.e., on ord($byte)%16. In particular, bytes "0" and "1" generate nybbles 0 and 1, as do bytes "\0" and "\1" . For bytes "a".."f" and "A".."F" the result is compatible with the usual hexadecimal digits, so that "a" and "A" both generate the nybble 0xa==10 . The result for bytes "g".."z" and "G".."Z" is not well-defined.

Starting from the beginning of the input string of pack(), each pair of bytes is converted to 1 byte of output. With format h the first byte of the pair determines the least-significant nybble of the output byte, and with format H it determines the most-significant nybble.

If the length of the input string is not even, it behaves as if padded by a null byte at the end. Similarly, during unpack()ing the "extra" nybbles are ignored.

If the input string of pack() is longer than needed, extra bytes are ignored. A * for the repeat count of pack() means to use all the bytes of the input field. On unpack()ing the bits are converted to a string of hexadecimal digits.

The p type packs a pointer to a null-terminated string. You are responsible for ensuring the string is not a temporary value (which can potentially get deallocated before you get around to using the packed result). The P type packs a pointer to a structure of the size indicated by the length. A NULL pointer is created if the corresponding value for p or P is undef, similarly for unpack().

The / template character allows packing and unpacking of strings where the packed structure contains a byte count followed by the string itself. You write length-item/string-item.

The length-item can be any pack template letter, and describes how the length value is packed. The ones likely to be of most use are integer-packing ones like n (for Java strings), w (for ASN.1 or SNMP) and N (for Sun XDR).

For pack, the string-item must, at present, be "A*" , "a*" or "Z*" . For unpack the length of the string is obtained from the length-item, but if you put in the '*' it will be ignored. For all other codes, unpack applies the length value to the next item, which must not have a repeat count.
    unpack 'C/a', "\04Gurusamy";        gives 'Guru'
    unpack 'a3/A* A*', '007 Bond  J ';  gives (' Bond','J')
    pack 'n/a* w/a*','hello,','world';  gives "\000\006hello,\005world"

The length-item is not returned explicitly from unpack.

Adding a count to the length-item letter is unlikely to do anything useful, unless that letter is A , a or Z . Packing with a length-item of a or Z may introduce "\000" characters, which Perl does not regard as legal in numeric strings.

The integer types s, S , l , and L may be immediately followed by a ! suffix to signify native shorts or longs--as you can see from above for example a bare l does mean exactly 32 bits, the native long (as seen by the local C compiler) may be larger. This is an issue mainly in 64-bit platforms. You can see whether using ! makes any difference by
	print length(pack("s")), " ", length(pack("s!")), "\n";
	print length(pack("l")), " ", length(pack("l!")), "\n";

i! and I! also work but only because of completeness; they are identical to i and I .

The actual sizes (in bytes) of native shorts, ints, longs, and long longs on the platform where Perl was built are also available via Config:
       use Config;
       print $Config{shortsize},    "\n";
       print $Config{intsize},      "\n";
       print $Config{longsize},     "\n";
       print $Config{longlongsize}, "\n";

(The $Config{longlongsize} will be undefined if your system does not support long longs.)

The integer formats s, S , i , I , l , L , j , and J are inherently non-portable between processors and operating systems because they obey the native byteorder and endianness. For example a 4-byte integer 0x12345678 (305419896 decimal) would be ordered natively (arranged in and handled by the CPU registers) into bytes as
 	0x12 0x34 0x56 0x78	# big-endian
 	0x78 0x56 0x34 0x12	# little-endian

Basically, the Intel and VAX CPUs are little-endian, while everybody else, for example Motorola m68k/88k, PPC, Sparc, HP PA, Power, and Cray are big-endian. Alpha and MIPS can be either: Digital/Compaq used/uses them in little-endian mode; SGI/Cray uses them in big-endian mode.

The names `big-endian' and `little-endian' are comic references to the classic "Gulliver's Travels" (via the paper "On Holy Wars and a Plea for Peace" by Danny Cohen, USC/ISI IEN 137, April 1, 1980) and the egg-eating habits of the Lilliputians.

Some systems may have even weirder byte orders such as
 	0x56 0x78 0x12 0x34
 	0x34 0x12 0x78 0x56

You can see your system's preference with
 	print join(" ", map { sprintf "%#02x", $_ }
                            unpack("C*",pack("L",0x12345678))), "\n";

The byteorder on the platform where Perl was built is also available via Config:
	use Config;
	print $Config{byteorder}, "\n";

Byteorders '1234' and '12345678' are little-endian, '4321' and '87654321' are big-endian.

If you want portable packed integers use the formats n , N , v , and V , their byte endianness and size are known. See also perlport.

Real numbers (floats and doubles) are in the native machine format only; due to the multiplicity of floating formats around, and the lack of a standard "network" representation, no facility for interchange has been made. This means that packed floating point data written on one machine may not be readable on another - even if both use IEEE floating point arithmetic (as the endian-ness of the memory representation is not part of the IEEE spec). See also perlport.

Note that Perl uses doubles internally for all numeric calculation, and converting from double into float and thence back to double again will lose precision (i.e., unpack("f", pack("f", $foo)) will not in general equal $foo).

If the pattern begins with a U , the resulting string will be treated as UTF-8-encoded Unicode. You can force UTF-8 encoding on in a string with an initial U0 , and the bytes that follow will be interpreted as Unicode characters. If you don't want this to happen, you can begin your pattern with C0 (or anything else) to force Perl not to UTF-8 encode your string, and then follow this with a U* somewhere in your pattern.

You must yourself do any alignment or padding by inserting for example enough 'x' es while packing. There is no way to pack() and unpack() could know where the bytes are going to or coming from. Therefore pack (and unpack) handle their output and input as flat sequences of bytes.

A ()-group is a sub-TEMPLATE enclosed in parentheses. A group may take a repeat count, both as postfix, and for unpack() also via the / template character. Within each repetition of a group, positioning with @ starts again at 0. Therefore, the result of
    pack( '@1A((@2A)@3A)', 'a', 'b', 'c' )

is the string "\0a\0\0bc".

x and X accept ! modifier. In this case they act as alignment commands: they jump forward/back to the closest position aligned at a multiple of count bytes. For example, to pack() or unpack() C's struct {char c; double d; char cc[2]} one may need to use the template C x![d] d C[2] ; this assumes that doubles must be aligned on the double's size.

For alignment commands count of 0 is equivalent to count of 1; both result in no-ops.

A comment in a TEMPLATE starts with # and goes to the end of line. White space may be used to separate pack codes from each other, but a ! modifier and a repeat count must follow immediately.

If TEMPLATE requires more arguments to pack() than actually given, pack() assumes additional "" arguments. If TEMPLATE requires fewer arguments to pack() than actually given, extra arguments are ignored.
)

 format =. 'c2 x5 C C x s d i l a6'
 ary    =. 1;_100;127;128;32767;(987.654321098 % 100.0);12345;123456;'abcdef'
 foo    =. format   pack foo
 ary2   =. format unpack ary

 ary -: ary2

 bits =. 2 ^ i.8
  16 -: '%32B*'  unpack a. {~ bits , 255 
  12 -: '%32b69' unpack a. {~ bits , 8b017
   9 -: '%32B69' unpack a. {~ bits , 8b017

 129 -: '%32B*'  unpack 'Now is the time for all good blurfl'  NB.  ASCII assumed

 (-: ]&.('I' pack))  16bffffffff
 
)

NULL =: {.a.

NB.  Pack an arbitrary string.
a =: _ & $: : (dyad define) :. ]
   assert. 'literal'-:datatype y
	x {.!.NULL y
)

pattern =: pack :. unpack
pack    =: star_repeats&$: : (repeats dyad data) 
unpack  =: monad : ((length_of_single_item , star_repeats) {~ ])

noun define

  a pattern is :
  default_length 
)

(#M) {. boxopen
