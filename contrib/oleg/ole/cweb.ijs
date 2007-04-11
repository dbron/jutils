require'user\classes\ole\COleObject.ijs'
coclass'CWeb'
coextend'COleObject'

NB. create ID[;url]
create=:3 : 0
create_COleObject_ f. y.
y.=. boxopen y.
if. 1<#y. do. 'Navigate'dobase ;1{y. end.
0
)

destroy=: verb define
destroy_COleObject_ f. y.
)
