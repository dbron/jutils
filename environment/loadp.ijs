
NB.  The &: allows this verb to be ambivalent, so load will be called
NB.  monadically or dyadically as appropriate.
loadpa   =:  >@:{.@:(4!:5&.>)@:(1 0"_)@:load&:([ 4!:5@:1:)

NB.  Pretty print list of names changed by loading the script
loadp    =:  ((,:~ 0&".&.>)~/&.|: ;:;._2 noun define)&(YAA=:dyad define)@:loadpa

    NB.  Format namelist
    y.=./:~y.-.;:'LOADED_j_'
    y.=. y. ,.~ <"> (18!:0 (0&>@:] 4 : 'x.}y.' (,: +&6)~) nc) HOO_z_=:y.
    y.=.(,. (((}.~ >:) ,&:< {.~ ) i:&'_')@:(}.~ _1: * -:&'_'@:{:)&>)/ |: y.
    y.=. (x.,.a:) , y.
    y.=.({. ( ,&'s'@:>@:((<0;0)&{) (; <) (,&':'&.>@:~.@:{.  (,. \: [) [: list each </./)@:|:@:}.) /. |:@:}.) |: y.
    y.=.(#~ 0: < #&>@:({:"1)) y.

    NB.  Box drawing characters to space
    NB.  makes formatting pretty
    n6=.9!:6''
    9!:7' '#~#n6
    y.=.":y.
    9!:7 n6

    NB.  Going to smoutput namelist, don't want them
    NB.  truncated
    n36=.9!:36 ''
    9!:37 (0 , 2 + $ y.) 2 3 1 } n36
    smoutput y.
    9!:37 n36

    NB.  No results
    empty''
)
_2  invalid
_1	unused
 0	noun
 1	adverb
 2	conjunction
 3	verb
 6	localename
 7  localenum
)