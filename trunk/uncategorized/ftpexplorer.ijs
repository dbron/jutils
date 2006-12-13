NB.  We want to turn the global MANE ini file into a registry file, suitable for executing.
NB.  That way when the ini file is changed, we can update FTPExplorer's configuration.
EXAMPLE =: noun define

	We want to turn an .ini file that looks like this: 
	
		[TLW]
		description=Host for downloaind EOD files from TLW.  As of this writing, we use this host to download AVP, MOL, and execution summary & detail reports.
		host=tlwtxftp1
		user=maple
		pass=fbf1602
		downloaddir=outgoing/slk

	Into a .reg file that looks like this:

		[HKEY_CURRENT_USER\Software\FTP Explorer\Profiles\TLW]
		"Host"="tlwtxftp1"
		"Login"="maple"
		"Type"="6F6E75434B484D"
		"InitialPath"="outgoing/slk"
		"AnonLogin"=dword:00000000
		"CacheData"=dword:00000000
		"Description"="Host for downloaind EOD files from TLW.  As of this writing, we use this host to download AVP, MOL, and execution summary & detail reports."

)

NB.  Read ftp-specifying INI file.
load 'c:\danielb\projects\work\order_manager\main\dev\util\default\ini.ijs'
inis			=: iniparse fread '\\statarbsvr0\D_Drive\Config\ftp.ini'

NB.  Turn ini into a table.
TBL				=: trim each ({:"1 inis) mapWithDefault &> < cols =: ;: 'host user pass downloaddir uploaddir description'

NB.  idx is cols we want to manipulate
'dirCols pwCol' =: (}: ; {:) cols i. ;:'downloaddir uploaddir pass'

NB.  Encode passwords.  The author of FTPExplorer wasn't very subtle.
load 'convert'
encodePW		=. ,@:hfd@:(+ 3&*@:+&3@:i.@:#)@:(a.&i.)
decodePW		=. {&a.@:(- 3&*@:+&3@:i.@:#)@:(_2&(dfh\))  NB.  Might come in handy if we want to go the other way.
modifyColumn    =. modifyIndicies &.: |:
pw				=: encodePW :. decodePW f.
TBL				=: pwCol pw&.> modifyColumn TBL  

NB.  Remove entries that don't specify hosts.
NB.  Store the mask for later use (to compress the profile list)
TBL				=:  TBL #~ noHostMask =: a: ~: TBL {&.|:~ cols i. {.;:'host'

NB.  Remove initial directories which are identically '.'
NB.  Consolidate upload and download dir into a single initial directory 
NB.  (defaulting to encoded password if neither is present).
TBL				=:   dirCols (<,'.') sr a: modifyColumn TBL
dirs			=:  {. |: spoof #"1~ ~:&a:"1  spoof =. TBL   {&.:|: ~ dirCols, pwCol NB.  Yes, FTP Explorer DOES default "initial path" to the encoded password.
'cols TBL'		=: (({.;:'dir') ,&< dirs) |:@:, each ~(<<<<dirCols) {&.> (cols ,&:< |: TBL)  NB.  Collapse the dir columns into a single value

NB.  Slap on the DWORD keys.
cols			=:  cols , dwords =: ;: 'anonymous cached'
TBL				=:  TBL ,"1 (<'dword:00000000') #~ # dwords

NB.  The names in the registry that correspond to our table's columns (see cols ,. regCols)
NB.  And the order in which we want to see those columns (the way FTPExplorer stores them).
NB.  Yes, the author of FTPExplorer hid the password under the key "Type"...
regCols			=: ;: 'Host Login Type Description InitialPath AnonLogin CacheData  '
orderWanted		=: ;: 'Host Login Type InitialPath AnonLogin   CacheData Description'

NB.  Slap the column names onto the columns of the table, and reorder appropriately.
NVpairs			=: (regCols i. orderWanted) {"_ _1 regCols  ,."1 TBL 

NB.  Enclose each value in quotes, unless it's a dword value.
NB.  Make sure to escape any embedded quotes and slashes.
NVpairs			=:  '"'&enclose@:((#!.'\'~&.|. 1: j. e.&'\"') )^:(-.@:beginsWith&'dword:') each NVpairs

NB.  This key is the registry key under which all this information is encoded.
key				=:  '[HKEY_CURRENT_USER\Software\FTP Explorer\Profiles]'

NB.  Seperate NV-pairs by equals signs
TEXT			=:  '=' <@:join"1 NVpairs

NB.  Slap on the names of our configurations (prefixed by the key)
NB.  Sort the profiles by name (because FTP explorer does this)
TEXT			=:  profNames /:~ TEXT ,.~ (<'\' _1 }key) ,&']'@:, each profNames =: noHostMask # {."1 inis   NB.  Note that we #'d out some hosts above, so we have to do the same to our config names.

NB.  Put on the magic header and the key name, then seperate each block with an empty line.
TEXT			=:  (CRLF,CRLF) join 'Windows Registry Editor Version 5.00' ; key ; CRLF <@:join"1 TEXT 

NB.  Manually convert to Unicode -- 2 u: doesn't work
TEXT			=:  255 254&, @: , @: ,.&0 &.: (a.&i.) TEXT  

NB.  Write out the registry file
TEXT fwrite fn	=:  '\\statarbsvr0\d_drive\config\ftpx.reg' 

ME              =:  3 : '(4!:3 $~0){::~ 4!:4 {.;: ''y'''0
ME    fcopy ME  ;@:({.@:] , {:@:[)&:splitPath fn 

NB.  Register it.  Need to figure out how to supress the Yes/No dialog.
NB.  wd 'winexec *regedit ','"' enclose fn 

NB.  Done.
NB.  2!:55''