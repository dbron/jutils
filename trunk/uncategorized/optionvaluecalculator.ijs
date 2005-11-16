NB.  Option value calculator

OVC =: verb define
NB.  Option Value Calculator based on the binomial model:
NB.  Calculates the value of an American put option on a non-dividend
NB.  paying stock at time 0, rounded to the nearest penny.
NB.
NB.  Inputs:  
NB.	  	y.: List of 6 numbers, in the following order:
NB.  		S:  initial stock price
NB.  		r:  risk-free interest rate (bank)
NB.  		T:  total time (in years)
NB.  		v:  volatility (sigma)
NB.  		X:  strike price
NB.  		n:  Number of iterations
NB.
NB.  Outputs:
NB.		Single, scalar number which is the value of the option at time 0 (rounded to the nearest hundredth).
NB.
NB.  Example:  
NB.  	OVC 50 0.10 0.4167 0.40 50 5  NB. Returns 4.49

	'S r T v X n' =. y.
		
	NB.  Calculate the neccesary constants
	dt	=. T%n					
	d 	=. % u =. ^ v * %: dt
	exp	=. % a =. ^ r * dt 
	p	=. a %&(-&d) u

	NB.  This is the calculation we'll use to get the array of prices.
	NB.  At each step, the price vector is: S * (u ^ i. step) * d ^ step - i. step
	NB.  Note that we boxed the results at each step, so we don't get unneccesary fill elements.
	calculatePrices			=. <@:((S&*)@:((u&^@:] * d&^@:(- >:)) i.))"0
	
	NB.  Steps go from 1 to N+1
	prices					=. calculatePrices >: i. >: n

	NB.  To calculate option values, we don't need the prices, 
	NB.  we need strike price minus the prices (that is, 0 >. X - the price at each step)
	strikeMinusPrices		=. 0&>.@:(X&-) each prices

	NB.  The array strikeMinusPrices is now _all the information we need_ to calcuate the
	NB.  option value at each step.  That is, to calculate the option value for step J
	NB.  all we need is the strikeMinusPrice for step J and the option value for step J+1.
	NB.  In the last step, the option value is the same as the strikeMinusPrice value.
	
	NB.  This is the calculation that determins the option value for step J.
	NB.  Its input is the option value for step J+1 on the right, and the 
	NB.  strikeMinusPrice for step J on the left.
	calculateOptionValue	=.  >. exp&*@:(p&(+/@:((, 1&-)@:[ * (}. ,: }:)@:])))

	NB.  Since the option value is the same as the strikeMinusPrice value in the last step,
	NB.  We can just put calculateOptionValue between each of the elements of strikeMinusPrices
	NB.  to calculate the final option value.  That is, our final calculation will be:
	NB.  finalOptionValue =: ... (_3 { strikeMinusPrices) calculateOptionValue (_2 { strikeMinusPrices) calculateOptionValue (_1 { strikeMinusPrices)
	0.01 ([ * <.@:+&0.5@:%~) {. > calculateOptionValue&.>/ strikeMinusPrices
)




NB.!!  The following verbs do not give the same results as OVC; I believe OVC is correct (or the other
NB.    verbs aren't producing the results fot the same kind of option.  EG They could be calculating
NB.    values for call options).

chop =: ( (10"_ ^ [) %~ <.@ ((10"_ ^ [) * ])  )				NB.  (floor(10^x. * y.))/(10^x.)

option =: verb define

	'S r T sigma X steps' =. > y.

	prob =. q, p [ q =. 1 - p [ p =. (a-d)%(u-d) [ exp =. %a [ a =. ^(r*dt) [ d =. ^(-exponent) [ u =. ^exponent [ exponent =. sigma*(%:dt) [ dt  =. T%steps
	
	2 chop (2: (exp"_ * ([: +/ prob"_ * ])) \ ]) ^: steps 0 >. X - (S"_*(u"_^])*d"_^(steps"_-])) i. >: steps 
)

option2 =: verb define

	'S r T sigma X steps' =. > y.				NB.  S = initial stock price, r = risk-free interest rate (bank)
														NB.  T = total time (in years), sigma = volatility, 
														NB.  X = strike price, steps = # of iterations
														NB.  Example option2 <"0 [ 50 0.10 0.4167 0.40 50 5

	dt  =. T%steps									NB.  delta-t is the total time over the number of steps
	exponent =. sigma*(%:dt)					NB.  exponent is volatility times the square root of delta-t
	u =. ^exponent 								NB.  u is the amount the stock can go up 
	d =. %u			 								NB.  d is 1/u - the amount the stock can go down
	a =. ^(r*dt) 									NB.  a is the expected value
	exp =. %a 										NB.  exp is 1/a
	p =. (a-d)%(u-d) 								NB.  p is the probability the stock will go up
	q =. 1 - p 										NB.  q is the probability the stock will go down
	prob =. q, p									NB.  Prob is the probability vector
	
	ints =. i. >: steps							NB.  Ints is the initial vector of indicies

	finalStockPrices  =. S*(u^ints)*d^(steps-ints)			NB.  Final stock price eqn:  S x u^i x d^(steps-i)

	finalOptionValues =. 0 >. X - finalStockPrices			NB.  Final option value eqn: max(0, X - final stock price)

	singleOptionDeriver =. exp"_ * ([: +/ prob"_ * ])		NB.  Derived option eqn: exp*(p*(ith option value) + 
																			NB.  q*(jth option value))

	multipleOptionDeriver =. 2: singleOptionDeriver \ ]	NB.  Derive the new option values for each pair of 
																			NB.  old option values (with overlap)

	optionValue   =. multipleOptionDeriver ^: steps finalOptionValues		NB.  Repeat derivation N times (N = steps) 
																								NB.  (e.g. sin(sin(sin(sin(...x...))))
	
	2 chop optionValue							NB.  Cut off all but the last 2 digits.
)


