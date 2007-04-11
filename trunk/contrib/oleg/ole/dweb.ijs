require'user\classes\ole\CWeb.ijs'

WEB=: 0 : 0
pc web;
tbar "system\examples\data\stdtbar.bmp";
tbarset "" 0 8;
tbarset idnew 1 0  "Clear URL" "New URL";
tbarset "" 2 2;
tbarset idopen 3 1  "Open URL" "Open URL";
tbarshow;
xywh 6 15 250 241;cc web ocx:Shell.Explorer.2 rightmove bottommove;
xywh 6 3 238 50;cc url combodrop rightmove;
xywh 244 2 12 12;cc logo richedit ws_disabled ws_thickframe es_autohscroll leftmove rightmove;
pas 6 6;pcenter;
rem form end;
)

web_run=: 3 : 0
wd WEB
NB. initialize form here
web=: ('web')conew'CWeb'
'AddressBar'setbase__web 1
t=. '{\rtf1{\fonttbl{\f0\fmodern\fprq1 Courier New;}}'
t=. t,'{\colortbl\red200\green200\blue255;}\pard\plain {\fs4  }'
wd'set logo *',t,'{\f0\fs28\cf0\b J}\plain\lang1049\f4\fs20\par}'
wd'setbkgnd logo 0 0 0'
t=. jpath '~user\classes\ole\j2.jpg'
wd'set url *about:<h1>Hello, <i>World </i>!</h1><img src="',t,'">'
wd'setselect url 0'
wd 'pshow;'
)

web_url_select=: web_url_button=: 3 : 0
'Navigate'dobase__web '*',url
)

web_cancel=: web_close
web_close=: 3 : 0
codestroy__web''
wd'pclose'
)
