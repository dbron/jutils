require'user\classes\ole\CMSFlexGrid.ijs'

TEST=: 0 : 0
pc test;
xywh 6 19 235 140;cc fl ocx:MSFlexGridLib.MSFlexGrid.1 rightmove bottommove;
xywh 6 6 33 11;cc curcell edit ws_border es_autohscroll es_readonly;
xywh 41 6 115 11;cc val edit ws_border es_autohscroll rightmove;
xywh 159 6 47 50;cc align combolist ws_vscroll leftmove rightmove;
xywh 211 6 28 11;cc merge checkbox leftmove rightmove;cn "Merge";
pas 6 6;pcenter;
rem form end;
)

test_run=: 3 : 0
wd TEST
NB. initialize form here
fl=: 'fl'conew'CMSFlexGrid'
'AllowUserResizing'setbase__fl 3
'FocusRect'setbase__fl 2
'FillStyle'setbase__fl 1
'FormatString'setbase__fl ('*',,|:'|','^',:(65+i.26){a.),';',;'|'&,@":&.> <"0]1+i.1000
'ColWidth'setbase__fl _1 800
'ColWidth'setbase__fl 0 500
'MergeCells'setbase__fl 1
wd'set merge 1'
'MergeRow'setbase__fl 1 1
(1 2;1 3;1 4) setcell__fl &.><'Jan'
2 2 setmatrix__fl i.4 3
(1 5;1 6;1 7) setcell__fl &.><'Feb'
2 5 setmatrix__fl 20+i.4 3
enable__fl &.>;:'entercell selchange'
t=. '"0 Left top" "1 Left center" "2 Left bottom" "3 Center top" '
t=. t,'"4 Center center" "5 Center bottom" "6 Right top" "7 Right center" '
t=. t,'"8 Right bottom" "9 General"'
wd'set align ',t,'; setselect align 9'
wd 'pshow;'
)

test_val_button=: 3 : 0
'text'setbase__fl '*',val
wd'setfocus fl'
)

test_fl_button=: 3 : 0
wd'set val *','base'get__fl'text'
c=. (64+".'base'get__fl'col'){a.
r=. ":'base'get__fl'row'
cs=. (64+".'base'get__fl'colsel'){a.
rs=. ":'base'get__fl'rowsel'
t=. c,r
if. -.(c-:cs)*.(r-:rs) do. t=. t,':',cs,rs end.
wd'set curcell *', t
)

test_align_select=: 3 : 0
'CellAlignment'setbase__fl {.align
)

test_f2_fkey=: 3 : 0
wd'setfocus val'
)

test_merge_button=: 3 : 0
'MergeCells'setbase__fl merge
)

test_cancel=: test_close
test_close=: 3 : 0
codestroy__fl''
wd'pclose'
)

