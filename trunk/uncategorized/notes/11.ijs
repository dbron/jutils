   xsltest=: 0 : 0
<x:stylesheet version="1.0"
        xmlns:x="http://www.w3.org/1999/XSL/Transform" >
    <x:output method="text"/>
    <x:template match="Record">
        <x:for-each select="*">
            <x:value-of select="." /><x:text>|</x:text>
        </x:for-each>
        <x:text>&#10;</x:text>
    </x:template>
</x:stylesheet>
)

xmltest=: 0 : 0
<THETABLE>
<Record>
  <Item0>Blablabla</Item0>
  <Item1>19990920</Item1>
  <Item2>0</Item2>
  <Item3>0</Item3>
  <Item4>-1.1</Item4>
</Record>
<Record>
  <Item0>QWERTY</Item0>
  <Item1>19990920</Item1>
  <Item2>0</Item2>
  <Item3>0</Item3>
  <Item4>-1.1</Item4>
</Record>
</THETABLE>
)

noun define
   load'~user/xsl.ijs'

   xsltest transform_pxsl_ xmltest
Blablabla|19990920|0|0|-1.1|
QWERTY|19990920|0|0|-1.1|

   <;._2;._2 toJ xsltest transform_pxsl_ xmltest
+---------+--------+-+-+----+
|Blablabla|19990920|0|0|-1.1|
+---------+--------+-+-+----+
|QWERTY   |19990920|0|0|-1.1|
+---------+--------+-+-+----+
)

NB. ======================================


NB. xsl transformation
NB.
NB. useful for converting XML to flat text
NB. for furhter processing with J
NB.
NB. REQUIREMENT
NB.
NB.    MSXML v4 (Microsoft XML Core Services)
NB.       http://msdn.microsoft.com/xml
NB.
NB. USAGE
NB.
NB.    load'~user/xsl.ijs'
NB.    OUTEXT=: XSLTEXT transform_pxsl_ XMLTEXT
NB.
NB. Author: Oleg Kobchenko 11/24/2003

coclass 'pxsl'

NB.*parseError v comprehensive error report
NB. OUT=: XSL xsl XML
parseError=: 3 : 0
  wd 'oleget ',y.,' base parseError; oleid ',y.,' parseError'
  if. 0~:0".c=. wd 'oleget ',y.,' parseError errorCode;' do.
    line=. wd 'oleget ',y.,' parseError line;'
    pos=. wd 'oleget ',y.,' parseError linePos;'
    src=. wd 'oleget ',y.,' parseError srcText;'
    t=. 'Error ',c,' at ',line,',',pos
    t=. t,LF,wd 'oleget ',y.,' parseError reason;'
    if. #src do.
      t=. t,LF,src
      t=. t,LF,(}.(0".pos)#' '),'^'
    end.
    1[smoutput t
  else. 0 end.
)

NB.*transform v transforms xml with xsl
NB. OUT=: XSL xsl XML
transform=: 4 : 0
try.
  wd 'pc xslform'
  try.
    wd 'cc x oleautomation:MSXML2.DOMDocument.4.0'
    wd 'cc y oleautomation:MSXML2.DOMDocument.4.0'
  catch. smoutput 'MSXML v4 is required' throw. end.
  wd 'oleset x base async 0'
  wd 'olemethod x base loadXML *',x.
  if. parseError 'x' do. throw. end.
  wd 'oleset y base async 0'
  wd 'olemethod y base loadXML *',y.
  if. parseError 'y' do. throw. end.
  try.
    r=. wd 'olemethod y base transformNode !object:.x.base'
  catch. smoutput wd'qer' throw. end.
catcht. r=. '' end.
  wd 'pclose'
  r
)