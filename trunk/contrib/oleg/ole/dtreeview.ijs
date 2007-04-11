require'user\classes\ole\CImageList.ijs'
require'user\classes\ole\CTreeView.ijs'

ABC=: 0 : 0
pc abc;
xywh 5 24 181 145;cc tv ocx:comctl.TreeCtrl.1 rightmove bottommove;
xywh 146 3 41 10;cc images ocx:comctl.ImagelistCtrl.1;
xywh 7 14 24 10;cc label1 static;cn "PathSep";
xywh 35 12 23 50;cc ps combolist;
xywh 72 14 20 10;cc label2 static;cn "Indent";
xywh 95 12 23 50;cc ind combolist;
xywh 6 2 136 10;cc path static;
xywh 6 171 18 10;cc label static topmove bottommove;cn "Event:";
xywh 24 171 86 10;cc event static topmove bottommove;
pas 4 4;pcenter;
rem form end;
)

abc_run=:3 : 0
wd ABC
img=: 'images'conew'CImageList'
addicon__img &.> (;:'lc lo wc wo'),&.><'.ico'

tv=: ('tv';img)conew'CTreeView'
add__tv 'aaa'
add__tv 'bbb'
add__tv 'ccc'
add__tv 'ddd';'Two Words'
'bbb' add__tv 'bug';'Three Little Words'
'bbb' add__tv 'mug';'Another Word'
'bbb/bug' add__tv 'crud'
'bbb/bug/crud' add__tv 'fub'
'pathseparator'setbase__tv '"--"'
'indentation'setbase__tv 5
'linestyle'setbase__tv 1
enable__tv &.> ;:'nodeclick expand collapse afterlabeledit keypress dblclick'

wd 'set ps "--" "__" "->"; setselect ps 0'
wd 'set ind 0 10 25 45 100; setselect ind 0'
wd'pshow;'
)

abc_ps_select=: 3 : 0
'pathseparator'setbase__tv '*',ps
)

abc_ind_select=: 3 : 0
'indentation'setbase__tv ind
)

abc_tv_button=: 3 : 0
wd'set event ', sysocx
wd'set path *Path: ','event0'get__tv'fullpath'
)

abc_close=: 3 : 0
destroy__tv''
destroy__img''
wd'pclose'
)

abc_cancel=: 3 : 0
abc_close''
)
