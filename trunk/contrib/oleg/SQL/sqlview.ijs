NB. sqlview v0.01 - simple ODBC sql query viewer
NB.
NB. Usage:
NB.   1. Make sure the necessary ODBC DSN exists
NB.      use Control Panel ODBC utility
NB.   2. Click '...' and connect to a DSN
NB.   3. Build an SQL statement using comboboxes:
NB.      - Tables: select to choose Fields, [Enter] to insert
NB.      - Fields: select or [Enter] to insert
NB.   4. Click Go! to execute the SQL query
NB.   5. Click Discon to disconnect and select a new DSN

require'dd'

SQLVIEW=: 0 : 0
pc sqlview;
xywh 0 28 200 60;cc input editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll rightmove bottomscale;
xywh 0 88 200 100;cc output editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly topscale rightmove bottommove;
xywh 2 3 13 10;cc label static;cn "dsn:";
xywh 13 1 119 11;cc dsn edit es_autohscroll es_readonly rightmove;
xywh 136 1 10 11;cc btnBrowse button leftmove rightmove;cn "...";
xywh 148 1 24 11;cc btnDiss button ws_disabled leftmove rightmove;cn "Discon";
xywh 174 1 26 11;cc btnGo button ws_disabled leftmove rightmove;cn "Go!";
xywh 2 17 17 10;cc label static;cn "Tables";
xywh 20 15 80 50;cc cbT combodrop ws_vscroll cbs_autohscroll;
xywh 103 17 16 10;cc label static;cn "Fields";
xywh 120 15 80 50;cc cbF combodrop ws_vscroll cbs_autohscroll;
pas 0 0;pcenter;
rem form end;
)

CH=: 0

sqlview_run=: 3 : 0
wd SQLVIEW
NB. initialize form here
wd'setfont input "Fixedsys" 10 default'
wd'setfont output "Courier New" 11 oem'
wd'set input *', 'SELECT *',LF,'FROM cust',LF,'WHERE id=1;',LF
wd'set output *', ,,&LF"1":<"0 i.3
wd'set dsn *<not connected>'
wd 'pshow;'
)

sqlview_close=: 3 : 0
if. CH>0 do.
    dddis CH
    CH=: 0
end.
wd'pclose'
)

sqlview_btnBrowse_button=: 3 : 0
'r n'=. ;wdselect dsn=.{.|:ddsrc''
wd'psel sqlview'
if. r do.
try.
    CH=:ddcon'dsn=',>n{dsn
    wd'set dsn *',>n{dsn
    wd'setenable btnBrowse 0'
    wd'setenable btnDiss 1'
    wd'setenable btnGo 1'
    sh=. ddtbl CH
    wd'set cbT *',;,&LF&.>2{|:ddfet sh,_1
catch.
    wdinfo dderr''
    CH=: 0
end.
end.
)

sqlview_btnDiss_button=: 3 : 0
if. CH>0 do.
    dddis CH
    CH=: 0
    wd'set dsn *<not connected>'
    wd'setenable btnBrowse 1'
    wd'setenable btnDiss 0'
    wd'setenable btnGo 0'
end.
)

sqlview_btnGo_button=: 3 : 0
if. (CH>0) *. (0<#input) do.
    try.
        SH=: input ddsel CH
        NB. r=. (ddfch ,:~ ddcnm) SH,_1
        n=. ddcnm SH,_1
        d=. >&.><"1|: ddfet SH,_1
        ddend CH
        wd'set output *',,,&LF"1": n,:d
    catch.
        wdinfo dderr''
        SH=: 0
    end.
end.
)

sqlview_cbT_select=: 3 : 0
wd'set cbF *',;,&LF&.>}.3{|:cbT ddcol CH
)

sqlview_cbT_button=: 3 : 0
wd'setreplace input *', cbT
)

sqlview_cbF_select=: sqlview_cbF_button=: 3 : 0
wd'setreplace input *', cbF
)

