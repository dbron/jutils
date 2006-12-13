    NB.  The fundamental operation, which is, more or less,
    NB.
    NB.     (m i. y) { n
    NB.
    NB.  but the interpreter is supplied with the
    NB.  following opportunities for optimization:
    NB.
    NB.     #0  m is sorted (and n rearraged accordingly)
    NB.     #1  After sorting, m and n are bound to their respective verbs
    NB.     #2  i.!.0 is used in place of i.
    NB.
    lookup          =:  conjunction define
    NB.  This conj. could be simpler, but I want to handle the case that
    NB.  a default value is supplied by appending an element to n
      keyGrade      =. /: m
      {&(t ,~ keyGrade /:~ > {: 't h' =. n ([ ({. ,&:< }.)~ _1&*@:(-: >:)&:#) m)@:((m /: keyGrade)&(i.!.0))
)

    NB.  Conjunction like lookup, but whose derived verb is invertible
    NB.  The (n {.~ # m) is to handle the case where a default value is supplied.
    NB.
    invertibleLookup=:  conjunction def 'm lookup n :. ((n {.~ # m) lookup m)'

    NB.  Invertible verb to turn the items of any J noun into integers.
    NB.
    nounToIntVector =: (6: s: s:)@: (3 : '<5!:5<''y'''"_1 :.(;@:(".&.>)))

    NB.  Proposed conjuction 'T:',  which is fundamentally like invertibleLookup,
    NB.  but the interpreter is given another opportunity for optimization,
    NB.  in that 's:' is used.
    NB.
    NB.  This could be made really fast, because at the bottom level the operation
    NB.  is:
    NB.
    NB.     sorted_integers i.!.0 integers
    NB.
    T_colon         =: conjunction define

        'm n'     =.  nounToIntVector&.> m ,&:< n

        NB.  If I use &.: in place of &. I get a domain error
        NB.  when trying to access the inverse of the derived verb.
        (m invertibleLookup n) &. nounToIntVector  f.
)

    NB.  Proposed conjunction 'X:', which is like 'T:' only items in y
    NB.  not found in m are not changed.
    NB.
    X_colon         =:  conjunction define

        NB.  If  e.&(/:~ something)  were optimized, I could use:
        NB.
        NB.    e.&(/:~ nounToIntVector m)@:nounToIntVector  in place of  e.&m
        NB.
        NB.  Of course, I'd have to calculate (nounToIntVector  y) and (/:~ nounToIntVector m)
        NB.  twice (once here and once in T_colon), but the optimization might
        NB.  compensate for that.
        NB.
        NB.  Even better, If I could figure out a default item to append to n which is
        NB.  guarunteed not to be in y, I could use
        NB.
        NB.     (, defaultItem)  in place of  ({.~ >:@:#)
        NB.
        NB.  and
        NB.
        NB.     =&({: n)        in place of  e.&m
        NB.
        NB.  And leverage the work that i.!.0 did in lookup (i.e. figuring out which
        NB.  items in y are not in m).
        NB.
        NB.  Of course, if these conjunctions were implemented as primitives
        NB.  all of this could be optimized out the wazoo.
        xcolon      =. 2 : 'e.&m  4 : ''x } y'' (,: m T_colon (({.~ >:@:#) n))'
        m xcolon n :. (n xcolon m)
)

    NB.  Simple case:  a first-last name map..
    uplook          =:  (;:'Roger Daniel') T_colon (;:'Hui Bron')

    NB.  Map first names to last names.
    smoutput         uplook                     ;: 'Daniel Roger'

    NB.  The mapping is invertible.
    smoutput (-: ]&.:uplook)                    ;: 'Daniel Roger'

    NB.  Try to map an unknown first name.
    smoutput         uplook :: (13!:12 bind '') ;: 'Eric'



    NB.  Default case:  A first-last name map with a default last name.
    uplookDefaulted =:  (;:'Roger Daniel') T_colon (;:'Hui Bron UNKNOWN')

    NB.  Map last names to first names, using the supplied default.
    smoutput         uplookDefaulted                      ;: 'Daniel Roger Eric'

    NB.  The inverse does NOT have a default, because the mapping is NOT 1-to-1
    smoutput         uplookDefaulted^:_1 :: (13!:12 bind '') ;: 'UNKNOWN'



    NB.  Obvious translation application:  Convert a string to uppercase.
    uppercase       =:  'abcdefghijklmopqrstuvwxyz' X_colon 'ABCDEFGHIJKLMOPQRSTUVWXYZ'
    smoutput uppercase 'Hello, world!'

    NB.  And its magically correct inverse, lowercase.
    smoutput uppercase^:_1 'Hello, world!'