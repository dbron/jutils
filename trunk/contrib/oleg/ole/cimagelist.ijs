require'~user\util\contrib\oleg\ole\COleObject.ijs'
coclass'CImageList'
coinsert'COleObject'

create=: 3 : 0
  create_COleObject_ f. y
  PATH=: 'user\classes\ole\' NB. path for pictures
  'listimages'setid'base listimages'
  0
)

addicon=: 3 : 0
  wd'olemethod ',ID,' listimages add ,, !picture:',PATH,y
)

destroy=: verb define
  destroy_COleObject_ f. y
)
