NB. interface to Win32api clipboard functionality
NB.
NB. SYNOPSIS:
NB.   clbDir''                       NB. sniff for what's available
NB.   (clbRead'') fwrite <'clb.txt'  NB. sneak into a file
NB.
NB.   H=. takestr clbRead 'html format' NB. get a web page
NB.
NB.   R=. takestr clbRead CF_RTF     NB. get an rtf passage
NB.   R1=.'{\rtf1\ansi{\fonttbl{\f0 Symbol;}}\f0 a+b=g}'
NB.   R1 clbSet CF_RTF               NB. set RTF, see clbOther formats
NB.
NB.   D=. clbRead CF_DIB     NB.
NB.   D=. clbRead 'cf_dib'   NB. same ways to get bitmaps
NB.   D=. clbRead 8          NB. see win32 api for dib format
NB.
NB.   clbEmpty''           NB. tabula rasa
NB.
NB.   (i.3 4) clbSet 'J Data'        NB. save in one session...
NB.   3 4 -: $A=. clbRead 'J Data'   NB. ... retrieve in another
NB.
NB. INSTAL: add ``clipbrd <path>\clipbrd z''
NB.           into system\extras\config\scripts.ijs
NB. USE:    load'clipbrd'
NB. HELP:   scriptdoc'clipbrd'
NB.
NB. SEE ALSO:
NB.   the source clipbrd.ijs for clipboard constants and more, esp. clbRead
NB.   format library for clipfmt and clipunfmt
NB.   wd commands for clipcopy, clipcopyx, clippaste
NB.
NB. NOTE: implemented in accordance with J winapi practices
NB. AUTHOR: Oleg Kobchenko

require 'stdlib winlib dll files'
'z' require'system\examples\winapi\winapi.ijs'
win32apif=: 1 : '{.@>@{.@(x win32api)'
ntype=: 3!:0
uc=: 223&AND"0&.(a.&i.)

