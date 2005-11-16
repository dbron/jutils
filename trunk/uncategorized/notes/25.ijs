mpid_lookup					=:  ([: ;@:(((trim@:}.@:}:)&.>@:{. (((,&':'@:[ , ])&.>"0 {."1) <@:,. {:"1@:]) (({. ,&([: < trim"1) }.@:}.)~ i.&'=')&> @:}.);.1~ ([: '[]'&-: 0 _1&{)&>) <;._2) noun define
[TLW]
	ALA=ARCA
	ARA=ARCA
	BAM=BAMM
	BRD=REDI
	BSL=GSCO
	CSL=GSCO
	FLE=FLEE
	FRD=REDI
	FSL=GSCO
	INS=INCX
	ISA=INET
	ISL=INET
	ISX=INET
	ITGI=ITGI
	KGT=NITE
	KNA=NITE
	KNT=NITE
	KSL=GSCO
	MAI=INCA
	MIS=INCA
	MKN=NITE
	MPI=INCA
	NYB=AMEX
	PER=AMEX
	RCB=ARCA
	RCH=ARCA
	RWA=ARCA
	SCH=SCHB
	SRD=REDI
	SWA=SCHB
	TKN=NITE
	TKT=NITE
	TRI=TRIM
	TRM=TRIM
	TRO=GSCO
	TRS=GSCO
	WRD=ARCA
	WSL=GSCO
[APPI]
	ISLD=INET
	RGRAY=REND
	CSFBOT=FBCO
	BLZUSA=BLZUSA
	BLZCAN=BLZCAN
)

SERVICES =: ' ' makeTable noun define
+ ISA
+ WSL
+ XYN
+ MAI
* SBI0
* BLZUSA
+ NYB
* ISLD
+ MPI
+ WBO
+ WRD
+ RWA
+ BRD
* BLZCAN
+ MIS
* CSFBOT
+ TWR
+ FLE
+ ARA
+ ISL
+ MIN
+ TKT
+ TND
+ SCH
* RGRAY
+ BLZ
+ RCH
* NULL
+ BSL
+ KNA                 
+ ISA                 
+ MAI
* om507.96232
* SBI0
* BLZUSA
+ NYB
* ISLD
+ WRD                 
+ RWA                 
* BLZCAN              
+ MIS
* CSFBOT              
+ TWR
+ ARA
+ ISL
+ TKT
* RGRAY
+ BLZ
+ RCH                 
* NULL
* BLZUSA              
)

SERVICES =: ' ' makeTable noun define
+ ISA
+ WSL
+ NYB
+ WRD
+ RWA
+ MIS
+ ARA
+ ISL
+ TKT
+ SCH
* RGRAY
+ RCH
* NULL
+ ARA                 
+ ISA                 
+ ISL                 
+ RWA                 
* 
)

smoutput ;:^:_1 /:~ a: -.~ ~. mpid_lookup mapWithDefault ((;:'+*') msr (,&':' each ;:'TLW APPI')@:{. ,&.> {:) |: 2 {."1 SERVICES