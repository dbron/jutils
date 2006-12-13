NB. To do:
NB. If we are not in the final minimization phase, just take an estimate
NB.  using the derivatives & go there; if it points the wrong way, search
NB.  for a reasonable spot.  If we are in the final minimization, bracket the
NB.  minimum & call dbrent.  In any case, take the maximum component of the
NB.  search direction & limit the move to avoid saturation of the weights.
NB. Take derivatives at specified point on the search line; use line search to
NB.    find best mu; compare to actual mu.  Should we be taking mu along the
NB.    gradient rather than along the search line?
NB. Jiggle the weights rather than the inputs
NB. Manage storage for the layer globals
NB. Switch to conjugate-gradient search direction to converge (but we may have
NB.  to do line minimization then)
NB. Recycle saturated neurons
coclass 'neuralnet'
require 'printf'
load 'd:\trade\langexten.ijs'
load 'd:\trade\utils.ijs'
NB. obsolete load 'd:\trade\tradingdays.ijs'

NB. Create network
NB. y is (list of layer descriptions: (# neurons, #inputs);(activation function name);(optional weights)); (other stuff TBD)
NB. If the weights are given, the # neurons/inputs are not used
create =: 3 : 0
layers =: (0 {:: y) conew"1 _ 'neurallayer'
''
)

destroy =: 3 : 0
for_l. layers do. destroy__l NIL end.
codestroy y
)

NB. Evaluate the network on the input vector y; x is layer parms
NB. Result is the last layer's output vector.
eval =: 3 : 0
for_l. layers do. y =. eval__l y end.
)

NB. Perform one cycle of backprop.
NB. y is vector of inputs;target output
NB. x is (noise level to add to the inputs)
NB. Result is error resulting from evaluating the inputs after the move of 'mu'
NB. We use the conjugate gradient for the search.
NB. On input, 'mu' holds the distance to move; we move there (provided the move
NB. reduces the error, else we take a small move), and then calculate the next move
NB. using the method of Yu et al., IEEE Trans Neural Nets, v6 #3 May 1995 pp. 669ff
backpropcycle =: 4 : 0
noise =. x
'inputs target' =. y

