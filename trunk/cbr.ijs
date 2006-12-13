require 'task winapi dd'
NB. require '~user\util\contrib\oleg\xsl.ijs ~user\util\contrib\oleg\xml\sax.ijs'

NB.  Cover adverb to string-related win32api functions.
NB.  Just tacks the buffer onto the end of the argument list, then picks it out of the results
NB.  and trims it.
NB.  EG:  'GetTempFileNameA' winapiAsString ''
winapiAsString			=:  1 : '({.~ i.&(0 { a.))@:>@:{:@:(m win32api)@:,&(<255 # '' '')@:boxopen'

NB.  Creates a temporary file, with the prefix given as the argument.
NB.! Note that this call actually creates the file.
NB.  EG:  getTemporaryFile 'OMSDBUPLOAD_'  NB.  Creates a .tmp file in the user's temp direcotry whose name starts with 'OMSDBUPLOAD_'.
NB.       getTemporaryFile ''	           NB.  No user-specified prefix
getTemporaryFile		=:  'GetTempFileNameA' winapiAsString@:(('GetTempPathA' winapiAsString 255)&;)@:;&0  f.


NB.  Tests if the end of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
isSuffix                =:  ,^:(0: -: #@:$)@:[ -: ({.~ -@:#)~

NB.  Drops the LHA from the end of the RHA iff the RHA ends with the LHA.
dropSuffix              =:  (}.~ -@:#)~^:isSuffix

NB.  Wrap in parenetheses.  EG:  parenclose 'Hi there' NB.  Returns '(Hi there)'
parenclose              =:  '('&,@:,&')'

NB.  A better version of scalarReplace; actually more of a hybrid of scalarReplace and xlat.  It shares the advantages of scalarReplace
NB.  in that it does not need to know the universe of possible values in advance (meaning it's not restricted to literals and doesn't
NB.  require explicit code).  It shares the advantage of xlat in that it can replace a list of scalars with another list of scalars, instead
NB.  of just a single scalars.  Like scalarReplace and xlat, it is restricted to replacing scalars with scalars: it cannot replace arbitrarily
NB.  shaped data (use replace for that [which has the additional freedom of not requiring the search and replace inputs to be of the same
NB.  length]).  One drawback of multiScalarReplace is that it needs to create large temporary (ephemeral) data; (#@[ * */@:$@:]) elements to
NB.  be exact.
NB.  EG:  abc_to_def 'aZbYcX'       [. abc_to_def	=: 'abc' multiScalarReplace	'def' NB.  Returns 'dZeYfX'
NB.  EG:  zero_to_one 5 5 5 5 $ 0   [. zero_to_one	=:     0 multiScalarReplace 1     NB.  Returns 5 5 5 5$1
find					=:  ((i.~)"0 _)&
overlay					=:  &(] ,~ ($~"0 1&, $))
msr						=:  multiScalarReplace	=: 2 : '(m find ` (n overlay)) }'

". ( ; {. nm ) , ' =: ',(;: '>:') msr ( ;:  ']')&.;: 5!:5 nm =. {. ;: 'splitPath'	
". 'splitHost' , ' =: ',(;: 'i:') msr ( ;: 'i.')&.;: 5!:5 nm
". 'splitNV' , ' =: ',(;: '''\''i:') msr ( ;: '''=''i.')&.;: 5!:5 nm
". 'splitExt' , ' =: ',(;: '''\'']') msr ( ;: '''.''>:')&.;: 5!:5 nm

NB. subUV =: (;: 'm v') msr (;: 'n u')
NB. subUVInStrings =: ([ ;@:, (subUV &. ;: &.(}: :. (,&QUOTE))@:]^:[~ -:&('a']QUOTE))~&.>)/@:split
NB. dfn =: (4!:0 nnn) : ( (subUVInStrings each@: subUV) &.;: each {:"1 (2) 5!:7 nnn=.{.;:'defineAndDefaultParams' )


NB.  Box the input iff it's not boxed and it's not null.  This way it's convenient to pass in one parameter, or
NB.  none, just allowing all the defaults to take effect.
normalizeInput             =.  <^:(# 2 b.&* L.)
NB.
NB.  Determines if the input's rank is at least 2.  That is, if it's 'less than' a table.
isList                     =.  2&>@:#@:$@:]
NB.
NB.  Stiches on the first N parameter names to the input list (where N = # list),  allowing the user to pass in a
NB.  list of parameters without names so long as they're in the correct order (the correct order is as defined by
NB.  the default parameters).
paramListToTable           =.  ([: ({."1@:[ ,. ,@:])&>/ <.&# {.&.> ,&<)^:isList
NB.
NB.  Appends the default param name/value pairs onto the end of the parameter table
NB.  with booleans indicating the source map (0=left, 1=right).
appendDefaults             =.  (paramListToTable ,&:>/@:(,&:<  (,.&.> <^:2">) 0 1"_)  [)
NB.
NB.  For convenience, normalizeNames lowercases and removes spaces, dashes, and underscores from parameter names.
NB.  This is so that, for example, 'someParameter', 'Some Parameter', 'some-parameter', 'SOME_PARAMETER' are
NB.  treated equivalently.  Doing this may result in name conflicts.  Note that the names defined, in the end,
NB.  are in the same format as specified by the default parameter table.
NB.! Make combineMaps an adverb with this verb as the parameter (or maybe a conjunction with a handle-missing-names-verb as the other parameter)
normalizeNames             =.  3 : 'tolower y'@:-.&' _-'&.>@:({."1)
NB.
NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to
NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
NB.  access).
combineMaps                =:  ([ ({."1@:[ ,. i.~&normalizeNames { }."1@:]) (appendDefaults normalizeInput)) f.

defineAndDefaultParams     =:  conjunction define
NB.  The input to this conjunction is a noun RHA and a explicit monadic verb LHA.
NB.  The noun RHA is a 2xN table of boxes, specifying a default parameter table.
NB.     
NB.  The output of this conjunction will be a derived monadic verb that can be called
NB.  with a parameter table, where the elements of column 0 are the names of the
NB.  parameters and the elements of column 1 are  the values of the parameters.  The
NB.  parameters are then defined as local names (assigned to their respective values)
NB.  which the explicit verb can reference at its convenience.  
NB.
NB.  Further, a second set of names is defined, the same as the first with 
NB.  '_is_default' appended to each name.  These names are booleans indicating
NB.  whether the corresponding parameter came from the default table or was
NB.  specified by the caller.
NB.
NB.  For the caller's convenience, instead of passing in a 2xN parameter table, it
NB.  may use a list of boxes.  These values will be assigned to the first (#y) names
NB.  in the default parameter table.  If the caller passes in an unboxed value, that
NB.  value will be assigned to the first name in the default parameter table, unless
NB.  that value is null (0-:#,y), in which case the default parameter table will be
NB.  used in its entirety, with no caller-defined values.

        if. # verbBody     =. {: |: (1) 5!:7 {.;: 'u' do.
        NB.  If this is an explicit monadic verb, then redefine it appropriately.

                NB.  This version of defineAndDefaultParams provides 'closures'
                NB.  However, the use may want to preserve value of some names, but not others.
                NB.  To this end, allow him to mark parameter names with a flag indicating their state
                NB.  is to be preserved across calls.
                preservationFlag     =.  ,'*' NB.  If the name ends with a star, preserve its value.
                flagAsString         =.  parenclose 5!:5 {. ;:'preservationFlag'
                checkFlags           =.  flagAsString , '&isSuffix'
                dropFlags            =.  flagAsString , '&dropSuffix'

                NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
                NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to
                NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
                NB.  access).
                createParameterTable =.  combineMaps f.
                cptAsString          =.  parenclose 5!:5 {. ;: 'createParameterTable'

                NB.  We will add these lines to the top of u, thereby redefining it.

                NB.  Apply createParameterTable to y (the input to u)
                header               =.  'y =. x' , cptAsString , ' y'      

                NB.  Define some local names from the parameter table we just created.
                NB. newHeading              =.  newHeading , CRLF , 'NB.  From the parameter name/value input table, define local names from column 0 to values from column 1'
                header               =.  header ; '(, (,. ,&''_is_default''&.>)', dropFlags , '&.> {."1 y) =. , }."1 y'

                NB.  We will add these lines to the bottom of u, further redefining it.

                NB.  Preserve the user's original output.
                NB.!  This only works in the case that the last line of the function provides the
                NB.!  output of the function.  There are MANY cases where this is not true.
                trailer              =.  'y =. ' &,&.> {: verbBody

                NB.  Save state of flagged names.  We'll have closure over x, so the assignment to it preserves state across calls.
                trailer              =.  trailer , < 'x =. }:"1 x ' , cptAsString , ' (,. ".@:(' , dropFlags , ')&.>)~  (#~ ' , checkFlags , '&>) {."1 x'

                NB.  Return user's expected output (but see NB.! above).
                trailer              =.  trailer , < 'y' 

                NB.  Return re-defined function.
                NB.!  Should really only use lexicalClosureOnRHA in the case that we have at least one flagged name.
                n&(4 : (header , (}: verbBody) , trailer))
        else.
        NB.  If u isn't an explicit monadic verb, don't do anything to it.
                u
        end.
)


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


lnkTemplate =: toHOST toJ LF join (#~ [: ~:&QUOTE {.&>)LF cut noun define
	Set objShell = WScript.CreateObject("WScript.Shell")

	'strDesktopFolder = objShell.SpecialFolders("AllUsersDesktop")
	strLnkFileName = "$prodLnk$"

	'Set objShortCut = objShell.CreateShortcut(strDesktopFolder & "\prod.lnk")
	Set objShortCut = objShell.CreateShortcut(strLnkFileName)

	objShortCut.TargetPath = "isqlw.exe"

	objShortCut.Description = "Connect to the production database"
	'objShortCut.HotKey = "Ctrl+Shift+I"
	objShortCut.Save
)

selectDSN =: noun define
<x:stylesheet xmlns:x="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<x:output method="text"/>

	<x:template match="appSettings/add[@key='DSN']">
			<x:value-of select="@value" />
	</x:template>

</x:stylesheet>
)


selectINCLUDE =: noun define
<x:stylesheet xmlns:x="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<x:output method="text"/>

	<x:template match="appSettings">
			<x:value-of select="@file" />
	</x:template>

</x:stylesheet>
)

makeURI =: (verb define) defineAndDefaultParams (':' makeTable noun define)
	SCHEME:  file
	HOST:
	ROOT:
	TOPFILE:
)

	SCHEME,'://',HOST,'/',ROOT,'/',TOPFILE
)



CSR_webhost =: (verb define) defineAndDefaultParams (':' makeTable noun define)
	HOST:    nyckb01
	PATH:    wwwroot/MRUProc
	CONFIG:  web.config
)
	smoutput CONFIG
	xml_file_name =. makeURI 'file'; HOST; ('\' sr '/' PATH) ; CONFIG

	tmpfile =. getTemporaryFile''
	selectDSN fwrite tmpfile
	
	'PATH CONFIG'=.splitPath tmpfile
	'HOST PATH'=.(;~ }:)~&.>/@:splitHost@:(2&}.)`('localhost'&;)`('Can''t get temporary file'&assert bind 0) @. ('\:'&i.@:{:@:(2&{.))  PATH

	xsl_file_name =. makeURI 'file';HOST; ('\' sr '/' PATH) ; }. CONFIG

	A =: shell 'msxsl ', xml_file_name ,' ',xsl_file_name

    if. 'Code:' ((1 (] -: |. ) <.&:# tolower@:trim@:{.&> ,&:<) ,)~ _2 {:: :: (a:"_) LF cut CR -.~ A do. 0 2 $ a: return. end.

	dsns	=:  a: -.~ trim each LF cut toJ }. 6 u: A
	dsn		=:  trim each ';' slice > {: dsns
	dsnNVs  =. (,: }.&.>)/&.|: splitNV&> dsn

	selectINCLUDE fwrite tmpfile
	B =: shell 'msxsl ', xml_file_name ,' ',xsl_file_name 
	includes=: a: -.	~ trim each LF cut toJ }. 6 u: B

	dsnNVs  =. includes (}:"1@:combineMaps CSR_webhost@:,:@:('CONFIG'&;@:>@{.))~^:(*@:#@:[) dsnNVs  

	ferase tmpfile

	dsnNVs
)

makeLNK =: (verb define) defineAndDefaultParams (':' makeTable noun define)
	DATA_SOURCE:
	USER_ID:
	PASSWORD:
	INITIAL_CATALOG:
	ODBC:xxxMRU_PRODxxx
)
 	(smoutput) '"C:\Program Files\Microsoft SQL Server\80\Tools\Binn\isqlw.exe" ',doString '–S$DATA_SOURCE$ –d$INITIAL_CATALOG$ -U$USER_ID$ -P$PASSWORD$'
	
	DSN =. doString 'dsn=$ODBC$;uid=$USER_ID$;pwd=$PASSWORD$'
)

NB. ferase prodLnk =: '\Desktop\prod.lnk' ,~ 2!:5 'USERPROFILE'
NB. (doString lnkTemplate) fwrite (ferase tmpfile)] tmpvbs =. 'vbs',~{.> splitExt tmpfile=.getTemporaryFile''
NB. shell tmpvbs
DSN    =:  makeLNK CSR_webhost ''
CH     =:  ddcon DSN

tbl    =:  cocreate''
tm     =:  'sc_TUResponse' ddcol CH
tmh    =:  '__tbl' ,L:0~ {. tm
(tmh)  =:  <"1 |: }. tm

TBL    =:  cocreate''
sh	   =:  ddfet _1 ,~ ddcheck CH ddsel~ 'select top 1 RESPONSE from sc_TUResponse where applicationid=75867 order by rowid desc' 

=. tbl
TBLh   =:  '__TBL' ,L:0~ COLUMN_NAME__tbl normalizeSqlNames~ 'CoB';'Cob';'wid';'wID'
(TBLh) =:  <"1|:RSLSTS 



NB.  Ok, assume from the above we were able to extract the data and save it to..
NB. n=.'C:\Documents and Settings\dbron\My Documents\credit.rpt'
NB. 0!:010 <'c:\app\j\current\user\util\uncategorized\danutils.ijs'  NB. for psql
NB. Q=:(- >:i.3) psql fread n

getTable =: verb define
	'nms data' =. split y
	tbl =. cocreate''
	(nms , L:0  '__tbl') =.  <@:>@:|:"1<&2@:#@:$>@:{.@:, data

	tbl
)




NB.sqlhn =: ('CoB';'Cob';'wid';'wID') normalizeSqlNames  {. Q
NB. 4 : '  q=.cocreate ''
NB.sqlhn 4 : ('  q=.cocreate $~0 ' ;' (x , L:0  ''__q'') =. y' ; 'q') (] {.~ #@:] , [: >./ i:&1@:(+./\.)"1@:~:) &.> {:Q

NB.QQ=:sqlhn 4 : ('  q=.cocreate $~0 ' ;' (x , L:0  ''__q'') =. y' ; 'q') ' ' (] {.~ #@:] (,>:) [: >./ i:&1@:(+./\.)"1@:~:) &.> {:Q
NB.ROW_ID__QQ
