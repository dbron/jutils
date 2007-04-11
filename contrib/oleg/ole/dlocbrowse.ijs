require '~user\util\contrib\oleg\ole\CImageList.ijs'
require '~user\util\contrib\oleg\ole\CListView.ijs'
require '~user\util\contrib\oleg\ole\CTreeView.ijs'
require'coutil scriptdoc'
coclass'plocbrowse'
locbr_z_=: br_run_plocbrowse_

NCOBJ=: '9'
BR=: 0 : 0
pc br;
sbar 4;
sbarset idsthelp 80 "Object Browser/ListView";
sbarset idsttype 30 "Type";
sbarset idstshape 30 "shape";
sbarset idstsize 40 "size";
sbarshow;
tbar "c:\documents and settings\dbron\my documents\app\j\current\user\util\contrib\oleg\ole\obbar.bmp" 16 tbstyle_flat;
tbarset tbdata 0 0 "Toggle Data Window" "Data";
tbarset "" 1 8;
tbarset tbtop 2 14 "Toggle stay on top" "Stay on top";
tbarset "" 3 8;
tbarset tbrefresh 4 9 "Refresh contents" "Refresh";
tbarset "" 5 8;
tbarset tbexpand 6 12 "Expand Tree" "Expand";
tbarset tbcollapse 7 13 "Collapse Tree" "Collapse";
tbarset "" 8 8;
tbarset tblist 9 10 "List View" "List";
tbarset tbreport 10 11 "Report View" "Report";
tbarset "" 11 8;
tbarset tbcopy 12 4 "Copy name" "Copy";
tbarset "" 13 8;
tbarset tbopen 14 1 "Open script" "Open";
tbarset tbsd 15 8 "Scriptdoc" "Scriptdoc";
tbarshow;
xywh 0 0 74 130;cc tv ocx:MSComctlLib.TreeCtrl.2 ws_border bottommove;
xywh 76 0 235 130;cc lv ocx:MSComctlLib.ListViewCtrl.2 ws_border rightmove bottommove;
xywh 265 5 19 10;cc img ocx:MSComctlLib.ImageListCtrl.2;
pas 0 0;
rem form end;
)

0 : 0   NB. Alternative ComCtl32
xywh 0 0 74 130;cc tv ocx:MSComctlLib.TreeCtrl.2 ws_border bottommove;
xywh 76 0 235 130;cc lv ocx:MSComctlLib.ListViewCtrl.2 ws_border rightmove bottommove;
xywh 265 5 19 10;cc img ocx:MSComctlLib.ImageListCtrl.2;
)

br_run=: 3 : 0
  wd BR
  img=: 'img'conew'CImageList'
  addicon__img &.> (;:'n a c v wc wo lc lo'),&.><'.ico'
  
  tv=: ('tv';img)conew'CTreeView'
  KEYSEP__tv=: '\'
  'indentation'setbase__tv 5
  'linestyle'setbase__tv 1
  'HideSelection'setbase__tv 1
  enable__tv &.> ;:'nodeclick'
  
  lv=: ('lv';img,img)conew'CListView'
  t=. 150 0;25 2;30 0;32 0;38 1;220 0
  (;:'Name Class Type Shape Size Script') addheadder__lv&.> t
  'View'setbase__lv 2
  'BorderStyle'setbase__lv 0
  'Sorted'setbase__lv 1
  'HideSelection'setbase__lv 0
  enable__lv &.> ;:'itemclick columnclick'
  
  br_tbrefresh_button''
  wd'setfocus tv'
  wd'set tbdata 1'
  wd'set tbtop 0'
  wd 'pshow;'
  wd'psel br'
  
  wd OBD
  wd 'setfont data "Courier New" 11 oem'
  wd 'pshow;'
)

OBD=: 0 : 0
pc obd;
xywh 0 0 256 100;cc data editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly rightmove bottommove;
pas 0 0;pmove 0 168 256 100;
rem form end;
)

obd_close=: 3 : 0
  wd'pshow sw_hide'
  wd'psel br; set tbdata 0'
  wd'psel br; pactive'
)

br_tbrefresh_button=: 3 : 0
  'nodes'do__tv'clear'
  'items'do__lv'clear'
  addloc &.> nl 6
)

