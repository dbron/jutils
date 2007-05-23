require 'debug jmf doog'
load'~user\etrade\blotter\blotter.ijs'
dbr 1
itay_requires =: ;: 'account last first order_id trader_id status b_s_ss_o_c quantity symbol optionsymbol mkt_lmt tif type time_entered b_s fill_qty price report action_time'
FIELDS        =: (_2]\;:'STATUS ORDER_STATUS QUANTITY ORDER_QUANTITY') ({:"1@:[)`((i. {."1)~)`] } normalNames_blotter_ itay_requires 
NB.coerase k #~ 0 ~: nc 'IFIJX_',L:0 '_' ,&.>~  k =. conl 1


	NB.  Need Last Business Date instead of _1+, I think.
NB. fn =: (todate _1 + todayno 3 {. 6!:0'') dateToString~ 'c:\documents and settings\dbron\my documents\proj\blotter\blotterMMDDYYYY.txt'
   NB.fn=:'C:\Documents and Settings\dbron\My Documents\proj\blotter\Blotter02022007.txt'
NB.a =: _3 ]\ 2007 01 30   2007 01 31  2007 02 01  2007 02 02  2007 02 05  2007 02 06  2007 02 07  2007 02 08  2007 02 12

NB.  Raul Miller's fixed-width-to-delimited from 
NB.  http://www.jsoftware.com/pipermail/programming/2007-February/005054.html
NB. other SPACE DELIM
s         =:  0 10#:10*".;._2]0 :0
      2.1   0.0   1.1  NB. 0: skipping initial whitespace
      2.2   0.3   1.2  NB. 1: found delimiter
      2.0   3.2   1.2  NB. 2: found non-whitespace
      2.2   3.0   1.1  NB. 3: potentially trailing whitespace
)

fieldSep  =: TAB

fw2dl     =:  (1;s;(a.=' ')+2*a.e.LF,fieldSep)&;:  NB.  Assuming TAB__A is TAB

doIt =: verb define
	unmapall_jmf_ ''
	erase'M_base_ N_base_ O_base_ p_base_ q_base_ W_base_'

	fn        =. 'E:\spoolview_blotter_YYYY-MM-DD.input' dateToString y NB. 'C:\Documents and Settings\dbron\My Documents\proj\blotter\Blotter_Report_20070308233004.rpt' 

	A         =: fn conew 'blotter'

	TAB__A    =:  fieldSep $~ 1 ,~ count__meta__A 
	CRLFs__A  =:  LF $~ 1 ,~ count__meta__A   NB.  Linux box -- no CR req'd

	Q         =:  '__A' , L: 0~ (<'CRLFs'),~}:,FIELDS ,. <'TAB'
	W         =:  ,>(,.&:(".^:(1 = #@:$)))&.>/ Q
	W         =: fw2dl W

	W 1!:2<'E:\blotter_YYYY-MM-DD.rpt' dateToString TRADE_DATE__meta__A
)

NB. 4 A."1]0 ". (1 1j1 1 1j1 1 1 1 1) #"1 ('c:\documents and settings\dbron\my documents\proj\blotter\Blotter' (+ i.)&:#'02132007') {"1 H#~ '7' = (-#'6.txt       '){"1 H=:>listFiles 'c:\documents and settings\dbron\my documents\proj\blotter\blotter*.txt'
doIt"1] 2007 05 21 NB.todate _1 + todayno 3 {. 6!:0'' NB. 2007 02 26 NB. todate 1 2 3 6 7 8 9 13 14 (+ todayno)  2007 01 30  
NB.doIt"1] 2007 3 14
NB.q=:W~:' '
NB.p=:W e. LF,{.,TAB__A
NB.N =: p ([: ; <@(+./\);.2) q 
NB.NB.p=:1 (0)} p  NB.  We know that W ends in a LF, so p ends in a 1, but
NB.M =: p ([: ; <@(+./\.);.1) q NB. we can't use ;.2 because if the cuts end in 1s, +/\. won't work

NB.O =: M*.N
NB.W=:O#W

NB.ts 'M=: p ([: ; <@(  (+./\ *. +./\.)@:(_1&(0})) );.2) q' NB. we can't use ;.2 because if the cuts end in 1s, +/\. won't work
NB.W=:M#W

RRR_base_ =: '-' I.@:~: 4 {"1 ACCOUNT
a. i. RRR_base_ { T

dbret''
dbrun ''
ln'date'

7 { {: dbstk''


dbst''

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