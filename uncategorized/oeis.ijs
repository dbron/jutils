load'pacman printf'
fmRq =: 'http://www.research.att.com/~njas/sequences/?q=id%%3a%?''A%%6.6d''&sprintf^:(0=0{.@$,)?s&p=1&n=10&fmt=3' sprintf ,@boxopen
A =: httpgetr_jpacman_@:fmRq 
A000670 =: A 670
NB.  Should probably return an object, where
NB.  the fields of the object are the accumulated %U, %T, %S, %D
NB.  etc of the OEIS file.
NB.  I can either have numbered locales or name them after the sequenec
NB.  e.g.  U_A00670_ -: 1 1 3 13 75 541 4683 47293 545835 7087261 102247563 1622632573 28091567595 526858348381 10641342970443 230283190977853 5315654681981355 130370767029135901 3385534663256845323x
NB.  (_1x ". 'x',~ trim ',' sr ' ' , (#'%S A000670 ') }.&>  3 {. 3 }. LF cut toJ 2000 {. > {: A000670 )  