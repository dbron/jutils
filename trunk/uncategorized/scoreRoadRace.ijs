require 'regex'

NB. Utility
Pf =. 1 : ('u y';':';'x u y') NB. protect from f.

NB. Make regex more readable/maintainable
RE =. +1 :n=. |. <;._2 noun define

  '^', RE_RANK K, RE_XXX1 T`'?', RE_XXX2 T`'?', RE_SEP, (RE_FIRST,' ',RE_LAST)K

  RE_RANK  =.  '\d+|DNF|DNS|VK|DQ|OTL|x'
  RE_XXX1  =.  RE_SEP,'\d+|x'
  RE_XXX2  =.  RE_SEP,'[a-zA-Z]+\d*'
  RE_FIRST =.  RE_LAST=. '[^\t\r\n\. ]+'
  RE_SEP   =.  '[\*\t \.]+'

  K        =. '('   , ,&')' Appl  NB.  Keep
  T        =. '(?:' , ,&')' Appl  NB.  Toss
  Appl     =. 2 : 'u n'

  NB. Nouns aren't as forgiving as verbs, and 
  NB. dependencies must be defined first.
  NB. So create a script & execute it in 
  NB. reverse order.
)

NB.  Scoring tables
'GROUPS POINTS' =. <"_1 |: ".;._2 noun define
 5  ;  3 2 1                NB.  5 <= #riders <= 10
 11 ;  7 5 4 3 2 1          NB. 11 <= #riders <= 20 
 21 ;  8 6 5 4 3 2 1        NB. 21 <= #riders <= 49
 50 ; 10 8 7 6 5 4 3 2 1    NB. 50 or more #riders 
)

NB.  Logic
report             =:  tally/@:|:@:record
  tally            =.  ~.@[  sortStich catSumCount@;/.
    sortStich      =.  ,. /: ]
    catSumCount    =.  +/ (category ; ;) #
      category     =.  4 <. 1 + 35 30 20 I. (* 2&<:) 
  record           =.  [: ; (,: <"0@scores)~/&.|:&.>@:races 
    scores         =.  [: score 0 ". ;:^:_1
      score        =.  scorePlace pointGroup
        scorePlace =.  (0,]) {~ [ * (<: #)
        pointGroup =.  (0;POINTS) {::~ (<:;GROUPS) I. #
      races        =.  [: cutRaces LF , toJ@fread@jpath Pf 
        cutRaces   =.  <@:cutFields;.1~ (LF,'--') E. ]
          cutFields=.  0 1 }. RE (rxmatches rxfrom ])Pf ]

NB. Export fully-fixed functional form
NB.  e.g. report '~temp\2013.txt'
report             =: report f.