NB.*takestr v take leading non-zero chars from string
NB. form: str=. takestr zstr
takestr=: {.~ i.&(0{a.)

NB.*clbEnum v return a list of available clipboard formats
NB. form: fmts=. clbEnum''
clbEnum=: monad define
if. 0 >: c=. CountClipboardFormats'' do. '' return. end.
res=. ,0
OpenClipboard ".wd'qhwndx'
for_i. i.c do.
	res=. res,EnumClipboardFormats {:res
end.
CloseClipboard''
}.res
)

NB.*clbFormat v get int format representation
NB.   backups [fmt] in other funcs
NB. form: fmt=. clbFormat fmt
NB.   fmt: is either integer or (boxed) string value
NB.     for standard constants or Registered formats
NB. see: clbAvailable, RegisterClipboardFormat
NB. e.g.
NB.   clbDataFormat 'cf_text'   NB.
NB.   clbDataFormat <'cf_text'  NB. three equivalent forms
NB.   clbDataFormat 1           NB. (0 if 1 is not on the clipboard)
NB.
NB.   clbRead 'html text'   NB. same for other functs with [fmt] arg
clbFormat=: monad define
if. ''-:y do. 0 return. end.
if. (ntype fmt=. {.;y) e. JB01,JINT do.
  if. CF_REGGEDFIRST > fmt do.
    if. -. fmt e. ".>clbFmt do. 0 return. end.
  else.
    if. '' -: clbFormatName fmt do. 0 return. end.
  end.
else.
  if. (#clbFmt) > ndx=. clbFmt i. uc &.>boxopen y do.
    fmt=. ".>ndx { clbFmt
  else.
    fmt=. RegisterClipboardFormat y
  end.
end.
fmt
)

NB.*clbAvailable v valid format or first available
NB. form: fmt=. clbAvailable [fmt]
NB. NOTE: sames as clbFormat, but returns the first valid format
NB.       if format is not present
NB. e.g.
NB.   clbAvailable ''                   NB. first available format
NB.   clbFormatName clbAvailable ''  NB. name for first available format
NB.   clbDataFormat 'cf_text'   NB. equivalent forms (but not 1
NB.   clbDataFormat 1           NB. if cf_text is not on the clipboard)
clbAvailable=: monad define
if. IsClipboardFormatAvailable fmt=. clbFormat y do.
  fmt
else.
  {.clbEnum''
end.
)

NB.*clbFormatName v useful for user defined formats
NB. form: name=. clbFormatName fmt
clbFormatName=: verb define
fmt=. {.y
if. (#clbFmt) > ndx=. (".>clbFmt) i. fmt do.
  > ndx { clbFmt
else.
  cFormatName=. 32
  takestr > 2&{ GetClipboardFormatName fmt;(cFormatName$'z');cFormatName
end.
)

NB.*clbSize v get data size for given format
NB. form: size=. [type=JCHAR] clbSize [fmt]
clbSize=: verb define
'' clbSize y
:
if. 0 >: hglb=. clbGetHandle y do. _1 return. end.
res=. GlobalSize hglb

type=. {.x,JCHAR
if. -. type e. JCHAR,JINT,JFL,JCMPX do. type=.JCHAR end.
res=. >. res % ((JCHAR,JINT,JFL,JCMPX)i.type){1 4 8 16 1
res
)

NB.*clbDir v list available formats with size and name
NB. form: fmts=. clbDir''
clbDir=: monad define
(<"0 ,. clbSize&.> ,. clbFormatName&.>) clbEnum''
)

NB.*clbRead v read clipboard data
NB. form: data=. [type=JCHAR] clbRead [fmt]
NB. see: takestr, clbSet, GetClipboardData
clbRead=: verb define
'' clbRead y
:
type=. {.x,JCHAR
if. -. type e. JCHAR,JINT,JFL,JCMPX do. type=.JCHAR end.
fmt=. clbAvailable y
if. (fmt e.(CF_TEXT, CF_OEMTEXT)) *. type = JCHAR do.
	count=. _1 else. count=. type clbSize fmt end.
if. 0 >: hglb=. clbGetHandle fmt do. _1 return. end.
NB.if. 0 >: lpvoid=. GlobalLock hglb do. _1 return. end.
res=. memr hglb,0,count,type
NB.GlobalUnlock hglb
if. fmt >: CF_REGGEDFIRST do.
	name=. clbFormatName fmt
	if.		CF_VRML -: name do. res=. takestr res
	elseif.	CF_JDATA -: name do. res=. 3!:2 res
	end.
end.
res
)

NB.*clbSet v set clipboard data
NB. form: handle=. data clbSet fmt
NB.   data: typically JCHAR, or else fmt is CF_JDATA
NB.     scalar int is treated as handle and put as is
NB.   fmt: should be definite, unlike [fmt] in clbDataFormat:
NB.     int or name, for standard CF_XXX formats or
NB.     strictly name, in which case Registration is done.
NB. see: clbRead, SetClipboardData
clbSet=: dyad define
if. 0= fmt=. clbFormat y do. 0 return. end.
if. (0=$$ x) *. (JINT=ntype x) do.
  handle =. x
else.
  if. JCHAR=ntype x do.
    handle=. 'GlobalAlloc'win32apif (OR/ >{.winconst 'GMEM_MOVEABLE GMEM_DDESHARE');len=. 1+{.$;x
	addr=. GlobalLock handle
    x memw addr,0,len, JCHAR   NB. is implied
    GlobalUnlock handle
  else.
    binrep=. 3!:1 x
    len=. {.$binrep
    handle=. 'GlobalAlloc'win32apif (OR/ >{.winconst 'GMEM_MOVEABLE GMEM_DDESHARE');len
	addr=. GlobalLock handle
    binrep memw addr,0,len, JCHAR NB. format of binrep
    GlobalUnlock handle
  end.
end.
OpenClipboard ".wd'qhwndx'
handle=. SetClipboardData fmt;handle
CloseClipboard''
handle
)

NB.*clbEmpty v empty clipboard data
NB. form: boolSuccess=. clbEmpty ''
NB. see: EmptyClipboard
clbEmpty=: verb define
res=.0
CloseClipboard''[res=.EmptyClipboard''[OpenClipboard ".wd'qhwndx'
res
)

NB.*clbGetHandle v get clipboard data handle
NB. form: hglb=. clbGetHandle [fmt]
NB. see: GetClipboardData, GlobalSize, memr
NB. NOTE: if memory handle -- Size and Reading is appropriate
NB.       for certain types this a resoure handle: CF_BITMAP, etc,
NB.       and special functions for working with resources are required
clbGetHandle=: monad define
fmt=. clbAvailable y
if. 0 = IsClipboardFormatAvailable fmt do. _1 return. end.
OpenClipboard ".wd'qhwndx'
hglb=. GetClipboardData fmt
CloseClipboard''
hglb
)

NB. the rest is from Win32 API

NB.*IsClipboardFormatAvailable v Win32api
NB. form: bool=. IsClipboardFormatAvailable fmt
IsClipboardFormatAvailable=: 'IsClipboardFormatAvailable'win32apif

NB.*CountClipboardFormats v Win32api
NB. form: count=. CountClipboardFormats ''
CountClipboardFormats=: 'CountClipboardFormats'win32apif

NB.*OpenClipboard v Win32api
NB. form: count=. OpenClipboard apphandle
NB. see: CloseClipboard
NB. NOTE: typically,  apphandle=. ".wd'qhwndx'
OpenClipboard=: 'OpenClipboard'win32apif

NB.*EnumClipboardFormats v Win32api
NB. form: nextfmt=. EnumClipboardFormats prevfmt
NB. see: OpenClipboard, CloseClipboard, CountClipboardFormats
NB. NOTE: fmt starts with 0 and iterates over all formats
  EnumClipboardFormats=: 'EnumClipboardFormats'win32apif

NB.*GetClipboardData v Win32api
NB. form: handle=. GetClipboardData fmt
NB. see: OpenClipboard, CloseClipboard, clbGetHandle
  GetClipboardData=: {.@>@{.@('user32 GetClipboardData i i'&cd) NB. wrong def at win32api.dat

NB.*SetClipboardData v Win32api
NB. form: handle=. SetClipboardData fmt;handle
NB. see: OpenClipboard, CloseClipboard, clbSet
NB. NOTE: Returns 0 if fails. handle must not be freed afterwards.
  SetClipboardData=: {.@>@{.@('user32 SetClipboardData i i i'&cd) NB. wrong def at win32api.dat

NB.*EmptyClipboard v Win32api
NB. form: boolSuccess=. EmptyClipboard ''
NB. e.g.
NB.   CloseClipboard''[EmptyClipboard''[OpenClipboard ".wd'qhwndx'
  EmptyClipboard=: 'EmptyClipboard'win32apif

NB.*CloseClipboard v Win32api
NB. see: OpenClipboard
NB. form: count=. CloseClipboard ''
CloseClipboard=: 'CloseClipboard'win32apif

NB.*GetClipboardFormatName v Win32api
NB. see: clbFormatName, takestr
NB. form: boxed=. GetClipboardFormatName fmt;str;strlen
GetClipboardFormatName=: 'GetClipboardFormatNameA'win32api

NB.*RegisterClipboardFormat v Win32api
NB. see: clbFormatName, clbDataFormat, GetClipboardFormatName
NB. form: fmt=. RegisterClipboardFormat str
RegisterClipboardFormat=: 'RegisterClipboardFormat'win32apif@boxopen

NB.*clbFmt n Win32api
NB. boxed list of standard format names, which are globally defined
clbFmt=: ;:'CF_TEXT CF_BITMAP CF_METAFILEPICT CF_SYLK CF_DIF CF_TIFF'
clbFmt=:clbFmt,;:'CF_OEMTEXT CF_DIB CF_PALETTE CF_PENDATA CF_RIFF CF_WAVE'
clbFmt=:clbFmt,;:'CF_UNICODETEXT CF_ENHMETAFILE CF_HDROP CF_LOCALE CF_MAX'
clbFmt=:clbFmt,;:'CF_OWNERDISPLAY CF_DSPTEXT CF_DSPBITMAP CF_DSPMETAFILEPICT'
clbFmt=:clbFmt,;:'CF_DSPENHMETAFILE CF_PRIVATEFIRST CF_PRIVATELAST'

winset clbFmt

CF_REGGEDFIRST     =: 16bc000  NB. customized values
CF_REGGEDLAST      =: 16bffff

NB.*clbOther n a set of useful format shortcuts
NB. boxed list of custom format names, which are globally defined
'CF_HTML CF_RTF CF_CSV CF_VRML CF_JDATA'=: clbOther=: <;._2(0 : 0)
HTML Format
Rich Text Format
Csv
Moving Worlds Nodes
J Data
)

NB.*GlobalSize v Win32api
NB. see: GlobalLock, GlobalUnlock
NB. form: count=. GlobalSize handle
NB. NOTE: need not GlobalLock
GlobalSize=: 'GlobalSize'win32apif

NB.*GlobalLock v Win32api
NB. see: GlobalSize, GlobalUnlock
NB. form: addr=. GlobalLock handle
GlobalLock=: 'GlobalLock'win32apif

NB.*GlobalUnlock v Win32api
NB. see: GlobalLock
NB. form: addr=. GlobalUnlock handle
GlobalUnlock=: 'GlobalUnlock'win32apif

