NB.  Needed for DB connection
load 'dd'

NB.  We use Tables.
load 'b:\projects\work\order_manager\main\dev\table\default\table.ijs'

NB.  Required so that we know how to declare the fields of the tables.
load 'b:\projects\work\order_manager\main\dev\oms\default\omsfields.ijs'

fetchSQL					=:  verb define
NB.  Verb performs a SQL command.  
NB.  Inputs:
NB.         	x. :  Boolen specifying what dd command to use.  Possible values are:
NB.         	      	0: ddfch
NB.         	     	1: ddfet
NB.         	      Default (i.e. monadic case) is 0.
NB.         	y. :  SQL string to execute
NB.
NB.  Outputs:   Output of SQL command.
NB.  EG:  "fetchSQL 'select * from TEST'" and "0 fetchSQL 'select * from TEST'" are equivalent to:
NB.       "ddfch _1 ,~ 'select * from TEST' ddsel SQLCONNECTION"

	NB.  Default to the faster 'ddfch'
	0 fetchSQL y.
:
	
	ddfch`ddfet@.x. _1 ,~ y. ddsel ddcon 'dsn=' , DATABASE
)

getTableColumnNames		=: verb define
NB.  Contributed by Devon McCormick [devonmcc@YAHOO.COM] on Thursday, July 17, 2003 10:03 AM
NB.  Modifications made by D. Bron.
NB.  ----------------------
NB.  * getTableColumnNames: get column names given (table or worksheet) NaMe for
NB.  Open Connection.
NB.  EG:  colnms=. 'SOMETABLE' getTableColumnNames cha=. ddcon 'dsn=DATSOURCE'
	y. getTableColumnNames SQLCONNECTION
:
	    nm	=.  x.							NB.  Table name
		oc	=.  y.							NB.  Data source handle.
    	nm	=.  nm-.';'						NB.  Remove terminal ";" from name.
    	dbi	=.  nm ddcol oc					NB.  Get DB info mat
    	colnms	=.  }.((0{dbi) i. <'COLUMN_NAME'){"1 dbi
)

NB.  Name of the ODBC connection 
DATABASE			=:  'OMSDB'
'Requested table not available in ODBC'  assert DATABASE e.&boxopen {."1 ddsrc''


NB.  The fields we'll care about from the database.
USEFUL_FIELDS		=:  ;: 'FILLED'

NB.  Get the month. Command line takes precedence.  Current month is default.
MONTH				=: dateToString bind 'YYYYMM'^:(0&-:) getOption 'month'
MONTH_BOTTOM		=: MONTH,'00'
MONTH_TOP			=: MONTH,'31'

NB.  These filters will extrac all the rows from a Tablw that were sent to a particular broker.
mapBrokerToFilter	=:  ({.@:] , (<@:(1&~:@:(#&>)@:] }:@:;@:,@:# ,.) ,&' '&.>@:}.))"1
groupBrokers		=:  ({.@:{. , <@:({:"1))/.~ {."1
BROKER_FILTERS		=:  groupBrokers@:(}.@:{. mapBrokerToFilter }.)  BROKER_TABLE	=. '|' makeTable noun define
BROKER			|VENUE|SERVICE                     |EXCH|LASTMKT
Island			|=TLW |=ISA ISL ISX                |    |
Island			|=APPI|=BLZUSA                     |    |=ISLD
Arca			|=TLW |=ALA ARA RCB RCH RWA WRD    |    |
Arca			|=APPI|=BLZUSA                     |    |=ARCA
Reynders        |=APPI|=RGRAY                      |    |
Redi			|=TLW |=BRD FRD SRD                |    |
Knight			|=TLW |=KGT KNA KNT MKN TKN TKT    |    |
Schwab          |=TLW |=SCH SWA                    |    |
Inca     		|=TLW |=MAI MIS MPI INS            |    |
Fleet			|=TLW |=FLE                        |    |
GSCO			|=TLW |=BSL CSL FSL KSL TRO TRS WSL|    |
Bamm			|=TLW |=BAM                        |    |
Itgi			|=TLW |=ITGI                       |    |
Trim			|=TLW |=TRI TRM                    |    |
)

NB.  Make sure to include all broker lookup fields in our useful fields list
USEFUL_FIELDS		=:  ~. USEFUL_FIELDS , }. {. BROKER_TABLE

NB.  The tables in SQL server that will be our data sources.
TABLES				=: (<@:{. ,  <@:>"1@:|:@:}.) '|' makeTable noun define
TABLENAME     |TYPE |DESK
OT            |order|StatArb
ET            |event|StatArb
USDESKOT      |order|USDesk
USDESKET      |event|USDesk
USDESKLISTENOT|order|USDesk
USDESKLISTENET|event|USDesk
)
T					=: Table (1;'') ,"1~ (<'"') ,. (>@:{. ,. {:@:$&.>@:}.) TABLES
Insert__T ,: TABLES

NB.  Across - apply gerund left to array on right (from system\packages\publish\web.ijs).
NB.  across	=. adverb def '(# # 1:) (}.@$ $ ,)@:u.;.1 ]'  NB.  Old, explicit version
across				=: ((}.@$ $ ,)@:)(;.1)~ (# # 1:)
NB.  Verb form of across.  Can have calculated gerund
acrossV				=: 4 : 'x. across y.'

NB.  Modify an element and put it back (make sure initial and terminal shapes match)
NB.  EG:  3: mod 2 ] 5 # 0 NB.  Returns 0 0 3 0 0
mod					=: 2 : 'u.@:(n.&{) NB. n.} ]'


NB.  Turn loops into ranks
NB.  Package this up into a verb
NB.  so that anything that wants to do a Broker/Desk breakdown can.

NB.  For now, we only care about the order tables.
NB.  Group tables by desk.
accumulateDeskData	=:   verb define 
	y.				=.  dtb&.> 	y.

	NB.  Since Lalit has defined some of the OMS' numeric fields as textual in the DB
	NB.  (because J's negative number character is '_' instead of '-'), we can't trust the
	NB.  database's definition of the fields.  We'll have to use the (current) OMS'.
	omsFields		=. USEFUL_FIELDS (] #~ (e.~ 1&{"1)) ('fields' ,~ > {. 1 { 'TYPE' From y.)~
NB.	fields_z_		=.  }. 'TYPE_NAME COLUMN_NAME COLUMN_SIZE REMARKS' From (> {. 1 { 'TABLENAME' From y.) ddcol ddcon 'dsn=',DATABASE
NB.	fields_z_		=.  ('varchar/" numeric/# /?'&lookupWithDefault`]`]`]`] across @: ,&(<1) )&.|: fields
NB.	fields_z_		=.  (0 2 }~ {.&.>@:(0&{) ,: '#'&=@:;@:{.`(,:&(<8)@:(2&{)) })&.:|: fields
NB.	fields_z_		=.  0 1 2 4 3 {"1 fields
NB.	fields_z_		=.  USEFUL_FIELDS (] #~ (e.~ 1&{"1)) fields
NB. wrongTypedFields=. fields #~ fields ~:&>/@:(,&<&:(0&{"1) {&.>~ i.@:#@:[ ; (i.~&:(1&{"1))) omsFields
	t				=.  Table omsFields

	colTypeMap		=.  1 0 {"1 Fields__t 12
	for_tn. , }. 'TABLENAME' From y. do.
		NB.  Be compatible with J5+ where reassining the loop variable inside the loop is unsupported
		tableName	=.  > tn
		data		=.  fetchSQL 'select ', (}: ; ,&','&.> USEFUL_FIELDS) , ' from ' , DATABASE , '..' , tableName , ' where DATE between ' , MONTH_BOTTOM , ' and ' , MONTH_TOP
		Insert__t ,: (<USEFUL_FIELDS), data acrossV~ (0&"."1&.>`]) {~ '#' ~: ; colTypeMap map USEFUL_FIELDS
	end.
	t	
)

createDataCube		=:  verb define
	deskTableMap	=.  y.
	resultMatrix	=.  a: $~ #&> BROKER_FILTERS;deskTableMap;<USEFUL_FIELDS

	for_brokerFilter. BROKER_FILTERS do.
		'broker filterSet' =. brokerFilter
		for_deskTable. deskTableMap do.
			desk		=. > {. deskTable
			table		=.   {: deskTable

			results		=. a: #~ # Fields__table 11

			for_filter. filterSet do.
				results  =. results  ,&.> }. {. Extract__table > filter
			end.

			resultMatrix  =. results (<brokerFilter_index;deskTable_index) } resultMatrix
		end.
	end.

	resultMatrix 
)

brokerDeskData		=:  createDataCube ((}.@:~.@:] ,. accumulateDeskData&>@:({. ,&.> }.)@:(</.~))  ,@:('DESK'&From)) 1 Extract__T 'TYPE=order'