require'user\classes\ole\COleObject.ijs'
coclass'CMSFlexGrid'
coextend'COleObject'

NB. create ID[;rows,cols[;fixedrows,fixedcols]]
create=:3 : 0
create_COleObject_ f. y.
y.=. boxopen y.
if. 1<#y. do. dim ;1{y. end.
if. 2<#y. do. fixeddim ;2{y. end.
0
)

dim=: 3 : 0
('ROWS COLS')=. 1>. 2{.y.
'rows'setbase ROWS
'cols'setbase COLS
)

fixeddim=: 3 : 0
('ROWS COLS')=. 0>. 2{.y.
'fixedrows'setbase ROWS
'fixedcols'setbase COLS
)

setcell=: 4 : 0
'textmatrix'setbase (":x.),' ',":y.
)

ofs=:<@,"0/&>/@:(i.&.>)
NB. offset setmatrix matrix
setmatrix=: 4 : 0
(x.&+&.>ofs$y.) setcell &.> <"0^:(L. = 0:) y.
)

destroy=: verb define
destroy_COleObject_ f. y.
)
