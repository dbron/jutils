require'~user\util\contrib\oleg\ole\COleObject.ijs'
coclass'CListView'
coinsert'COleObject'

create=: 3 : 0
  create_COleObject_ f. y
  y=. 3{.boxopen y
  lgimg=: 1{y   NB. CImageList object for large icons
  smimg=: 2{y   NB. CImageList object for small icons
  'headers'setid'base columnheaders'
  'items'setid'base listitems'
  'icons'setbase'!object:.',ID__lgimg,'.base'
  'smallicons'setbase'!object:.',ID__smimg,'.base'
  0
)

NB. name additem size,pos
addheadder=: 4 : 0
  wd'olemethod ',ID,' headers add ,, ',x,' ',":y
)

NB. (bigicon,smallicon) additem item1;item2;..;itemN
additem=: 3 : 0
  ''additem y
:
  'items'do'add ,,"',(":>{.y),'" ',":x
  wd'oleid ',ID,' curitem'
  for_i. i.&.<: #y do.
    'curitem'set'subitems ',(":i),' *',,":;>i{y
  end.
)

destroy=: verb define
  destroy_COleObject_ f. y
)

NB. ---------------------------------------------------------
(0 : 0) NB. sample list view initialization
lv=: ('ocx';lgimg,smimg)conew'CListView'
(;:'Name Size Date') addheadder__lv&.> 50 0;50 1;50 2
1 1 additem__lv 'Two Words';125;'1-1-97'
2 2 additem__lv 'bbb';126;'1-2-97'
3 3 additem__lv 'ccc';126;'1-3-97'
4 4 additem__lv 'ddd';128;'1-4-97'
)
