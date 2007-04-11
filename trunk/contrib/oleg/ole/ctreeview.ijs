require'~user\util\contrib\oleg\ole\COleObject.ijs'
coclass'CTreeView'
coinsert'COleObject'

create=: 3 : 0
  create_COleObject_ f. y
  y=. 3{.boxopen y
  img=: 1{y   NB. CImageList object for icons
  KEYSEP=: '/'
  setid'base nodes'
  'imagelist'setbase'!object:.',ID__img,'.base'
  0
)

NB. x. is key, y. is item to add to top level with image 1-closed, 2-open
NB.* [parentkey] add key[;visible_name]
add=: 3 : 0
  y=. 2&#^:(1=#)@boxopen y
  wd'olemethod ',ID,' nodes add ,, ',(0{::y),' "',(1{::y),'" 1 2'
:
  y=. 2&#^:(1=#)@boxopen y
  wd'olemethod ',ID,' nodes add ',x,' 4 ', x,KEYSEP,(0{::y),' "',(1{::y),'" 3 4'
)

destroy=: verb define
  destroy_COleObject_ f. y
)
