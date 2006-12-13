NB.  	File system locations
cocurrent 'z'            [ originalLocale_z_ =. coname''
'REPORT_DIR REPORT_FILE'=: (({. ,&< }.)~ (# <. >:@:i:&'\')) 3 : '(4!:4 {:: 4!:3) <''y''' $0
load OMS_DIR,'..\..\util\default\resolvelink.ijs'
CODE_ROOT			=:  resolvelink REPORT_DIR, '..\'
UTIL_DIR			=:  resolvelink CODE_ROOT,'util\default\'
RSERVER_DIR			=:  resolvelink CODE_ROOT,'rserver\default\'
TABLE_DIR			=:  resolvelink CODE_ROOT,'table\default\'
erase 'originalLocale_z_' [ cocurrent originalLocale

NB.  Production/Development
PRODUCTION					=: (;: 'Bron Parashar2K') -.@:e.~&:(,@:tolower&.>) <2!:5 'COMPUTERNAME'

NB.  DEPENDENCY SECTION

NB.  Strings is for 'dtb'
NB.  Boot is to connect to the OMS server,
NB.  DanUtils & General are for utilities.
NB.  Table is for 'From'
load 'strings'
load UTIL_DIR&,&.> ;: 'boot danutils general'
load TABLE_DIR , 'table'


NB.  Sets up our connection to the OMS server, and various utilities used to access it.
bootConnection		=: verb define
	try.	
		NB.  Ensure global names are put in z
		cocurrent 	'z'
		
		NB.  Connection details
		'OMSHP OMSROOT' =: BootClient 'oms.prod1.live'
	
		NB.  Make sure to load the rget which is compatible with the server
		load OMSROOT,'rserver\default\rclient'
		
		NB.  Utility functions to access the OMS server
		doRemotely		=:  conjunction def 'n&rget@:(u callToText)'
		doOnOMSServer	=:  OMSHP&rget
	
		NB.  Example:  i. ohs 5  NB.  Calculates results on OMS server and returns answer
		oos				=:  onOMSServer	=: doRemotely OMSHP
	
		OT				=:  doOnOMSServer 'OT' 
		ET				=:  doOnOMSServer 'OT' 

		NB.  Return code is good
		return =. 0;'OK'
	catch.
		return =. (13!:11;13!:12) ''
	end.

	return
)

o			=: 1 Extract__OT oos 'SERVICE=RGRAY'
e			=: 1 Extract__ET oos 'OID=', ;:^:_1 }. , 'OID' From o

CLAMS=: ;}: , (<' ,. ') ,.~ parenclose each  a: -.~ , {."1 (LF;'NB.') multiCut TAB -.~ noun define
	<'REND'
	}. 'ACCOUNT' From e
	}. 'EVID' From e 
	}. 'TICKER' From e 
	}. 'OURTAG' From e
	'n/NYSE a/AMEX' lookup trim@:lc each , }. 'EXCH' From e
	<'USD'
	<dateToString'YYYYMMDD'
	": each (}. 'OID SHARES' From o) map , }. 'OID' From e
	}. ": each 'SHARES' From e
	}. ": each 'PRICE' From e
	<'0.00'
	<'0.00'
	'b/B s/S t/SS' lookup trim@:lc each , }. 'ACTION' From e
	<'0226' 
	<'REND' 
	<'0226'
	<'REND'
	a: 
	<'COR'
	(<:#e)#<'A'NB. (trim@:uc each , }. 'ACTYPE' From e)
)

(dateToString 'b:\temp\omstrades_YYYYMMDD.txt') fwrite~ TAB sr '|' compressTableText NVtext ". CLAMS