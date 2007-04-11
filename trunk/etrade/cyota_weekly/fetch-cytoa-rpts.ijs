require'task'
AxA =: 'WWW, OOO DD, YYYY' dateToString"1 ]BxB=:6{."1 todate (todayno 3{.6!:0'')-i.2 NB.(1+todayno 2007 03 15) + i.7
NB.assert 7-:#AxA  NB.  1 week exactly
NB.assert (>;:'Fri Thu') -: AxA ,;.0~ 2 2 2 $  0 0  1 3    _1 0  _1 3  NB.  Starting on Fri and ending on Thu

CxC =: 0 ". > LF cut toJ fread (tolower 2!:5'USERPROFILE'),'\My Documents\bkdwn.txt'

BxB =: CxC #~ -. fexist ((tolower 2!:5'USERPROFILE'),'\my documents\proj\cyota\report\data\event_breakdown\etrade_event_breakdown_reportYYYYMMDD.txt') <@dateToString"1 CxC

scpbk =: dltb TAB sr ' ' CRLF -.~ noun define

    "%userprofile%\my documents\app\putty\pscp.exe" logscan1m3:/etrade/adm/etadm/web/logs/logs/cyota/YYYY/MM/DD/etrade_event_breakdown_report.txt etrade_event_breakdown_reportYYYYMMDD.txt

)

cwd   =: 'cd /d "%USERPROFILE%\My Documents\proj\cyota\report\data\event_breakdown"'
getfs =:  scpbk dateToString"1 BxB
batch =:  , CRLF ,"1~ cwd, getfs 

batchf =: jpath '~temp\getfs.bat'
ferase batchf
assert -. fexist batchf
batch fwrite batchf
assert batch -: fread batchf
shell '"',batchf,'"'
ferase batchf
assert -. fexist batchf
smoutput 'hyperclams'

assert *./ fexist ((tolower 2!:5'USERPROFILE'),'\my documents\proj\cyota\report\data\event_breakdown\etrade_event_breakdown_reportYYYYMMDD.txt') <@dateToString"1 BxB