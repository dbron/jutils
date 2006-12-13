require 'jmf'

unmapall_jmf_''
erase 'K J L spcs O'


JCHAR map_jmf_ 'K';'C:\projects\rma_data_dump\apptrack.rpt'


NB. K=:fread 'C:\projects\rma_data_dump\dump.rpt'
L=:({.~ i.&1@:(('- ',CRLF)&E.)) K
spcs=:' ' = L }.~ 1 + len =: i.&LF L

 J=:LF cut K
$J
(~. ,. #/.~) #&>J
O=:spcs  (] <;._2~ 1 ,~ <:@:#@:] {. [) L: 0 J
O=:>O



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


unmap_jmf_'K'
erase 'K J L spcs O'

NB. erase 'O' NB. APPLICATION_ID
NB. unmap_jmf_ 'K'

NB.$~.DISBURSEMENT_DATE
evokeN =: 3 : 'y~'

((k,'_'),L:0 c=.(a,1)<;._2 b, ' ') g ('';({:$k~){.1,~a=:-. e.&ALPHA b=:'YYYY-MM-DD HH:mm:SS.UUU') <;._2 evokeN k =. 'DATE_UPDATED'
('_' join k ; 3 {.c)=:(<.10 ^ 4 2 2[ >: <. 10 ^. 3{.6!:0'') #. |: (0 ". evokeN)&> (k , '_') ,L: 0 ]3 {. c
DATE_UPDATED_YYYY_MM_DD
