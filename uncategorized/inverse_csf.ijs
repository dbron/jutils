Q=:LF join ({.&> <@:(;:^:_1)/. (#'d(4) <- ')  -.&'+'@:('-' sr '_')@:}.&.> ]) a: -.~ trim&.> }. LF cut noun define
   Coefficients in rational approximations.
   a(1) <- -3.969683028665376e+01
   a(2) <-  2.209460984245205e+02
   a(3) <- -2.759285104469687e+02
   a(4) <-  1.383577518672690e+02
   a(5) <- -3.066479806614716e+01
   a(6) <-  2.506628277459239e+00

   b(1) <- -5.447609879822406e+01
   b(2) <-  1.615858368580409e+02
   b(3) <- -1.556989798598866e+02
   b(4) <-  6.680131188771972e+01
   b(5) <- -1.328068155288572e+01

   c(1) <- -7.784894002430293e-03
   c(2) <- -3.223964580411365e-01
   c(3) <- -2.400758277161838e+00
   c(4) <- -2.549732539343734e+00
   c(5) <-  4.374664141464968e+00
   c(6) <-  2.938163982698783e+00

   d(1) <-  7.784695709041462e-03
   d(2) <-  3.224671290700398e-01
   d(3) <-  2.445134137142996e+00
   d(4) <-  3.754408661907416e+00
)


region=.(0 , 1 ,~ (, -.) 0.02425)&I.
test=. _0.01 0 0.01 0.02425 0.03425 0.97575 0.98575 1 1.01
region test

region=.((, -.) 0.02425)&( I. +. (={.)~)  NB.  Doesn't test for out-of-range values (i.e. y<0  or  y>1  )

C=: ([: |. 0&".);._2 noun define
-3.969683028665376e+1 +2.209460984245205e+2 -2.759285104469687e+2 +1.383577518672690e+2 -3.066479806614716e+1 +2.506628277459239e+0
-5.447609879822406e+1 +1.615858368580409e+2 -1.556989798598866e+2 +6.680131188771972e+1 -1.328068155288572e+1 +1.000000000000000e+0
-7.784894002430293e-3 -3.223964580411365e-1 -2.400758277161838e+0 -2.549732539343734e+0 +4.374664141464968e+0 +2.938163982698783e+0
+0.000000000000000e+0 +7.784695709041462e-3 +3.224671290700398e-1 +2.445134137142996e+0 +3.754408661907416e+0 +1.000000000000000e+0
)

hl=._2 %:@* ^.
-

invCDF0 =:  (0.02425 ; (0 |.@". ]);._2 noun define)&$: : (dyad define)
    NB.  Check bounds
	assert. (0<y)*.(y<1)

    NB.  Threshold & coefficients given as parameters
	't c'=.x

    p_high =. -. p_low =. t
    
    hl =. _2 %:@:* ^.
	if. y < p_low do.
       q=.hl   y
           %/ (2 3 { c) p."_1    q
	elseif. (p_low<:y)*.(y<:p_high) do.
       q=.y-0.5
       q * %/ (0 1 { c) p."_1 *: q
    elseif. y > p_high do.
      q=.hl -. y
         - %/ (2 3 { c) p."_1    q
    elseif. do.
       __
    end.
)
	-3.969683028665376e+1 +2.209460984245205e+2 -2.759285104469687e+2 +1.383577518672690e+2 -3.066479806614716e+1 +2.506628277459239e+0
	-5.447609879822406e+1 +1.615858368580409e+2 -1.556989798598866e+2 +6.680131188771972e+1 -1.328068155288572e+1 +1.000000000000000e+0
	-7.784894002430293e-3 -3.223964580411365e-1 -2.400758277161838e+0 -2.549732539343734e+0 +4.374664141464968e+0 +2.938163982698783e+0
	+0.000000000000000e+0 +7.784695709041462e-3 +3.224671290700398e-1 +2.445134137142996e+0 +3.754408661907416e+0 +1.000000000000000e+0
)


NB.  Try to make this work like it's rank zero, without actually doing "0
invCDF1 =: (({.@:,;}.)];._2(0|.@".]);._2 noun define)&$: : (dyad define)
    NB.  Threshold & coefficients given as parameters
	't c'=.x
	
	NB.  Find the region
	region =.  y (I.~ +. (= {.)) (, -.) t 
 
    NB.  Select the two polynomials
	cf     =.  c {~ hl =. 1 ~: region

    NB.  Calculate q (based on region)
    q      =.  hl } (*: srq =. y-0.5) , ,: %: _2 * ^. h + y * _1 ^ h =. region = 2

    NB.  Divide polynomials & multiply by final coefficient (-1, y-0.5, or 1 based on region)
    (region } 1 , _1 ,~ ,:srq) * %/"1 cf p. q
)
	+0.02425 

	-3.969683028665376e+1 +2.209460984245205e+2 -2.759285104469687e+2 +1.383577518672690e+2 -3.066479806614716e+1 +2.506628277459239e+0
	-5.447609879822406e+1 +1.615858368580409e+2 -1.556989798598866e+2 +6.680131188771972e+1 -1.328068155288572e+1 +1.000000000000000e+0

	-7.784894002430293e-3 -3.223964580411365e-1 -2.400758277161838e+0 -2.549732539343734e+0 +4.374664141464968e+0 +2.938163982698783e+0
	+0.000000000000000e+0 +7.784695709041462e-3 +3.224671290700398e-1 +2.445134137142996e+0 +3.754408661907416e+0 +1.000000000000000e+0

)

region=.] I.~ (, -.)@(0 {:: [) 
cf    =.(1 ~: region) { 1 {:: [
q     =. 2=region


assert   (invCDF0"0 -: invCDF1) }.}:-:1+i:1j1e2
plot invCDF0"0 }.}:-:1+i:1j1e2 [ require'plot'



in2vCDF =: verb define

	a      =.  _3.969683028665376e001  2.209460984245205e002 _2.759285104469687e002  1.383577518672690e002 _3.066479806614716e001  2.506628277459239e000
	b      =.  _5.447609879822406e001  1.615858368580409e002 _1.556989798598866e002  6.680131188771972e001 _1.328068155288572e001  1.000000000000000e000
	c      =.  _7.784894002430293e_03 _3.223964580411365e_01 _2.400758277161838e000 _2.549732539343734e000  4.374664141464968e000  2.938163982698783e000
	d      =.   0.000000000000000e000  7.784695709041462e_03  3.224671290700398e_01  2.445134137142996e000  3.754408661907416e000  1.000000000000000e000

    C      =: |."1 a,b,c,:d

    p_low  =.  0.02425
    p_high =.  -. p_low

        if.      (0< y) *. y< p_low  do.
          q=.%:_1*^.y
           (((((c(1)*q+c(2))*q+c(3))*q+c(4))*q+c(5))*q+c(6)) %
            ((((d(1)*q+d(2))*q+d(3))*q+d(4))*q+1)
             q*}.c
    elseif. (p_low <:y) *. y<:p_high do.
    elseif. (p_high< y) *. y< 1      do.
    elseif.                          do.
       assert.  (y>0)*.(y<1) 
    end.   
)


3 : '(y(,":)&.>1+i.#z)=:z=.".y'&.>'abcd'
Q=:verb define

q=.y

NB.(((((c(1)*q+c(2))*q+c(3))*q+c(4))*q+c(5))*q+c(6))
qc1=.                    q*c1                  +0
NB.(((((qc1+c2)*q+c(3))*q+c(4))*q+c(5))*q+c(6))
qqc1_c2=.                q*qc1                +c2
NB.((((qqc1_c2+c(3))*q+c(4))*q+c(5))*q+c(6))
qqqc1_c2_c3=.            q*qqc1_c2            +c3
NB.(((qqqc1_c2_c3+c(4))*q+c(5))*q+c(6))
qqqqc1_c2_c3_c4=.        q*qqqc1_c2_c3        +c4
NB.((qqqqc1_c2_c3_c4+c(5))*q+c(6))
qqqqqc1_c2_c3_c4_c5=.    q*qqqqc1_c2_c3_c4    +c5
NB.(qqqqqc1_c2_c3_c4_c5+c(6))
qqqqqc1_c2_c3_c4_c5_c6=.   qqqqqc1_c2_c3_c4_c5+c6


NB.((((d(1)*q+d(2))*q+d(3))*q+d(4))*q+1)
qd1=.                   q*                     d1
NB.(((qd1+d(2))*q+d(3))*q+d(4))*q+1)
qqd1_d2=.               q*qd1                 +d2
NB.(((qqd1_d2+d(3))*q+d(4))*q+1)
qqqd1_d2_d3=.           q*qqd1_d2             +d3
NB.((qqqd1_d2_d3+d(4))*q+1)
qqqqd1_d2_d3_d4=.       q*qqqd1_d2_d3         +d4
NB.(qqqqd1_d2_d3_d4+1)
qqqqd1_d2_d3_d4_1=.       qqqqd1_d2_d3_d4     +1

z=.(qqqqqc1_c2_c3_c4_c5_c6 , (c p. q) , c #. q) ,: qqqqd1_d2_d3_d4_1 , ((d,1) p. q) , d #. q
rc=.|.c
rd=.|.d,1
z,:(qqqqqc1_c2_c3_c4_c5_c6 , (rc p. q) , rc #. q) ,: qqqqd1_d2_d3_d4_1 , (rd p. q) , rd #. q

)

noun define
C =: -:@>:@i:
+/ q * */\.}.c,1
p.
+/c*q^i.#c
   Q

NB.           (((((c(1)*q+c(2))*q+c(3))*q+c(4))*q+c(5))*q+c(6)) %
NB.            ((((d(1)*q+d(2))*q+d(3))*q+d(4))*q+1)


NB.            (((((   +c(2))*q+c(3))*q+c(4))*q+c(5))*q+c(6))

NB.   c(1)*q
'x <-  (((((c(1)*q+c(2))*q+c(3))*q+c(4))*q+c(5))*q+c(6)) / ((((d(1)*q+d(2))*q+d(3))*q+d(4))*q+1) ' ;'x <- -(((((c(1)*q+c(2))*q+c(3))*q+c(4))*q+c(5))*q+c(6)) / ((((d(1)*q+d(2))*q+d(3))*q+d(4))*q+1)'