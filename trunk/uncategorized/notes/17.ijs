AF=: 224
EF=: 232
IF=: 236
OF=: 242
UF=: 249
AR=: 225
ER=: 233
IR=: 237
OR=: 243
UR=: 250

sc_key=: 3 : 0
ndx=. {. 0 ,~ 0 ". txt_select
txt=. (ndx{.txt),(y{a.),ndx}.txt
wd 'set txt *',txt
wd 'setselect txt ',":(1+ndx,ndx),0
wd 'setfocus txt'
)

sc_actrl_fkey=: sc_key bind AF
sc_ectrl_fkey=: sc_key bind EF
sc_ictrl_fkey=: sc_key bind IF
sc_octrl_fkey=: sc_key bind OF
sc_uctrl_fkey=: sc_key bind UF

sc_actrlshift_fkey=: sc_key bind AR
sc_ectrlshift_fkey=: sc_key bind ER
sc_ictrlshift_fkey=: sc_key bind IR
sc_octrlshift_fkey=: sc_key bind OR
sc_uctrlshift_fkey=: sc_key bind UR