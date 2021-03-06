PERLDOC_DASH_F_PACK=:noun define
    pack TEMPLATE,LIST
            Takes a LIST of values and converts it into a string using the
            rules given by the TEMPLATE. The resulting string is the
            concatenation of the converted values. Typically, each converted
            value looks like its machine-level representation. For example,
            on 32-bit machines a converted integer may be represented by a
            sequence of 4 bytes.

            The TEMPLATE is a sequence of characters that give the order and
            type of values, as follows:

                a   A string with arbitrary binary data, will be null padded.
                A   An ASCII string, will be space padded.
                Z   A null terminated (asciz) string, will be null padded.

                b   A bit string (ascending bit order inside each byte, like vec()).
                B   A bit string (descending bit order inside each byte).
                h   A hex string (low nybble first).
                H   A hex string (high nybble first).

                c   A signed char value.
                C   An unsigned char value.  Only does bytes.  See U for Unicode.

                s   A signed short value.
                S   An unsigned short value.
                      (This 'short' is _exactly_ 16 bits, which may differ from
                       what a local C compiler calls 'short'.  If you want
                       native-length shorts, use the '!' suffix.)

                i   A signed integer value.
                I   An unsigned integer value.
                      (This 'integer' is _at_least_ 32 bits wide.  Its exact
                       size depends on what a local C compiler calls 'int',
                       and may even be larger than the 'long' described in
                       the next item.)

                l   A signed long value.
                L   An unsigned long value.
                      (This 'long' is _exactly_ 32 bits, which may differ from
                       what a local C compiler calls 'long'.  If you want
                       native-length longs, use the '!' suffix.)

                n   An unsigned short in "network" (big-endian) order.
                N   An unsigned long in "network" (big-endian) order.
                v   An unsigned short in "VAX" (little-endian) order.
                V   An unsigned long in "VAX" (little-endian) order.
                      (These 'shorts' and 'longs' are _exactly_ 16 bits and
                       _exactly_ 32 bits, respectively.)

                q   A signed quad (64-bit) value.
                Q   An unsigned quad value.
                      (Quads are available only if your system supports 64-bit
                       integer values _and_ if Perl has been compiled to support those.
                       Causes a fatal error otherwise.)

                f   A single-precision float in the native format.
                d   A double-precision float in the native format.

                p   A pointer to a null-terminated string.
                P   A pointer to a structure (fixed-length string).

                u   A uuencoded string.
                U   A Unicode character number.  Encodes to UTF-8 internally.
                    Works even if C<use utf8> is not in effect.

                w   A BER compressed integer.  Its bytes represent an unsigned
                    integer in base 128, most significant digit first, with as
                    few digits as possible.  Bit eight (the high bit) is set
                    on each byte except the last.

                x   A null byte.
                X   Back up a byte.
                @   Null fill to absolute position.

            The following rules apply:

            *       Each letter may optionally be followed by a number
                    giving a repeat count. With all types except "a", "A",
                    "Z", "b", "B", "h", "H", and "P" the pack function will
                    gobble up that many values from the LIST. A "*" for the
                    repeat count means to use however many items are left,
                    except for "@", "x", "X", where it is equivalent to "0",
                    and "u", where it is equivalent to 1 (or 45, what is the
                    same).

                    When used with "Z", "*" results in the addition of a
                    trailing null byte (so the packed result will be one
                    longer than the byte "length" of the item).

                    The repeat count for "u" is interpreted as the maximal
                    number of bytes to encode per line of output, with 0 and
                    1 replaced by 45.

            *       The "a", "A", and "Z" types gobble just one value, but
                    pack it as a string of length count, padding with nulls
                    or spaces as necessary. When unpacking, "A" strips
                    trailing spaces and nulls, "Z" strips everything after
                    the first null, and "a" returns data verbatim. When
                    packing, "a", and "Z" are equivalent.

                    If the value-to-pack is too long, it is truncated. If
                    too long and an explicit count is provided, "Z" packs
                    only "$count-1" bytes, followed by a null byte. Thus "Z"
                    always packs a trailing null byte under all
                    circumstances.

            *       Likewise, the "b" and "B" fields pack a string that many
                    bits long. Each byte of the input field of pack()
                    generates 1 bit of the result. Each result bit is based
                    on the least-significant bit of the corresponding input
                    byte, i.e., on "ord($byte)%2". In particular, bytes
                    ""0"" and ""1"" generate bits 0 and 1, as do bytes
                    ""\0"" and ""\1"".

                    Starting from the beginning of the input string of
                    pack(), each 8-tuple of bytes is converted to 1 byte of
                    output. With format "b" the first byte of the 8-tuple
                    determines the least-significant bit of a byte, and with
                    format "B" it determines the most-significant bit of a
                    byte.

                    If the length of the input string is not exactly
                    divisible by 8, the remainder is packed as if the input
                    string were padded by null bytes at the end. Similarly,
                    during unpack()ing the "extra" bits are ignored.

                    If the input string of pack() is longer than needed,
                    extra bytes are ignored. A "*" for the repeat count of
                    pack() means to use all the bytes of the input field. On
                    unpack()ing the bits are converted to a string of ""0""s
                    and ""1""s.

            *       The "h" and "H" fields pack a string that many nybbles
                    (4-bit groups, representable as hexadecimal digits,
                    0-9a-f) long.

                    Each byte of the input field of pack() generates 4 bits
                    of the result. For non-alphabetical bytes the result is
                    based on the 4 least-significant bits of the input byte,
                    i.e., on "ord($byte)%16". In particular, bytes ""0"" and
                    ""1"" generate nybbles 0 and 1, as do bytes ""\0"" and
                    ""\1"". For bytes ""a".."f"" and ""A".."F"" the result
                    is compatible with the usual hexadecimal digits, so that
                    ""a"" and ""A"" both generate the nybble "0xa==10". The
                    result for bytes ""g".."z"" and ""G".."Z"" is not
                    well-defined.

                    Starting from the beginning of the input string of
                    pack(), each pair of bytes is converted to 1 byte of
                    output. With format "h" the first byte of the pair
                    determines the least-significant nybble of the output
                    byte, and with format "H" it determines the
                    most-significant nybble.

                    If the length of the input string is not even, it
                    behaves as if padded by a null byte at the end.
                    Similarly, during unpack()ing the "extra" nybbles are
                    ignored.

                    If the input string of pack() is longer than needed,
                    extra bytes are ignored. A "*" for the repeat count of
                    pack() means to use all the bytes of the input field. On
                    unpack()ing the bits are converted to a string of
                    hexadecimal digits.

            *       The "p" type packs a pointer to a null-terminated
                    string. You are responsible for ensuring the string is
                    not a temporary value (which can potentially get
                    deallocated before you get around to using the packed
                    result). The "P" type packs a pointer to a structure of
                    the size indicated by the length. A NULL pointer is
                    created if the corresponding value for "p" or "P" is
                    "undef", similarly for unpack().

            *       The "/" template character allows packing and unpacking
                    of strings where the packed structure contains a byte
                    count followed by the string itself. You write
                    *length-item*"/"*string-item*.

                    The *length-item* can be any "pack" template letter, and
                    describes how the length value is packed. The ones
                    likely to be of most use are integer-packing ones like
                    "n" (for Java strings), "w" (for ASN.1 or SNMP) and "N"
                    (for Sun XDR).

                    The *string-item* must, at present, be ""A*"", ""a*"" or
                    ""Z*"". For "unpack" the length of the string is
                    obtained from the *length-item*, but if you put in the
                    '*' it will be ignored.

                        unpack 'C/a', "\04Gurusamy";        gives 'Guru'
                        unpack 'a3/A* A*', '007 Bond  J ';  gives (' Bond','J')
                        pack 'n/a* w/a*','hello,','world';  gives "\000\006hello,\005world"

                    The *length-item* is not returned explicitly from
                    "unpack".

                    Adding a count to the *length-item* letter is unlikely
                    to do anything useful, unless that letter is "A", "a" or
                    "Z". Packing with a *length-item* of "a" or "Z" may
                    introduce ""\000"" characters, which Perl does not
                    regard as legal in numeric strings.

            *       The integer types "s", "S", "l", and "L" may be
                    immediately followed by a "!" suffix to signify native
                    shorts or longs--as you can see from above for example a
                    bare "l" does mean exactly 32 bits, the native "long"
                    (as seen by the local C compiler) may be larger. This is
                    an is sue mainly in 64-bit platforms. You can see whether
                    using "!" makes any difference by

                            print length(pack("s")), " ", length(pack("s!")), "\n";
                            print length(pack("l")), " ", length(pack("l!")), "\n";

                    "i!" and "I!" also work but only because of
                    completeness; they are identical to "i" and "I".

                    The actual sizes (in bytes) of native shorts, ints,
                    longs, and long longs on the platform where Perl was
                    built are also available via the Config manpage:

                           use Config;
                           print $Config{shortsize},    "\n";
                           print $Config{intsize},      "\n";
                           print $Config{longsize},     "\n";
                           print $Config{longlongsize}, "\n";

                    (The "$Config{longlongsize}" will be undefine if your
                    system does not support long longs.)

            *       The integer formats "s", "S", "i", "I", "l", and "L" are
                    inherently non-portable between processors and operating
                    systems because they obey the native byteorder and
                    endianness. For example a 4-byte integer 0x12345678
                    (305419896 decimal) be ordered natively (arranged in and
                    handled by the CPU registers) into bytes as

                            0x12 0x34 0x56 0x78     # big-endian
                            0x78 0x56 0x34 0x12     # little-endian

                    Basically, the Intel and VAX CPUs are little-endian,
                    while everybody else, for example Motorola m68k/88k,
                    PPC, Sparc, HP PA, Power, and Cray are big-endian. Alpha
                    and MIPS can be either: Digital/Compaq used/uses them in
                    little-endian mode; SGI/Cray uses them in big-endian
                    mode.

                    The names `big-endian' and `little-endian' are comic
                    references to the classic "Gulliver's Travels" (via the
                    paper "On Holy Wars and a Plea for Peace" by Danny
                    Cohen, USC/ISI IEN 137, April 1, 1980) and the
                    egg-eating habits of the Lilliputians.

                    Some systems may have even weirder byte orders such as

                            0x56 0x78 0x12 0x34
                            0x34 0x12 0x78 0x56

                    You can see your system's preference with

                            print join(" ", map { sprintf "%#02x", $_ }
                                                unpack("C*",pack("L",0x12345678))), "\n";

                    The byteorder on the platform where Perl was built is
                    also available via the Config manpage:

                            use Config;
                            print $Config{byteorder}, "\n";

                    Byteorders "'1234'" and "'12345678'" are little-endian,
                    "'4321'" and "'87654321'" are big-endian.

                    If you want portable packed integers use the formats
                    "n", "N", "v", and "V", their byte endianness and size
                    is known. See also the perlport manpage.

            *       Real numbers (floats and doubles) are in the native
                    machine format only; due to the multiplicity of floating
                    formats around, and the lack of a standard "network"
                    representation, no facility for interchange has been
                    made. This means that packed floating point data written
                    on one machine may not be readable on another - even if
                    both use IEEE floating point arithmetic (as the
                    endian-ness of the memory representation is not part of
                    the IEEE spec). See also the perlport manpage.

                    Note that Perl uses doubles internally for all numeric
                    calculation, and converting from double into float and
                    thence back to double again will lose precision (i.e.,
                    "unpack("f", pack("f", $foo)") will not in general equal
                    $foo).

            *       If the pattern begins with a "U", the resulting string
                    will be treated as Unicode-encoded. You can force UTF8
                    encoding on in a string with an initial "U0", and the
                    bytes that follow will be interpreted as Unicode
                    characters. If you don't want this to happen, you can
                    begin your pattern with "C0" (or anything else) to force
                    Perl not to UTF8 encode your string, and then follow
                    this with a "U*" somewhere in your pattern.

            *       You must yourself do any alignment or padding by
                    inserting for example enough "'x'"es while packing.
                    There is no way to pack() and unpack() could know where
                    the bytes are going to or coming from. Therefore "pack"
                    (and "unpack") handle their output and input as flat
                    sequences of bytes.

            *       A comment in a TEMPLATE starts with "#" and goes to the
                    end of line.

            *       If TEMPLATE requires more arguments to pack() than
                    actually given, pack() assumes additional """"
                    arguments. If TEMPLATE requires less arguments to pack()
                    than actually given, extra arguments are ignored.

            Examples:

                $foo = pack("CCCC",65,66,67,68);
                # foo eq "ABCD"
                $foo = pack("C4",65,66,67,68);
                # same thing
                $foo = pack("U4",0x24b6,0x24b7,0x24b8,0x24b9);
                # same thing with Unicode circled letters

                $foo = pack("ccxxcc",65,66,67,68);
                # foo eq "AB\0\0CD"

                # note: the above examples featuring "C" and "c" are true
                # only on ASCII and ASCII-derived systems such as ISO Latin 1
                # and UTF-8.  In EBCDIC the first example would be
                # $foo = pack("CCCC",193,194,195,196);

                $foo = pack("s2",1,2);
                # "\1\0\2\0" on little-endian
                # "\0\1\0\2" on big-endian

                $foo = pack("a4","abcd","x","y","z");
                # "abcd"

                $foo = pack("aaaa","abcd","x","y","z");
                # "axyz"

                $foo = pack("a14","abcdefg");
                # "abcdefg\0\0\0\0\0\0\0"

                $foo = pack("i9pl", gmtime);
                # a real struct tm (on my system anyway)

                $utmp_template = "Z8 Z8 Z16 L";
                $utmp = pack($utmp_template, @utmp1);
                # a struct utmp (BSDish)

                @utmp2 = unpack($utmp_template, $utmp);
                # "@utmp1" eq "@utmp2"

                sub bintodec {
                    unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
                }

                $foo = pack('sx2l', 12, 34);
                # short 12, two zero bytes padding, long 34
                $bar = pack('s@4l', 12, 34);
                # short 12, zero fill to position 4, long 34
                # $foo eq $bar

            The same template may generally also be used in unpack().

)

spc   =. ' '
types =. 'aA Z bB hH cC sS iI lL nN vV qQ fd pP uU w xX @' -. ' '
count =. '0123456789','*'
meta  =. '!/'
comm  =. '#',LF

<line>     =: <template>[<comment>]
<template> =: [<slashless> '/' ]<slashless>[count]



NB. an int followed by an unsigned short, two doubles, and a null-terminated (C) string
iSd2Z =: 'iSd2Z*' pack 
iSd2Z 1023;23;12.34;56.78;'hello'
dfh=:16&#.@:(16&| + *&10@:>:&16) @: ('0123456789ABCDEFabcdef'&i.)
GOOD_ANSWER =: a. {~  dfh&> ' ' slice 

Input  =:  1023        ; 23     ; 12.34                   ;  56.78                  ; 'hello'
Output =: 'ff 03 00 00   17 00    ae 47 e1 7a 14 ae 28 40    a4 70 3d 0a d7 63 4c 40   68 65 6c 6c 6f 00'

input  =: iSd2Z input
output =: a. {~  dfh&> ' ' slice Output
