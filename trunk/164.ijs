calendar =: 3 : 0
	a=. ((j<100)*(-100&|){.6!:0'')+j=. {.y
	b=. a+-/<.4 100 400%~<:a
	r=. 28+3,(~:/0=4 100 400|a),10$5$3 2
	r=. ,(-7|b+0,+/\}:r)|."0 1 r(]&:>:*"1>/)i.42
	m=. m,(0=#m=. <:}.y)#i.12
	h=. 'JanFebMarAprMayJunJulAugSepOctNovDec'
	h=. ' Su Mo Tu We Th Fr Sa',:"1~_3(_12&{.)\h
	<"2 m{h,"2[12 6 21$,>(<'') ((r=0)#i.#r)} <"1 [ 3":,.r
)

calendar 2007 4 5