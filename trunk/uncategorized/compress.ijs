NB.  ----------------------------------
NB.  0:  Convert to/from internal form.
internal		=:  3!:1
NB.  ----------------------------------


NB.  ----------------------------------
NB.  1:  Encode/decode data.
NB.  To encode data that contains all of a.
require jpath '~system\packages\misc\base64.ijs'

NB.  Scalar replace
sr				=:  2 : '(m.&=)`(,:&n.) } y.'

encode			=:  verb define
	if. y. e.~ null =. 0 { a. do.
	NB.  The function compressblock_jsfl_ doesn't like nulls

		if. 0 < # freeLetters =. a. -. y. do.
		NB.  If there's a free letter from the alphabet,
		NB.  encode nulls as that character.

			nullChar=.  {. freeLetters
			ed		=.  nullChar , null sr nullChar y.
			type	=.  'X'
		else.
		NB.  If the data contains all of a., base64 encode it.
		NB.  Since we only want to restrict the alphabet by one character
		NB.  (i.e. to }. a.), there is probably a more efficient encoding 
		NB.  mechanism. Base64 encoding might actually expand the data so
		NB.  much that the benefits of compression are lost.

			ed		=. tobase64 y.
			type	=.  '6' 
		end.
	else.
		NB.  No 0s in y. .. so leave it as-is
		ed			=.  y.
		type		=. 'N'
	end.

	type , ed
)
decode			=: (3 : '({. y.) sr (0 { a.) }. y.'`frombase64`])@:}.@.('X6N'&i.@:{.) 
enc				=:   encode :. decode
NB.  ----------------------------------



NB.  ----------------------------------
NB.  2:  Compress/expand data.
require 'dll'
require jpath '~addons\sfl\sflcompress.ijs'

NB.  Fix the error in compressblock_jsfl_:
NB.       a  -: expandblock_jsfl_ compressblock_jsfl_ a=.,'a'
NB.  0
NB.     (,a) -: expandblock_jsfl_ fixedcompressblock_jsfl_ a=.,'a'
NB.  1
0!:100 'fixedcompressblock_jsfl_ =: ',  ('(#source)';'(>:#source)') rplc~ 5!:5<'compressblock_jsfl_'
compress		=:  fixedcompressblock_jsfl_ :. expandblock_jsfl_
NB.  ----------------------------------



NB.  ----------------------------------
NB.  4:  Put it all together.
squish			=:  compress@:enc@:internal
testSquish		=: (-: ]&.:squish)
NB.  ----------------------------------