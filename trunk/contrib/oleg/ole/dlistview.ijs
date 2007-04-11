require'user\classes\ole\CImageList.ijs'
require'user\classes\ole\CListView.ijs'

SLV=: 0 : 0
pc slv;
xywh 6 30 177 94;cc ocx ocx:COMCTL.ListViewCtrl.1 rightmove bottommove;
xywh 160 6 22 10;cc icons ocx:comctl.ImagelistCtrl.1;
xywh 136 6 22 10;cc smallicons ocx:comctl.ImagelistCtrl.1;
xywh 6 8 16 10;cc label static;cn "View";
xywh 22 6 49 50;cc view combolist;
pas 6 6;pcenter;
rem form end;
)

slv_run=: 3 : 0
wd SLV

NB. init icons
lgimg=: 'icons'conew'CImageList'
smimg=: 'smallicons'conew'CImageList'
addicon__lgimg &.> (;:'lc lo wc wo'),&.><'.ico'
addicon__smimg &.> (;:'lc lo wc wo'),&.><'.ico'

NB. init list
lv=: ('ocx';lgimg,smimg)conew'CListView'
(;:'Name Size Date') addheadder__lv&.> 50 0;50 1;50 2
1 1 additem__lv 'Two Words';125;'1-1-97'
2 2 additem__lv 'bbb';126;'1-2-97'
3 3 additem__lv 'ccc';126;'1-3-97'
4 4 additem__lv 'ddd';128;'1-4-97'
enable__lv &.> ;:'itemclick columnclick'

wd'set view "0 Icon" "1 Small Icon" "2 List" "3 Report"; setselect view 0'
wd'pshow;'
)

slv_view_select=: 3 : 0
'view'setbase__lv {.view
)

slv_cancel=: slv_close
slv_close=: 3 : 0
destroy__lv''
destroy__lgimg''
destroy__smimg''
wd'pclose'
)
