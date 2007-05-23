hx =: noun define
   * * * *
  *       *
 *         *
*           *
 *         *
  *       *
   * * * *

    * * *
   *     *
  *       *
   *     *
    * * *

     * *
    *   *
     * *

      *
)

HX =: LF >@:cut&.> (2#LF) arbCut hx
Hx =: <@:(' *' {~ [: +./ '*' =&> (-@:i.@:# |.&.> ] {.&.>~ #@:>@:{.))\. HX
eC6n =: ('*' +/@:,@:=&> |.) Hx  NB. Empirical numbers for C6n
Ckn =: 1 + (* 2&!)  NB.  http://en.wikipedia.org/wiki/Centered_polygonal_number
C6n =: 6&Ckn
assert eC6n -: C6n 1+ i. # Hx
   
