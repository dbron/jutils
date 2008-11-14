Hi   =:  >: @: (+/~) @: i. @ x:  NB. inverse Hilbert matrix of order n
det  =:  (-/ .*)&.:%
exp  =:  __ |.@{:@q: det@:Hi"0


H2    =:  % @: >: @: (+/~) @: i. @ x:  NB. Hilbert matrix of order n
det2  =:  -/ .* 
exp2  =: __ |.@{:@q: %@:det2@:H2"0
exp3  =: __    {:@q: %@:det2@:H2"0

NB. R=:exp 1+i.25
NB. plot R
NB. plot |:R

NB. Q=:exp3 1+i.25
NB. W=:-: |: 2 -/\&.|. Q
NB. (#;.1~ ] ~: _1&|.)^:a: {.W


NB.  Exponents of prime factorization
Q2  =:  exp3 1+i.50
W2  =:  -: |: 2 -/\&.|. Q2

NB.  Exponents of 2 shows self-similarity (fractal natured)
NB.  Looks like an ever-ascending mountain
plot 0,{.W2

NB.  Which we can generate...
(0,{.W2)-: (1+{:$W2) {. (, >:)^:(6) 0

NB.  The next one is a little trickier to generate...
NB.  Looks like a cross between a mountain and a castle
NB.  (instead of ever-ascending, acends and descends periodically,
NB.  like the turrets on a castle).
NB. 'line marker' plot 1+0 1 2 0 2 4 2 3 4 0 1 2 0 3 6 4 5 6 2 3 4 2 4 6 4 5 6 0 1 2 0 2 4 2 3 4 0 1 2 0 4 8 6 7 8 4 5 6 4 6

NB.  The rest look like castles, and each successive one
NB.  is a 'zoom' of the preceding (zooming into the turrets
NB.  of the castle...)  Does 'zoom' just mean a subsequence?
NB.  plot +:0,2{W2
NB.  plot +:0,3{W2
NB.  plot +:0,4{W2
NB.  plot +:0,5{W2

