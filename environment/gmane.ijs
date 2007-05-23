require 'files'
ac =. <@:#@:[ }.&.> [ (E. <;.1 ]) ,
tmp=: jpath'~temp\jijs.ijs'
f  =: > {. (<_1) -.~ fread&.> (bkup=:jijs,'.bkup');jijs =: ; (4!:3''){~4!:4<'jijs_selplus_button_jijs_'
f fwrite^:(1 - fexist@:]) bkup
f fwrite tmp
i_z_=:0
A=:noun define dyad define&.>&:('NB.----'&ac)&:toHOST noun define
end.

if. -. new -: sel do.
  smsetselect bgn, end
  smreplace new
  smsetselect set <. <: #smread''
end.
NB.----
jijs_selplus_button=: select_line bind 'plus'
NB.----
jijs_nctrlshift_fkey=: jijs_selplus_button
NB.----
menu selplusline2 "&Add ZZ. ==" "Ctrl+Shift+L" "" "";
)
i_z_=:>:i_z_
tmp fwrite~ ; (}:, (#Q)$ ,:1 0) #^:_1!.(<x) Q=:y (] <;.1~ 1: 0} E.) fread tmp
)
case. 'gmane' do.
  new =. ; ('<at>';'@') stringreplace L: 1 0 csl
  set =. bgn + 0, <: #new
NB.----
jijs_selgmane_button=: select_line bind 'gmane'
NB.----
jijs_qctrlshift_fkey=: jijs_selgmane_button
NB.----
menu selgmane "&Fix gmane munging" "Ctrl+Shift+Q" "" "";
)

jijs fwrite~ fread tmp
load jijs