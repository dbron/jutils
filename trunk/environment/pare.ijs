NB. Adverb: Apply [verb] To Atomic Representation [of input]
NB.
NB. The goal is to produce  
NB.    ((<":0)`) (f`) (@.(0; 1 2))
NB. Where the input and output of f are atomic representations (a.r.s).
NB.
NB. For rationale, see:  http://www.jsoftware.com/pipermail/programming/2013-November/033914.html
NB.
NB. Thus, in the RHA to the final @. : the (3 1) is (<":0)` and the
NB. (0 1) is (f`) and the (2 4) is @.(0;1 2)
A2ar =:  (`'') ( `(;:'`@.') ) ( `(<<|.;~<":noun) ) ( `(< (":noun); < 0; 1 2) ) ( @.(3 1;0 1;2 4) )

NB. Knock Out (convert nouns to verbs, 
NB. then convert everything to a.r.)
Ko   =:  ("_) (`'')
sri  =.  {.@>@{:           NB. Strip Rank Infinity off the atomic rep

NB. Process Atomic Rep: similar to A2ar except transparent handling of
NB. both nouns and verbs. 
NB.
NB. Pare is similar, but Executes the result.
NB. 
NB. Because J doesn't allow, e.g. A2ar (`:6), as A2ar produces an adverb,
NB. there's really no good way to reuse the logic of A2ar, so we copy and
NB. tweak it.
Par  =:  (@(sri f.)) (`'') ( `(;:'Ko`@.  ') ) ( `(<<|.;~<":noun) ) ( `(< (":noun); < 0; 1 2) )                        ( @.(1;4 2;0 2;3 5    ) )
Pare =:  (@(sri f.)) (`'') ( `(;:'Ko`@.`:') ) ( `(<<|.;~<":noun) ) ( `(< (":noun); < 0; 1 2) ) ( `(< (":noun); < 6) ) ( @.(1;5 2;0 2;3 6;4 7) )

NB. Atomic Representation as an adverb 
Ar   =:  ] Par

0!:2^:(DEBUG=.0) noun define
   NB. A bug in the J engine prevents S from being displayed
   S    =.  f A2ar
   T    =.  ( (<":0)` ) (f`) ( @.(0; 1 2) )

   NB. But none-the-less it's the result we want (i.e. T).
   -:&(5!:1)&</ 'ST'

   NB. Here, we can see Ar produces the actual a.r. of its input
   NB. whether that input is a noun or verb.
   ar   =.  1 : '5!:1<,''u'''

   +  ar -: +  Ar        NB. a.r. of plus  (verb)
   +/ ar -: +/ Ar        NB. a.r. of sum   (verb)
   3  ar -: 3  Ar        NB. a.r. of three (noun)
   a: ar -: a: Ar        NB. a.r. of ace   (noun)

   NB. Given the fork (v0 v1 v2), bends the outer tines 
   NB. such that it produces (v0@[ v1 v2@])
   NB. For rationale, see the thread:
   NB.  http://www.jsoftware.com/pipermail/programming/2015-December/043657.html
   xform   =.  (left center right)`'' ('[' atop~ ])`(']' atop~ ])`]@.((;:'left right') i. [)"0 L:1 ]
     atop  =.  '@' <@; <@:,&boxopen

   7 10 -:  3 4 (+: + -:) xform Pare 2 4      NB. (+:3 4) + (-: 2 4)
)