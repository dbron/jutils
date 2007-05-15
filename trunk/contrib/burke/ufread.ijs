NB. unicode fread
NB.
NB. The following reads a file and returns a text string
NB. in utf8 format - the default for J.
NB.
NB. On error, a _1 is returned.
NB.
NB. Possible file types are:
NB.
NB.   2-byte unicode with a u16 BOM (byte order marker)
NB.   utf8 unicode with a u8 BOM
NB.   utf8 unicode with no BOM
NB.   8-bit ansi (ISO-8859-1 or Latin1)
NB.
NB. Requires the files script.

require 'strings files'

ufread=: 3 : 0
dat=. fread y
if. (dat -: _1) +. 0=#dat do. return. end.
NB. u16 marker:
if. (255 254 { a.) -: 2 {. dat do.
  dat=. utf8 6 u: 2 }. dat
NB. u8 marker:
elseif. (239 187 191 { a.) -: 3 {. dat do.
  dat=. 3 }. dat
NB. ansi codepage:
elseif. 0 -: 7 u: :: 0: dat do.
  val=. a. i. dat
  msk=. 127 < val
  uni=. 192 128 +"1 [ 0 64 #: msk # val
  val=. val #~ 1 j. msk
  ndx=. I. 127 < val
  dat=. a. {~ uni (ndx +/ 0 1) } val
end.
)

utf16LEto8			=:  utf8 @: (6&u:) @: dropBOM_bom_

cocurrent'bom'
T					=:  (>@:{. ; a. {~ 0 ". [: ;:^:_1 '16b' (, tolower) L: 0 }.)@:(' '&cut)@:deb;._2 TAB sr_base_ ' ' noun define
	UTF_8	    EF BB BF
	UTF_16_BE	FE FF
	UTF_16_LE	FF FE
	UTF_32_BE	00 00 FE FF
	UTF_32_LE	FF FE 00 00
	SCSU        0E FE FF
	UTF_7       2B 2F 76
	UTF_EBCDIC	DD 73 66 73
	BOCU_1      FB EE 28
)
'names bytes'		=:  <"1 |: (\: [:#&> {:"1) T
(names)				=:  bytes
NB.!  I need a more consistent way to handle
NB.!  variable-length BOMs.  Almost none of the 
NB.!  BOM functions will work correctly/consistently
NB.!  with UTF_7 .
UTF_7_trailers		=:  (a. {~ 0 ". [: ;:^:_1 '16b' (, tolower) L: 0 ' ' cut ])&.> '|' cut '38 | 39 | 2B | 2F | 38 2D'

bomer				=:  1 : ('b =. <u~';'t=.u,''_trailers''';'if. noun = nc{.;:t do. t =. t~ else. t =. a: end.';'e =. (;&.>,{b,&<t)';'e +./@:e.~(#&>e){.&.><')
BOMchecks			=:  ('is' 4 : ('(v=.x,y)=:y bomer';'v') ])&.> names
BOM					=:  (bytes, <'') {::~ i.&1@:(BOMchecks`:0) 
dropBOM				=:  #@:BOM }. ]