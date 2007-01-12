   require 'debug jmf doog'
   dbr 1
   coerase k #~ 0 ~: nc 'IFIJX_',L:0 '_' ,&.>~  k =. conl 1
   unmapall_jmf_ ''
   load'~user\util\etrade\blotter\blotter.ijs'
   fn=:'C:\Documents and Settings\dbron\My Documents\blotter\Blotter10172006.txt'
   A=:fn conew 'blotter'

noun define

   abc=:'a b c'=:1 <@:(0 _2})"_1 ({:$T__A) xb"_1 +/\"_1 fwidths__meta__A , 9 11 11 11 10 9 10 12 8 13 9 5 5 13 8 9 8 7 15 16 7 5 1 ,: 9 11 11 9 12 6 8 15 10 8 14 4 3 11 11 10 8 8 15 12 10 5 2
   
   CDE =: 'C D E'=:abc (<;.1~ ''&;)~&.> <T__A
   GHI=:'G H I'=:({."1 ;&:~: {:"1) L: 0 CDE

NB. noun define
   (\: 7!:5) a:-.~,;:ln__''
   JKL =: 'J K L'=:+.&>/ L: 1 GHI
MNO=:'M N O'=:JKL # L: 0 CDE
M
N
O
$a

T__A #~ 'QQQQ' (1 e. E.)"1 T__A
T__A #~ 'AAPL JA' (1 e. E.)"1 T__A
c

erase'abc a b c CDE C D E GHI G H I JKL J K L MNO M N O'
(names__meta__A ,L:0 '_',~'_',>{;A) =: T__A<;._2~ '';1 _1:}({:$T__A) xb +/\ 9 11 11 9 12 6 8 15 10 8 14 4 3 11 11 10 8 8 15 12 10 4 
~.ACCOUNT__A

ls names__meta__A 
a. i. ~.DET__A

_5 {. 1 _1:}({:$T__A) xb +/\ 9 11 11 9 12 6 8 15 10 8 14 4 3 11 11 10 8 8 15 12 10 4
ERT=:~.@:".&.> names__meta__A ,L:0 '_',~'_',>{;A
10 {.&.> ERT
_4 _3 _2 _1 { ERT
a. i. /:~ ~._2{."1 > _5 { ERT
a. i. /:~ ~._2{."1 > _4 { ERT
a. i. /:~ ~._2{."1 > _3 { ERT
dbr 0
clip ;:^:_1 ,names__meta__A (#@:] {. |:@:,:) ":&.> 9 11 11 9 12 6 8 15 10 8 14 4 3 11 11 10 8 8 15 12 10 4 

([: ~. [: 	{:"1 ".)&.>names__meta__A

EXPECTED
)