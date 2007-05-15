ami_z_ =: conew & 'ami' : ($:@:,&:<)

smoutput noun define

   ami  'MODEL_PREFIX' ; 'C:\demo_model\dir'

)

coclass  'ami'      NB.  AIS Model Instantiator
coinsert 'base'

require 'printf task winapi regex dir convert ~user\contrib\bone\utf16.ijs ~user\contrib\burke\ufread.ijs'  NB.  debug 

NB.  Override  dfh  from  convert  .  Need extended integers for guids.
dfh              =:  16x #. 16x | '0123456789ABCDEF0123456789abcdef' i. ] 

NB.  Modified replacement for  rxrplc_jregex_  .  Have it 
NB.  convert guids.  Maybe I could use  rxapply  instead, 
NB.  somehow.
rxRplc_jregex_   =:  4 : 0
	pat=. >{.x
	NB.new=. {:x
	if. L. pat do. 'pat ndx'=. pat else. ndx=. ,0 end.
	if. 1 ~: #$ ndx do. 13!:8[3 end.
	mat=. ({.ndx) {"2 CLAMS=.pat rxmatches y
	new =. aiaguid_base_&.> {:"1 CLAMS rxfrom y
	new mat rxmerge y
)

rxRplc_z_        =:  rxRplc_jregex_

NB.  Modified  dirtree  from  dir  , which has 2 problems: 
NB.  it always lowercases filenames, and it doesn't list 
NB.  directories.  This version solves the lowercase problem.
dirtree2 =: 3 : 0
	0 dirtree2 y
:
	oldtolower=:5!:1{.;:'tolower'
	tolower =: ]
	z=.x dirtree y
	tolower=: oldtolower 5!:0
	z
)

NB.  Completely replace dirtree.  This version solves both problems.
DirTree          =:  (; [: ,@:; 1 (;@:($:&.>))&.>`];.1 <^:2 (, '\'&,)&.>&.> (({.~ 0 - 2 + #) <@:({."1)@:}./.~ 1 0 , 'd' = 4 {::"1^:2 ])^:(0 < #)@:(1!:0)@:(,&'\*'))

NB.  Copy directory and substitute MODEL_PREFIX 
NB.  for 'demo' in names (recursively).
substDir         =:  verb define
	
	sd =. 'src dest'=.(; demoRplc) y
	
	smoutput 'Going to create directory:  ', dest
	smoutput '(it will be deleted first if it already exists)'
	
	shell 'RD %s /S /Q' sprintf < dest
	
	shell 'xcopy /EVCIQFHRKYZ "%s" "%s"' sprintf sd
	
	|. (<src) (<_1;1)} ('MoveFile' win32api)"1  (,. [: (, demoRplc)&.>/"1 splitPath&>) \:~ DirTree dest  NB.  /:~ important -- don't want to rename the dir first
	
	dest
)

NB.  Derived monad's input and output are guids in the format 
NB.  '419c943-4507-4efe-a198-80f08208c7cf' .  Derived dyad
NB.  is like monad but takes numeric LHA.  Verb argument to
NB.  adv is applied to extended int equivalent of guid argument
NB.  or between that argument and the numeric LHA.
guid             =:  adverb define
	'-' join H <;.1~ (+/\0,#&>K) e.~ i.#H=. tolower (-#L){.!.'0'      hfd u dfh L=.;K=.'-' cut y NB. '419c943-4507-4efe-a198-80f08208c7cf'
:
	'-' join H <;.1~ (+/\0,#&>K) e.~ i.#H=. tolower (-#L){.!.'0'(x:x) hfd u dfh L=.;K=.'-' cut y 
)


NB.  Derived monad adds extended int equivalent of adv's 
NB.  string argument to its guid input, producing a guid 
NB.  output.
addtoGUID        =:  adverb define

	(+ ((#a.) #.&:x: a.i.m) * 0&~:) guid

)


create           =:  verb define

	assert.         2 -:            # y [ 'Argument is  ''MODEL_PREFIX'' ; ''C:\demo_model\dir'' '
	assert.   'boxed' -:   datatype   y [ 'Argument is  ''MODEL_PREFIX'' ; ''C:\demo_model\dir'' '
	assert. 'literal' -:"1 datatype&> y [ 'Argument is  ''MODEL_PREFIX'' ; ''C:\demo_model\dir'' '

	smoutput 'Starting...'

	'pfx src'    =:  y 

	MODEL_PREFIX =:  pfx

	smoutput 'New model''s prefix is ',MODEL_PREFIX 

	src_dir      =:  }:^:('\/' e.~ {:) src
    
 	smoutput 'Demo model directory is ',src_dir

    d            =.  1!:0 :: ((0 5 $ a:)"_) src_dir

	assert. 1 5 -: $ d            [ 'Demo directory must exist'
	assert. 'd' -: 4 {::^:2 {. d  [ 'Demo must be a directory'


	demoRplc     =:  ('(?ix) demo ';MODEL_PREFIX)&rxrplc
	aiaguid      =:  MODEL_PREFIX addtoGUID	

	dest_dir     =:  substDir src_dir

	smoutput 'Copied demo model dir, beginning object modification...'

	(fwrite~ (  (BOM_bom_   @:[ , [: utf16le   @:demoRplc ('(?ix)  (  [0-9a-f]+-  (?:[0-9a-f]+-){3}  [0-9a-f]+  )';'') rxRplc ]) utf16LEto8   ) @:fread)&.> {."1 dirtree2 dest_dir,'\*.aro'

	smoutput 'Object modification complete; beginning package modification...'
	(fwrite~ ('(?ix)  (  [0-9a-f]+-  (?:[0-9a-f]+-){3}  [0-9a-f]+  )';'') rxRplc demoRplc@:fread)&.> {."1 dirtree2 dest_dir,'\*.apk'

	smoutput 'Done.'
	smoutput 'Please double-check results. New model is here:  ', dest_dir

)



TEST             =:  0

0!:2^:TEST noun define

	L-: >{:,'(?ix)  (  [0-9a-f]+-  (?:[0-9a-f]+-){3}  [0-9a-f]+  )' (rxmatches rxfrom ]) L=.'419c943-4507-4efe-a198-80f08208c7cf'
	'419c943-4507-4efe-a198-80f08208c7d0' -: >:^:(~:&0) guid L

)

Note 'Code to process using XML instead of straight replacement'

	require '~user\general\parse\xml.ijs'
	NB.N=:(; ( (bom_BOM_@:[ , [: utf16le  ('(?ix)  (  [0-9a-f]+-  (?:[0-9a-f]+-){3}  [0-9a-f]+  )';'') rxrplc ]) utf16LEto8) ) @:fread'E:\ais_demo\AIA_Thresh-Active Table.aro'
	NB.'A B'=:N
	'A B' =: fread&.> src ({:@:] ;~ (([ , ] }.~ (i. 1+{:)~ &:(+/\)&:('\/' e.~ ])) >@:{.)) 1 2 { _2 { F
	xA =: proc_xml_ A
	xB =: proc_xml_ B
	
	assert    xA -:&:#&:(<S:0) xB  NB.  SHould really -:&{::
	diffs =: utf8@:(6&u:)@:}. L: 0 xA ( ~: # ,. )&:(< S: 0)  xB
	G=:xA ( ~: &:(<S:0) |:@:# ,.&:(<S:1)&:({::) )  xB
	assert    -:/G 
	g=:{.G
	PATHS =: /:~ ~. ; , <\.&.> utf8@:(6&u:)@:}. L:0 xA {:: :: (''"_) L: 1 _~ <@:,&(1 0; 0 1)@:}:\&.>g
	

	NB.N=:(fwrite~ (  (]          @:[ , [: ]         @:]        ('(?ix)  (  [0-9a-f]+-  (?:[0-9a-f]+-){3}  [0-9a-f]+  )';'') rxRplc ]) demoRplc     ) @:fread)&.> {."1 dirtree2 dest,'\*.apk'
	NB. #    >{. {:"1 >M
	NB. #Q=:fread{. {."1 >M
	NB. |: Q (~: (([ # 1 ,~ 2 >/\ [) <;.2"1 #"1) ,:) >{. {:"1 >M
)