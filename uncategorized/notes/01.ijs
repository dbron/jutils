es =: erasthones_sieve =: verb define
  	N =. y. 
	L =. N # 0
	for_i. 2 + i. %: N do.
		if. -. i { L do.
			L =. L 1:`((>: #) #~ [)`[ } i * 2 + i. <. i %~ # L
		end.
	end.
)