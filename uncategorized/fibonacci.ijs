NB. Tacit Definition

self =: ]
concat =: ,
append =: self @ concat

of =: @

sum =: +/

head =: {.
lastTwo =: _2 & head

decrement =: <:

or =: `

one =: 1:

if =: @.

lessThanTwo =: 2 & > 

fiboTacit =: ((append sum of lastTwo) of (fiboTacit of decrement)) or one if lessThanTwo
NB. (((], +/ (_@&head)) @  ($: @ <:))`1:@.2&>



NB.  Explicit Definition

fiboExplicit =: 3 : 0

	i =. 0
	n =. y

	fibonacci =: 1 1

	while. i < n do.
		fibonacci =. fibonacci , ( (i+1) { fibonacci ) + (i { fibonacci) 
		i =. i + 1
	end.

	fibonacci
)