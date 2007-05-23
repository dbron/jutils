   N     =.  +&2@:i. 
   s     =.  [: (|."1) |.@(0 , 0 = {. | }.)\.
   SoE0  =:  (#~ [: -. +./@:s)@:N f.

   N     =.  +&2@:i. 
   s     =.  (~: *. 0 = |)"0 1~
   SoE1  =:  (#~ [: -. +./@:s)@:N f.
   

   N     =.  +&2@:i. 
   soe   =.  (+./@:) (#~`[:`-.`) (`:6) (@:N) f.    NB.  Adverb

   SoE0  =.  ([: (|."1) |.@(0 , 0 = {. | }.)\.) soe
   SoE1  =.  (~: *. 0 = |)"0 1~ soe

multiples     =: 4 : 'y * (1 + ( i.(>. x % y)))'   NB. max multiples n
make_sieve    =: 3 : '0 (0 1) } (y+1) $ 1'
next_prime    =: prime_indices pick_prime ]
prime_indices =: I. @ [   NB. return indices in list which equal 1
pick_prime    =: I. { [   NB. dyadic fork to lookup the 
drop_le       =: 4 : '(x > y) # x'  NB. drop elements in list <= value

NB. A process_prime 2 - marks all multiples of 2 in A as non-prime
process_prime =: 4 : '0 (}: }. (((#x)-1) multiples y)) } x'

A =: make_sieve 27
