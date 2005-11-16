MORSE=: makeTable noun define
A	.-
B	-...
C	-.-.
D	-..
E	.
F	..-.
G	--.
H	....
I	..
J	.---
K	-.-
L	.-..
M	--
N	-.
O	---
P	.--.
Q	--.-
R	.-.
S	...
T	-
U	..-
V	...-
W	.--
X	-..-
Y	-.--
Z	--..
0	-----
1	.----
2	..---
3	...--
4	....-
5	.....
6	-....
7	--...
8	---..
9	----.
.	.-.-.-
,	--..--
?	..--..
/	-..-.
)

COMMENTS=: noun define
	Don't think of these symbols as "dashes" and "dots". Instead, think of these as "dah's" and "dit's". When a 'dit' is in the middle of a letter, think of it as a 'di'. 
	Example: the letter 'f' should be thought of as di-di-dah-dit.
	Okay, at first this may look and sound silly but it is much better thinking this way as opposed to "dots" and "dashes".
	
	Now let's move on to how these characters are sent.
	In terms of duration, one "dah" equals 3 "dits".
	The pause between each "dah" or "dit" equals one "dit". 
	Example: when you send the letter 'f' it would be as: 
		'di' (pause 1 dit) 'di' (pause 1 dit) 'dah' (pause 1 dit) dit.
	The pause between each letter is 3 dits.
	The pause between each word is 5 dits.
)