option3 =: verb define

	'S r T sigma X steps' =: > y.				NB.  S = initial stock price, r = risk-free interest rate (bank)
														NB.  T = total time (in years), sigma = volatility, 
														NB.  X = strike price, steps = # of iterations
														NB.  Example option2 <"0 [ 50 0.10 0.4167 0.40 50 5

	dt  =: T%steps									NB.  delta-t is the total time over the number of steps
	exponent =: sigma*(%:dt)					NB.  exponent is volatility times the square root of delta-t
	u =: ^exponent 								NB.  u is the amount the stock can go up 
	d =: %u			 								NB.  d is 1/u - the amount the stock can go down
	a =: ^(r*dt) 									NB.  a is the expected value
	exp =: %a 										NB.  exp is 1/a
	p =: (a-d)%(u-d) 								NB.  p is the probability the stock will go up
	q =: 1 - p 										NB.  q is the probability the stock will go down
	prob =: q, p									NB.  Prob is the probability vector
	
	ints =: i. >: steps							NB.  Ints is the initial vector of indicies

	finalStockPrices  =. S*(u^ints)*d^(steps-ints)				NB.  Final stock price eqn:  S x u^i x d^(steps-i)

	finalOptionValues =. 0 >. X - finalStockPrices				NB.  Final option value eqn: max(0, X - final stock price)

	singleOptionDeriver =. exp"_ * ( +/ @ (prob"_ * ,) )		NB.  Derived option eqn: exp*(p*(ith option value) + 
														    					NB.  q*(jth option value))

	multipleOptionDeriver =. (}:@]  singleOptionDeriver"0 }.@])  		NB.  Derive the new option values for each pair of 
																							NB.  old option values (with overlap)
	optionValue   =. multipleOptionDeriver ^: steps finalOptionValues	NB.  Repeat derivation N times (N = steps) 
																							NB. (e.g. sin(sin(sin(sin(...x...))))
	2 chop optionValue																NB.  Cut off all but the last 2 digits.
)


option4 =: verb define
	
	'S r T sigma X steps' =. > y.

	prob =. q, p [ q =. 1 - p [ p =. (a-d)%(u-d) [ exp =. %a [ a =. ^(r*dt) [ d =. ^(-exponent) [ u =. ^exponent [ exponent =. sigma*(%:dt) [ dt  =. T%steps

	2 chop ((}:@])  ((exp"_ * ( +/ @ (prob"_ * ,) ))"0)  (}.@]) )  ^: steps (0 >. X - (S"_*(u"_^])*d"_^(steps"_-])) i. >: steps)
)