NB.  Utilities 

az      =:  'abcdefghijklmnopqrstuvwxyz'
AZ      =:  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
aZ      =:  az,AZ

NB.  Name the various error messages
(=&a:`(,:&(<'XXXX'))} k)=.1+i.#k=. toupper@:('_error' (] }.~ -@#@[ * [ -: -@#@[ {. ]) e.&aZ`('_'&,:)})&.> 9!:8''

NB.  Precondition checkers
assert  =:  0 0 $ 13!:8@:]^:((0 e. ])`([))
isType  =:  -: {.@($ ,)~&0	

NB.  Train to gerund ( (+/ % #) t2g -: +/`%`# . Has known bugs (try (+/ # ,&<) t2g) 
NB.  Utility only used in  "rr"  cover function.
t2g     =:  adverb define NB.  train to gerund
        if. verb -: nc un=.{.;:'u' do.
                NB.!  Must be a way to avoid the redundant boxopen.
                boxopen (}: , boxxopen@:$:@:{:)@:>@:{:^:((,&.>'23')e.~{.)@:> 5!:1 un
        else.
                u 
        end.
)

NB.  Conjunction  rr  doesn't represent a proposed new definition
NB.  of " .  It is only a cover function I would define locally 
NB.  if the proposed new definitions of  "  below were implemented.
rr      =:  conjunction define
	u r (v t2g)	     NB.  Precludes use of rV directly, but allows us to write  u rr (f g h)  for  u r (f`g`h)  .
)




NB.  PROPOSAL:  new overall definition of  "  
r       =:  conjunction define NB.  General rank

	if. verb-:nc{.;:'v' do.
		u rV v
	elseif. a: isType n do.
		if. *./ ((,3)-:$n) > nmr =. 0 isType&> n do.
			u rG n
		elseif. *./ nmr do.
			u rB n
		elseif. do.
			DOMAIN assert 1
		end.
NB. 	elseif. (0 isType n) *. 1=#@$n do.          NB.  Ambrus' proposal
NB. 		if. 3<#n  do. n =. 3 $&.|. n end.       NB.  Rule 2
NB. 		if.+./ ngr=.0>n do. n =. nrg}n,:_ end.  NB.  Rule 1
NB. 		u"n
	elseif. do.
		u"n
	end.
	
)

NB.  PROPOSAL:  u"v y  <->  u"(v y) y  & similarly for the dyad.
rV      =:  conjunction define NB.  u"v reproposed
	  u r (  v y) y
:
	x u r (x v y) y
)

NB.  PROPOSAL:  u"n  with n boxed but not gerund, then n represents nested recursions, one level per box.
NB.  EG: u"(1 1;2;3 3 3)  <=>  u"1 1"2"3 3 3
rB      =:  conjunction define NB.  r"B with B boxed (non gerund) 
	DOMAIN assert a: isType n
	RANK assert 1=#@$n   NB.  Exclude scalars for now - maybe we can find a better use for u"(<something)
	DOMAIN assert 0 isType&> n

	u (,({.;:'r')<@,"0(":noun)&;&.>n)`:6
)

NB.  PROPOSAL:  u"n y with n a gerund f`g`h is  u"( (f u b. 0) g h&#&$ y) y  & similarly for the dyad
rG     =:  conjunction define NB.  r"G with G gerund 
	DOMAIN assert a: isType n
	RANK assert 1=#@$n   
	LENGTH assert 3=#n  NB.  COuld just assert on (,3)-:$n  but RANK vs LENGTH gives more help

	'mru dru' =. split u b. 0  NB.  n@.0 bind (u b. 0) 
	u r ( n@.0 bind mru : (n@.0/ bind dru) n@.1 n@.2&#&$)  NB.  Could skip the bind if we assume n@.0 is functional & side-effect free (should be)
)


NB.  PROPOSAL:  Competes with rV for the new definition of  u"v  , and is similar to 
NB.  (and in some ways a simplification of) rG :
NB.        u"v y <=>   u"(      mru  v&,   # $ y )y 
NB.      x u"v y <=> x u"( (lru,rru) v x ,&#&$ y )y 
rP     =:  conjunction define NB.  r"P with P a verb processing pertinent information (verb rank[s] on the left, noun rank[s] on the right)
	u r ( ,@:( 1: :_2: {. u b.@:0: )   v  ,&#&$)
)