require'dll'

coclass 'ptbtest'

PTBTEST=: 0 : 0
pc ptbtest;
menupop "&File";
menu new "&New" "" "" "";
menu open "&Open" "Ctrl+O" "tool tip" "status help text";
menusep ;
menu idquit "Quit" "" "" "";
menupopz;
menupop "&View";
menu idtb "Flip Toolbar" "" "" "";
menupopz;
menupop "&Help";
menu idhelp "&Contents" "" "" "";
menupopz;
tbar "system\examples\data\isitbar8.bmp";
tbarset idnew 0 0 "new file" "Create a new file.";
tbarset idsave 1 2 "save file" "Save file.";
tbarset "" 2 25;
tbarset idprint 3 6 "print file" "Print file";
tbarset "" 4 2400;
tbarshow;
xywh 0 0 250 150;cc ed editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll rightmove bottommove;
pas 0 0;
rem form end;
)

create=: 3 : 0
wd PTBTEST
formhwnd=: wd'qhwndp'
NB. initialize form here
wd'pshow'
flattoolbar ".formhwnd
)

destroy=: 3 : 0
wd 'pclose'
codestroy''
)

ptbtest_close=:destroy

formselect=: 3 : 'wd''psel '',formhwnd'

ptbtest_idtb_button=: 3 : 'flattoolbar ".formhwnd'

NB. ========================================== flat toolbar

TBSTYLE_FLAT=: 16b0800
GW_HWNDNEXT=: 2
WM_USER=: 16b0400
TB_SETSTYLE=: WM_USER + 56
TB_GETSTYLE=: WM_USER + 57
xor=: 22 b.

GetWindow=: 'user32 GetWindow i i i'&cd
SendMessage=: 'user32 SendMessageA i i i i i'&cd
InvalidateRect=: 'user32 InvalidateRect i i i i'&cd

ToolBarStyle=: 1 : 0
:
  t=. 0 pick SendMessage y;TB_GETSTYLE;0;0
  t=. x u t
  SendMessage y;TB_SETSTYLE;0;t
  InvalidateRect y;0;1
)

flattoolbar=: 3 : 0
  h=. 0 pick GetWindow y;GW_HWNDNEXT
  if. h do. TBSTYLE_FLAT xor ToolBarStyle h end.
)

NB. =======================================================

cocurrent 'base'
'' conew 'ptbtest'
