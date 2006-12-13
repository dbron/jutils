NB. ado wrapper
NB.
NB. useful for accessing data with ADO
NB. 
NB. REQUIREMENT
NB. 
NB.    MDAC 2.6, or above
NB.       http://msdn.microsoft.com/data
NB. 
NB. USAGE
NB. 
NB.    cs=. prompt_ado_''
NB.    myado=: cs&rs_ado_
NB.    myado 'select * from tdata'
NB. Macdonald B   	F	D101	19590600
NB. Genereaux S   	F	D103	19450300
NB. ...
NB. Livingston P  	F	D101	19580900
NB. Holliss D     	F	D101	19600500
NB. 
NB. Author: Oleg Kobchenko 03/09/2004

coclass 'ado'

NB.*prompt_ado_ v - select ado connection
NB.  cs=. prompt_ado_''
prompt=: 3 : 0
try.
  wd 'pc promptform'
  try.
    wd 'cc r oleautomation:DataLinks'
  catch. smoutput 'DataLinks is required' throw. end.
  try.
    wd 'olemethod r base PromptNew'
    r=. wd 'oleget r temp ConnectionString'
  catch. smoutput wd'qer' throw. end.
catcht. r=. '' end.
  wd 'pclose'
  r
)

NB.*rs_ado_ v - select with ado recordest
NB.  result=. strConnection rs_ado_ strSQL
rs=: 4 : 0
try.
  wd 'pc rsform'
  try.
    wd 'cc r oleautomation:ADODB.Recordset'
  catch. smoutput 'ADO is required' throw. end.
  try.
    wd 'oleset r base ActiveConnection *',x
    wd 'olemethod r base Open *',y
    if. '1'=wd 'oleget r base State' do.
      r=. wd 'olemethod r base GetString'
      wd 'olemethod r base Close'
    else.
      r=. 1
    end.
  catch. smoutput wd'qer' throw. end.
catcht. r=. '' end.
  wd 'pclose'
  r
)

NB. ==================================================

0 : 0 NB. press Ctrl+R on each line in succession

NB. select Microsoft Jet OLEDB, Next >>
NB. Select "<j home>\system\examples\data\jdata.mdb"

cs=. prompt_ado_''
myado=: cs&rs_ado_
myado 'select * from tdata'

myado 'create table test1 (aa char(10), bb integer)'
myado 'insert into test1 (aa,bb) values (''a1'',22)'
myado 'insert into test1 (aa,bb) values (''a2'',44)'
myado 'select * from test1'
myado 'drop table test1'
)
