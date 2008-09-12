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
invCDF1 =: (X=:({.@:,;}.)];._2(0|.@".]);._2 noun define)&$: : (dyad define)
    NB.  Threshold & coefficients given as parameters
    't c'=.x
	
    NB.  Find the region
    region =.  y (I.~ +. (= {.)) (, -.) t 
 
    NB.  Select the polynomials
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

NB.  x is (threshold;coeff), y is data
invCDF2                =:  ] invCDFh~ region ; {:@:[
    NB.  x is (region ; coeff), y is data
    invCDFh            =:  ((] scaledPolyDiv (y05_q~ }:)) {. , hl_cf&>~/)~
        NB.  x is coeff , y is region
        hl_cf          =:  (] ; {~) 1&~:
        NB.  x is (region;hl;cf), y is (y05;q)
        scaledPolyDiv  =:  selectMult&:>&:{. * polyDiv&:>&:{:
            NB.  x is region, y is y05
            selectMult =:  merge@:(,&< 1 , _1 ,~ ,:)
            NB.  x is cf, y is q
            polyDiv    =:  %/"1@:p.
        NB.  x is (region;hl), y is data
        NB.  output is y05 ; q (i.e. transformed data)
        y05_q          =:  [ ({.@:] (,<) merge@:,&:{:) y05_nlt     
        merge          =:  >@:{.`(>@:{:)}
            NB.  output is y05 ; all transform choices, i.e. 
            NB.  y05 ;  (*:y-0.5),nlt
            y05_nlt    =:  y05 (([ ; (,~ *:)~) ,:) nlt                  
                y05    =:  _0.5 + ]
                NB.  Non-linear transform choices
                NB.  x is (region ; hl), y is data
                nlt    =:  _2 %:@:* ((] ^.@:+ (* _1&^)) 2 = >@:{.)~           

X=:({.@:,;}.)];._2(0|.@".]);._2 noun define
	+0.02425 

	-3.969683028665376e+1 +2.209460984245205e+2 -2.759285104469687e+2 +1.383577518672690e+2 -3.066479806614716e+1 +2.506628277459239e+0
	-5.447609879822406e+1 +1.615858368580409e+2 -1.556989798598866e+2 +6.680131188771972e+1 -1.328068155288572e+1 +1.000000000000000e+0

	-7.784894002430293e-3 -3.223964580411365e-1 -2.400758277161838e+0 -2.549732539343734e+0 +4.374664141464968e+0 +2.938163982698783e+0
	+0.000000000000000e+0 +7.784695709041462e-3 +3.224671290700398e-1 +2.445134137142996e+0 +3.754408661907416e+0 +1.000000000000000e+0

)

(nm)=:(5!:1 <nm=.'invCDF2')5!:0(X&)



NB. TEST =: }.}:-:1+i:1j1e2 
NB. assert  (invCDF0"0 -: invCDF1) TEST
NB. plot invCDF1 TEST
NB. plot X&invCDF2 TEST

R =:}.}:-:1+i:1j1e5
smoutput (%"1 <./) ts&> 'invCDF0"0 R';'invCDF1 R';'invCDF2 R'
NB. 42.5888       1
NB. 1.00093 30.5095
NB.       1 25.4229
