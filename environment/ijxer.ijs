NB.  This will turn any script into a 1-liner executable by the bots
NB.  in the #jsoftware or #ijx channels on the IRC networks Freenode
NB.  and EFnet.
NB.
NB.  THe output of this one liner is guarunteed to be the same as the
NB.  original script, with the following exceptions:
NB.    (A) The output MUST be on the last line
NB.        (i.e. the last non-blank non-comment line of your script 
NB.        must be the output of your script.)  In particular, if 
NB.        your script ends with something like:
NB.                3 : 0 'a'
NB.                .       y
NB.                )
NB.         You will get a nonce error.
NB.
NB.   (Ai) If your script introduces a  ( : 0) as its 
NB.        last executable production, and doesn't end with
NB.        a  )  , weird things will happen.
NB.
NB.   (B)  The converter does some text normalization
NB.        to make the output briefer.  This will have no effect
NB.        on J code, but will affect lines read by (0 : 0)
NB.
NB.   (C)  Funny tricks like  9!:27  or  13!:0  etc will probably 
NB.        cause funny results.  
NB.
NB.   (Ci) Your script will not run from a file.  So, e.g., 3 : '4!:4 <''y''' 0 
NB.        won't do what you expect.
NB.
NB.   (D)  The output is assigned to the variable  Z_ijx_ .  Since this
NB.        is the last line of your script, that shouldn't matter, but
NB.        there might be edge conditions where it does.

lrep           =.  3 : '5!:5<''y'''
'TAB CR LF'    =.  9 10 13 { a.
dltb           =.  #~ ([: (+./\ *. +./\.) ' '&~:)
sr             =.  2 : '(m&=`(e.&m)@.(1<#m))`(,:&n) }'
isnb           =.  3&(('NB.' -: {.) *. '.:' -.@:e.~ { :: (' '"_))@:>@:{:@:(;: :: (a:"_))
dropnb         =.  }.~ isnb * -@:#@:>@:{:@:;:
cut            =.  [: -.&a: <@:dltb@:dropnb;._2@,~
strprep        =.  (LF&cut)@:(TAB sr ' ')@:(-.&CR)
boxopen        =.  <^:(0 = L.)
fread          =.  1!:1@:boxopen
nonexplend     =.  ( (13!:8 )@:(11"_)^:(')'-:{.&>@:{:))
fprep          =.  nonexplend@:strprep@:fread
join           =.  -@:#@:[ }. ;@:(,&.> boxopen)~
assgnlast      =.  }:    , 'Z_ijx_ =: ' , L: 0 {:
srep           =.  ';'&join@:(lrep&.>)@:assgnlast@:fprep
ijxer          =:  '+ 2 : ''Z_ijx_'' ( 0!:0 ; (10{a.) ,&.> ' , ')' ,~ srep f.
clixer         =:  'clipcopy *' wd@:, ijxer