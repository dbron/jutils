coclass 'neurallayer'

NB. y. is (number of neurons,number of inputs per neuron);(parms: activation function name;variance penalty);(optional weights)
NB. We create the neurons, initialize them with random weights, and save the
NB. names of the activation functions and their derivatives.
NB. We add on an input of 1 to each input vector
create =: 3 : 0
NB. If weights not given use randoms with an average absolute value (total at input) of 0.5
if. 2 < #y. do.
  weights =: 2 {:: y.
  searchdirection =: prevgradient =: ($weights) $ 1  NB. Direction of the last search: init to 0.  scaffolding
else.
NB. If weights not given, initialize the information used for conjugate-gradient search
  weights =: 4.0 ((% +/@:|) * ])"_ 1 <: +: 0.000001 * ? (shp =. 0 1 + 0 {:: y.) $ 1000000
  searchdirection =: prevgradient =: ($weights) $ 1  NB. Direction of the last search: init to 0
end.
'anm varpenalty' =: 1 {:: y.
actfun =: (< 'actfun_', anm) `: 6
actfunderiv =: (< 'actfun_deriv_', anm) `: 6
actfunderiv2 =: (< 'actfun_deriv2_', anm) `: 6
actfunchangehomotopy =: (< 'actfun_changehomotopy_', anm) `: 6
''
)

destroy =: codestroy

NB. Here are the activation functions
NB. y. is the weighted sum of the inputs
NB. Result is the function value
NB. For derivative:
NB. x. is parameter
NB. y. is function value
NB. Result is derivative
NB. For second derivative:
NB. x. is function value
NB. y. is derivative value
NB. Result is second derivative
NB. linear.  value is identity, derivative is 1
actfun_linear =: ]
actfun_deriv_linear =: 1:"0
actfun_deriv2_linear =: 0:"0
NB. sigmoid. 2 * (1/(1+exp(-beta*sum)) - 0.5 (subtract 0.5 & double to keep 0 bias)
actfun_sigmoid =: <:@:+:@:%@:>:@:^@:-
actfun_deriv_sigmoid =: -:@:-.@:*:  NB. deriv is (f+1) * (1-f) * 0.5 = 0.5 * 1-f^2
NB.	   (deriv of g = %@:>:@:^@:-y. is g(1-g); actfun_sigmoid produces f=_1 + 2g; so deriv
NB.	   of f is 2g' = 2g(1-g) = (f+1)(1-g) = (f+1)(1-(f+1)%2)) = (f+1)(1-f)%2 as above
actfun_deriv2_sigmoid =: -@:*  NB. deriv2 is -f(f')
NB. tanh(beta*sum)/beta
actfun_tanh =: 7&o.
actfun_deriv_tanh =: -.@:*:  NB. deriv is  (1 - f^2)
actfun_deriv2_tanh =: (_2&*)@:*  NB. deriv2 is  -2f(f')

NB. y. is a fraction indicating how much to jiggle the weights
NB. We jiggle the weights by a random value in the range -y. to y.
perturbweights =: 3 : 0
weights =: weights + y. * <: 0.000002 *  ? ($ weights) $ 1000000
''
)

NB. x. is (activation-function parms) y. is the inputs (rank 1 or higher)
NB. result is the outputs.
eval =: 3 : 0
actfun weights +/@:*"1"_ 1 (1 ,"0 1 y.)
)

NB. x. is the distance to move in the search direction
NB. y. is inputs to the layer (probably rank-2, could be rank-1)
NB. result is the output resultng from a move of that distance.
NB. We save the calculated activation function for later use, in case we take the move
probeeval =: 4 : 0
lastactfun =: actfun (weights + x. * searchdirection) +/@:*"1"_ 1 lastinput =: 1 ,"0 1 y.
)

NB. y. is error vector at outputs (actual - expected)
NB. Result is error vector for the previous layer
NB. We save the gradient in gradient
NB. Following Schittenkopf et al. (Neural Networks vol 10 #3 pp 505-516) we
NB. calculate the gradient after adding an error term which is the
NB. variance of each neuron's output over the training set
backproperror =: 3 : 0
NB. $y. is #vectors,#neurons
NB. $weights is #neurons,#inputs
NB. $lastactfun is #vectors,#neurons
outerr =. }."1 weights (+/ . *)~ inverr =. y. * lastactderiv =: actfunderiv lastactfun
NB. $inverr is #vectors,#neurons
NB. Add the penalty term, using a penalty proportional to the variance of
NB. the output of the neuron.  This is equivalent to using an expected
NB. output value of the mean for the training set; then the average
NB. squared 'error' is the variance. and we add an appropriate adjustment
if. 0 ~: varpenalty do.
inverr =. inverr + varpenalty * lastactderiv * (-"_1 _ (+/ % #)) lastactfun
end.
NB. $lastinput is #vectors,#inputs
gradient =: lastinput (+/ . *~  |:)&:(,:^:(1: = #@$)) inverr  NB. Bring inputs up to rank 2 if necessary
NB. $gradient is #neurons,#inputs
outerr
)

NB. Nilad.  Result is grad dot grad, prevgrad dot prevgrad, and grad dot prevgrad
NB. for this layer
calcgraddotproducts =: 3 : 0
(prevgradient =: gradient) ((] +/^:(#@$)@:*:)~  ,  (] +/^:(#@$)@:*:)  ,    +/^:(#@$)@:*) prevgradient
)

NB. y. is the amount of the previous search direction we want to keep
NB. We calculate the search direction as -grad(E) + y. * previous direction, and save that
setsearchdirection =: 3 : 0
searchdirection =: gradient -~ y. * searchdirection
NILRET
)

NB. y. is (2,#testvectors,#inputs) list of (first derivative,second derivative)
NB. We append a zero to the derivative representing the bias term (since the bias
NB. does not change when mu changes), and then calculate derivatives with respect
NB. to mu of the output for each input vector
NB. Result is (2,#testvectors,#inputs) list of (first derivative,second derivative) of the outputs wrt mu
calcderivatives =: 3 : 0
0 calcderivatives y.
:
NB. obsolete  yin   =: y.
NB. obsolete lin   =: lastinput
NB. obsolete lip   =: lastinputprime
NB. obsolete laf   =: lastactfun
NB. obsolete lad   =: lastactderiv
evalwt =. weights + x. * searchdirection
NB. we need a probeeval first, so lastactderiv will be right.  Or evaluate here if x. ~: 0
b =. (evalwt +/@:*"1"_ 1 lastinputprime =: 0 ,"0 1  (0) { y.) + (searchdirection +/@:*"1"_ 1 lastinput)
d =. (evalwt +/@:*"1"_ 1 (0) ,"0 1  (1) { y.) + (+: searchdirection +/@:*"1"_ 1 lastinputprime)
(lastactderiv * b) ,: ((lastactfun actfunderiv2 lastactderiv) * *: b) + lastactderiv * d
)

NB. y. is the distance to move in the search direction
NB. We set the weights for a move of that distance
ratifyprobe =: 3 : 0
weights =: weights + y. * searchdirection
NILRET
)

NB. Return (#neurons,#inputs);(activation function);(current weights)
querylayer =: 3 : 0
(0 1 -~ $weights);(anm;varpenalty);weights
)
