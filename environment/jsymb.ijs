

mkdir DIR



symbdata     =:  0 4 $ a:
symbdata     =:  symbdata , 'card'   ; 5   ; JINT  ; 0$0
symbdata     =:  symbdata , 'strlen' ; 5   ; JINT  ; 0$0
symbdata     =:  symbdata , 'table'  ; 1e6 ; JINT  ; 10
symbdata     =:  symbdata , 'str'    ; 1e7 ; JCHAR ; 0$0
symbdata     =:  symbdata , 'hash'   ; 1e4 ; JINT  ; 0$0
symbdata     =:  symbdata , 'root'   ; 5   ; JINT  ; 0$0
symbdata     =:  symbdata , 'fillfac'; 5   ; JINT  ; 0$0
symbdata     =:  symbdata , 'gap'    ; 5   ; JINT  ; 0$0


require 'jmf'
DIR_jsymb_         =: 'D:\temp\jsymb\'
mapdata_jsymb_     =: dyad define
    'name MAXSIZE_IN_BYTES JTYPE TRAILING_SHAPE' =. 4 {. boxopen x.
	NAME     =.  toupper name
	name     =.  tolower name
	fn       =.  DIR,name,'.jmf'
	createjmf_jmf_ fn;MAXSIZE_IN_BYTES
	(JTYPE, TRAILING_SHAPE) map_jmf_ (localname =. NAME,'_',(; {. , coname''),'_');fn;NAME;0
	(localname) =. y.
)

unmapall_jmf_''
(<"1  (mapdata_jsymb_ 0&s:)&.> i.@:#) symbdata

NB.10 s: ".@:,&'_jsymb_' each ;: 'CARD STRLEN TABLE STR HASH ROOT FILLFAC GAP'
10 s: (<CARD_jsymb_),(<STRLEN_jsymb_),(<TABLE_jsymb_),(<STR_jsymb_),(<HASH_jsymb_),(<ROOT_jsymb_),(<FILLFAC_jsymb_),(<GAP_jsymb_)