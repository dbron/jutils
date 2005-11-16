4!:5]1
header						=:  noun define
Record Type Code=			,: '#HD#'
Version Description=		,: 'OATS D1999-01'
Generation Date=			,: YYYY,MM,DD
Firm FORE ID=				,: DESK,'_',;OMSDATE
Reporting/Transmitting OSO=	,: '689'
User ID=					,: 'brond'
Password=					,: '06022003'
Order Receiving Firm MP ID=	,: 'MAPL'
)

NB.  Calculate the fields for the new order records
newOrder					=:  noun define
Record Type=				,: '#OE#'
Event Type=					,:   'NW'
Action Type=				,: ,  'N'
Firm ROE ID=				,: 1 {. a.									NB.  As placeholders for our line indicies, I use (0 { a).
Correct/Delete Time=		notUsed
Resubmit=					notUsed
Order Rec Firm MP ID=		notUsed
Order Received Date=		orderDateTimeStamps
Order Rec Firm Order ID=	OURTAG  									NB. This field is a maximum of 20 characters, so I used OURTAG instead of OID
Routing Firm MP ID=			notUsed
Routed order ID=			notUsed
Order Received Time=		orderDateTimeStamps
Received Method=			,: , 'E'
Issue Symbol=				TICKER
Buy/Sell Code=				([: {::&(;: 'B SL SS SX') 'bstx'&i.) ACTION
Share quantity=				":"0 SHARES
Limit Price=				":&> ((PRICE = 0) +. , 'M' = TYPE) } a: ,:~ <"0 PRICE		NB.  Leave this field blank if the it was a market order or the price was 0.  Note that I use <"0 instead of ;/ because ;/ breaks on empty vectors
Limit Order Display=		,: ,  'N'
Stop Price=					notUsed										NB.  Do we have stop orders?
Time in Force=				'D/DAY /DAY' >@:lookupWithDefault <"_1 FORCE		NB.  Kind of static now, can be changed later
Expire Date=				notUsed
Expire Time=				notUsed
No reduce/increase=			notUsed
Special Handling Code 1=	notUsed
Special Handling Code 2=	notUsed
Special Handling Code 3=	notUsed
Special Handling Code 4=	notUsed
Special Handling Code 5=	notUsed
Rec Terminal ID=			notUsed
Rec Dept ID=				notUsed
Originate Dept ID=			ACCOUNT
Account Type=				,: , 'P' 									NB.  Geri & Jon say hard-code this field for now.
Program Trading=			'NY' {~ ACTYPE e."1 'dcjukymnw'				NB.  These are all the 'program trading' values for account type in transattrs.txt
Arbitrage Code=				'NY' {~ ACTYPE e."1 'jumd'					NB.  These are all the 'index arbitrage' values for account type in transattrs.txt
Member Type=				,: ,  'M'
ECN Flag=					notUsed
Not used=					notUsed
)

NB.  Keep this code until we decide we don't need it anymore.  It's the old way of calculating the field "Sent To Firm MP ID" by defaulting COUNTERPARTY to SERVICE, unless VENUE is TLW, in which case 'TLW' is used.
NB.  > (([: ({. * >:@:{:) (' ';'TLW')&((] -:"1 ({.~ {:@:$))&>"0))@:(0 2&{) mergelists <"_1 each @:])  (< COUNTERPARTY), (< SERVICE) , < VENUE

NB.  Calculate the fields for the routed order records
routeOrder					=:  noun define
Record Type=				,: '#OE#'
Event Type=					,:   'RT'
Action Type=				,: ,  'N'
Firm ROE ID=				,: 1 {. a.									NB.  As placeholders for our line indicies, I use (0 { a).
Correct/Delete Time=		notUsed
Resubmit=					notUsed
Order Rec Firm MP ID=		notUsed
Order Received Date=		orderDateTimeStamps
Order Rec Firm Order ID=	OURTAG  NB.  (For next field) To get the MMID, we use the COUNTERPARTY field if it's present, if it's not, we look up the VENUE/SERVICE pair in our look up table; if the VENUE/SERVICE is not in our table, we default to 'VENUE:SERVICE'.
Sent To Firm MP ID=			> route =: routeToXPSE (<@removeTrailingBlanks"_1 COUNTERPARTY) (e.&(a:,<'PER')@:[ {"_1 ,.) ('ISLAND/INET A/AMEX' lookupSelfDefault <@removeTrailingBlanks"_1 LASTMKT) (beginsWith&'APPI:'&>@:] {"_1 ,.~) VENUE ([: ((i.~ {."1) { (,~ {:"1))"0 _&mpid_lookup (,&':'@:[ <@, ])&:(removeTrailingBlanks)"1) SERVICE NB.  Note that TLW encodes its AMEX counterparties as 'PER', G. Finlason says retain them as 'AMEX'
Routed order ID=			OURTAG
Issue Symbol=				TICKER
Order Sent Timestamp=		orderDateTimeStamps							NB.  The OMS does not keep seperate "order-received from client" and "order sent to venue" timestamps
Routed Share quantity=		":"0 SHARES
Routing Method=				,: , 'E'
Bunched Order=				notUsed
Originating MP ID=			notUsed
Destination=				'EX' {~ ,. route e. ;: 'AMEX CINN MWSE BOSX XPSE NYSE PHLX'	NB.  G. Finlayson says the routing method is only X if the route is one of these.
)

NB.  Calculate the fields for the cancelled order records
cancelOrder					=:  noun define
Record Type=				,: '#OE#'
Event Type=					,:   'CL'
Action Type=				,: ,  'N'
Firm ROE ID=				,: 1 {. a.									NB.  As placeholders for our line indicies, I use (0 { a).
Correct/Delete Time=		notUsed
Resubmit=					notUsed
Order Rec Firm MP ID=		notUsed
Order Received Date=		cancelPermutation { orderDateTimeStamps	NB. Find the dates and times for the orders which correspond to these cancels
Order Rec Firm Order ID=	cancelPermutation { OURTAG
Issue Symbol=				CXL_TICKER
Order Cancel Timestamp=		CXL_OURTIME makeOATSTimestamp~ (0&=@:{. }) |: CXL_DATE ,. ". ; OMSDATE
Cancel Type=				'PF' {~ ,. 0 = SHREMAINING =: SHARES -&(cancelPermutation&{) SHCANCELLED			NB.  Even if the trader cancelled the 'entire' order, according to J. Unger, if he got some fills then it's still a partial cancel
Cancel Quantity=			":"0 cancelPermutation { SHCANCELLED
Cancel Leaves Qty=			":"0 SHREMAINING							NB.  This field is defined as the original qty - cancel qty
Cancelled by=				,: ,  'C'
Originating MP ID=			notUsed
)


newCanrep					=:  noun define
Record Type=					,: '#OE#'
Order Event=					,:   'CR'
Action Type Code=				,: ,  'N'  NB.  TLW always seems to use 'N', so I will too.
Firm ROE ID=					,: 1 {. a.	NB.  As placeholders for our line indicies, I use (0 { a).
Correction/Deletion Time=		notUsed   NB. Because our Action Type Code is 'N'
Resubmit=						notUsed
Order Rec Firm MP ID=			notUsed
Replaced Order Rec Date=		parentPermutation { orderDateTimeStamps , canrepDateTimeStamps  NB.  This is the timestamp of the parent order
Replaced Firm Order ID=			parentPermutation { OURTAG , CRP_OURTAG  NB.  ID of the parent order
Order Rec Firm Order Rec Date=	canrepDateTimeStamps
Order Rec Firm Order ID=		CRP_OURTAG
Routing Firm MP ID=				notUsed
Routed Order ID=				notUsed
Order Received Time=			canrepDateTimeStamps
Received Method=				,: , 'E'
Issue Symbol=					CRP_TICKER
Buy/Sell Code=					([: {::&(;: 'B SL SS SX') 'bstx'&i.) CRP_ACTION
Share quantity=					":"0 CRP_SHARES
Limit Price=					":&> ((CRP_PRICE = 0) +. , 'M' = CRP_TYPE) } a: ,:~ <"0 CRP_PRICE
Limit Order Display=			,: ,  'N'
Stop Price=						notUsed
Time in Force=					'D/DAY /DAY' >@:lookupWithDefault <"_1 CRP_FORCE
Expire Date=					notUsed
Expire Time=					notUsed
No reduce/increase=				notUsed
Special Handling Code 1=		notUsed
Special Handling Code 2=		notUsed
Special Handling Code 3=		notUsed
Special Handling Code 4=		notUsed
Special Handling Code 5=		notUsed
Rec Terminal ID=				notUsed
Rec Department ID=				notUsed
Originating Department ID=		notUsed
Account Type=					,: , 'P'
Program Trading=				'NY' {~ CRP_ACTYPE e."1 'dcjukymnw'
Arbitrage Code=					'NY' {~ CRP_ACTYPE e."1 'jumd'
Member Type=					,: , 'M'
ECN Flag=						notUsed
Not used =						notUsed
)

NB.  Calculate the fields for the canrep routed order records
routeCanrep 				=:  noun define
Record Type=				,: '#OE#'
Event Type=					,:   'RT'
Action Type=				,: ,  'N'
Firm ROE ID=				,: 1 {. a.									NB.  As placeholders for our line indicies, I use (0 { a).
Correct/Delete Time=		notUsed
Resubmit=					notUsed
Order Rec Firm MP ID=		notUsed
Order Received Date=		canrepDateTimeStamps
Order Rec Firm Order ID=	CRP_OURTAG  NB.  (For next field) To get the MMID, we use the COUNTERPARTY field if it's present, if it's not, we look up the VENUE/SERVICE pair in our look up table; if the VENUE/SERVICE is not in our table, we default to 'VENUE:SERVICE'.
Sent To Firm MP ID=			> crp_route =: routeToXPSE (<@removeTrailingBlanks"_1 CRP_COUNTERPARTY) (e.&(a:,<'PER')@:[ {"_1 ,.) ('ISLAND/INET A/AMEX' lookupSelfDefault <@removeTrailingBlanks"_1 CRP_LASTMKT) (beginsWith&'APPI:'&>@:] {"_1 ,.~)  CRP_VENUE ([: ((i.~ {."1) { (,~ {:"1))"0 _&mpid_lookup (,&':'@:[ <@, ])&:(removeTrailingBlanks)"1) CRP_SERVICE NB.  Note that TLW encodes its AMEX counterparties as 'PER', G. Finlason says retain them as 'AMEX'
Routed order ID=			CRP_OURTAG
Issue Symbol=				CRP_TICKER
Order Sent Timestamp=		canrepDateTimeStamps							NB.  The OMS does not keep seperate "order-received from client" and "order sent to venue" timestamps
Routed Share quantity=		":"0 CRP_SHARES
Routing Method=				,: , 'E'
Bunched Order=				notUsed
Originating MP ID=			notUsed
Destination=				'EX' {~ ,. route e. ;: 'AMEX CINN MWSE BOSX XPSE NYSE PHLX'
)

NB.  Calculate the fields for the canrep cancelled order records (same as regular cancels for now)
cancelCanrep				=:  noun define
Record Type=				,: '#OE#'
Event Type=					,:   'CL'
Action Type=				,: ,  'N'
Firm ROE ID=				,: 1 {. a.										NB.  As placeholders for our line indicies, I use (0 { a).
Correct/Delete Time=		notUsed
Resubmit=					notUsed
Order Rec Firm MP ID=		notUsed
Order Received Date=		crpcancelPermutation { canrepDateTimeStamps	NB. Find the dates and times for the orders which correspond to these cancels
Order Rec Firm Order ID=	crpcancelPermutation { CRP_OURTAG
Issue Symbol=				CRPCXL_TICKER
Order Cancel Timestamp=		CRPCXL_OURTIME makeOATSTimestamp~ (0&=@:{. }) |: CRPCXL_DATE ,. ". ; OMSDATE
Cancel Type=				'PF' {~ ,. 0 = CRP_SHREMAINING =: CRP_SHARES -&(crpcancelPermutation&{) CRP_SHCANCELLED	NB.  Even if the trader cancelled the 'entire' order, according to J. Unger, if he got some fills then it's still a partial cancel
Cancel Quantity=			":"0 crpcancelPermutation { CRP_SHCANCELLED
Cancel Leaves Qty=			":"0 CRP_SHREMAINING							NB.  This field is defined as the original qty - cancel qty
Cancelled by=				,: ,  'C'
Originating MP ID=			notUsed
)
a=:4!:5]1
4!:5]0