NOTES=: noun define
   		NB.! TODO:  Handle other common pluralizations.  
		NB.! This can be acheived with a matrix.   EG, a cleaner version of:
	'wds spcl'	=.  <"1 (;: 'corps') (<1 ; ,_1) } 2 {. ,: ;: 'apple princess company millenium radius corps'  NB.  The plural of 'corps' is 'corps'
	'end rpl'	=.  <"1 |: ' /' multiCut 's/ses y/ies ium/ia ius/ii'  NB.  Later entries have precedence over earlier entries.  E.G. 'ius' vs 's'.
	((spcl = a:) * >: 1 i:~"1 |: (wds endsWith&>"1 0 end)) merge spcl , (wds ,&.> 's') ,~ rpl ,&.>~"0 1 end dropIfAppended&.>"0 1 wds
	(spcl = a:) * >: 1 i:~"1 |: (wds endsWith&>"1 0 end)

   (|: ' /' multiCut 's/ses y/ies ium/ia ius/ii')&
   (

		#&>@:{.@:[
	)
    @:|:@:(,.&a:^:(1: = rank))

	x  ({.&.>"0 1~ -@:#&>)~&:{. y


  		x   (  a:&=@:{:@:] * >@:{.@:[
                
				
			)
               y
		    


x (]  ) y 

x ((,&<~ {:) ((a:&=@:>@:{.@:[ * >@:{.@:]) ,&< (>@:{.@:[ , ,&'s'&.>@:((0 ; 0)&{::)@:[ ,~ >@:{:@:])) xx) y

x ((,&<~ {:)) y



x xx y
)

NB.  Input expected: 
NB.  	x is prefixes 
NB.     y is output of splitRootsFromEndings
roots						=.  {.@:]  NB.  This is from the output of splitRootsFromEndings
calculateMergeSpec			=.  (>:@:(i:&1@:="1)&.|: >@:{:)
mergeSpecPlusRoots			=.  calculateMergeSpec ; roots

NB.  Input expected:
NB.  	x is prefixes ,: suffixes
NB.     y is original words ,: custom plurals 
prefixes					=.  {.@:[
splitRootsFromEndings		=.  ({.@> ,&<  {:@>)@:((}. ; {.)&.>"0 1~ -@:#&>)~&:{.
mergeSpecAndRoots			=.  (prefixes mergeSpecPlusRoots splitRootsFromEndings) f.  NB.  Need to f. because I will reuse the name 'roots' and 'prefixes'

NB.  Input expected:
NB.  	x is (original words ,: custom plurals) ,&< suffixes
NB.     y is merge spec ,&< word roots
roots						=.  >@:{:@:]
suffixes					=.  >@:{:@:[
originalWords				=.  {.@:>@:{.@:[
customPlurals				=.  {:@:>@:{.@:[
mergeSpec					=.  >@:{.@:]

allPossibleSuffixes			=. (|:@:roots  |:@:(,&.>"1) suffixes)
allPossiblePlurals			=.  customPlurals , allPossibleSuffixes , ,&'s'&.>@:originalWords
mergeSpecWithCustomization	=.  a:&=@:customPlurals * mergeSpec

calculatePlurals			=.  mergeSpecWithCustomization  merge allPossiblePlurals

NB.  Input expected:
NB.  	x is prefixes ,: suffixes
NB.     y is original words ,: custom plurals 
plurals						=.  ((,&< {:)~ calculatePlurals mergeSpecAndRoots) f.

NB.  Input expected:
NB.  y is original words OR original words ,. custom plurals
transformInputForPluralization	=.  ,.&a:^:(1: = rank)@:(;:^:(2: = 3!:0))
pluralize					=:  (' /' multiCut 's/ses y/ies ay/ays ey/eys oy/oys uy/uys ium/ia ius/ii')&(plurals&|: transformInputForPluralization)

NB.  The plural of 'corps' is 'corps'
smoutput pluralize |: (;: 'corps') (<1 ; ,_1) } 2 {. ,: ;: 'apple princess company millenium radius corps'






formatTimespan 			=:  10 10 10 13 4 7 24 60 60 1000  breakdownLeagues 'Millenium Century Decade Year Month Week Day Hour Minute Second Millisecond' 

smoutput formatTimespan 1231238131