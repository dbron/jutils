require'user\classes\ole\CImageList.ijs'
require'user\classes\ole\CListView.ijs'
require'user\classes\ole\CTreeView.ijs'
require'scriptdoc'
coclass'pdbrowse'
dbr_z_=: br_run_pdbrowse_

BR=: 0 : 0
pc br;
sbar 4;
sbarset idsthelp 80 "Object Browser/ListView";
sbarset idsttype 30 "Type";
sbarset idstshape 30 "shape";
sbarset idstsize 40 "size";
sbarshow;
tbar "user\classes\ole\obbar.bmp" 14 tbstyle_flat;
tbarset tbtop 0 14 "Toggle stay on top" "Stay on top";
tbarset "" 1 8;
tbarset tbrefresh 2 9 "Refresh contents" "Refresh";
tbarset "" 3 8;
tbarset tbexpand 4 12 "Expand Tree" "Expand";
tbarset tbcollapse 5 13 "Collapse Tree" "Collapse";
tbarset "" 6 8;
tbarset tblist 7 10 "List View" "List";
tbarset tbreport 8 11 "Report View" "Report";
tbarset "" 9 8;
tbarset tbcopy 10 4 "Copy name" "Copy";
tbarset "" 11 8;
tbarset tbopen 12 1 "Open script" "Open";
tbarset tbsd 13 8 "Scriptdoc" "Scriptdoc";
tbarshow;
xywh 0 0 100 120;cc tv ocx:COMCTL.TreeCtrl.1 bottommove;
xywh 102 0 189 120;cc lv ocx:COMCTL.ListViewCtrl.1 rightmove bottommove;
xywh 265 0 19 10;cc img ocx:COMCTL.ImageListCtrl.1;
pas 0 0;pcenter;
rem form end;
)

0 : 0   NB. Alternative ComCtl32
xywh 0 0 100 120;cc tv ocx:MSComctlLib.TreeCtrl.2 bottommove;
xywh 102 0 189 120;cc lv ocx:MSComctlLib.ListViewCtrl.2 rightmove bottommove;
xywh 265 0 19 10;cc img ocx:MSComctlLib.ImageListCtrl.2;
)

br_run=: 3 : 0
  wd BR
  img=: 'img'conew'CImageList'
  t=. (;:'sc so tc to pc po hc ho ic io fc fo'),&.><'.bmp'
  addicon__img &.> ((;:'wc wo wc wo'),&.><'.ico'),t
  tv=: ('tv';img)conew'CTreeView'
  KEYSEP__tv=: '\'
  'indentation'setbase__tv 5
  'linestyle'setbase__tv 1
  lv=: ('lv';img,img)conew'CListView'
  t=. 100 0;50 1;120 1;36 0;24 0
  (;:'Name Size TimeStamp Access Attr') addheadder__lv&.> t
  'View'setbase__lv 2
  enable__tv &.> ;:'nodeclick'
  br_tbrefresh_button''
  wd'set tbtop 0'
  wd 'pshow;'
)

lstdirs=: (#~ 'd'"_ (e."1) _1&{::"1)@(1!:0)

addnode=: 3 : 0
  add__tv y.
  P=. y.
  (<P) addnode &.> {."1 lstdirs P,'\*'
  empty''
  :
  x. add__tv y.
  P=. x.,'\',y.
  (<P) addnode &.> {."1 lstdirs P,'\*'
  empty''
)

br_close=: 3 : 0
  destroy__lv''
  destroy__tv''
  destroy__img''
  wd'pclose'
)

br_tbrefresh_button=: 3 : 0
  'nodes'do__tv'clear'
  'items'do__lv'clear'
  add__tv'R_O_O_T';'<<Home>>'
  addnode &.> {."1 lstdirs'*'
)

NB. sc so tc to pc po hc ho ic io (fc fo)
EXT=: ;:&.><;._2(0 : 0)
js ijs
txt doc
exe bat com dll
hlp chm
ico bmp gif jpg pcx
)

fileext=: 1&{.@}.@(<;._1)@('.'&,)

br_tv_button=: 3 : 0
  if. 'R_O_O_T'-:key=. 'event0'get__tv'key' do. key=. '.' end.
  wd'set idsthelp *Path: ',key
  'items'do__lv'clear'
  for_i. i.#d=. thedir key,'\*.*' do.
    t=. 4+(,>:)+:(i.1:);(<fileext tolower>{.i{d)e.&.> EXT
    t additem__lv ,i{d
  end.
)

br_tblist_button=: wd bind 'oleset lv base view 2'
br_tbreport_button=: wd bind 'oleset lv base view 3'

br_tbexpand_button=: nodeexpand bind 1
br_tbcollapse_button=: nodeexpand bind 0
nodeexpand=: 3 : 0
  for_i. >:i.".'nodes'get__tv'count' do.
    'curnode'setid__tv'nodes item ',":i
    'curnode'set__tv'expanded ',":y.
  end.
  'items'do__lv^:(-.y.)'clear'
)

thedir=: 3 : 0
  y=. y.,(0=#y.)#'*.*'
  y=. y,(':\' e.~ {:y)#'*.*'
  if. 0=#dr=. 1!:0 y do. empty'' return. end.
  fls=. 'd' ~: 4{"1>4{"1 dr
  dr=. fls#dr
  if. 0=#dr do. empty'' return. end.
  ts=. >1{"1 dr
  mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
  f=. > @ ([: _2&{. [: '0'&, ": )&.>
  'y m d h n s'=. f&> ,<"1 |: 100|ts
  m=. (1{"1 ts){mth
  time=. d,.'-',.m,.'-',.y,.' ',.h,.':',.n,.':',.s
  0 2 1 3 4{"1(<"1 time) 1}"0 1 dr
)

br_tbcopy_button=: wd@('clipcopy '&,)@selecteditem
br_tbopen_button=: open@selecteditem
br_tbsd_button=: scriptdoc@selecteditem
br_tbopen_button=: open@selecteditem
selecteditem=: 3 : 0
  try.
    setid__lv'base selecteditem' [ setid__tv'base selecteditem'
    if. 'R_O_O_T'-: }:p=. '\',~'selecteditem'get__tv'key' do. p=. '' end.
    if. a:-:{.fileext f=. 'selecteditem'get__lv'text' do. f=. f,'.' end.
    p,f
  catch.
    empty wdinfo'nothing selected'
  end.
)

br_tbtop_button=: 3 : 0
  wd'psel br; ptop ', tbtop
)
