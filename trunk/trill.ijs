NB.  Script to extract usernames and passwords from a Trillian IM client installation.
NB.
NB.  Knowledge of password encoding stolen from
NB.     http://www.blacksheepnetworks.com/security/hack/trillian-ini-decrypt.c  
NB.     on 2006-June-21
NB.
NB.  The script was originally 3 lines long, all tacit, and was aesthetically much
NB.  more pleasing than the C.  Handling malformed data changed that.  But this script
NB.  is much more robust than that one.  It will even try to find the Trillian installation
NB.  if no INI files are specified.


require 'files strings convert dir registry'


NB.  Standard utils
join             =.  -@:#@:[ }. ;@:(,&.> boxopen)~
splitNV          =. ' '&splitNV : (a: ;~ [) -.&.>~ ] ({.~ ,&< }.~) #@:] <. >:@:i.~  NB.  DO NOT USE  $:  HERE ...  f.  fucks with it


NB.  Some standard locations to look for Trillian's installation path, in case the user doesn't specify filenames to read.

NB.  Places in the registry that trill's install path might be mentioned..
trillKeys        =:  _3 ]\ HKEY_LOCAL_MACHINE;'SOFTWARE\Clients\IM\Trillian\InstallInfo\'; 'ReinstallCommand'  ; HKEY_CLASSES_ROOT ;'Trillian.SkinZip\shell\Add\command' ;'(Default)'

NB.  Trill installs in 'C:\Program Files' by default, but I'm not sure if it respects the SystemDrive and ProgramFiles settings,
NB.  so seek both hard-coded 'C:\Program files', and SystemDrive\ProgramFiles and all drive\path combinations of path thereof.
defaultTrillPaths=:  '\' join each (<'Trillian';a:) ,&.>~ , { <@:-.&a:@:~."1 |: ':' splitNV&> 'C:\Program Files' ; 2!:5&.> ;: 'SystemDrive ProgramFiles'


NB.  The core logic:  Trillian encodes passwords with a simple bitwise XOR and a hard-coded salt.
hex2int          =.  _2 dfh\ ]
key              =.  243 38 129 196 57 134 219 146 113 163 185 230 83 122 149 124
decypher         =.  # {. a. {~ key ~:/@:,:&.:#:&.:((<:#a.)&,) ]   NB.  Not auto-invertible, but would be interesting
decrypt          =:  decypher@:hex2int f.


NB.  Split an ini file.  If can't be read, defaults to 0 2 $: a:
deIni            =. '=' splitNV&> LF cut toJ :: (''"_)@:('fread'~)  NB. 'fread'~  protects from f.

NB.  Pull accounts out of an ini file (makes some assumptions, so not as "true" as it could be)
extractAccounts  =. (;:'name password') (] #~ (e.&:(dltb&tolower L: 0)~ {."1)) deIni

NB.  This is neccesary to avoid writing a real INI parser
wellFormed       =. 'password' -:&dltb&tolower :: 0: >@:{.@:]
default          =. 0 2 $ a:

NB.  Is really just _2 (, 'decrypted' ; decrypt f. @:dltb@:>@:{:@:,)\ extractAccounts
NB.  But has all sorts of guards in place to avoid bad data.
outPasswds       =. [: (#~ wellFormed@:{.@:}."2) _2 (] default"_`(, 'decrypted' ; decrypt f.@:dltb&.>@:{:)@.wellFormed {:)\ extractAccounts

NB.  Complicated function to format the report prettily.  Thrown together quickly.
pwds             =. (,. #~ [: -. (0 e. $)&>@:]) outPasswds each
fmtPwdTbls       =. [: (,. TAB&,"1)"2&.>/"1  [:  <@:>"1@:|:"2&>   <@:>"1@:|:"2&.>
joinFns          =. (, ,/@:(,&' '"2))&.>
fmtPwds          =: ;@:(joinFns fmtPwdTbls)/@:|:@:pwds f.


NB.  Filenames (vector of boxes of strings) as  y  .  Report (string) as output.
main             =:  3 : 0

	NB.  Either use the files specified in the argument (can also be wildcards)
	if. 0 < # y do.
		files =. y
	else.
	NB.  Or try to figure out where Trillian is installed.
	
		NB.  First, check the registry (known 'trillian path keys' stored in the global  trillKeys
		H                 =.  regcreatekey "1 (}:"1 trillKeys),.<1
	
		NB.  If we were able to access any of the keys..
		if. 0 < +/ m =. 0 = ; {."1 H do.

			NB.  Read them
			h             =. m # 1 {"1 H 
	        k             =. ('(Default)' -:&dltb&tolower S: 0 ] )`(,:&(<'')) } 2 {"1 m # trillKeys   NB.  Substitute  ''  for  '(Default)'
	        L             =.  regqueryvalue"1 h ,. k

			NB. If we were able to read them...
	        if. 0 < +/ mm =. 0 = ; {."1 L do.


				NB.  Extract the paths
	            l         =. mm # 1 {"1 L
	            l         =. ('trillian.exe' ([: (] }.~ '"' -: {.) ] {.~ i.&1@:E.)&dltb&tolower L: 0 ]) l

				NB.  Combine these paths with defaultTrillPaths (take nub)
	            paths     =. (#~ ~:@:(dltb@:tolower L: 0)) defaultTrillPaths, l NB. > {. (~. /: #/.~) l

				NB.  And seek all ini files in the "users" subdirectory
				files     =. paths , L: 0 'users\*.ini'
			end.
		end.
	
		NB.  Clean up
	    regclosekey&> m # 1 {"1 H
	end.


	NB.  If we weren't given any files to read, and we couldn't find any in the standard Trillian locations, inform the user.
	if. 0 = # files do.
        'You must specify Trillian configuration files on the command line, because I cannot determine Trillian''s installation location.  Wildcards may be used, and will be searched for recursively.'
	else.

		NB.  Otherwise make the filenames canonical.  This resolves wildcards, and looks in subdirectories, 
		NB.  which is useful in either case (i.e. whether the user gave a wildcard or we calculated one)
		files =. (#~ ~:@:(dltb@:tolower L: 0)) ; {."1@:dirtree L: 0  files

		NB.  Do it.
        fmtPwds  files 
	end.
)


NB.  Argument is the command line less j.exe and the name of this script.
smoutput main 2 }. ARGV

NB.  While developing, (i.e. in the GUI), I don't want J to die.
NB.  But I do want it to return when I call the script from the command line.
2!:55^:IFCONSOLE ''


NB.  A way to find out which environment variable specifies the program files folder.
NB. ('C:\Program Files' (0 -: E.  i. 1:)&:dltb&:tolower S: 0 {:"1 )  '=' makeTable shell 'SET'