'A B'=:4!:5&.>i.2
require 'task'

2!:5 'http_proxy'  NB.  <-- CASE SENSITIVE:  Make sure this is set correctly -- parse the PAC if required (get the PAC from IE's settings)
2!:5 'https_proxy'  NB.  <-- CASE SENSITIVE:  Make sure this is set correctly -- parse the PAC if required (get the PAC from IE's settings)

USER_names_=:'dbron'
PASSWORD_names_=:'w00t!W00T!3'


F =: fread fn=:'c:\documents and settings\dbron\my documents\cygwin-home\r.txt'
ACTION =:({::~[:  < 1 ;~ ({.;:'ACTION') i.~ {."1) >{.trim L: 0 (({.~ ; (}.~>:)) i.&'=')&>&.> (<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' '&.> ({.~ i.&1@:('/>'&E.))&.> }.'<FORM' arbCut F 
R=:(3 : 'NAMES_names_' , (a: ,~ {:"1)&.> {&>~ [: (i.&.> <@:(3 : 'NAMES_names_=:y')@:/:~@:~.@:;) ([: toupper&.> {."1)&.>) (#~ [: * [: +/"1 #&>)&.> trim L: 0 (({.~ ; (}.~>:)) i.&'=')&>&.> (<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' '&.> ({.~ i.&1@:('/>'&E.))&.> }.'<input ' arbCut F 
S  =: ([ ,. =&a:@:] 4 : 'x}y' ] ,: '_names_' ".@:, L: 0~ [) / |: }. R {"1~ (;:'NAME VALUE') i.~ {. R
P =: '&' join'=' <@:join"1 S

d=:'dir' in getNmdPath fn
NB. P fwrite d,'post-file.txt'


noun define
'wget --save-cookies cookies.txt --keep-session-cookies --post-file post-file.txt https://genie.corp.etradegrp.com',ACTION
wget --save-cookies cookies.txt --keep-session-cookies --save-headers --http-user='andrew.wen@etrade.com' --http-password='1Dv3r1f1cat10n!' -O - 'https://netview.verid.com/transact/ViewArchiveReport.do'
)

F1 =: fread fn=:'c:\documents and settings\dbron\my documents\cygwin-home\rr.txt'
ACTION1 =: 'ViewArchiveReport.do' [ ({::~[:  < 1 ;~ ({.;:'action') i.~ {."1)&.> trim L: 0 (({.~ ; (}.~>:)) i.&'=')&>&.> (<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' '&.> ({.~ i.&1@:('>'&E.))&.> }.'<form' arbCut F1 
R1=:(3 : 'NAMES_names1_' , (a: ,~ {:"1)&.> {&>~ [: (i.&.> <@:(3 : 'NAMES_names1_=:y')@:/:~@:~.@:;) ([: toupper&.> {."1)&.>) (#~ [: * [: +/"1 #&>)&.> trim L: 0 (({.~ ; (}.~>:)) i.&'=')&>&.> (<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' '&.> ({.~ i.&1@:('>'&E.))&.> }.'<input ' arbCut F1 
S1  =: ([ ,. =&a:@:] 4 : '(x *. M=:-. ({.;:''hidden'')~:}. R1 {"1 ~({.;:''TYPE'') i.~ {. R1) }y' ] ,: '_names_' ".@:, L: 0~ [) / |: }. R1 {"1~ (;:'NAME VALUE') i.~ {. R1
P1 =: '&' join'=' <@:join"1 S1



smoop =: 'customStartDate=12%2F14%2F2006&customEndDate=12%2F21%2F2006&updateQuery=Go%21&tx                 tTransactionId=&cmbTime=41&cmbAccountName=LexisNexis%3AETrade%3AAcctCmp&txtUser=                 &txtReferenceNumber=&cmbTask=1040&cmbStatus=-1&cmbReason=0&cmbVenue=1&cmbProcess                 =0&cmbMode=live&transactionId=&accountName=LexisNexis%3AETrade%3AAcctCmp&referen                 ceId=&adl=&veriteId=&agent=&ageVerificationStatusTypeId=-1&city=&comboTaskTypeId                 =1040&companyName=&dispositionStatusTypeId=0&driversLicenseNumber=&driversLicens                 eStateTypeId=0&fein=&fraudTypeId=0&gradeMultichoiceRuleTypeId=-1&ipAddress=&mode                 Type=live&nameFirst=&nameLast=&ofacStatusTypeId=0&parentTransactionId=&phoneNumb                 er=&presentationPosition=&processTypeId=0&questionGradeOutcomeTypeId=-1&question                 Id=&questionSetId=&questionSetTypeId=-1&questioningStyleTypeId=-1&questionTierTy                 peId=-1&questionTypeId=-1&reasonTypeId=0&remoteAddress=&requestEntryTypeId=-1&pa                 rameterSet=&serverName=&ssn=&ssnTypeId=-1&street1=&stateTypeId=0&statusTypeId=-1                 &subsetGradeOutcomeTypeId=-1&subsetNumber=&timeWindowTypeId=41&trackingId=&uniqu                 eAuthenticationId=&uniqueIdentityId=&userName=&venueTypeId=1&zip=&queryPattern=1                 1LexisNexis%3AETrade-1null1040000All00-10-10nullTransactionIdASC100&reportId=Ver                 idReport1&reportGroupType=Transaction&lastId=61397516&detailTransactionId=0&form                 at=tsv&logonAccount=LexisNexis%3AETrade&sortColumn=TransactionId&sortMethod=ASC&                 updateReportGroupSpec=&updatePreferences=false&lastSortToken=61397516&doNext=&do                 Last='

A=:(,: uri_decode&.>@:])/&.|:  '&=' multiCut ,}: _97 (_17)&}.\ smoop


F2 =: fread fn=:'c:\documents and settings\dbron\my documents\cygwin-home\rr.txt'
ACTION2 =: ({::~[:  < 1 ;~ ({.;:'name') i.~ {."1)&.> trim L: 0 (({.~ ; (}.~>:)) i.&'=')&>&.> (<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' '&.> ({.~ i.&1@:('>'&E.))&.> }.'<select' arbCut F1 
R2=:(3 : 'NAMES_names2_' , (a: ,~ {:"1)&.> {&>~ [: (i.&.> <@:(3 : 'NAMES_names2_=:y')@:/:~@:~.@:;) ([: toupper&.> {."1)&.>) U2=:(#~ [: * [: +/"1 #&>)&.> trim L: 0 (({.~ ; (}.~>:)) i.&'=')&>&.> (<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' '&.> ({.~ i.&1@:('>'&E.))&.> }.'<option ' arbCut F1 
S2  =: ([ ,. =&a:@:] 4 : '(x *. M=:-. ({.;:''hidden'')~:}. R1 {"1 ~({.;:''TYPE'') i.~ {. R1) }y' ] ,: '_names_' ".@:, L: 0~ [) / |: }. R1 {"1~ (;:'NAME VALUE') i.~ {. R1
P2 =: '&' join'=' <@:join"1 S1

NB. ('.html',~ ; (;:'dir basename') in getNmdPath fn) fwrite~ SHPENK =: '(?is)<select[^>]+/>' (<<<_2)&{rxapply F2 
SHPENK =: '(?is)<select[^>]+/>' (<<<_2)&{rxapply F2 
HENK =: SHPENK shell 'tidy 2>NUL'

assert 0

require'~user\general\parse\xml.ijs ~user\contrib\oleg\map.ijs'
coinsert 'map xml'
R=:proc HENK
'A B'=:4!:5&.>i._2


erase (;:'R')-.~ (\: 7!:5) (coname'') ({.@:] #~ (= {:)) |: '_' ([ (({.@:] ,. (-.&.>~ {:)) |:) ] split~ ( 2     i:~+/\.)@:=)&> A  [ (a: -.~ , ;: noun define) 
R_base_       F1_base_      F2_base_      SHPENK_base_  HENK_base_    
R1_base_      U2_base_      S1_base_      S2_base_      R2_base_      
A_base_       F_base_       P1_base_      P2_base_      smoop_base_   
S_base_       ACTION2_base_ M_base_       P_base_       d_base_       
fn_base_      ACTION1_base_ ACTION_base_  B_base_                     
)

Q=: a:-.~( a:"_`(<@:])@.( ('tag' ,"1 0&:;: 'input select') e.~ 2 {. [: , 1 {. [)  S: 1 {::) R
W=:((}: , }:&.>@:{:)@:}:&.>Q){::&.><R NB. W=:(_1 }.&.>Q){::&.><R