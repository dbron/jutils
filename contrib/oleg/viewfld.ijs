NB. viewfld - View Field
NB.           extension to viewmat for complex values
NB. INSTALL
NB.    > copy viewfld.ijs user/
NB.
NB. RUN
NB.   require '~user/viewfld.ijs'
NB.   viewfld *: (jiota 20 20)%10
NB.
NB. SEE ALSO
NB.    examples at the bottom of viewfld.ijs
NB.
NB. AUTHOR
NB.    (C) Oleg Kobchenko <olegykj@yahoo.com>, 12/30/2003
NB.        improved, mostly complex bulk operation 03/12/2004

require 'viewmat'

coclass 'jviewfld'
COCLASSPATH=: ;: 'jviewfld jviewmat jgl2 z'

NB.*YORT n Y-orientation: 1 down (default), _1 up
NB.           <----+  Y=p2
NB. Y+Y*5r6p1=p3  /
NB.              o  X+...
NB.             /
NB.            +  -Y=p1
YORT=: 1

NB.*viewfld v view field given by complex matrix
NB.   viewfld *: (jiota 20 20)%10
viewfld=: 3 : 0
'' viewfld y
:
a=. conew 'jviewfld'
RMAT=: 0.455 * * y                           NB. rotation matrix
ARROWS=: +^:(YORT~:1) RMAT */ _1,1,1+r.5r6p1  NB. arrows rotated at origin
COLROW=: |.$y
GRID=: jjota |.COLROW                         NB. complex grid R,C
empty x vmrun__a 1e6||y
)

vm_show=: 3 : 0
vm_show_jviewmat_ f. y
if. 2>sc=.<./wh=.(_2{.0".wd 'qchildxywhx g')%COLROW do.return.end.
gllines <. ,@:+."1 ,/ (sc * ARROWS) + (j./wh) (-:@[ + *&.+.) GRID
glshow''
)

viewfld_z_=: viewfld_jviewfld_

NB.*jjota v complex i.
NB.   jjota 3 4
jjota_z_=: |:@:(j./&i./)@|.     NB. complex i.

NB.*jiota v complex i:
NB.   jiota 3 4
jiota_z_=: |:@:(j./&i:/)@|.     NB. complex i:


NB. =======================================================================
0 : 0 NB. test suite: press Ctrl+R on each line
viewfld jiota 12 12
viewfld %jiota 12 12
viewfld sin (jiota 15 15)%15
viewfld sin 1:^:(_&=@|)"0% (jiota 15 15)%5
viewfld %sin (jiota 20 20)%20

viewfld cos (jiota 15 15)%15
viewfld cos 1:^:(_&=@|)"0% (jiota 15 15)%5
viewfld %cos (jiota 20 20)%20

viewfld *: (jiota 20 20)%10
viewfld *: %(jiota 20 20)%10
viewfld %: (jiota 20 20)%10
viewfld (jiota 20 20)%10
viewfld ^(jiota 20 20)%10
viewfld ^.(jiota 20 20)%10

jjota 3 4            NB. YORT=1, downward Y
viewfld jjota 3 4
jiota 2 2
viewfld jiota 20 20

YORT_jviewfld_=: _1  NB. YORT=_1, upward Y
|.jjota 3 4          
viewfld |.jjota 3 4
|.jiota 2 2
viewfld |.jiota 15 15
YORT_jviewfld_=: 1  NB. restore YORT=1

viewfld lvp_jviewfld_ 0j7 + 2j0.125 *&.+. jjota 40 40
)

NB. Lotka-Volterra
'lvR lvA lvB lvM'=: 0.1 0.01 0.001 0.05
lvp=: 3 : 0"0
'r f'=. +.y
dR_dt=. (lvR*r)-lvA*r*f
dF_dt=. (lvB*r*f)-lvM*f
dR_dt j. dF_dt
)