NB. We enter here with a move 'mu' to make, using the direction saved in the layers.
NB. We make a trial evaluation of the move; if it is OK, we keep it, otherwise
NB. We just make a small move
outputs =. inputs
for_l. layers do. outputs =. mu probeeval__l outputs end.
if. preverror < probeerror =. +/^:(#@$)@:*: finalerror =. outputs - target do.
  display 'move failure - searching for a small move'
  NB. We may be in a spot where the calculated derivatives predict a large move,
  NB. but that move doesn't work.  In that case, we search for a suitable move,
  NB. starting with a very small one
  mu =: 0.00001
  while.
    probeerror =. preverror
    outputs =. inputs
    for_l. layers do. outputs =. mu probeeval__l outputs end.
    NB. Loop again if new error is better than previous
    probeerror > preverror =: +/^:(#@$)@:*: outputs - target
  do.
    NB. The previous try was OK - look at a longer one
    mu =: mu * 1.3
  end.
  cgresetcount =: _  NB. Go back to gradient direction
  mu =: mu % 1.3
qprintf 'mu preverror probeerror '
  outputs =. inputs
  for_l. layers do. outputs =. mu probeeval__l outputs end.
  probeerror =. +/^:(#@$)@:*: finalerror =. outputs - target
end.

NB. We have the move to make.  Make it.
for_l. layers do. ratifyprobe__l mu end.

NB. Add noise to the inputs, as indicated by the noise parameter
if. noise ~: 0 do.
  for_l. layers do. perturbweights__l noise end.  NB. jiggle weights
  NB. Now that we have applied noise, we have to recompute the error
  outputs =. inputs
  for_l. layers do. outputs =. 0 probeeval__l outputs end.
  probeerror =. +/^:(#@$)@:*: finalerror =. outputs - target
  cgresetcount =: _  NB. Don't bother with CG direction if we are adding noise
end.

preverror =: probeerror
NB. Propagate the errors back through the layers, updating the weights as we go.
NB. Each layer returns the target for the previous layer
NB. 'starting backprop, target=%j' printf target
error =. finalerror
for_l. |. layers do. error =. backproperror__l error end.

NB. Now calculate the conjugate gradient search direction.
NB. Call each layer to return grad dot grad, prevgrad dot prevgrad, and grad dot prevgrad
NB. (grad - prevgrad) dot (grad - prevgrad)
NB. Also, save the gradient for use next time.
dotprods =. 0 NB. Init the sum (will become a vector)
for_l. layers do. dotprods =. dotprods + calcgraddotproducts__l NIL end.
'graddotgrad prevgraddotprevgrad graddotprevgrad' =. dotprods
cglambda =. (graddotgrad - graddotprevgrad) % prevgraddotprevgrad  NB. Amount of old direction to add in
qprintf 'graddotgrad prevgraddotprevgrad graddotprevgrad cglambda '
NB. Every so often, we reset the conjugate gradient direction and just use the gradient
NB. We also reset when the gradient is not close to perpendicular to the previous
NB. gradient
if. (10 < cgresetcount =: >: cgresetcount) +. 0.04 < (*: graddotprevgrad) % graddotgrad * prevgraddotprevgrad do.
  cglambda =. 0
  cgresetcount =: 0
display 'resetting cgdirection'
end.

NB. In each layer, set the conjugate gradient search direction, which is a combination
NB. of -grad(E) (saved in the layer) and the previous direction (also saved in the layer).
NB. The amount of the previous direction to use is given by ((grad - prevgrad) dot grad) % grad dot grad.
NB. We will save this direction in the layer, for use during search and for use
NB. during the next backpropcycle.
NB. If you don't want to use conjugate gradient search, use a y of 0 in this call.
NB. While we're at it, accumulate the length-squared of the search direction
for_l. layers do. setsearchdirection__l ] cglambda end.

NB. Now we calculate our move mu.  We compute the first and second derivatives
NB. of the error function with respect to mu, evaluated at the current position.
NB. If err'' > 0, we use a rough
NB. approximation of Newton's method, i. e. -err'%err''.  If err'' <= 0 (or is
NB. very small positive), that won't work, and we use a small positive move
NB. which we keep increasing until we hit a positive second derivative
NB. The formulas come from Yu et al., IEEE Trans Neural Nets, v6 #3 May 1995 pp. 669ff
qprintf 'cglambda preverror '
derivatives =. (2 , $inputs) $ 0  NB. Init derivatives from previous layer
for_l. layers do. derivatives =. calcderivatives__l derivatives end.
NB. $Result is 2,#testvectors,#outputs: item 0 is err', item 1 is err'' for each output of each testcase

NB.  Combine to produce err', err'' for all testcases and outputs
errprime =. +:@:(+/^:(#@$) % */@$) finalerror * 0 { derivatives
errprime2 =. +:@:(+/^:(#@$) % */@$) (*: 0 { derivatives) + finalerror * 1 { derivatives

NB. Calculate the move, either by Newton or by guesswork
if. errprime2 > 0.0001 do.
  mu =: - errprime % errprime2  NB. bowl-shaped fn: use Newton.  This is the normal case
  searchmovesize =: 0.000001  NB. Reinit for next search
else.
  cgresetcount =: _  NB. For the next move, forget about conjugate gradient as we follow the rapid slope down
  mu =: searchmovesize =: searchmovesize * 1.5  NB. Keep looking, in bigger steps
end.
qprintf 'preverror mu searchmovesize cgresetcount errprime errprime2 '
NB. scaffolding recompute errprime, errprime2 as secants
outputs =. inputs
for_l. layers do. outputs =. 0.00001 probeeval__l outputs end.
error1 =. +/^:(#@$)@:*: outputs - target
outputs =. inputs
for_l. layers do. outputs =. 0.00002 probeeval__l outputs end.
error2 =. +/^:(#@$)@:*: outputs - target
secantprime =. -: (error1 - preverror) % 0.00001
secantprime2 =. ((-: (error2 - error1) % 0.00001) - secantprime) % 0.00001
qprintf 'secantprime secantprime2 '
NB. Continue scaffolding: compute mu by line search
outputs =. inputs
for_l. layers do. outputs =. mu probeeval__l outputs end.
probeerror =. +/^:(#@$)@:*: evec =. outputs - target
derivatives =. (2 , $inputs) $ 0  NB. Init derivatives from previous layer
for_l. layers do. derivatives =. mu calcderivatives__l derivatives end.
muerrprime =. +:@:(+/^:(#@$) % */@$) evec * 0 { derivatives
muerrprime2 =. +:@:(+/^:(#@$) % */@$) (*: 0 { derivatives) + evec * 1 { derivatives
newmu =. mu - muerrprime % muerrprime2
qprintf 'probeerror newmu muerrprime muerrprime2 '
outputs =. inputs
for_l. layers do. outputs =. newmu probeeval__l outputs end.
probeerror =. +/^:(#@$)@:*: evec =. outputs - target
derivatives =. (2 , $inputs) $ 0  NB. Init derivatives from previous layer
for_l. layers do. derivatives =. newmu calcderivatives__l derivatives end.
mu2errprime =. +:@:(+/^:(#@$) % */@$) evec * 0 { derivatives
mu2errprime2 =. +:@:(+/^:(#@$) % */@$) (*: 0 { derivatives) + evec * 1 { derivatives
newmu2 =. newmu - mu2errprime % mu2errprime2
qprintf 'probeerror newmu2 mu2errprime mu2errprime2 '


preverror % */ $ finalerror  NB. return average error
)

NB. Train the net
NB. y is (list of inputs;list of outputs) for training ; (list of inputs;list of outputs) for crossvalidation
NB. x is parameters to control the operation
NB.  0{x is a gerund, inverse of pdf to use for sampling the inputs (currently not used)
NB.  1{::x is the noise-addition schedule for the inputs:
NB.   0{ is vector of noise amplitudes, one for each input
NB.   1{ is (start-of-taper time,end time) in # of cycles.  Taper is linear
NB.  2{::x is unused
NB.  3{::x is unused
NB.  4{::x is the minimum number of training cycles allowed
NB.  5{::x termination criterion: when we don't improve this much, stop
NB.  6{x is a gerund, the routine to use for calculating the cv error.  Returns a vector, which
NB.			we type.  The first element must be the error
train =: 4 : 0
'tr cv' =. y
'tin tout' =. tr
'cvin cvout' =. cv
invpdf =. (0{x) `:6
rmserr =. (+/ % #)&.(*:"_)@:,@:-
calccverr =. (6{::x) `: 6
'noisesched  mincycles termcrit' =. 1 4 5 { x
'cverr cycct lasttime lastlogtime trerr' =. ($0) ; 0 ; __ ; __ ; 100000
NB. y is ts, result is time in seconds from epoch
julianday =: {:  NB. Use better version if you go over month boundary
ymdhmstojsec =. 13 : '0 24 60 60 #. (julianday 3 {. y) , 3 }. y'
NB. Loop through in batches of the test set, but in random order.  To make a
NB. turnaround on crossvalidation easier to detect, we use the same
NB. random sequence each time: 8 copies of the test vectors, shuffled
NB. not used  testvec =. (<: # tin) <. <. (#tin) * invpdf (%~ ?@:(5000&#)) 1000000
evec =. 0 2$a:
'cgresetcount searchmovesize mu preverror' =: _ 0.000001 0 _ NB. Init to use gradient, ignoring previous gradient
NB. Now loop to minimize the error function
whilst. ((+./ (< {:) cverr) +. (cycct < 0 { mincycles)) *. ((termcrit < -~/ 2 {. trerr) +. (cycct < 1 { mincycles)) do.  NB. stop when oldest cv is the best; but there's a minimum
qprintf 'cycct '
NB. Calculate the strength of noise to be used this cycle
  noisevec =. (* (0&>.)@(1&<.)@(invlerp&cycct)@|.)&>/ noisesched
  bperr =. noisevec backpropcycle tr
  cverr =. 10 {.!._ cverr ,~ {. cverrfull =. cvout calccverr eval cvin
  trerr =. 10 {.!._ trerr ,~ bperr
  evec =. evec , bperr , {. cverr
  cycct =. 1 + cycct
  if. 120 < (currtime =. <. ymdhmstojsec tod NIL) - lastlogtime  do.  NB. display every 5 seconds
    lastlogtime =. currtime
NB.    writerschlog '%j cycles: average CV error is %j, average training error is %j'&sprintf cycct ; (((0j4&*)@(~: <.) ": ]) cverrfull) ; ({. trerr)
  end.
  if. 5 < (currtime =. <. ymdhmstojsec tod NIL) - lasttime  do.  NB. display every 5 seconds
    lasttime =. currtime
    '%j cycles: average CV error is %j, average training error is %j' printf cycct ; (((0j4&*)@(~: <.) ": ]) cverrfull) ; ({. trerr)
NB.     display ": querynet ''
NB.     for_l. layers do. 'total output errors: %j' printf (+/ err__l) end.
NB.     if. # plotd =. (#~ (0&<)@:,@:(1&eval)) ,/ ,"0/~ (% #) i. 50 do.
NB.       'type point' plot 0 1 <@:({"1)"0 _ plotd
NB.     end.
  end.
end.
)

NB. Read out the whole net in a form that can be used to initialize a net object
querynet =: 3 : 0
layerlist =. 0 3$a:
for_l. layers do. layerlist =. layerlist , querylayer__l '' end.
,<layerlist  NB. Return boxed vector
)