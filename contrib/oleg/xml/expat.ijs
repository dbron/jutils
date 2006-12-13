NB. expat -- xml parser library binding for J
NB.    based on Expat 2.0.0 version 01/11/06 
NB.    http://expat.sourceforge.net/
NB. Mac OS X build: http://www.wsanchez.net/
NB.
NB. 01/19/06 Oleg Kobchenko

require 'dll files strings'
coclass 'pexpat'

ADDONDIR=: '~addons/xml'
IFMACOSX=: fexist '/.DS_Store'

LIB=: jpath ADDONDIR,'/lib/libexpat.',((#.IFWIN32,IFMACOSX){::'so';'dylib';'dll';''),' '

cdecl=: ({. , ' +'"_ , }.)~ i.&' '
xcdm=: 1 : '(LIB,cdecl^:(-.IFWIN32) x)&(15!:0)'

ParserCreate=:             'XML_ParserCreate            i    *c    ' xcdm
ParserFree=:               'XML_ParserFree              i i        ' xcdm

SetElementHandler=:        'XML_SetElementHandler       i i  i i   ' xcdm
SetCharacterDataHandler=:  'XML_SetCharacterDataHandler i i  i     ' xcdm

Parse=:                    'XML_Parse                   i i  *c i i' xcdm

GetErrorCode=:             'XML_GetErrorCode            i i        ' xcdm
ErrorString=:              'XML_ErrorString             i i        ' xcdm
GetCurrentLineNumber=:     'XML_GetCurrentLineNumber    i i        ' xcdm
GetCurrentColumnNumber=:   'XML_GetCurrentColumnNumber  i i        ' xcdm


SZINT=: IF64{4 8

trim=: ] #~ [: -. [: (*./\. +. *./\) e.&(TAB,CRLF,' ')
memint=: memr@(,&(0,1,JINT))
memchr=: memr@(, (0: , ,&JCHAR))
memstr=: memr@(,&(0,_1,JCHAR))

attributes=: 3 : 0
  z=. empty''
  while. p=. memint y do.
    z=. z, (memstr p);memstr memint y+SZINT
    y=. y+2*SZINT
  end.
  z
)

getAttribute=: 4 : 0
  while. p=. memint x do.
    if. y-: memstr p do. memstr memint x+SZINT return.end.
    x=. x+2*SZINT
  end.
  _1
)

NB. =========================================================

seterr=: 3 : 0
  if. 3~:#y do. y=. 0;0 0;'' end.
  ('ERRCODE_pexpat_ ERRPOS_pexpat_ ERRMSG_pexpat_')=: y
  empty''
)
seterr''

geterr=: 3 : 0
  code=. 0{::GetErrorCode y
  line=. 0{::GetCurrentLineNumber y
  col=. 0{::GetCurrentColumnNumber y
  msg=. memstr 0{::ErrorString code
  seterr code;(line,col);msg
)

error=: 3 : 0
  if. ERRCODE_pexpat_=0 do. '' return. end.
  'xml error ',(":ERRCODE_pexpat_),' at (',(":ERRPOS_pexpat_),'): ',ERRMSG_pexpat_
)
