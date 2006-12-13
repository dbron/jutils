unmapall_jmf_''
erase 'K J L spcs O'


require 'jmf'
JCHAR map_jmf_ 'K';'C:\projects\rma_data_dump\dump.rpt'


NB. K=:fread 'C:\projects\rma_data_dump\dump.rpt'
L=:({.~ i.&1@:(('- ',CRLF)&E.)) K
spcs=:' ' = L }.~ 1 + len =: i.&LF L

 J=:LF cut K
$J
(~. ,. #/.~) #&>J
O=:spcs  (] <;._2~ 1 ,~ <:@:#@:] {. [) L: 0 J
 O=:>O

unmapall_jmf_''
erase 'K J L spcs O'

A =: 2 {. O
O =: 2 }. O
O =: _4 }. O
O=:<@:>"1|: O
$&>O
{.A

normalizeSqlNames =: verb define
	(0 2 $ a:) normalizeSqlNames y
:
	y =. ( (] # ((toupper@:{~`]`[} I.) _1&(|.!.0)@:-.)) e.&ALPHA) each y  NB.  Non-alphanumerics seperate words.  So just capitalize the letter after the symbol and remove the symbol
	y =. x&stringreplace each y  NB.  User specific string transformations
	y =. _2 (, ([^:(-:&'ID'@:[)~ toupper))&>~/@:split_z_ each  y  NB.  If the last 2 letters are 'ID', make sure they're capitalized, so they get to be a seperate word.
	y =.  (<UCALPHA;LCALPHA) (] <@:toupper;.1~ 2&(>/\)@:((<./i.0)&,)@:(i.&1"1@:|:@:(e. S: 0)~) ) &.>  y NB. seperate names into words by detecting capital/lowercase boundaries (some of which I imposed `manually`
	y =. '_' (join -.&a:) each y  NB.  Join words with underscores
	y
)

N=:(_2 ]\ 'Adc';'AdC';'CoB';'Cob') normalizeSqlNames  {.A

g =: dyad define

	for_n. x do.
	   dat=.n_index {:: y
	   dat fwrite fn =. 'c:\tmp\',(;n),'.txt'
	   (JCHAR,{:$dat) map_jmf_ n,<fn
	end.
)

N g O

erase 'O' NB. APPLICATION_ID
unmap_jmf_ 'K'

$~.DISBURSEMENT_DATE

((k,'_'),L:0 c=.(a,1)<;._2 b, ' ') g ('';({:$DISBURSEMENT_DATE){.1,~a=:-. e.&ALPHA b=:'YYYY-MM-DD HH:mm:SS.UUU') <;._2 (k=.'DISBURSEMENT_DATE')~
('_' join k ; 3 {.c)=:(<.10 ^ 4 2 2[ >: <. 10 ^. 3{.6!:0'') #. ( DISBURSEMENT_DATE_YYYY (,.~ 0&".)~  DISBURSEMENT_DATE_MM (,.~ 0&".)~ 0&". DISBURSEMENT_DATE_DD ) NB.  #~ -. DISBURSEMENT_DATE_YYYY =&:s: {.;:'NULL'
+/(=>./)DISBURSEMENT_DATE_YYYY_MM_DD


((k,'_'),L:0 c=.(a,1)<;._2 b, ' ') g ('';({:$k~){.1,~a=:-. e.&ALPHA b=:'YYYY-MM-DD HH:mm:SS.UUU') <;._2 (k=.'DATE_APPLIED')~
('_' join k ; 3 {.c)=:(<.10 ^ 4 2 2[ >: <. 10 ^. 3{.6!:0'') #. ( (k,'_',0{::c)~ (,.~ 0&".)~  (k,'_',1{::c)~ (,.~ 0&".)~ 0&". (k,'_',2{::c)~ ) NB.  #~ -. DISBURSEMENT_DATE_YYYY =&:s: {.;:'NULL'

>./ DATE_APPLIED_YYYY_MM_DD #~ (=>./)DISBURSEMENT_DATE_YYYY_MM_DD

((=>./) DATE_APPLIED_YYYY_MM_DD ) # DISBURSEMENT_DATE_YYYY_MM_DD

 DISBURSEMENT_DATE_YYYY_MM_DD #~ DATE_APPLIED_YYYY_MM_DD  > >./ DISBURSEMENT_DATE_YYYY_MM_DD

>./ DATE_APPLIED_YYYY_MM_DD  
