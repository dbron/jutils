DATA  =: }.@:}:&.|: }: (#~ $&0 1@:#) (LF,'|') multiCut toJ noun define
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|27.47|-3.4 |98|97|100  |48 |-3   |36|5 |4    |17   |2|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|29.6 |-27.8|97|99|"-- "|100|"-- "|21|10|11   |28   |0|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|50.85|-8.9 |99|96|69   |322|24   |31|13|6    |3    |3|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|37.5 |4.8  |99|95|147  |82 |256  |89|66|23   |"-- "|2|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|37.05|-4.9 |99|94|34   |44 |35   |6 |13|19   |40   |3|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|18.01|-10.8|98|94|1    |55 |200  |19|23|"-- "|35   |0|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|39.94|-17.7|98|94|251  |288|218  |89|6 |6    |17   |3|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|42   |-5.2 |97|96|42   |26 |22   |3 |27|7    |50   |3|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|23.47|-19.9|98|93|38   |64 |7    |54|12|13   |82   |1|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
|68.5 |-16.9|97|95|202  |176|"-- "|29|9 |9    |"-- "|1|
+-----+-----+--+--+-----+---+-----+--+--+-----+-----+-+
)
NB.  numerify		=:  ($ $ 0&".@:((#~ -.) ' " '&E.)@:(;:^:_1)@:,) 
NB.  appendAverage	=:  (,: # $ +/ ,:@:% #)
NB.  N				=: (=&(<'"-- "') 4 :'x.}y.' appendAverage@:numerify) DATA

	   NB.  Noun:  Placeholder for a "missing value"
	   MISSING_VALUE	=:  __

	   NB.  Conjunction:  Perform operation over input less the "missing values"
	   NB.  LHA is monadic verb, RHA is placeholder for "missing value"
	   withoutMissing	=:  2 : 'u.@:(-.&n.)' NB.  In J4 I could have said [.@:(-.&)

	   NB.  Adverb:  Performs operation on data, ignoring MISSING_VALUEs
	   NB.  EG:  (+/ % #) ignoreMissing 1 __ 2 __ 3 __ 4 __ 5 NB.  Returns 3
	   ignoreMissing	=:  withoutMissing MISSING_VALUE

	   NB.  Monadic verb:  Turn array in DATA format into a numeric array,
	   NB.  with MISSING_VALUE substituted for "missing values".
	   numerify		=:  ($ $ MISSING_VALUE&".@:((#~ -.) ' " '&E.)@:(;:^:_1)@:,)

	   NB.  Adverb:  Perform operations on the columns of the data
	   onColumns 	=:  ("1)(&.|:)

	   NB.  Monadic verb:  Append to the input a matrix of the the
	   NB.  average of its items.
	   appendAverage=: (,: # $ [: ,: (+/ % #) ignoreMissing onColumns)

	   NB.  Monadic verb:  Given an input array in DATA form, output a numeric
	   NB.  array of the same shape, with the "missing values" replaced with
	   NB.  the average of their corresponding columns.
	   replaceMissingWithAverage	=:  (=&MISSING_VALUE 4 :'x.}y.' appendAverage)@:numerify

	   replaceMissingWithAverage DATA