NB.  Input.  Small.
NB.  Should really put more test cases in there.  Empty lines,
NB.  Lines that end with something other than a  ) or  0-9 or  }  .
NB.  All different lengths, etc.
P=.>{.splitPath 3 : '(erase W) ] (4!:3$0){::~ 4!:4 W=:{.;:''W'''0
F =: 1!:1 fn =.<P,'data.txt'

NB. Equivalent to   perl -pi -e "s/([^)0-9])\r/$1)\r/" input.txt
NB. I haven't the patience to see if this completes on large inputs.
NB. It hangs for a while, at the least.
G0 =: '([^)0-9])\r' 4 : '('')'',&.>~z rxfrom y) z rxmerge y [ z=.(,1) {"2 x rxmatches y' F

NB. Equivalent to  perl -pi -e "s/(?<![)0-9])\r/)\r/" input.txt
NB. I haven't the patience to see if this completes on large inputs.
NB. It hangs for a while, at the least.
G1 =: ('(?<![)0-9])\r';')',CR) rxrplc F

NB.  Out-of-memory errors on large inputs.
G2 =: F #!.')'~ 1 j. (-. F e. DIGITS,')') *. 1|.CR=F

NB.  A "J way" that works on large inputs
G3 =: }: ; F <@:,&')';.0~ (,:&> _ ,~ 2 -~/\ ]) 0 , cr #~ -. (DIGITS,')') e.~ F {~ <: cr =. CR I.@:= F