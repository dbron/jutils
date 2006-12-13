NB.  To do:
NB.  	1)  Document get/set functions
NB.  	2)  Try to consolidate get/set functions:
NB.  	3)  Either combine their verbs (make the verb parts common) or their nouns (so 'opposite' functions are stored together, eg: 'Location | qsmmfmove | smmfmove').

NB.  Utility functions:  
NB.  Monadic verb that converts the Table data to character list that represents the data in TAB- and CRLF-delimited table format.
NB.  Ouput is suitable for printing, exporting to Excel, etc.
NB.  Inputs:  Internal NV form (like 0 Extract) or tabular form (like 1 Extract)
NB.  Ouputs:  Character list (rank 1)
NB.  EG:  NVtext ,: (<;:'NAME AGE'),(<];._1' BOB JOE JANE'),<34 27 22 NB.  Returns 78 65 77 69 9 65 71 69 13 10 66 79 66 32 9 51 52 32 13 10 74 79 69 32 9 50 55 32 13 10 74 65 78 69 9 50 50 32 13 10{a.
rankTwo				=. ,:^:(2: - #@:$)
defaultToAce		=. ,&(,a:)^:(-.@:*@:#)
internalfy			=. ,:@:(<@:{. , {:@:$ {. <@:>"1@:|:@:}.)
makeInternal		=. internalfy^:(L. = 1:)
NVtext_z_			=: ([: ,@:>@:(,.&(9{a.)&.>@:}: ,.&.>/@:, ,"1&(13 10{a.)&.>@:{:)@:(>@:{. rankTwo@:,&.> -.&(13 10 9{a.)@:":"_1&.>@:}.)@:{. makeInternal)@:defaultToAce f.

NB.  Function to get the filename of a workspace, so that it can be loaded or saved
NB.  Inputs:   x :  Determines type of file prompt; either 'get' for an 'open/load' prompt, or 'set' for a 'save' prompt.
NB.            y :  Filename of workspace.   If '', the filename will be defaulted to the value in WORKSPACE_z_.  
NB.                 If the filename specifies a valid file, this file will be used.  If not, the user will be prompted
NB.                 to choose a file (initial directory can be given as y if desired).
NB.                 If the user cancels the file prompt, an assert will be raised.
NB.  Outputs:  Filename of workspace chosen.  Note also that WORKSPACE_z_ is set to the output.
promptForWorkspace		=: dyad define
	NB.  Default y to WORKSPACE_z_
	if. * # y do.
		filename	=. y
	else.
		filename	=. ''"_`".@.(0&=@:nc@:<) 'WORKSPACE_z_'
	end.

	NB.  If the file doesn't already exist, test if it's a valid filename.
	if. -. goodFile		=. fexist filename do.
		NB.  The filename given is good iff we can write to the file.
		goodFile		=. 1 = 'a' fwrite :: 0: filename

		NB.  Cleanup
		ferase :: 0: filename
	end.

	NB. If, after the preceeding, we still do not have a valid file, then prompt for one
	if. -. goodFile do.
		NB.  Pick an initial directory for the file prompt.  The precendece for choosing is y,my workspace dir, J's working directory,
		NB.  if all else fails, choose the root '\'.
	 	dir		=. (,&(<'\') {::~ [: i.&1 >@:{.@:('shlwapi.dll PathFileExistsA i *c'&(15!:0))"0) y ; 'b:\data\srccode\j\workspaces\' ; 1!:40 ''

		NB.  Prompt for a filename: prompt type (open/save) is determined by x
		filename	=. wd (' "J Workspace" "',dir,'" "" "J Workspaces (*.jws)|*.jws|All files(*.*)|*.*" ') ,~ > 'get/mbopen set/mbsave /mbopen' lookupWithDefault x

		NB.  Can't do anything unless the user chooses a filename
		'Workspace filename must be chosen' assert -. '' -: filename
	end.

	NB.  Default the file extension to '.jws'
	'path filename'		=. splitPath filename
	filename 		=. path , ; 2 {. '.jws' ,&boxopen~ a: -.~ (split~ i.&'.') filename

	NB.  Save our filename in WORKSPACE_z_
	WORKSPACE_z_		=. filename
)


NB.=======================================================
NB.  Save workspace
getMainParams			=: ({. ,: wd each @:{:)@:|: bind ('=' makeTable noun define)
	Position = qsmmfmove
	State    = qsmmfshow
	IJXState = qsmmfshow
)

NB.!  The following logic assumes 'Filename' is the first entry in the getWindowParams array - no other assumptions are made about the order.
getWindowParams			=:  ('=' makeTable noun define)&({."1@:[ , ([ ,. }."1@:(((<@:,~ ,&' '@:>@:{.)~ wd&.> @:, }.@:[ )&>~ (<@:({:"1)@:[)))~)
	Filename  = smsel
	Position  = qsmsize
	Selection = smgetsel
	State     = smgetshow
)

NB.  Function to save a J workspace
NB.  Inputs:   y :  Filename where workspace is to be saved.  Same rules as y to promptForWorkspace
NB.  Outputs:  Saves workspace config in file named in y
saveWorkspace			=: verb define
	NB.  Get the parameters of the main window
	mainParams		=.  getMainParams	''	

	NB.  Get the parameters of the sub windows 
	NB.! Should I do a smsave & smclose on each script window?
	windowParams	=.  getWindowParams (#~ -.@:endsWith&'.ijx'&>)@:(<;._2) wd 'qsmall'

	config 			=. _2 }. ; ('['&,@:,&']'@:(0&{::) ,&:(,&CRLF) NVtext@:(1&{::)) each ('Main';<mainParams),&<'Windows';<windowParams
	config fwrite 'set' promptForWorkspace y
)
NB.=======================================================






NB.=======================================================
NB.  Load workspace

NB.!  should we restore the IJX windows' contents too?
setMainParams			=: ('=' makeTable noun define)&(wd :: empty each @:({:"1@:[ (~:&a:@:] # (, ' '&,)&.>) (mapWithDefault {."1)~))
	Position = smmfmove
	State    = smmfshow
	IJXState = smselout ; smshow 
)

NB.! I think smmove is broken.  I tried: 
NB.   wd 'smsel c:\j406\temp\1.ijs'  NB.  Works - no domain error.
NB.   wd 'qsmsize'                   NB.  Works, returns metrics.
NB.   wd 'smmove 10 10 100 100'      NB.  Fails, wd 'qer' says 'bad file name : 0'
setWindowParams			=: ('=' makeTable noun define)& ([: wd :: empty each ;@:(|.@:(';'&arbCut)&.>)"1@:({:"1@:[ (~:&a:@:] # (, ' '&,)&.>)"1 }.@:] ({ ,&a:)"1~ {."1@:[ i. {.@:]))
	Filename  = smopen ; smsel
	Position  = smmove
	Selection = smsetselect
	State     = smshow
)


NB.  Function to load a J workspace
NB.  Inputs:   x :  Type of restart:  All scripts windows are to restart either maximised, restored (old positions), cascaded, or minimized 
NB.                 this is because there's no way to query the state of a child window in J.  In the monad form, x is defaulted to minimized.
NB.                 Enumeration is ;: 'maximized restored cascaded minimized'
NB.            y :  Filename of workspace to be loaded.  Same rules as y to promptForWorkspace
NB.  Outputs:  Restores a the J workspace in y
loadWorkspace			=: verb define
	fileCut			=.  -.&a:@:trim@:(({.~ i.&'#') each)@:(LF&arbCut)@:toJ
	cutIniBlocks		=. }.@:((trim@:}.@:}:@:>@:{. ; <@:}.);.1~ '[]'&-:@:(0 _1&{)&>)@:((<'[]')&,)
	iniFileCut		=. cutIniBlocks@:fileCut 

	iniData			=. ({."1 ,. trim each @:(TAB&arbCut&>)&.>@:}."1) iniFileCut fread 'get' promptForWorkspace y

	NB.  Open and position script windows, etc.
	setWindowParams winData =.  'Windows' map~ iniData

	NB.  Do this after the sub-window setup, so that we set focus correctly and it isn't changed afterwards.
	setMainParams |:   'Main' map~ iniData

	smoutput 'Opened:  ' , ls winData  ([: }. (i.~ {.)~ {"1 [) <'Filename'
)
NB.=======================================================
