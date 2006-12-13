NB. sax -- J wrapper for Simple API for XML
NB.    object-oriented wrapper for Expat library
NB.
NB. 01/19/06 Oleg Kobchenko

NB. require '~addons/xml/expat.ijs'
require '~user/util/contrib/oleg/xml/expat.ijs'

coclass 'psax'
coextend 'pexpat'

create=:  3 : 0
  PARSER=: 0{::ParserCreate <<0
  IGNOREWS=: 0
  seterr''
  SetElementHandler PARSER;(cdcb 3);(cdcb 2)
  SetCharacterDataHandler PARSER;cdcb 3
)

destroy=: 3 : 0
  empty ParserFree PARSER
)

parse=: 3 : 0
  if. 0=0{::Parse PARSER;y;(PARLEN=:#y);0+1 do.
    destroy geterr PARSER
    (assert~ error) 0 end.
)

startDocument=: ]
endDocument=: ]

startElement=: ]
endElement=: ]

characters=: ]

cdcallback=: 3 : 0
  if. 3=#y do.
    if. PARLEN(> *. 0&<@])2{y do.
      characters^:(*@#) trim^:IGNOREWS memchr/}.y return.end.
    (2{y) startElement memstr 1{y
  else.
    endElement memstr 1{y
  end.
)

process=: 3 : 0
  p=. '' conew >coname''
  startDocument__p''
  parse__p y
  ([ destroy__p) endDocument__p''
)

saxclass_z_=: cocurrent@(3 : 0) f.
  coclass y
  coextend 'psax'
  process=: process_psax_ f.
  y
)
