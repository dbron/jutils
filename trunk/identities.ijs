require 'PRIM'

NB. Add the commuted verbs to the list of verbs
verbs        =. ,(,. '~' , L: 0~ ]) PRIM_VERBS

NB.  Verbs and their identities
ids        =:  ((,. #~ [: , _9 ~: ;@:,@:]) 3 : ('v =. a: 1 : y';'v/i.0') ::_9:&.>) verbs

NB.  Verbs with valid identities
id_verbs   =: {."1 ids

NB.  Verbs whose identities do not match the identities of their reflex  (i.e.   -. (u/ -: u~/) ''  )
paired_ids =:  (#~ (1 ~: #@:~.)@:({:"1)&>) (</.~ {.@;:@:>@:{."1) ids
NB.  rpt   =: TAB,(#~ ([: (+./\ *. +./\.) [: -. e.&(TAB,CRLF,' '))) NVtext ,: (,~ a: <@#~ #) (,~ '' <@$~ 0 ,~ [: }: $@:>@:{.) (<0 1) C. L: 1 0 '-' , each (ljust&.>@:[ , rjust&.>@:])/ <@:>"1 |: ": each (;:'dyad id'), }:;paired_ids , each<a:

test_front =: 1 : 'u/ -: [: u/ (u/i.0) ,  ]'  NB.  Does prepending the identity element change the answer?
test_back  =: 1 : 'u/ -: [: u/ (u/i.0) ,~ ]'  NB.  Does appending  the identity element change the answer?

NB.  Prepend-id-test a set of verbs (provided the data against which to test)
t_front    =: 2 : '(#~ [: -. 3 : (''v =. a: 1 : y'';'' v test_front '',ntt m) &>) n'

NB.  Append-id-test  a set of verbs (provided the data against which to test)
t_back     =: 2 : '(#~ [: -. 3 : (''v =. a: 1 : y'';'' v test_back  '',ntt m) &>) n'

NB.  Some of these are artifacts of the datasets chosen
assert (i.10) t_front id_verbs  -: <;._2 '% %: - ^ >: !~ |~ <:~ '
assert 1 1 1  t_front id_verbs  -: <;._2 '%. - > %:~ |~ <~ '
assert (i.10) t_back  id_verbs  -: <;._2 '%: -~ '
assert 1 1 1  t_back  id_verbs  -: <;._2 '-~ ^~ '