cocstate=: (((=~ boxopen)~ {.&.;:&.>@{:"1) # ])^:(*@#@]) }.@costate
addobj=: 4 : 0
  p=. x,'/',NCOBJ,'/',y  NB. path, parent of items
  'nodes'do__tv'add ',(x,'/',NCOBJ),' 4 ',p,' ',y,' 5 6'
)
addword=: 4 : 0
  w=. >y{;:'Nouns Adverbs Conjunctions Verbs'
  p=. x,'/',":y  NB. path, parent of items
  'nodes'do__tv'add ',x,' 4 ',p,' ',w,' 5 6'
)
addloc=: 3 : 0
  l=. ('"'&,@(,&' (c)"'))^:((<'COCLASSPATH')e.('nl_',y,'_')~'') y
  'nodes'do__tv'add ,,',y,' ',l,' 7 8'
  y addword ^:(*@#@".@(('nl_'&,)@(y&,)@('_ '&, )@":@]))"_ 0 i.4
  if. 0<#COC=. cocstate y do.
    p=. y,'/',NCOBJ  NB. path, parent of items
    'nodes'do__tv'add ',y,' 4 ',p,' Objects 5 6'
    (<y) addobj&.> 1{"1 COC
  end.
)

br_tbdata_button=: 3 : 0
  wd'psel obd; pshow ', >(".tbdata) {;:'sw_hide sw_shownormal'
  wd'psel br; pactive'
)

br_tbtop_button=: 3 : 0
  wd'psel obd; ptop ', tbtop
  wd'psel br; pactive; ptop ', tbtop
)

br_tbexpand_button=: nodeexpand bind 1
br_tbcollapse_button=: nodeexpand bind 0
nodeexpand=: 3 : 0
  for_i. >:i.".'nodes'get__tv'count' do.
    'curnode'setid__tv'nodes item ',":i
    'curnode'set__tv'expanded ',":y
  end.
)

br_tblist_button=: wd bind 'oleset lv base view 2'
br_tbreport_button=: wd bind 'oleset lv base view 3'

br_tbopen_button=: 3 : 0
  edit selecteditem''
)
br_tbsd_button=: 3 : 0
  setid__lv'base selecteditem'
  scriptdoc 'selecteditem'get__lv'subitems 5'
)

selecteditem=: 3 : 0
  setid__lv'base selecteditem' [ setid__tv'base selecteditem'
  ('selecteditem'get__lv'text'),'_',(_2&}.^:('/'&e.)'selecteditem'get__tv'key'),'_'
)

br_tv_button=: 3 : 0
  wd'set idsthelp *Locale: ',key=. 'event0'get__tv'key'
  'items'do__lv'clear'
  if. '/'e.key do.
    if. ('/',NCOBJ,'/') +./@E. key do.
      numloc=. ;{:<;._2 key,'/'
      (<numloc) additems ('nl_',numloc,'_')~''
    else.
      if. -.('/',NCOBJ) +./@E. key do.
        (<_2}.key) additems ".'nl_',(_2}.key),'_ ',{:key
      end.
    end.
  else.
    (<key) additems ".'nl_',key,'_ '''''
  end.
)

additems=: 4 : 0
  if.#y do.setitem"1 x genitem&> y end.
)

home=: PATHSEP_j_,~ jpath'~home'
cls =: ;:'bool char int float cmplx boxed ext rat'

genitem=: 4 : 0
  c=. nc <n=. y,'_',x,'_'
  if. 0=c do.
    t=. cls{::~ 2^.(3!:0)".n
    s=. ('$0'"_)^:(''&-:)":$n~
  else. t=. s=. '' end.
  l=. (#~ ' '&~:),,'c'(8!:2) 7!:5<n
  if. _1 ~: i=. (4!:4)<n do.
    p=. home (#@[ }. ])^:({.@E.)&tolower >i{4!:3''
  else. p=. '' end.
  y;(":c);t;s;l;p
)

setitem=: 3 : 0
  'items'do__lv'add ,,',(0{::y),' ', ":2#>:".1{::y
  wd'oleid lv cur'
  for_i. i.&.<:#y do.
    'cur'set__lv'subitems ',(":i),' *',i{::y
  end.
  'cur'set__lv'ghosted ',":-.*#_1{::y
)


br_lv_button=: 3 : 0
  if. 'columnclick'-:sysocx do.
    key=. <:".wd'oleget lv event0 index'
    if. key=".wd'oleget lv base sortkey' do.
      wd'oleset lv base sortorder ',":-.".wd'oleget lv base sortorder'
    else.
      wd'oleset lv base sortkey ',": key
    end.
  elseif. 'itemclick'-:sysocx do.
    setid__lv'base SelectedItem'
    name=. 'SelectedItem'get__lv'text'
    
    t=. 'SelectedItem'get__lv'subitems 1'
    t=. t,' ','SelectedItem'get__lv'subitems 2'
    wd'set idsttype *',t
    wd'set idstshape *','SelectedItem'get__lv'subitems 3'
    wd'set idstsize *',('SelectedItem'get__lv'subitems 4'),'b'
    
    n=. name,' - ','SelectedItem'get__lv'subitems 5'
    
    setid__tv'base SelectedItem'
    key=. 'SelectedItem'get__tv'key'
    loc=. ({.~ i.&'/')`(}.~ >:@i:&'/')@.(('/',NCOBJ,'/')&(+./@E.)) key
    fullname=. name,'_',loc,'_'
    if. nc <fullname do.
      t=. 5!:5 <fullname
    else. NB. nouns
      if. (1<#$t)+.2~:3!:0 t=. fullname~ do.
        t=. ,,&LF"1 }:"1}."1}:}. ":<t
      end.
    end.
    
    wd'psel obd'
    wd'pn *',n
    wd'set data *',t
  end.
)

br_close=: 3 : 0
  destroy__lv''
  destroy__tv''
  destroy__img''
  wd'pclose'
  wd'psel obd; pclose'
)
