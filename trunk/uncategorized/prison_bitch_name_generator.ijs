NB.  See http://members.iglou.com/lyons/bitchGen.html
NB.  URL available as of 2004-Mar-29
PRISON_BITCH_NAMES=: a: -.~ LF arbCut noun define
Faggot
Twinkle Toes
Ball Boy
Ox
One Nut
The Bastard
Bitch Ho
Stubby
Boy Pussy
Man Hole
Fuzzy Nuts
Sweet Lips
The Alter Boy
Baby Buns
Sweet Cheeks
Weed Whacker
Sugar Plum Fairy
Fudge Boy
Ass Mangler
Fruity Pebbles
Shit Stain
Snaggle Tooth
Beecher
Hot Hole
Cum Guzzler
Self-Toucher
Cum Queen
Fancy Pants
Salad Tosser
Ass Cunt
He Whore
Turd Tapper
The Wood-meister
Herr Homo
Jockstrap Jockey
Golden Shower Whore
Gay Boy
Long Dong Kong
Towelboy
Cock Gobler
Ass Muncher
Faggot Enforcer
Ass Executioner
Nipple Nibbler
The Fist
Gimp
The Harpoon
Ball Sucker
Tubby Bitch
Asspick
The Jacker
Juicy Ass
Turd Knocker
The Crack Killer
Knob Goblin
Cum Bucket
Sugar Pussy
Skank Cunt
Mouth-Mangler
The Necrophiliac
The Perv
Hung Muther
Shower Stalker
Slick Dick
Fist Fucker
The One-Eyed Ogre
Horse Hung Harry
Squealing Piglet
Queer Johnny
Boy Bitch
Fat Boy
Whore
Dildo Head
Nut Buster
Cum Stain
Glory Hole
Finger Fucker
Backroom Baller
Double Fisted
Ugly Skank Bitch Twat
Count Suckula
The Undertaker
The Piss Guzzler
Shit Eater
Keller's Fuck Boy
Water Boy
Wish Bone
Aryan Fuck Toy
Fuck Stick
Cock Sucker
Ass Eater
)

NB.  Most of the name generators on the web use the same algorithm, but different name lists.
NB.  This function can emulate any of them (with an appropriate LHA).
nameSelector				=:  [ {~ ((|~ <:@:#)~ +/@:;@:(>:@:(LCALPHA&i.)@:lc&.>))    							NB.  Original algorithm, NAMES {~ (#NAMES) | +/ LCALPHA i. lc INPUT
NB.nameSelector				=:  [ {~ {.@:(1&{.)@:((= >./) index)@:([ +/@:e.&:(-.&'aeiou') &> <@:;@:(lc&.>)@:])  NB.  Shares the most letters (not including vowels)
NB.nameSelector				=:  [ {~ ?@#@:[ 												   					NB.  Random name
NB.nameSelector				=:  (< ;:^:_1 -.&a: (|: {~"_1 {:@:$ ?@:# #) ' '&arbCut &> [) ats					NB.  Slot machine alogrithm (random first word, random second word, etc.)

NB.  EG:  prisonBitchNameGenerator@:(' '&arbCut^:(0: = L.))"1  'Daniel Bron' NB.  Returns <'One Nut'
prisonBitchNameGenerator	=:  PRISON_BITCH_NAMES&nameSelector

NB.  Interactive prompt;use the J session as our UI.
pbng						=:  verb define
	smoutput (LF;LF,TAB) replace CRLF envelope 80 wordWrap 'Enter a person`s name at the prompt (or multiple names seperated by commas) to see what his bitch name would be in prison.  Type a single closing parenthesis '')'' to quit.'
	easyInEasyOut			=.  ( CRLF&, NVtext a:&,. (,. ((<'=')&,. prisonBitchNameGenerator ' '&arbCut) ats &>) trim&.> ','&arbCut ' '&collapseMultiples ) ats
	easyInEasyOut smconsole 'NAMES> ' ''
)