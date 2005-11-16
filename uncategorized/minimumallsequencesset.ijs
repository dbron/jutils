NB.  The minimum set length for a set that contains every possible sequence of N-length
NB.  sets from the M-length set is M^N + N - 1.  The reason for this is a minimum set has
NB.  to have at LEAST the same number of starting points  for N-length sequences as there are
NB.  possible N-length sequences.  Further, because the last N-1 elements can't be starting
NB.  points for length-N sequences (because the length from any of the last N-1 elements to
NB.  the end of the list is less than N), we must tack on extra elements.  The N-1 is
NB.  derived from the fact that is the last element needs N-1 more elements to be a possible
NB.  starting point for a N-element sequence.  And obviously if the last element can be a
NB.  starting point for a N-element sequence then so can all the points before it. 

NB.  Therefore the absolute minimum size for a set containing all possible length N sequences
NB.  of elements from a set of size M is the number of possible N-length sequences + N - 1.
NB.  The number of ways to pick N-length (with possible duplicates) sequences from a set of 
NB.  length M is M^N, because each position in the size N subset can be any of M items.  
NB.  That's M*M*M*...*M = M^N.   

NB.  So we have derived that the absolute minimum size for a set
NB.  containing all possible length N sequences of elements from a set of size M is
NB.  M^N + N - 1.

   3 (^ + [: <: ]) 2							NB.  Minimum all-sequences set size for sequence-size=2 and number-of-possible-elements=3
10
   2 <"1@:(((# #: [: i. ^~) #@:]) { ]) 'ABC'	NB.  All possible length-2 sets from possible elements set of 'ABC'
ÚÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄ¿
³AA³AB³AC³BA³BB³BC³CA³CB³CC³
ÀÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÙ
     # 'CAABBCCBAC'   							NB.  Length of my attempt at a miminum all-sequences set
10
   (# 'CAABBCCBAC') -: 2 (^ + [: <: ])~ #'ABC'	NB.  Yep, it's minimal
1
   2 <\ 'CAABBCCBAC'   							NB.  Extract all length-2 sequences from it
ÚÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄ¿
³CA³AA³AB³BB³BC³CC³CB³BA³AC³
ÀÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÙ
   (2 <\ 'CAABBCCBAC') -:&sort 2 <"1@:(((# #: i.@:^~) #@:] ) { ]) 'ABC'	NB.  Yep, they're all there. 
1

	2 (<"1@:(((# #: i.@:^~) #@:] ) { ]) -:&sort ([ (<\) genString)) 'ABC'	NB.  General testing utility for a "genString"