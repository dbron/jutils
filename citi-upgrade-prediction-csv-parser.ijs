NB.#################
NB. DEPENDENCIES
NB.#################
require 'tables/csv format/printf'


NB.#################
NB.## UTILITIES
NB.#################
der_z_ =:  #~ 1 - *./"1@:=&a:  NB. Delete empty rows (all aces)
dta_z_ =:  #~ [: +./\. a:&~:   NB. Delete trailing aces (prob. best at rank 1)
mmddyy2yyymmdd_z_ =: ] (((<'2000-00-00') <@= ]) ;@:{.`}.}@:, ,:~)  ('/'&$: : ('%d-%02d-%02d' <"1@:sprintf 2000 0 0 (+"1) _ 3 {. 0 {.@".&> 0 _1 |. cut&>))
erase'mkdir_base_'
mkdir_z_ =: ([: 2!:0 'mkdir ' , ''''&(, , [)) :: _1:


NB.#################
NB.## CONFIG
NB.#################
SDIR   =:  '/users/dbron/Dropbox/Ayasdi/Accounts/Citi/AyasdiCitiEngagement/'
TDIR   =:  '/users/dbron/Dropbox/Ayasdi/Accounts/Citi/AyasdiCitiEngagementLogical/'
HUH_z_ =:  <'#N/A N/A'


NB.#################
NB.## METADATA SET 1 PARSER
NB.#################
coclass 'metafinancier'

parse_metafinancials_worksheet =: verb define
 companies =.  _ 3 {. y
 fields    =.  0 4 }. y

 'co_hdr companies'=.  split companies
 'fld_hdr fields'  =.  split fields

  NB. Consolidate notes which trail
  NB. first two columns into a single column
  f =. |: 0 2 }. fields
  assert. 2 > +/ nonace =. a: ~: f
  notes =. (, I. |: nonace) }  f
  fields =. notes ,.~ _ 2 {. fields
  fld_hdr =. (2 {. fld_hdr),<'Notes'

  NB. Not sure how this section relates
  NB. to the preceeding, but it seems non-sequitor
  'companies symbology' =. companies split~ (<'NOT FOUND') i.~ companies {~ < a: ; < co_hdr i. <'company_name'

  dta"1@:der L:1 ".&.> ;:'co_hdr companies fld_hdr fields symbology'
)

field_table =: verb define
  FLD_HDR,FIELDS
)

company_table =: verb define
  CO_HDR,COMPANIES
)

symbology_table =: verb define
  SYMBOLOGY
)

create =: verb define
 try.
     'CO_HDR COMPANIES FLD_HDR FIELDS SYMBOLOGY' =: parse_metafinancials_worksheet readcsv y
 catch.
   smoutput 'error getting metadata from:' , y
   destroy ''
 end.

 i.0 0
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## DATA SET 1 PARSER
NB.#################
coclass 'financier'

parse_financials_worksheet =: verb define
 'hdr finances' =. split y
 'fin_hdr finances'=.split finances
  sec =. >{.,hdr

  dta"1@:der L:1 ".&.> ;:'sec fin_hdr finances'
)

create =: verb define
 try.
    'SECURITY COLS FINANCES' =: parse_financials_worksheet readcsv y
     FINANCES =: FINANCES idx}~ '-' mmddyy2yyymmdd FINANCES {~ idx=.< a: ; < COLS i. <'Date'
 catch.
   smoutput 'error getting financial data from:' , y
   destroy ''
 end.

 i.0 0
)

financials_table =: verb define
  COLS, FINANCES
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## DATA SET 2 PARSER
NB.#################
coclass 'macroAggr'

ISO3166_1_alpha_2 =: deb&.> TAB cut&> LF cut noun define
  US	United States
  EU	EU[n 1][8]
  CN	China
  JP	Japan
  DE	Germany
  GB	United Kingdom
  FR	France
  IN	India
  IT	Italy
  BR	Brazil
  CA	Canada
)

parse_me_worksheet =: verb define
  NB. Contains 3 subtables listed horizontally
  NB. Country+QTR for which indicator is relevant
  NB. List of macroeconomic indicators for that country+Q
  NB. Independent table of the "Case-Schiller" indicator
  'ctry macro schiller' =. 1 2 4 { (deb each y) <;.1~ '' ; 0 2 5 10 12 e.~ i. {:$y

  NB. Extract & clean-up independent Schiller table
  NB. (which is monthly, where the other indicators are quarterly)
  'schiller_src schiller' =.  _1 split dta"1@der schiller
  'schiller_hdr schiller' =.  2 split schiller
  'schiller_title schiller_hdr'=.<"1 schiller_hdr
   schiller_title         =.  > {. ,schiller_title
   schiller_src           =.  deb CRLF -.~ > {. ,schiller_src

  NB. Split out the index for the indicators
  NB. i.e. country & quarter for which indicator is relelvant
  'ctry_hdr ctry'=.2 split ctry
  'ctry qtrs'=. |: 2&}."1&.> _2 0 |.&.>"1 split &> (<;.1~ a: ~: {."1) ctry

  NB. Make sure we have data points for all the same dates across countries
  assert. 1 = # ~. qtrs
  qtrs =. , {. qtrs      NB. Since unique, take first as index
  ctry =. , ctry

  NB. pull out macros
  'macro_hdr macro' =. 2 split macro
   macro =. (-1+#qtrs) <\ macro       NB. 1+ for macro name row
   assert. ctry =&# macro             NB. Better have the same # of sets of indicators as countries
  'macro_nms macro' =. <"1 |:  split&> macro

  NB. Tag macro indicators with country/region applicable
  iso3166 =. ({."1 ISO3166_1_alpha_2) {~ ctry i.~ {:"1 ISO3166_1_alpha_2
  macro_nms =. ; iso3166 ('[%s] %s' <@sprintf"1  ,.) L:1"0 macro_nms
  macro =. > ,.&.>/ macro

  dta"1@:der L:1 ".&.> ;:'qtrs macro_nms macro schiller_title schiller_hdr schiller_src schiller'
)

create =: verb define
  try.
    'QTR MACRO_NMS MACRO SCHILLER_TITLE SCHILLER_HDR SCHILLER_SRC SCHILLER' =: parse_me_worksheet readcsv y
    assert. (#MACRO_NMS) -: {:$ MACRO NB. Not sure what to do if this isn't true.
    QTR =: '-' mmddyy2yyymmdd QTR
  catch.
    smoutput 'error creating bond chain from:' , y
    destroy ''  NB. Should we do this automatically?
  end.

  i.0 0
)

me_table =: verb define
  ('QUARTER';MACRO_NMS) , QTR ,. MACRO
)

schiller_table =: verb define
  NB. Stick source URL on as additional "source" column
  (SCHILLER_HDR , <'Source') , SCHILLER ,. (<SCHILLER_SRC) , a: #~ _1+#SCHILLER
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## METADATA SET 3 PARSER
NB.#################
coclass 'metabondbreaker'

parse_metabonds_worksheet =: verb define
 companies =.  _ 1 {. y
 fields    =.  _ 1 {. 0 3 }. y
 unknown   =. ,. {:"1 y  NB. No idea what this is, probably just a typo

 cap =. <"0 'NY' {~ >./\ +./"1 (,:'<-';ch=.'monthly limit reached') E. y

 'co_hdr companies'=. split companies ,. ch ; }. cap
 fields =. fields -. ,.<ch
  dta"1@:der L:1 ".&.> ;:'co_hdr companies fields unknown'
)

field_table =: verb define
  (<'Fields'),FIELDS
)

company_table =: verb define
  CO_HDR,COMPANIES
)

unknown_table =: verb define
  UNKNOWN
)

create =: verb define
NB.  try.
      'CO_HDR COMPANIES FIELDS UNKNOWN' =: parse_metabonds_worksheet readcsv y
NB.  catch.
NB.    smoutput 'error getting metadata from:' , y
NB.    destroy ''
NB.  end.

 i.0 0
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## DATA SET 3 PARSER
NB.#################
coclass 'bondbreaker'

parse_bond_worksheet =: verb define
  NB. Format is:
  NB.
  NB. ISP IM Equity
  NB. BOND_CHAIN				ISP IM Equity	BOND_CHAIN	UV859352 Corp		UV859526 Corp		EJ785614 Corp
  NB. UV859352 Corp	ISPIM 0.000 09/16/16					#NAME?	100.03	#NAME?	99.819	#NAME?	102.898
  NB. 						9/14/15	100.03	9/17/15	99.819	11/27/14	102.891
  'h b'      =.  split y

  NB.'ISP IM Equity'
  SECURITY_NAME     =.  > {. h
  NB. Better have exactly 3 space-separated fields
  assert. 3 = {: $ TICKER_REGION_AC =. ' ' cut SECURITY_NAME
  'TICKER REGION AC' =. TICKER_REGION_AC

  NB. (n,2) $ <;._1 '|UV859352 Corp|ISPIM 0.000 09/16/16|||UV859526 Corp|ISPIM 0.000 09/16/16 ....'
  BOND_CHAIN =.  }. _ 2 {. b

  NB. Break chain into BBG code for bond,
  NB. plus instrument details
  'BOND_BBG UND_COUPON_MATURITY' =. <"1 |: der BOND_CHAIN

  NB. Better have exactly 3 space-separated fields
  assert. 3 = {: $ UND_COUPON_MATURITY =. ' ' cut&> UND_COUPON_MATURITY
  'UND COUPON MATURITY' =. <"1 |: UND_COUPON_MATURITY

  NB. Now just the bond strips table w/ header
  b          =.  0 4 }. b

  NB. Sometimes, there's a sub-header like 'ISP IM Equity';'BOND_CHAIN'
  NB. Other times, no sub-header but extra blank row
  b =. b }.~ (1 0;0 2) {::~ 'BOND_CHAIN' -: > {: {. H2 =.  _ 2 {. b


  NB. Bond headers (strip tickers) & chain
  'BH b'     =.  split b
  BH         =.  _2 {.\ BH

  NB. Strips individually boxed into chain
  CHAIN      =.  _2 <@:|:\ |: b
  CHAIN      =.  (< _ 2) {.&.> dta"1@:der L:1 CHAIN    NB. Require even empty bond chain to have appropriate width

  NB. Date index
  DATES  =. ~. /:~ ;  {."1&.> CHAIN

  NB. Sometimes the catalog repeats itself at the end, not sure why
  NB. so if the beginning of the catalog is the same as the bonds in the chain
  NB. and everything after that is a dupe, just truncate the catalog
  empties =. *./ (0 e. $)&> BH,:CHAIN
  'BH CHAIN' =. (<-.empties)    #&.>BH,&<CHAIN
  if. ( BH -:&:(/:~) (#BH){.BOND_BBG) *. (*./ 1 0 *./ . =&> (#BH) split ~: BOND_BBG) do.
    'BOND_BBG UND COUPON MATURITY' =. (#BH) ({. ".)&.> ;:'BOND_BBG UND COUPON MATURITY'
  end.

  NB. By this point, BOND_BBG and BH better
  NB. have the same content. But there are cases
  NB. where the order slightly changes, so sync them up.
  NB.!! Maybe defer parsing out UND/COUPON/MATURIY until here
  NB.!! or simply parse them from BH instead
  'BOND_BBG UND COUPON MATURITY' =. (".&.>;:'BOND_BBG UND COUPON MATURITY') {&.>~ < BH i. BOND_BBG

  NB. Remove completely empty rows
  NB. Then remove trailing empty columns on each sub-table
  NB. (except empty bond chain, those have to have 2 cols)
  (<CHAIN) ,~ dta"1@:der L:1 ".&.> ;:'SECURITY_NAME TICKER REGION AC BOND_BBG UND COUPON MATURITY BH DATES'
)

create =: verb define
NB.   try.
    'SECURITY_NAME TICKER REGION AC BBG_CODE UND COUPON MATURITY BONDS DATES BONDTS' =: parse_bond_worksheet readcsv y
    NB. assert. BBG_CODE -: BONDS NB. Sometimes the index (BBG_CODE) has dupes at the end, not sure why
    BONDTS =:  BONDTS '-'&mmddyy2yyymmdd@:{`[`]}&.>~ < < a: ; < 0 NB. S_HDR i. <'Date'
    MATURITY  =:  '/' mmddyy2yyymmdd MATURITY
    DATES     =:  '-' mmddyy2yyymmdd DATES
NB.   catch.
NB.     smoutput 'error getting bond data from:' , y
NB.     destroy ''  NB. Should we do this automatically?
NB.   end.

  i.0 0
)

tabulate =:  verb define
  dates  =.  {."1&.> BONDTS  NB. Risk of this getting out-of-synch with DATES ?
  px     =.  {:"1&.> BONDTS  NB. Can't use column-name lookup; no column names

  idx =.  dates i.&.> <DATES
  t =.  idx ({ ,&HUH)&> px  NB. Price table: bond_px x alldates
)

bond_table =: verb define
  t =. tabulate ''
  securities =. (<TICKER) ,. (<REGION) ,. UND ,. BONDS ,. COUPON ,. MATURITY
  t =. securities ,. t
  cols =. (;:'ticker exch underlying bond coupon maturity'), DATES
  cols , t
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## DATA SET 4 PARSER
NB.#################
coclass 'treasurer'

parse_yield_worksheet =: verb define
 yield =. 2 1 }. y
 'yield_hdr yield' =. split yield

  NB. Split out date column
  yield_hdr =. }. yield_hdr NB. Drop date column name
  'dts yield' =. (<;.1~ '' ; 1 1 , 0 #~ _2 + {:@$) yield
  dts =. , dts

  dta"1@:der L:1 ".&.> ;:'yield_hdr dts yield'
)

create =: verb define
 try.
    'MATURITIES DATES YIELD' =: parse_yield_worksheet readcsv y
    DATES =: '-' mmddyy2yyymmdd DATES
 catch.
   smoutput 'error creating yield curve from:' , y
   destroy ''
 end.

 i.0 0
)

yield_table =: verb define
  ('Date' ; MATURITIES) , DATES ,. YIELD
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## DATA SET 5 PARSER
NB.#################
coclass 'rater'

parse_rating_worksheet =: verb define
 'hdr ratings' =. split y

  dta"1@:der L:1 ".&.> ;:'hdr ratings'
)

create =: verb define
  try.
     'COLS RATINGS' =: parse_rating_worksheet readcsv y
     RATINGS =: RATINGS idx}~ '-' mmddyy2yyymmdd RATINGS {~ idx =. < a: ; COLS i. <'Date'
  catch.
    smoutput 'error creating external ratings from:' , y
    destroy ''
  end.

 i.0 0
)

ratings_table =: verb define
  COLS,RATINGS
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## DATA SET 6 PARSER
NB.#################
coclass 'vixen'

parse_vix_worksheet =: verb define
 'hdr vix' =. split y

  dta"1@:der L:1 ".&.> ;:'hdr vix'
)

create =: verb define
 try.
    'COLS VIX' =: parse_vix_worksheet readcsv y
     VIX =: VIX idx}~ mmddyy2yyymmdd VIX {~ idx=.< a: ; < COLS i. <'Date'
 catch.
   smoutput 'error getting VIX OHLC from:' , y
   destroy ''
 end.

 i.0 0
)

vix_table =: verb define
  COLS, VIX
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## DATA SET 6 PARSER
NB.#################
coclass 'equitor'

parse_equity_worksheet =: verb define
  NB. Format is:
  NB.																																																																																																														(non USD)						(non USD)																																																																																																																																																(non USD)
  NB. ticker	company_name	Security Name			AMX US Equity
  NB. AMXL	America Movil SAB de CV 	AMX US Equity			Date	PX_LAST
  NB. AMT	American Tower Corp	AMT US Equity			1/1/14	23.37
  y  =.  }. y

  COMPANIES =. _ 3 {. y
  price_series =. 0 5 }. y

  NB. Break out company catalog
  'COMP_HDR COMPANIES' =. dta"1@:der L:1 split COMPANIES
  NB. Expect catalog to end with "security name" column
  assert. 'Security Name' -: > {: COMP_HDR
  NB. Sec name better have exactly 3 space-separated fields
  assert. 3 = {: $ TICKER_REGION_AC =. ' ' cut&> SECURITY_NAMES =. {:"1 COMPANIES
  COMPANIES =. (}:"1 COMPANIES) ,. TICKER_REGION_AC

  NB. Break out price series
  'px_hdr px' =. dta"1@:der L:1 split price_series

  NB. Make sure catalog matches price series index
  NB. assert. security_names -: _3 {.\ , px_hdr
  NB.!!Can't assert this ^. Varied nomeclature for share classes
  NB. (RDS'b can be RDSb or RDSB [uppercase], and similarly DBKGn may or may not have the Gn suffix)

  SERIES      =.  _3 <@:(dta"1)@:der@:|:@:}:\ |: px,.a:
  's_hdr SERIES' =. <"1 |: split&> SERIES
  NB. Make sure each price series starts with same header field
  assert. 1 = # S_HDR =. ~. > s_hdr
  S_HDR =. {. S_HDR      NB. Since unique, take first
  SERIES      =.  (< _ , # S_HDR) {.&.> SERIES NB. Require even empty price series to have appropriate width
  NB. Date index
  DATES  =. ~. /:~ ;  {."1&.> SERIES  NB. Maybe assert 'Date'-:>{.S_HDR ?

  NB. Remove completely empty rows
  NB. Then remove trailing empty columns on each sub-table
  NB. (except empty price series, those have to have 2 cols)
  (<SERIES) 4} dta"1@:der L:1 ".&.> ;:'SECURITY_NAMES COMP_HDR COMPANIES S_HDR SERIES DATES'
)

create =: verb define
  try.
    'SECURITY_NAMES COMP_HDR COMPANIES S_HDR SERIES DATES' =: parse_equity_worksheet readcsv y
    SERIES =:  SERIES '-'&mmddyy2yyymmdd@:{`[`]}&.>~ < < a: ; < S_HDR i. <'Date'
    DATES  =:  '-' mmddyy2yyymmdd DATES
  catch.
   smoutput 'error getting equity prices from:' , y
   destroy ''
 end.

 i.0 0
)

equity_table =: verb define
 NB. _1 |. because in orig, sec_names were last col, here putting them first
 cols =. (_1 |. COMP_HDR),(;:'listed exchange asset_class') , DATES
 data =.  SECURITY_NAMES ,. COMPANIES ,. SERIES  ((i.~ {."1) { HUH ,~{:"1@:])&>~ < DATES
 cols,data
)

destroy=: 3 : 0
  codestroy ''
)



NB.#################
NB.## RUN
NB.#################
cocurrent'base'

metafinancials =: dyad define
  'rate sdir tdir' =. y

  MF =.  'metafinancier' conew~ SDIR, sdir , x

  mkdir tsdir =. tdir,'meta/'
  (company_table__MF   '') writecsv tsdir, 'companies.csv'
  (field_table__MF     '') writecsv tsdir, 'fields.csv'
  (symbology_table__MF '') writecsv tsdir, 'symbology.csv'
  destroy__MF ''

)

financial_series =: dyad define
  'glob exclude' =.  x
  'rate sdir tdir' =.  y

  AGGREGATE =. 0 0 $ a:
  mkdir tsdir =. tdir,'series/'

  for_f. {."1 (1!:0) SDIR, sdir , glob do.
    if. -. exclude -: f =. > f do.  NB. cf is a meta-file
      F  =.  'financier' conew~ SDIR, sdir , f
      (financials_table__F '') writecsv tsdir , SECURITY__F , '.csv'
      cols =. COLS__F  NB. Needed for header of consolidated table
      AGGREGATE =. AGGREGATE , (<SECURITY__F) ,. FINANCES__F
      destroy__F ''
    end.
  end.

  (tdir,rate,'.csv') writecsv~ ('Security Name';cols), AGGREGATE
)

financials =: dyad define
  'annual daily' =. y

  mkdir tdir =. TDIR,'1. Financials/'
  cf =. 'Companies+fields.csv'

  mkdir tadir =. tdir,'annual/'
  cf metafinancials 'annual';annual;tadir
  (x;cf) financial_series 'annual';annual;tadir

  mkdir tddir =. tdir,'daily/'
  cf metafinancials 'daily';daily;tddir
  (x;cf) financial_series 'daily' ;daily ;tddir

  i. 0 0
)

macroeconomics =: dyad define
  mkdir tdir =. TDIR,'2. MacroEconomics/'
  M  =.  'macroAggr' conew~ SDIR, y, x

  NB.!! Put raw in meta folder
  (me_table__M         '') writecsv tdir,'macro-economics.csv'
  (schiller_table__M   '') writecsv tdir, SCHILLER_TITLE__M , '.csv'

  destroy__M ''
)

metabonds =: dyad define
  'type sdir tdir' =. y

  MB =.  'metabondbreaker' conew~ SDIR, sdir , x

  mkdir tsdir =. tdir,'meta/'
  (company_table__MB   '') writecsv tsdir, 'companies.csv'
  (field_table__MB     '') writecsv tsdir, 'fields.csv'
  (unknown_table__MB   '') writecsv tsdir, 'unknown.csv'
  destroy__MB ''

)

bond_chains =: dyad define
  try.
    'type file'=.y

    B  =.  'bondbreaker'   conew~ file

    mkdir tsdir =. x,'chain/'
    if. BONDS__B <&# BONDTS__B do. BONDTS__B =. (#~ 0 < #&>) BONDTS__B end.
    fns =. (<tsdir) ,&.> BONDS__B ,&.> (<'.csv')
    fns writecsv&.>~ ('Date';type) ,L:1 BONDTS__B

    (bond_table__B   '') writecsv x, 'bonds.csv'

    destroy__B ''
  catch.
    smoutput 'Couldn''t get bond data from:', file
  end.
)

bonds =: dyad define
  'prices spreads'=.y

  mkdir tdir =. TDIR,'3. Bonds/'

  cf =. 'Companies.csv'

  mkdir tpdir =. tdir,'prices/'
  cf metabonds 'prices' ;prices ;tpdir
  for_f. {."1 (1!:0) SDIR, prices , x do.
    if. -. cf -: f =. > f do.  NB. cf is a meta-file
       sec_name =. (-#'.csv') }. f
       mkdir tpsdir =. tpdir,sec_name,'/'
       tpsdir bond_chains 'price';SDIR, prices , f
    end.
  end.


  mkdir tsdir =. tdir,'spreads/'
  cf metabonds 'spreads';spreads;tsdir
  for_f. {."1 (1!:0) SDIR, spreads , x do.
    if. -. cf -: f =. > f do.  NB. cf is a meta-file
       sec_name =. (-#'.csv') }. f
       mkdir tssdir =. tsdir,sec_name,'/'
       tssdir bond_chains 'spread';SDIR, spreads , f
    end.
  end.
)

treasuries =: verb define
  mkdir tdir =. TDIR,'4. Treasuries/'

  Y  =.  'treasurer'     conew~ SDIR,'4. Daily Treasury Yield Curve Rates.csv'
  (yield_table__Y '') writecsv tdir,'yields.csv'

  destroy__Y ''
)

ratings =: verb define
  mkdir tdir =. TDIR,'5. Ratings/'

  R  =.  'rater'         conew~ SDIR,'5. External Ratings.csv'

  (ratings_table__R '') writecsv tdir,'ratings.csv'

  destroy__R ''
)

vix =: verb define
  mkdir tdir =. TDIR,'6. VIX/'

  V  =.  'vixen'       conew~ SDIR,'6. VIX.csv'
  (vix_table__V '') writecsv tdir,'vix.csv'

  destroy__V ''
)

equities =: verb define
  mkdir tdir =. TDIR,'7. Equities/'

  E  =.  'equitor'       conew~ SDIR,'7.Equity_px.csv'

  mkdir tsdir =. tdir,'series/'
  fns =. (<tsdir),&.> SECURITY_NAMES__E ,&.> (<'.csv')
  fns writecsv&.>~ S_HDR__E ,L:1 SERIES__E

  (equity_table__E '') writecsv tdir,'consolidated.csv'

  destroy__E ''
)

main =: verb define
  '*.csv'                   financials     '1. BloombergFundamentalFinancialAnnual/';'1. BloombergFundamentalFinancialDaily/'
  'NationalMacro final.csv' macroeconomics '2. MacroEconomics/'
  '*.csv'                   bonds          '3. bonds_px_all/';'3. bonds_spread_all/'
                            treasuries     '4. Daily Treasury Yield Curve Rates.csv'
                            ratings        '5. External Ratings.csv'
                            vix            '6. VIX.csv'
                            equities       '7.Equity_px.csv'
)

NB. Normalize equity tickers where needed
NB. clean column names
NB. remove any #NA etc
NB. take a nub of all non-numeric values, sort, introspect
