NB. dancersogl.ijs
NB. 2/9/6
me =. getNmdPath''
require <dir__me,'tgsj3ogl.ijs'
load < dir__me,'tgsj3ogl.ijs'
NB. tgsj3_run 0

Generation =: 0           NB. initiate progression

Screenwidth =: 1500
Delay_bmsturtle3_ =: 0.00    NB. the locale name is needed
SizeScale =: 0.7     NB. scale dancers' size
NumSteps =: 4  NB. for circle, dosido, etc.
Smooth =: 4    NB. higher makes smoother arcs inc circle, dosido, etc
Half =: 0.5
Quarter =: 0.25
Whole =: One =: 1
ThreeQuarters =: 0.75
ThreePlaces   =: 0.75
FourQuarters =: One
FourPlaces   =: One
OneAndAHalf =: 1.5

NB. progressions and  directions
Ccw =: Left =: _1
Cw =: Right =: 1
Reverse =: _1  NB. nonce
Normal =: 1
Across =: _1
Along =: UpDown =: 1
DancerSymbols =: <''&,@, @:({&a.) @:(65 97&+"1 0) @:i. 26

NB. contra types
Duple    =: 0  NB. nonce
Improper =: 1
Becket   =: 2
Proper =: 3  NB. nonce
SetType =: Proper

NB. Formations
Duples    =:  0
Lines     =:  1
LongLines =: _1
LongWaves =:  2
Waves     =: _2

form =: monad define
  Formation =: y
)

form      Duples

HSqrt3 =: 2%~%:3
Sqrt3 =: %:3
Sqrt2 =: %:2
HSqrt2 =: 2%~%:2
RHey =: 1  NB. 0.5+cos rfd 60

Null4Print =: i. 0 2
I_4 =: i. 4

cfd =: _2:]\]                 NB.  couples from dancers
pafd =: |:"2 @cfd"1            NB.  pairs across from dancers
sfd =: sfdEven =: (_2:<@|.@|:\] ) @ cfd  NB. sideways from dancers
sfdOdd  =: (<@|.@,.@{. , _2: <@|.@|:\ }.)@cfd
lfd =: lfdEven =: (_2: <@|.@,.@,\ ])@cfd NB. longways from dancers
lfdOdd  =: (<@|.@,.@{. , _2: <@|.@,.@,\ }.)@cfd
anotherlfd =: (_2: <@|.@,.@(14&A.^:(4=#)@:,)\ ])@cfd NB. for actives between inactives
stdBoxMask =: 1 0 1 0 0 0 1 0 1 &#^:_1
stdFoursomes =: ([: 3 3&$@({&DancerSymbols)&.> [: stdBoxMask@:,@:>:&.> ])@sfd


NB. movement verbs below take lha of shape 2,n
NB.                           rha of shape 2
pair   =: (#@[ # ])"1 0
rtpair =: [ rt&, pair
fdpair =: [ fd&, pair
ltpair =: [ lt&, pair
bkpair =: [ bk&, pair

boxifopen =: <^:(L.=0:)
rnd =: <.@(0.5&+)
dfd =: 360&|&.(180&-)
dancerHWidth =: [: <. 2"_ %~ Screenwidth&%@-:  
Pencolors =: Black,DarkGreen,:DarkOrange
NB. Dancercolors =: _0&|. Blue,Red,Black,Purple,Orange
Dancercolors =: _0&|. Blue,Red,Black,:Lime
pencolors =: 3: | ] {. (4&#) @ i.@ >.@ %&4
coupleNdx =: i.@-:
oddQ =: 2&|
evenQ =: -.@oddQ
duple =: 4&|
double =: 2&#
NB. dancercolors is not really needed because of Foursomes
NB. dancercolors =: (#Dancercolors)"_ | double@coupleNdx 
across =: [: ,"1/ _4 (0 3&{ ,: 1 2&{)\ ]  NB. used with Foursomes
across =: ,"1/@(_2&( ,.\))    NB. try this one for now
across =: ,"1/@(_2&(|.@:,.\)) NB. try this one for now
                              NB.  it works with Dancers also
along  =: [: ,"1/ _4 (0 1&{ ,: 2 3&{)\ ]  NB. used with Foursomes
detTrans =: -/ . *&(1000&+)&|."2   NB. 1000 translates away from axes
onLeftQ =:  *@detTrans

NB. copies =: $,:
acopy =: 2&copies
copy =: #~
copyN =: copy #
inout =: ],:-.
menQ =: copy evenQ
menwomen =: inout menQ
NB. Becket sets rearrange the couples relative to im/proper sets
NB. the following verbs permute Becket set Dancers and Foursomes
becketperm  =: #{.[:,(_4) 1 3 0 2&{^:(4 = #)\ ]
becketperm4 =:    [:,(_4) 1 3 0 2&{         \ ]
activeQ =: e.&0 1@(duple @i.@#)
activesQ =: copy activeQ
actinacts =: inout activesQ
nneQ =: ~:&#

NB. direction of dancers looking ACROSS or OUT of the set
NB. usage: acrossHeading Position
acrossHeading =: 180"_ * 0&<@:(1&{"1)@}:
outHeading    =: 180"_ * 0&>@:(1&{"1)@}:

NB. NumSteps is the right argument for next three verbs
rfd=: *&(pi%180)
cos=: 2&o.
dps =: 360&% : ((%~ 4&*)~)  NB. degrees per step
startTurn =: -:@%

NB. usage: radius chord angle (in degrees)
chord    =: [: %: +:@:*:@[ *1: - cos@:rfd@]

cos0 =: -.@ cos@rfd@(360&%)@*
bigR =: [:%:(4&cos0)%(6&cos0)*4:
NB. bigChord =: [: 0.75&chord dps
bigChord =: [: RHey&chord dps
smallChord =: [: 0.5&chord dps
circleChord =: [: Sqrt2&chord dps
dsafh =: *_1^i.@#  NB. dancer sequence adjustment for heys
HeyStationOffset =: -: 2 - RHey chord 120

NB. This next system was never implemented. A simpler one is.
NB. Offsets are expressed as complex numbers, in half units
NB.     fd_j_lt where each dancer faces across the set
NB.     even if they are not actually facing across
NB. The 4 positions of stations are in the following
NB.     locations if Station =: 4#0
NB. --------
NB. -11--33-
NB. -11--33-
NB. --------
NB. --------
NB. -00--22-
NB. -00--22-
NB. --------
NB. Eg, 2j1 for station 0 means   up 2*0.5 and west 1*0.5
NB. Eg, 2j1 for station 3 means down 2*0.5 and east 1*0.5
NB. |@(-"1{.@(<./),3:)rnd&+:(,Stepsize)%~&}:]}:"1 Position
NB. diagram =: ' '"_$~(7:,+:@#)
NB. Station =: 4#0  NB. offset position of foursome dancers
NB.  (Dancers{DancerSymbols)(Dancers{;/|."1|(-"1{.@(<./),3:)rnd&+:(,Stepsize)%~&}:]}:"1 Position)}diagram Dancers

NB. shows dancers using ascii numerals beginning with 0
NB. usage: asciiOrig Position
NB. works for 2 equal length lines only
13 : '|:cfd {."1(/: 1&{"1)(\: 2&{"1)}:y ,.~i. #y'
NB. first one is experiment for non-square station positions
asciiOrig0 =: [: |: _2: ]\ [: {."1 [: (/: 1&{"1) [: (\: 2&{"1) [: }: ] ,.~ [: i. #
asciiOrig =: asciiOrig0&rnd

diagram =: ' '&$: : ($~(7:,+:@#@]))   NB. creates a blank diagram of shape 7,2*# dancers
NB. ascii produces diagram with MALE (uc) and female (lc) letters
NB. usage: ascii Dancers or '-' ascii Dancers
ascii =: verb define
  ' ' ascii y                        NB. Jennings uses  '.' instead of  ' '
  :
  space =. x
  dancers =. y
  startGrid =. space diagram dancers
  markers =. '+:'$~-:# dancers        NB. Jennings uses '+*' instead of '+:'
  markerPlaces =. ;/3,.3+4*i.-:# dancers
  startGrid =. markers markerPlaces} startGrid
  locations =. ;/|.@(1 0&+)"1|(-"1{.@(<./),3:)rnd&+:(,Stepsize)%~&}:}:"1 Position
  locations =. dancers{locations
  symbols =. dancers{DancerSymbols
  symbols locations}startGrid
)

NB. This section is not implemented, and will not likely be
NB. States of nonstandard duples, for ascii display
LineState =: 0            NB. signals a straight line arrangement
HorizontalShiftState =: 0 NB. # of steps left for diagonal arrangement
VerticalShiftState =: 0   NB. signals a wavy line arrangement
<|:3 3$'A B   D C'        NB.  0
<|:2 4$' A BD C '         NB. +1
<|:2 4$'A B  D C'         NB. _1

circular =: {. ,: |.@{:
negNumCols =: - @ # @ {. @]
circularRotate =: [: circular negNumCols ]\ ( |. ,/@circular)
leftOutOf =: ({~<@<@<@])~
oddGen  =: i.@* , [: ; _2: <@|.\ }.@i.
evenGen =:        [: ; _2: <@|.\    i.
swp2  =:  2&(}.,~|.@{.)
swp_2 =: _2&(}., |.@{.)
ife =: -:@>: NB. indicator from effects coding
pfa =: 2 : '(m{~ ife n)&A.' NB. permutation from anagram

isempty =: 0 e. $
isempty =: 0 =  #
takefirst =: {.~  -.@isempty NB. take first if any
takelast  =: {.~-@-.@isempty NB. take last  if any
lastiftakefirst =: {:@[{.~  -.@isempty@]
firstiftakelast =: {.@[{.~-@-.@isempty@]
NB. ]'ACE BDF bdf ace' =. ;:'ACE BDF bdf ace'
NB. ]Yy =. 'Yy'
NB. ]Zz =. 'Zz'
NB. ACE,~takefirst Zz
NB. BDF, takefirst Yy
NB. (}: ace),~{.({.bdf),~takelast Zz
NB. (}: ace),~{.({.bdf),~takelast ''
NB. (ace lastiftakefirst  Yy),~(}: ace),~{.({.bdf),~takelast Zz
NB. (bdf firstiftakelast  Zz), (}. bdf), {.({:ace),~takelast Yy

groupDancers =: monad define
  NB. All and Foursomes do NOT include Neutrals,
  NB.   but, Dancers does include Neutrals
  NB. MenAlone =: Lead =: (copy evenQ) Dancers 
  NB. WomenAlone =: Follow =: (-.&Lead) Dancers
  'MenAlone WomenAlone' =: menwomen becketperm^:(SetType=Becket)Dancers
  Lead =: MenAlone
  Follow =: WomenAlone
  All =: Foursomes =: NTs -.~  NBs -.~ Dancers
  if. duple # Foursomes do. smoutput'Error*** Foursomes ' return. end.
  'ActivesList InactivesList' =. actinacts becketperm4^:(SetType=Becket)Foursomes
  ActiveMen =: (copy evenQ) ActivesList
  ActiveWomen =: (-.&Lead) ActivesList
  NB. ActiveWom =: (copy oddQ) ActivesList
  InactiveMen =: (copy evenQ) InactivesList
  InactiveWomen =: (-.&Lead) InactivesList
  NB. InactiveWom =: (copy oddQ) InactivesList

  NB. Neighbor & Opposite are by gender, not by position
  Neighbor =: (ActiveMen,InactiveMen) ,: InactiveWomen,ActiveWomen
  Opposite =: (ActiveMen,ActiveWomen) ,: InactiveMen,InactiveWomen
  nextActiveMen =. ActiveMen,~takefirst NTs
  nextInactiveMen =. InactiveMen, takelast NBs
  nextInactiveWomen =. (InactiveWomen firstiftakelast NTs), (}. InactiveWomen), {.({:ActiveWomen),~takefirst NBs
  nextActiveWomen =. (ActiveWomen lastiftakefirst NBs),~(}: ActiveWomen),~{.({.InactiveWomen),~takelast NTs
  NextNeighbor =: (nextActiveMen,nextInactiveMen) ,: nextInactiveWomen,nextActiveWomen
  Men =: ActiveMen ,: InactiveMen  NB. apparently not used
  Women =: ActiveWomen ,: InactiveWomen  NB. apparently not used
  Men =: |:_2]\NBs -.~NTs -.~  MenAlone
  Women =: |:_2]\NBs -.~ NTs -.~ WomenAlone
  Partner  =: (ActiveMen,InactiveMen) ,: ActiveWomen,InactiveWomen
  nextActiveWomen =. (ActiveWomen firstiftakelast NTs), (}. ActiveWomen), {.({:InactiveWomen),~takelast NBs
  nextInactiveWomen =. (InactiveWomen lastiftakefirst NBs),~(}: InactiveWomen),~{.({.ActiveWomen),~takelast NTs
  nextActiveWomen =. (ActiveWomen firstiftakelast NTs), (}. ActiveWomen), {.({:InactiveWomen),~takefirst NBs
  nextInactiveWomen =. (InactiveWomen lastiftakefirst NBs),~(}: InactiveWomen),~{.({.ActiveWomen),~takelast NTs
  Shadow =: (nextActiveMen,nextInactiveMen) ,: nextActiveWomen,nextInactiveWomen
  Ones =: Actives =:ActiveMen ,: ActiveWomen
  Twos =: Inactives =:InactiveMen ,: InactiveWomen
  FoursomesAcross =: across Foursomes
  FoursomesAlong  =:  along Foursomes
  DancersAcross =: across Dancers
  NB. DancersAlong  =:  along Dancers  NB. may be impossible

  NB. assign turtlecolors to Foursomes
  FoursomeColor0 =. (NBs,NTs)(([;;/@]),."1  ;/@i.@>:@#@])_4]\Foursomes
  ns =. neutrals =. >@{.@{.@[;{:@]
  nncs =. nonneutralcolors =. }:@]
  nnfs =. nonneutralfours =. }.@[
  nns =. nonneutrals =. (>@{.@[;(#@]|>@{:@[){])"1 _
  FoursomeColors =: FoursomeColor0 (ns ,~ nnfs nns"1 _ nncs) Dancercolors 

)

debuggroupDancers =: monad define
  NB. >(;(-.(copy evenQ));(copy evenQ)) Dancers
  try. FoursomeColors catch. FoursomeColors =. '' end.
  before =. Men ; Women ; Partner  ; Actives ; Inactives ; FoursomeColors ; All 

  All =. Foursomes =. NTs -.~  NBs -.~ Dancers
  if. duple # Foursomes do. smoutput'Error*** Foursomes ' return. end.
  NB. Neighbor & Opposite are by gender, not by position
  NB. Neighbor =. (ActiveMen,ActiveWomen) ,: InactiveWomen,InactiveMen 
  Neighbor =. (ActiveMen,InactiveMen) ,: InactiveWomen,ActiveWomen
  Opposite =. (ActiveMen,ActiveWomen) ,: InactiveMen,InactiveWomen
  MenAlone =. Lead =. (copy evenQ) Dancers 
  WomenAlone =. Follow =. (-.&Lead) Dancers
  Men =. ActiveMen ,: InactiveMen
  Women =. ActiveWomen ,: InactiveWomen
  Men =. |:_2]\NBs -.~NTs -.~  MenAlone
  Women =. |:_2]\NBs -.~ NTs -.~ WomenAlone
  Partner  =. (ActiveMen,InactiveMen) ,: ActiveWomen,InactiveWomen
  Actives =.ActiveMen ,: ActiveWomen
  Inactives =.InactiveMen ,: InactiveWomen

  NB. assign turtlecolors to Foursomes
  FoursomeColor0 =. (NBs,NTs)(([;;/@]),."1  ;/@i.@>:@#@])_4]\Foursomes
  ns =. neutrals =. >@{.@{.@[;{:@]
  nncs =. nonneutralcolors =. }:@]
  nnfs =. nonneutralfours =. }.@[
  nns =. nonneutrals =. (>@{.@[;(#@]|>@{:@[){])"1 _
  FoursomeColors =. FoursomeColor0 (ns ,~ nnfs nns"1 _ nncs) Dancercolors 

  names  =. 'Men';'Women';'Partner ';'Actives';'Inactives';'FoursomeColors';'All' 
  after  =. Men ; Women ; Partner  ; Actives ; Inactives ; FoursomeColors ; All 
  AF =: after
  BF =: before
  if. y do. before -: after else. names,.before,.after end.
)

PairsTypes =: noun define
  Neighbor
  Opposite
  Men
  Women
  Partner
  Active
  Inactive
)

arrangeFoursomes =: monad define
  NB. perm is really a "put" vector more than a perm vector
  NB. the ith element of perm tells where to place the ith dancer
  NB.   in the Foursome
  perm =. y
  Foursomes =: , (perm}"1)~ _4]\Foursomes

  NB. moved 8/5/6
  NB. PhysicalOpposites are used for facing in a circle for example 
  PhysicalOpposite =: ,."2/ _4(0 1,:3 2)&{\Foursomes

  Dancers =: NTs,Foursomes,NBs
  NB. groupDancers ''     NB. ********* commented OUT 8/4/6
  NB. Dancers     NB. ********* commented OUT 8/4/6
)

NB. y is positive or negative, indicating direction
NB.    and the magnitude may later be used for 
NB.    double or triple progressions
NB. if. statements wrt Improper are tentative
NB.  and meant to force a FULL progression in certain cases
NB.  this feature was designed with passThrough in mind,
NB.  but is not used for now
NB. progress =: verb define
NB. 1 progress y
NB. :
progress =: verb define
  NB. type =. y
  NB. amount =. x
  type =. SetType
  amount =. y

  even =. evenGen NumCouples
  odd  =.  oddGen NumCouples
  NB. smoutput 'Prev progression'
  NB. smoutput sfd Dancers

  while. amount do.
    amount =. <: amount
    Generation =: >: Generation
    if. oddQ Generation do.
      if. type -: -Improper do. Dancers =: ,even{cfd Dancers end.
      if. evenQ NumCouples do.
        if. type -: -Improper do. Dancers =: swp2 swp_2 Dancers end.
        NB. NBs =: Dancers({.~-@duple) NumDancers-2 NB. NeutralBottoms
        NBs =: |._2 {. Dancers                  NB. NeutralBottoms  NB. 8/4/6 added |.
        NTs =: 2 {. Dancers                   NB. NeutralTops
      else.
        if. type -: -Improper do. Dancers =: swp2 Dancers end.
        NBs =: i. 0                           NB. NeutralBottoms
        NTs =: 2 {. Dancers                   NB. NeutralTops
      end.
      groupDancers ''
      sfd =: sfdOdd
      lfd =: lfdOdd
      DancerSymbols {~ each sfd Dancers
    else.
      if. type -: -Improper do. Dancers =:  ,odd{cfd Dancers end.
      if. oddQ NumCouples do.
        if. type -: -Improper do. Dancers =: swp_2 Dancers end.
        NB. NBs =: Dancers({.~-@duple) NumDancers NB. NeutralBottoms
        NBs =: _2 {. Dancers                  NB. NeutralBottoms
        NTs =: i. 0                           NB. NeutralTops
      else.
        NBs =: i. 0                           NB. NeutralBottoms
        NTs =: i. 0                           NB. NeutralTops
      end.
      groupDancers ''
      sfd =: sfdEven
      lfd =: lfdEven
      DancerSymbols {~ each sfd Dancers
    end.
  end.
  orig =. (NBs,NTs){state 'Turtletrait'
  (NBs,NTs) turtletraitto (-.@:{.,}.)"1 orig
  ([turtlecolorto#@[copies])&>/"0 1 FoursomeColors
  Dancercolor =: Turtlecolor    NB. not used
  yw 0
)

NB. Initialize dancers' states
iDS =: monad define
  yy =.  | y
  if. oddQ yy do.
    'Number of dancers must be an even integer.' 
    return. 
  end.

  NB. paintme =: paintme0

  Generation =: 0              NB. initialize progression
  SetType =: Proper
  sfd =: sfdEven               NB. initialize progression
  lfd =: lfdEven               NB. initialize progression
  NumDancers =: yy              NB. initialize 
  NumCouples =: -: NumDancers

  cs ''

  LISTS =: i. 0 
  glDeleteLists (>:PARTSSTART);#PARTS
  PARTS =: i. 0 
  Delay =: 0  NB. initialize wd 'timer'
  glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT

  NB. LTurtle =. i. 0
  LTheTurtle =.  i. 0
  LTurtlehead =.  i. 0
  LHead =.  i. 0
  LLeftforearm =.  i. 0
  LRightforearm =.  i. 0
  LLeftupperarm =.  i. 0
  LRightupperarm =.  i. 0
  LLeftleg =.  i. 0
  LRightleg =.  i. 0
  LLeg =.  i. 0
  LShoe =.  i. 0

  for_j. i. | y
  do.
    NB. LTurtle =. LTurtle,' '&, 'LTurtle',": j
    LTheTurtle =. LTheTurtle,' '&, 'LTheTurtle',": j
    LHead =. LHead,' '&, 'LHead',": j
    LLeftforearm =. LLeftforearm,' '&, 'LLeftforearm',": j
    LRightforearm =. LRightforearm,' '&, 'LRightforearm',": j
    LLeftupperarm =. LLeftupperarm,' '&, 'LLeftupperarm',": j
    LRightupperarm =. LRightupperarm,' '&, 'LRightupperarm',": j
    LLeftleg =. LLeftleg,' '&, 'LLeftleg',": j
    LRightleg =. LRightleg,' '&, 'LRightleg',": j
    LLeg =. LLeg,' '&, 'LLeg',": j
    LShoe =. LShoe,' '&, 'LShoe',": j
    LTurtlehead =. LTurtlehead,' '&, 'LTurtlehead',": j
  end.
  NB. LISTS =: >: i. 5
  gsgenlist 'LTurtlepath'     NB. LTurtle,
  genpartslist LTheTurtle
  genpartslist LHead
  genpartslist LLeftforearm
  genpartslist LRightforearm
  genpartslist LLeftupperarm
  genpartslist LRightupperarm
  genpartslist LLeftleg
  genpartslist LRightleg
  genpartslist LLeg
  genpartslist LShoe
  genpartslist LTurtlehead

  genpartslist Partsnames
  forearm makelist FOREARM ''
  upperarm  makelist UPPERARM ''
  torso  makelist TORSO ''
  shoulder  makelist SHOULDER ''
  neck  makelist NECK '' 
  skirt  makelist SKIRT ''

  NB. Next not implemented and likely will not be
  stdFoursomes =: ([: 3 3&$@({&DancerSymbols)&.> [: stdBoxMask@:,@:>:&.> ])@sfd
  stdNBs =: [: < 3 1&$@({&DancerSymbols)@:(1 0 1&#^:_1@:>:@:|.)
  stdNTs =: [: < 3 1&$@({&DancerSymbols)@:(1 0 1&#^:_1@:>:    )

  Dancers =:  i. NumDancers
  NTs =: i. 0                      NB. NeutralTops
  NB. |. in next line required only temporarily for NextNeighbor & Shadow
  NBs =: |. (i.{.~-@duple) yy      NB. NeutralBottoms    NB. added |.  8/4/6
  groupDancers ''                  NB. initialize dancer groups
  NBs =: |. NBs                    NB. NeutralBottoms    NB. move here 8/4/6

  womansizes =. SizeScale"_*(dancerHWidth,(300"_),~[:+:dancerHWidth) % -:
  NB. mansizes =. 1.2 1.2 1"_ * womansizes
  mansizes =. womansizes
  dancersizes =. [: ,/ [: <.  -: copies mansizes,:womansizes
  NB. verbs for positioning
  xposition =. [:double (-&(Screenwidth%5))@(dancerHWidth * coupleNdx)
  yposition =. [:, -: copies [:  (,~-) -:@dancerHWidth
  position =. 0:,.~ yposition,.~ xposition

  NB. 3D eye information
  Pe0 =: 0 0 1000
  He0 =: 0 0 _90

  Eye =: yy              NB. add one turtle for the eye
  yy =. >: Eye           NB. add one turtle for the eye
  eye =: Eye&{          NB. must always be changed after Eye

  NB. initialize default State
  State =:  0$~yy,#StateNames
  (yy&# each BasicTvalues) state each BasicTnames
  EyeGazesAt =: ,:0 0 0

  NB. initialize user info
  P0 =: Position =: (position yy-1),Pe0
  H0 =: Heading =: (_90 _90 _90 copies~ yy-1),He0
  Station =: (xposition,.yposition) yy-1

  NB. convert user info to dbase format
  Z =: heading =. ,"_1 allRot rfd Heading
  position =. Position
  pencolor =. White,~Pencolors{~pencolors yy-1
  NB. dancercolor =. White,~Dancercolors{~dancercolors yy-1
  NB. dancersize =. 0 0 0,~dancersizes yy-1
  NB. dancertrait =. 0 0 0,~dancersizes yy-1  NB. fix this later
  stepsize =. 5,~(copies -:@dancerHWidth) yy-1
  between =. (-/)@(2 0&{)@xposition
  stepsize =. 5,~(copies -:@between) yy-1
  penstate =. yy#0
  dancerstate =. 0,~1#~ yy-1

  NB. revise default State
  fields =. 'Position Heading Pencolor Stepsize Penstate Turtlestate'
  fieldvals =.  position;heading;pencolor;stepsize;penstate;dancerstate
  fieldvals state each ;: fields

  NB. read State into dancer names
  fields =. 'Position Heading Pencolor Turtlecolor Turtletrait Stepsize Penstate Turtlestate Turtletype'
  dancertraits =.  'position heading pencolor dancercolor dancertrait stepsize penstate dancerstate dancertype'
  (dancertraits)  =.  state each ;: fields

  StereoFlag =: 0

  NB. revise user info
  (BasicTnames) =: state each BasicTnames
  Position =: P0
  Heading =: H0
  Turtletrait =: dancertrait
  Turtlecolor =: dancercolor

  NB. keep copy of initial State
  State0 =: State 

  NB. create State Change shell
  SC0 =: SC =: StateChange =: 0$~ yy,0,#StateChangeNames NB. unsparse
  NB. SC0 =: SC =: StateChange =: $. 0$~  yy,0,#StateChangeNames NB. sparse

  dancercolors yy-1
  names =.  'position dancercolor dancertrait dancertype'
  traits =.  ;:'Position Turtlecolor Turtletrait Turtletype'
  (names) =. state each traits

  NB. initialize shell drawing database
  fields =. 'Pencolor Pensize Penstyle'
  DrawPathList =: i. (#Eye), 0 ,6++/#&> (<SN) aindex each ;:fields

  Dancercolor =: Turtlecolor    NB. not used
  NB. eyeto 0 _3 2.5

  NB. draw new turtle
  turtles =. Dancers
  heading =. (mfv0 state 'Heading')
  rightArg =.  heading
  leftArg =.  position;dancercolor;dancertrait;dancertype
  for_j.  turtles 
  do.
    i =. j{turtles
    TID =: ": i
    leftArg drawsetup &:((i&{)each) <rightArg
    TheTurtle =: whichTurtle  i&{,dancertype
    NB. LTurtle =. ".'LTurtle',TID
    makeanyTurtle TURTLECOLOR
    NB. anyTurtle TURTLECOLOR
  end.

  paint''
  NB. yw 0
  StateNames;|:rnd State
)

dancercolors =: monad define
  setupcouples =. (,&0 0)"1 0@ (1&(0 1}) &.|.)@($&0 0 1 1)
  shoecolors =. 15&|@i.@|
  (i.turtletraitto (shoecolors (1})"0 1 setupcouples)) y
  ([turtlecolorto#@[copies])&>/"0 1 FoursomeColors
  (i. turtletypeto ,.@:$&1000 2000) y
)

hands4 =: monad define
  if. -. (y = NumDancers) *. Position -:&:}: P0 do.
    iDS y[ cs ''
  end.
  NB. penup Dancers
  NB. Actives rt 180
  form Duples
  face Neighbor
)

hands4cross =: monad define
if. -. (y = NumDancers) *. Position -:&:}: P0 do.
  iDS y[ cs ''
end.
Dancers =: NBs ,~ ,(_4) 1 0 2 3&{\ Dancers -. NBs
NB. Dancers =: (|.NBs) ,~ ,(_4) 1 0 2 3&{\ Dancers -. NBs   NB. adjusted 8/4/6
Foursomes =: NTs -.~  NBs -.~ Dancers 
SetType =: Improper
NB. groupDancers '' NB. initialize dancer groups   NB. removed 8/4/6
face Actives
Actives rt 45
Actives fd %:2
Actives lt 90
Actives fd %:2
NB. face (ActiveMen,ActiveWomen) ,: InactiveWomen,InactiveMen 
form Duples
PhysicalOpposite =: ,."2/ _4(0 1,:3 2)&{\Foursomes
face Opposite
DancerSymbols {~ each sfd Dancers
)



becket =: verb define
  Cw becket y
  :
  NB. x is 1 for cw _1 for ccw
  direction =. x
  hands4cross y
  SetType =: direction*Becket  NB. tentative ********
  NB. groupDancers '' NB. initialize dancer groups NB. removed 8/5/6
  circle direction%4
  face Neighbor
  NB. if. direction = 1 
  NB. do.   Dancers =: NBs ,~ ,(_4) 1 3 0 2&{\ Dancers -. NBs
  NB. else. Dancers =: NBs ,~ ,(_4) 2 0 3 1&{\ Dancers -. NBs
  NB. end.
  NB. Foursomes =: NTs -.~  NBs -.~ Dancers
  if. 0<#NBs do. face NBs end.
  form Duples
  DancerSymbols {~ each sfd Dancers
)

NB. used with rha: "Heading{~{."1 pairs "
couplesOnSidesQ =: 270&>@:+/&|/@:(1&{"1)
NB. too limited
NB. might be a prototype for california twirls, etc.
NB. but dancers needs to be y, for example
NB. and the turn needs to be more like a courtesy turn
turnAsACouple =: verb define
  pairs =. y NB. couple pairs
  pairs turnAsACouple ''
  :
  pairs =. x
  separation =. 1
  sep =. separation&*
  dancers =. ,/ pairs
  numdancers =. #dancers
  numcouples =. -:numdancers
  position =. state 'Position'
  men =. (copy evenQ) dancers
  women =. (copy oddQ) dancers
  stepsize =. state 'Stepsize'
  distances =. length -/pairs{position % ,"2 stepsize
  moves =. ,/ 2 copies -: distances - separation
  mancount =. # men
  firstman =. {. men
  hisopps =. mancount {."1 Opposite
  hisopp  =. (,~/hisopps){~firstman i.~ ,/hisopps 
  dupleTopQ =. </ {."1 position{~firstman,hisopp

  face pairs
  NB. dancers =. Foursomes
  if. Foursomes nneQ dancers 
  do.  NB. only Actives, Inactives are supported
  else.
    maleLeftQ =. acopy onLeftQ pairs{2{."1 position
    T =: maleLeftQ =. ,acopy onLeftQ ,/(2 2,:2 2)];._3,"2 pairs{2{."1 position
    dancers fd moves
    dancers lt 45*maleLeftQ
    dancers fd sep HSqrt2
    pairs  rtpair 90 _90*{.maleLeftQ  NB. works only for uniform pairs
    pairs fdpair sep HSqrt2, -HSqrt2
    dancers rt 45*maleLeftQ
    dancers jl moves*numcouples#1 _1*{.maleLeftQ
    if. couplesOnSidesQ Heading{~{."1 pairs
    do.
      perm =. C. (1 3); (0 2)  NB. works for Neighbor & Partner turning after crossing set
    else.
      perm =. C. (0 1); (2 3)  NB. works for Neighbor & Partner turning after crossing set
  end.
  end.
  DancerSymbols {~ each sfd arrangeFoursomes perm
)

NB. Assumes dancers are facing already
passThrough =: monad define
  heading =. rnd 1&{"1 Foursomes{Heading
  alongQ =. heading -: 90 90 _90 _90$~#Foursomes
  acrossQ =. heading -: 0 180$~#Foursomes
  if. -. (alongQ *. Along = y) +. (acrossQ *. Across = y)
  do. 
    smoutput 'Dancers passing through must be facing'
    return.
  end.
  dancers =. Foursomes
  NB. dancers =. NTs -.~ NBs -.~ Dancers
  dancers lt 45
  dancers fd HSqrt2
  dancers rt 45
  dancers fd 1
  dancers rt 45
  dancers fd HSqrt2
  dancers lt 45
  if. Along = y do.
    NB. The rearrangement and progress below
    NB.    are done before the courtesyTurn
    NB.    because before is the best time
    NB.    to know the ultimate position of
    NB.    each dancer.
    NB. progress Improper
    position =. Foursomes i."1 ({.,{:)"1 |.|:cfd Foursomes
    NB. perm =. I_4 C.~ <"1 duple |: position
    perm =. I_4 C.~ <"1 duple position
    arrangeFoursomes perm
    NB. progress Duple  NB. progress is now monadic
    progress  1
    NB. dancers =. |.|:cfd NTs,|.NBs
    dancers =. |:cfd NTs,|.NBs
    NB. dancers =. |:cfd NTs,  NBs   NB. changed 8/4/6
    if. #dancers do. 
      'lead   follow' =. dancers
      (lead , follow) jl (_0.5 copyN lead),(0.5 copyN follow)
      (lead , follow) lt 45
      courtesyTurn dancers
      NTs =: |. NTs
      NBs =: |. NBs
      NB. NBs =: |. NBs   NB. changed 8/4/6
      arrangeFoursomes I_4
    end.
  end.
  if. Across = y do.
    NB. The rearrangement and progress below
    NB.    are done before the courtesyTurn
    NB.    because before is the best time
    NB.    to know the ultimate position of
    NB.    each dancer.
    NB. progress Improper
    position =. Foursomes i."1 ({.,{:)"1 |.|:cfd Foursomes
    perm =. I_4 C.~ <"1 duple |: position
    NB. perm =. I_4 C.~ <"1 duple position
    arrangeFoursomes perm
    NB. dancers =. |.|:cfd NTs,|.NBs
    dancers =. |:cfd NTs,|.NBs
    if. #dancers do. 
      'lead   follow' =. dancers
      (lead , follow) rt (90 copyN lead),(_90 copyN follow)
    end.
  end.
  DancerSymbols {~ each sfd Dancers
)

face =: monad define
  NB. argument contains 2 paired rows of dancers
  'partA partB' =. y
  if. partA nneQ partB
  do. smoutput 'The two arguments must contain equal numbers of values'
    return.
  end.
  if. (partA nneQ ~. partA) +. (partB nneQ ~. partB)
  do.
    smoutput 'The two arguments must not have any repeated values'
    return.
  end.
  if. (partB nneQ partB-. partA) +. (partA nneQ partA-. partB)
  do. 
    smoutput 'The two arguments must not share any values'
    return.
  end.
  position =. state 'Position'
  (partA, partB) turnto (partB, partA){position
  DancerSymbols {~ each sfd Dancers
)

turnAlone =: monad define
  NB. argument contains 2 paired rows of dancers
  'partA partB' =. y
  if. partA nneQ partB
  do. smoutput 'The two arguments must contain equal numbers of values'
    return.
  end.
  if. (partA nneQ ~. partA) +. (partB nneQ ~. partB)
  do.
    smoutput 'The two arguments must not have any repeated values'
    return.
  end.
  if. (partB nneQ partB-. partA) +. (partA nneQ partA-. partB)
  do. 
    smoutput 'The two arguments must not share any values'
    return.
  end.
  if. y -: Neighbor do.
    face Neighbor
    face Partner
  else.
    face Partner
    face Neighbor
  end.
  DancerSymbols {~ each sfd Dancers
)


fdTurnFd =: adverb define
  :
  x fd u
  x rt 90*y
  x fd u
)

fdTurn =: adverb define
  :
  x fd u
  x rt 90*y
)

fdTurnAmt =: conjunction define
  :
  x fd u
  x rt v*y
)

star =: verb define
  _1 star y
  :
  direction =. -*x NB. positive y means left
  quarters =. rnd NumSteps*y
  if. direction = 0 do. 
    smoutput 'Error**** circle amount cannot be 0'
    return. 
  end.
  NB. Opposite is pairs of lists of Dancers
  NB. face Opposite 
  face PhysicalOpposite
  smoutput direction
  smoutput firstT  =. direction*90-90 startTurn Smooth
  smoutput angle =. direction*90 dps NumSteps*Smooth
  step =. 90 circleChord NumSteps*Smooth
  (,/ PhysicalOpposite) rt firstT
  (_1) ((quarters*Smooth) repeats (step fdTurnAmt angle)~) ,/ PhysicalOpposite
  NB. (,/ PhysicalOpposite) rt firstT*direction
  temp =. A. 2 0 3 1,:1 3 0 2
  getperm =. temp pfa direction
  perm =. getperm^:quarters I_4
  DancerSymbols {~ each sfd arrangeFoursomes perm
)

circle =: verb define
  Left circle y
  :
  direction =. x *&* y  NB. negative x means left
  quarters =. rnd NumSteps*|y
  if. direction = 0 do. 
    smoutput 'Error**** circle amount cannot be 0'
    return. 
  end.
  NB. Opposite is pairs of lists of Dancers
  NB. face Opposite 
  face PhysicalOpposite
  firstT  =. direction*90-90 startTurn Smooth
  angle =. direction*90 dps NumSteps*Smooth
  step =. 90 circleChord NumSteps*Smooth
  (,/ PhysicalOpposite) rt firstT
  _1((quarters*Smooth) repeats (step fdTurnAmt angle)~) ,/ PhysicalOpposite
  (,/ PhysicalOpposite) rt -firstT
  temp =. A. 2 0 3 1,:1 3 0 2
  getperm =. temp pfa (-direction)
  perm =. getperm^:quarters I_4
  DancerSymbols {~ each sfd arrangeFoursomes perm
)

diag =: dyad define
  smoutput x
  smoutput y
  smoutput rnd&.(10&*)4{.Position
  smoutput rnd&.(10&*)4{.Heading
)

NB. Lead/Follow angle pairs
heysequence =: ".;._2 noun define
_60 _60
_60  90
_60  90
_60 _60
_60 _60
90 _60
90 _60
_60 _60
)

NB. heykernel =: dyad define
heykernel =: monad define
  NB. quarters =. | rnd NumSteps*x
  NB. direction =. *x NB. positive x means Women first
  quarters =. | rnd NumSteps*y
  direction =. *y NB. positive y means Women first
  NB. 'lead follow' =. y
  'lead follow' =. FoursomesAcross
  dancers =.  lead , follow
  previous =. _60 60 * Smooth 
  for. i. quarters%2 
  do.
    for_j. heysequence
    do.
      L =. {. j
      F =. {: j
      pL =. {. previous
      pF =. {: previous
      angleF =. follow copyN~ F  dps NumSteps*Smooth
      angleL =. lead   copyN~ L  dps NumSteps*Smooth
      angle  =. angleL,angleF
      achord =. [: , (<;._1 ' bigChord smallChord') pick~ _60 90 i. ]
      stepF =. follow copyN~ F  (achord F)~ NumSteps*Smooth
      stepL =. lead   copyN~ L  (achord L)~ NumSteps*Smooth
      step  =. stepL,stepF
      firstTF  =. (F-pF) startTurn Smooth
      firstTL  =. (L-pL) startTurn Smooth
      firstT =. (firstTL copyN lead), (firstTF copyN follow)
      dancers rt firstT
      dancers (Smooth repeats (step fdTurnAmt angle )) direction
      previous =. j
    end.
  end.
)

NB. hey =: verb define
hey =: monad define
  NB. 1 hey y
  NB. :
  NB. assumes dancers are on stations
  NB. assumes Ladies start with right shoulder
  NB. only multiples of half hey and whole hey

  NB. only considers women first
  NB. quarters =. | rnd NumSteps*x
  quarters =. | rnd NumSteps*y
  if. 2|quarters do.
    smoutput 'Error**** hey amount must be a multiple of 0.5'
    return. 
  end.
  NB. direction =. *x NB. positive x means Women first
  direction =. *y NB. positive y means Women first
  direction =. 1
  if. direction = 0 do. 
    smoutput 'Error**** hey amount cannot be 0'
    return. 
  end.
  NB. 'lead follow' =. y
  'lead follow' =. FoursomesAcross
  fHead =. rnd dfd follow{(}:1{"1 Heading)-acrossHeading Position
  lHead =. rnd dfd lead  {(}:1{"1 Heading)-   outHeading Position
  dancers =.  lead , follow
  dancers lt lHead,fHead
  position =. ,(}:Stepsize)%~(}:Position)-&:(0&{"1) Station {~/:Dancers
  NB. moveL =. HeyStationOffset -   lead{position
  NB. moveF =. HeyStationOffset + follow{position
  moveL =. HeyStationOffset - dsafh   lead{position
  moveF =. HeyStationOffset - dsafh follow{position
  move  =. rnd&.(100&*) moveL,moveF
  dancers jl move
  position =. ,(}:Stepsize)%~(}:Position)-&:(1&{"1) Station {~/:Dancers
  NB. moveL =. lead{position
  NB. moveF =. follow{position
  moveL =. dsafh lead{position
  moveF =. dsafh follow{position
  move  =. rnd&.(100&*) moveL,moveF
  dancers bk move
  firstTF  =.  _30
  firstTL  =.   30
  firstT =. (firstTL copyN lead), (firstTF copyN follow)
  NB. dancers rt firstT
  NB. x heykernel y  NB. this is the kernel calculation
  heykernel y  NB. this is the kernel calculation
  temp =. A. 3 2 1 0,:3 2 1 0
  getperm =. temp pfa direction
  perm =. getperm^:(quarters%2) I_4
  DancerSymbols {~ each sfd arrangeFoursomes perm
)

NB. Assumes couples are turned left 45 degrees
NB. so man can backup and woman can go forward to start
courtesyTurn =: verb define
  y courtesyTurn~ 0.5,_0.5
  :
  'lead   follow' =. y
  'ldlt flwlt' =. x
  (lead , follow) fd ((-HSqrt2) copyN lead),(HSqrt2 copyN follow)
  (lead , follow) rt _90
  (lead , follow) fd ((-HSqrt2) copyN lead),(HSqrt2 copyN follow)
  (lead , follow) rt _45
  (lead , follow) jl (ldlt copyN lead),(flwlt copyN follow)
)

leftDiagChain =: monad define
  NB. assumes chain is ACROSS the set
  NB. assumes women on right
  NB. argument contains 2 paired rows of dancers
  NB. First  row is Lead
  NB. Second row is Follow
  outTop =. (copy oddQ) NTs
  outBot =. (copy oddQ) NBs
  if. #NBs,NTs do. face |:_2]\NTs,NBs end.
  follow =. outTop ,&, (|:y) ,&, outBot
  lead   =. follow  -.~ NTs, (Men ,&(,@|:) Women) ,NBs
  45        lt~ outTop,outBot
  (2*Sqrt2) fd~ outTop,outBot
  135       lt~ outTop,outBot
  removeTop =. -.#outTop
  removeBot =. -.#outBot
  follow =. (<<< 1)&{^:  removeTop  follow
  follow =. (<<<_2)&{^:( removeBot) follow
  lead   =. (<<< 0)&{^:  removeTop  lead
  lead   =. (<<<_1)&{^:( removeBot) lead
  dancers =. lead,:follow

  'lHead  fHead' =. dfd (lead,:follow) {(}:1{"1 Heading)-acrossHeading Position

  NB. no longer assumes everyone is facing across the major set, women on right

  (lead , follow) rt (90-lHead),(_90-fHead)
  follow         fd Sqrt3
  follow         rt 30
  (lead , follow) fd ((_3+2*Sqrt3) copyN lead),(2 copyN follow)
  (lead , follow) rt (_180 copyN lead),(15 copyN follow)
  (lead , follow) fd (_1 copyN lead),(Sqrt2 copyN follow)
  lead           rt _135
  ((_3+2*Sqrt3),(_4+2*Sqrt3)) courtesyTurn lead ,: follow
  swapFoursomes =.  13 : 'y C.~;/ 6 1& +"_ 0 (4&*@ i.@ <:@%&4 # y)'
  swapFoursomes =. ] C.~ [: <"1 [: 6 1&+"_ 0 [: 4&*@i.@<:@%&4 #
  swapNTs =. (<4 0)&C.
  swapNBs =. (<_1 _5)&C.
  Foursomes =: swapFoursomes Foursomes
  if. #NTs 
  do. 
    swap =. swapNTs NTs,4{.Foursomes
    NTs =: 2{.swap
    Foursomes =: (2}.swap),4}.Foursomes
  end.
  if. #NBs 
  do. 
    swap =. swapNBs NBs,~_4{.Foursomes
    NBs =: _2{.swap
    Foursomes =: (_2}.swap),~_4}.Foursomes
  end.
  Dancers =: NTs,Foursomes,NBs
  outTop =. (copy oddQ) NTs
  outBot =. (copy oddQ) NBs
  45        lt~ outTop,outBot
  (2*Sqrt2) fd~ outTop,outBot
  135       lt~ outTop,outBot
  if. #NBs,NTs 
  do. 
    'men women' =. |:_2]\NTs,NBs 
    (men , women) rt (_90 copyN men),(90 copyN women)
  end.
  groupDancers ''
  DancerSymbols {~ each sfd Dancers
)

RLThrough =: monad define
  NB. assumes chain is ACROSS the set
  NB. assumes women on right
  NB. argument contains 2 paired rows of dancers
  NB. results in dancers off-station, 1*********
  NB. First  row is Lead
  NB. Second row is Follow
  NB. 'lead   follow' =. y
  NB. 'lHead  fHead' =. dfd y {(}:1{"1 Heading)-acrossHeading Position
  'lead   follow' =. FoursomesAcross
  'lHead  fHead' =. dfd FoursomesAcross {(}:1{"1 Heading)-acrossHeading Position

  NB. no longer assumes everyone is facing across the major set, women on right
  (lead , follow) rt (0-lHead),(_30-fHead)
  (lead , follow) fd ((2-HSqrt3) copyN lead),(1 copyN follow)
  (lead , follow) rt 30
  (lead , follow) fd (1 copyN lead),((2-HSqrt3) copyN follow)
  (lead , follow) lt (75 copyN lead),(45 copyN follow)
  courtesyTurn lead ,: follow
  DancerSymbols {~ each sfd arrangeFoursomes 23 A. I_4 
  NB. sfd arrangeFoursomes  3 2 1 0
)

turnkernel =: adverb define
  :
  'lead follow' =. y
  degree =. n
  achord =: [: degree&chord dps
  dancers =.  lead , follow
  previous =. Smooth * {.x
  turnsequence =. }.x
  numSteps =. # turnsequence
  for_j. turnsequence
  do.
    L =. {. j
    F =. {: j
    pL =. {. previous
    pF =. {: previous
    angleF =. follow copyN~ F  dps numSteps*Smooth
    angleL =. lead   copyN~ L  dps numSteps*Smooth
    angle  =. angleL,angleF
    achord =. [: , (<;._1 ' bigChord smallChord') pick~ _60 90 i. ]
    stepF =. follow copyN~ F  (achord F)~ numSteps*Smooth
    stepL =. lead   copyN~ L  (achord L)~ numSteps*Smooth
    step  =. stepL,stepF
    firstTF  =. (F-pF) startTurn Smooth
    firstTL  =. (L-pL) startTurn Smooth
    firstT =. (firstTL copyN lead), (firstTF copyN follow)
    dancers rt firstT
    dancers (Smooth repeats (step fdTurnAmt angle )) direction
    previous =. j
  end.
)

chain =: monad define
  NB. assumes chain is ACROSS the set
  NB. assumes women on right
  NB. argument contains 2 paired rows of dancers
  NB. works only for Women argument for now
  NB. I am not wure what it means to chain Men
  NB. 'lead   follow' =. y
  follow =. ,y
  lead =. (Men,&,&|:Women) -. follow
  'lHead  fHead' =. dfd (lead,:follow) {(}:1{"1 Heading)-acrossHeading Position

  NB. no longer assumes everyone is FACING across the major set, women on right

  (lead , follow) rt (90-lHead),(_60-fHead)
  follow         fd 1
  (lead , follow) fd (HSqrt3 copyN lead),(1 copyN follow)
  follow         rt 105
  (lead , follow) fd (HSqrt3 copyN lead),(Sqrt2 copyN follow)
  (lead , follow) rt (_135 copyN lead),(_90 copyN follow)
  lead           rt  _180
  ((_1+Sqrt3),(_2+Sqrt3)) courtesyTurn lead ,: follow
  DancerSymbols {~ each sfd arrangeFoursomes  0 2 1 3  NB. women only chain
)

NB. needs to be updated to account for starting Formation
NB.    and to change the Formation after the allemande
NB. also needs to be updated to allow for nneQ when starting
NB.    Formation is not Duples
allemande=: verb define
  1 allemande y
  :
  quarters =. rnd NumSteps*x NB. number of quarter revolutions
  direction =. *x NB. positive x means left
  pairs =. y NB. couple pairs
  dancers =. ,/ pairs
  dancerPositions =. ({."1 pairs){ state 'Position'
  dancerStepsizes =. ({."1 pairs){ state 'Stepsize'
  dancerDistance =. length -/ dancerPositions%"1 0 dancerStepsizes
  move =: -: <: dancerDistance
  NB. if. oddQ quarters do.  smoutput 'nonce' return. end.
  face pairs
  dancers fd move
  dancers rt direction*45
  dancers (quarters repeats (HSqrt2 fdTurn)) -direction
  dancers lt direction*45
  NB. dancers bk move
  dancers rt direction*45
  if. evenQ quarters do. 
    if. oddQ -: quarters do.
      if. Foursomes nneQ dancers do.
        position =. Foursomes i. {."1 pairs
        perm =. I_4 C.~ <duple position
      else.
        position =. Foursomes i."1 ({.,{:)"1 pairs
        perm =. I_4 C.~ <"1 duple |: position
      end.
      DancerSymbols {~ each sfd arrangeFoursomes perm
    else. DancerSymbols {~ each sfd Dancers
    end.
  end.
)

dosido =: verb define
  1 dosido y
  :
  quarters =. rnd NumSteps*x NB. number of quarter revolutions
  pairs =. y NB. couple pairs
  dancers =. ,/ pairs
  if. oddQ quarters do.  smoutput 'nonce' return. end.
  face pairs
  dancers lt 45
  while. quarters do.
    dancers fd HSqrt2
    dancers rt 45
    dancers fd 0.5
    quarters =. <: quarters
    if. 0=quarters do.  return.  end.
    dancers fd 0.5
    dancers rt 45
    dancers fd HSqrt2
    dancers lt 45
    quarters =. <: quarters
    if. 0=quarters do.  
      if. Foursomes nneQ dancers do.
        position =. Foursomes i. {."1 pairs
        perm =. I_4 C.~ <duple position
      else.
        position =. Foursomes i."1 ({.,{:)"1 pairs
        perm =. I_4 C.~ <"1 duple |: position
      end.
      DancerSymbols {~ each sfd arrangeFoursomes perm
      return.  
    end.
    dancers lt 45
    dancers bk HSqrt2
    dancers rt 45
    dancers bk 0.5
    quarters =. <: quarters
    if. 0=quarters do.  return.  end.
    dancers bk 0.5
    dancers rt 45
    dancers bk HSqrt2
    dancers lt 45
    quarters =. <: quarters
    if. 0=quarters do.  
      DancerSymbols {~ each sfd Dancers
      return.  
    end.
    dancers lt 45
  end.
)

NB. left = 1, right = _1
balance =: verb define
  0 balance y
  :
  if. 0 = x 
  do. 
    face y 
    0.5 fd~ ,y
    0.5 bk~ ,y
  else.
    (x*0.5) jl~ ,y
    (x*0.5) jr~ ,y
  end.
  DancerSymbols {~ each sfd Dancers
)

balanceAndSwing =: dyad define
  balance x
  x swing y
)

oldswing =: dyad define
  NB. sfd at end is not working for becket starts and maybe for more

  NB. To end facing across, requires 0=4|quarters if women on the right
  NB. To end facing across, requires 2=4|quarters if women on the  left
  NB. To end facing down  , requires 1=4|quarters if woman on the right
  NB. To end facing up    , requires 3=4|quarters if woman on the right
  quarters =. rnd NumSteps*x NB. number of quarter revolutions
  pairs =. y NB. couple pairs
  NB. if. oddQ quarters do.  smoutput 'nonce' return.  end.
  dancers =. ,/ pairs
  men =. (copy evenQ) dancers
  women =. (copy oddQ) dancers
  face pairs
  position =. state 'Position'
  stepsize =. state 'Stepsize'
  distances =. length -/pairs{position % ,"2 stepsize
  moves =. ,/ 2 copies -: distances - 1
  dancers jl 0.5
  dancers fd moves
  Right ((quarters-1) repeats (1 fdTurn)~) dancers
  dancers fd 0.5
  if. evenQ quarters do. dancers jl moves end.
  NB. (men , women) rt (90 copyN men),(_90 copyN women)
  women rt 180 copyN women
  if. oddQ quarters 
  do.  
    DancerSymbols {~ each sfd Dancers
    return. 
  else.
    if. Foursomes nneQ dancers do.
      position =. Foursomes i. {."1 pairs
      perm =. I_4 C.~ <duple position
    else.
      position =. Foursomes i."1 ({.,{:)"1 pairs
      perm =. I_4 C.~ <"1 duple |: position
    end.
    DancerSymbols {~ each sfd arrangeFoursomes perm
  end.
)

ForwardAndBack =: 1 _1
Forward        =: 1
Back           =:   _1
UpTheHall      =: 2
DownTheHall    =:   _2
NB. Longlines go ForwardAndBack  : 1 _1
NB.     Lines go Back            :   _1
NB.     Lines go Forward         : 1
NB.     Lines go UpTheHall       : 2
NB.     Lines go DownTheHall     :   _2
NB. assumes dancers are in duple minor positions to start
go =: dyad define
  linetype =. x
  movetype =. y
  moves =. Forward;Back;ForwardAndBack;UpTheHall;DownTheHall
  if. -. movetype e.&boxifopen moves
  do.
    smoutput 'You have supplied an invalid right argument to go'
    return.
  end.
  if. movetype e.&boxifopen Forward;Back;ForwardAndBack
  do.
    if. (Formation = Duples) *. linetype = LongLines
    do.
      position =. state 'Position'
      stepsize =. state 'Stepsize'
      select. movetype
      case. Forward
      do.
        face DancersAcross 
        distances =. DancersAcross{(1{"1 position)% , stepsize
        close =. 0.75
        DancersAcross fd&, -:,:~ close *-:| -/ distances
        DancersAcross fd&, -:,:~ close *-:| -/ distances
      case. Back
      do.
        ypositions =. DancersAcross{(1{"1 position)% , stepsize
        stations   =. (across i.NumDancers){(1{"1 Station)%}:, stepsize
        distances =.  1 _1&(*"0 1)ypositions -~stations
        DancersAcross bk&, -:distances
        DancersAcross bk&, -:distances

      case. ForwardAndBack
      do.
        face DancersAcross 
        distances =. DancersAcross{(1{"1 position)% , stepsize
        close =. 0.75
        DancersAcross fd&, -:,:~ close *-:| -/ distances
        DancersAcross fd&, -:,:~ close *-:| -/ distances
        position =. state 'Position'
        ypositions =. DancersAcross{(1{"1 position)% , stepsize
        stations   =. (across i.NumDancers){(1{"1 Station)%}:, stepsize
        distances =.  1 _1&(*"0 1)ypositions -~stations
        DancersAcross bk&, -:distances
        DancersAcross bk&, -:distances
      end.
      DancerSymbols {~ each sfd Dancers
    else.
      smoutput 'The set formation or desired result are'
      smoutput 'inconsistent with the initial facing requirement.'
    end.
    return.
  else.
    if. (Formation = Lines) *. linetype = Lines
    do.
      position =. state 'Position'
      (i. NumDancers)turnto }: (y*_100000) (0})"1 position
      Dancers fd 0.5
      Dancers fd 0.5
      Dancers fd 0.5
      Dancers fd 0.5
      DancerSymbols {~ each lfd arrangeFoursomes I_4
      return.
    else.
      smoutput 'Not yet able to start with Formation ~: Lines'
      return.
      NB. needs to be added **************
    end.
  end.
)

californiaTwirl =: verb define
  pairs =. y
  pairs californiaTwirl ''
  :
  pairs =. x
  separation =. 0.75
  sep =. separation&*
  dancers =. ,/ pairs
  numdancbk movesers =. #dancers
  numcouples =. -:numdancers
  position =. state 'Position'
  men =. (copy evenQ) dancers
  women =. (copy oddQ) dancers
  face pairs
  stepsize =. state 'Stepsize'
  distances =. length -/pairs{position % ,"2 stepsize
  moves =. ,/ 2 copies -: distances - separation
  mancount =. # men
  firstman =. {. men
  hisopps =. mancount {."1 Opposite
  hisopp  =. (,~/hisopps){~firstman i.~ ,/hisopps 
  dupleTopQ =. </ {."1 position{~firstman,hisopp
  if. Foursomes nneQ dancers 
  do.  NB. only Actives, Inactives are supported
    if. Actives +.&(pairs&-:) Inactives 
    do.
      if. Actives -: pairs
      do. 
        if.   dupleTopQ do. perm =. 1 0 2 3 else. perm =. 0 1 3 2 end.
      else.
        if. -.dupleTopQ do. perm =. 0 1 3 2 else. perm =. 1 0 2 3 end.
      end.
      dancers fd moves
      dancers lt 45
      dancers fd sep HSqrt2
      (men,:women) ltpair _90 90
      (men,:women) fdpair sep HSqrt2, -HSqrt2
      dancers rt 45
      dancers jl moves*numcouples#1 _1
      DancerSymbols {~ each sfd arrangeFoursomes perm
    else.
      smoutput 'Error: Only Actives/inactives can twirl now'
      return.
    end.
  else.
end.
)

Minqtrs      =:  4   NB. must be 0, 4, 8 (, etc.)
Facedown     =: _1
Faceup       =:  1
Faceacross   =:  0
Promenadeset =:  0.5
swing =: dyad define
  pairs =. x NB. couple pairs
  endface =. y
  NumBeats =. 8  NB. could be made 12 for a long swing
  swingSeparation =. 1
  swingSeparation =. 0.75
  dancers =. ,/ pairs
  numdancers =. #dancers
  numcouples =. -:numdancers
  position =. state 'Position'
  men =. (copy evenQ) dancers
  women =. (copy oddQ) dancers
  face pairs
  stepsize =. state 'Stepsize'
  distances =. length -/pairs{position % ,"2 stepsize
  moves =. ,/ 2 copies -: distances - swingSeparation
  dancers fd moves
  NB. dancers jl 0.5
  if. Foursomes nneQ dancers 
  do.  NB. only Actives, Inactives are supported
    if. Actives +.&(pairs&-:) Inactives 
    do.
      mancount =. # men
      firstman =. {. men
      hisopps =. mancount {."1 Opposite
      hisopp  =. (,~/hisopps){~firstman i.~ ,/hisopps 
      aboveQ =. </ {."1 position{~firstman,hisopp
      if. Actives -: pairs
        do. 
          if. aboveQ do. perm =. 1 0 2 3 else. perm =. 0 1 3 2 end.
        else.
          if. aboveQ do. perm =. 0 1 3 2 else. perm =. 1 0 2 3 end.
        end.
        manRightLineQ   =. 0 < 1{ firstman{position
        if. Faceup +.&(endface&=) Facedown
        do. quarters =. 2 * manRightLineQ -.@~: endface = Faceup
        else.
          smoutput 'Error: Active/inactive swing position'
          return.
        end.
    else.
      smoutput 'Error: Only Actives/inactives can swing now'
      return.
    end.

  else.  NB. assumes dancers symmetric and swing on their side of the set
    couples =. ({.,{:)"1 pairs
    dupleEastQ   =. 0< 1{"1 position{~{. couples
    dupleTopQ =. </ 0{"1 position{~   couples
    select. endface
    case. Faceup ; Facedown
    do.
      quarters =. >:+: dupleTopQ -.@~: endface = Faceup
      if. endface = Faceup
      do. perm =. 1 2 0 3 
      else. perm =. 0 3 1 2 
      end.
      form Lines
    case. Faceacross
    do.
      quarters =.   +: dupleTopQ -.@~: dupleEastQ
      perm =. 2 3 0 1
      form Duples
    case. Promenadeset
    do.
      quarters =. >:+: dupleTopQ -.@~: dupleEastQ
      perm =. 0 2 1 3
      form Lines
    end.
  end.
  ZeroOne =. 0 0,._1 _1
  zeroOne =. #"0 1&ZeroOne  NB. indices for (side) swing amount assignment
  getIndices =. zeroOne -: numcouples
  quarters =. , getIndices{quarters+Minqtrs
  turnAngle =. (90%NumSteps)*quarters%-:NumBeats
  startAngle =. -:180-turnAngle
  eachstep =.  turnAngle  chord~ -: swingSeparation 
  dancers lt startAngle
  lastTurnAngle =. (numcouples#0 180)+-:turnAngle
  Right ((<:NumSteps*-:NumBeats) repeats (eachstep fdTurnAmt turnAngle)~)    dancers
  Right                                  (eachstep fdTurnAmt lastTurnAngle~) dancers
  NB. I am not sure whether to include the next line or not
  NB. if. evenQ quarters do. dancers jl moves*~ numcouples#1 _1 end.

  if. oddQ quarters 
  do.  
    NB. DancerSymbols {~ each sfd Dancers
    DancerSymbols {~ each lfd arrangeFoursomes perm
  else.
    perm =. (quarters%2) perm&{ I_4 
    DancerSymbols {~ each sfd arrangeFoursomes perm
  end.
)

demo =: noun define
  NB. todo: update allemande   *****************
  NB. needs to be updated to account for starting Formation
  NB.    and to change the Formation after the allemande
  NB. also needs to be updated to allow for nneQ when starting
  NB.    Formation is not Duples

  NB. todo: passThruToAWavyLine   *****************

  NB. vi pattern search this string for todo's: /*$

  DancerSymbols {~ each sfd Dancers     NB. display dancers in foursomes

  hands4cross 10
  circle ThreeQuarters 
  chain Women
  chain Women

  becket 10
  chain Women
  chain Women

  becket 10
  Partner swing Faceacross

  hands4 10
  Actives swing Facedown

  hands4 10
  circle Half
  Actives swing Faceup

  hands4 10
  LongLines go ForwardAndBack
  LongLines go Forward
  LongLines go Back

  hands4 12
  Actives swing Faceup

  hands4cross 10
  Neighbor swing Faceacross

  hands4cross 10
  Neighbor swing Facedown

  hands4cross 10
  Neighbor swing Promenadeset 

  hands4      10
  (Neighbor;Partner;NextNeighbor;Shadow){each DancerSymbols

  hands4      10
  Inactives californiaTwirl ''
  Inactives californiaTwirl ''
            californiaTwirl Actives

  hands4cross 10
      Neighbor{>DancerSymbols
  NextNeighbor{>DancerSymbols
  (Neighbor;Partner;NextNeighbor;Shadow){each DancerSymbols
  face Neighbor
  passThrough Along
  passThrough Along

  hands4cross 10
  Neighbor swing Facedown
  Lines go DownTheHall
  NB. turn alone
  Lines go UpTheHall

  1 becket 10
  leftDiagChain Women
  leftDiagChain Women

  hands4cross 12
  Neighbor swing Faceacross
  leftDiagChain Women
  leftDiagChain Women

  Smooth =:4
  hands4cross 10
  circle ThreeQuarters 
  chain Women

  hands4cross 10
  star ThreeQuarters 
  Right star ThreeQuarters 

  NB. Neutral women come into the set
  hands4cross 10
  circle ThreeQuarters 
  leftDiagChain Women
  leftDiagChain Women

  hands4cross 10     NB. or 12
  face Neighbor
  passThrough Along
  passThrough Along

  hands4cross 12
  face Partner
  passThrough Across
  turnAlone Neighbor
  passThrough Across
  turnAsACouple Neighbor

  becket 12
  passThrough Across
  turnAsACouple Partner

  hands4cross 10     NB. or 12
  Neighbor swing Faceacross
  RLThrough ''
  RLThrough ''

  becket 12
  RLThrough ''

  hands4cross 10     NB. or 12
  Neighbor swing Faceacross
  chain Women
  chain Women

  NB. Rachels Reel www.conntras.org/conndanc.htm
  hands4 10
  pendown 0 5 NB. unnecessary
  1.5 dosido Actives
  1.5 allemande Neighbor
  hey Whole
  _1 allemande Actives
  Neighbor swing Faceacross
  1 swing Neighbor
  Actives balanceAndSwing Faceup
  NB. castoff with Neighbor ??


  becket 10
  Half allemande Men
  Half allemande Partner

  hands4cross 10
  Half swing Neighbor
  pendown 0 5
  Half hey Men ,:&, Women

  Smooth =: 1
  hands4cross 10
  Half swing Neighbor
  pendown 0 5
  One hey Men ,:&, Women

  Smooth =: 4
  becket 12
  pendown 0 5
  Half hey Men ,:&, Women
  Half hey Men ,:&, Women

  NB. attempt at Roadblock Reel by Bob Dalsemer
  hands4cross 10
  face Partner
  passThrough Across
  progress 1  
  _0.75 allemande Neighbor
  NB. not sure if this is the intent of the dance
  NB. because Men and Women have to keep moving
  NB.  to get into the wave position

)

Direction =: noun define
  Several of the dance moves take as an argument
  the number of repetitions. For example 
  1.5 dosido Partner

  Usually, when there is a possibility that
  the move can be in alternate directions
  such as cw or ccw, then positive numeric
  values are taken to mean the "usual"
  direction and negative values mean the
  contrary direction.
)

penup Dancers
NB. eyeto 0 _3 2.5  NB. not needed because included in iDS 
iDS 10
smoutput Direction
smoutput DancerSymbols {~ each sfd Dancers 
