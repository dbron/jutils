NB.  Command tool class.
coclass 'cmdtool'

NB.  Usage information for the command tool
Usage =: 0 : 0
Usage: 	
	Dyadically:
	wait runcommand__a <cmd>

	Where <cmd> is the command to be executed and
	wait is a flag indicating whether to wait for 
	the command to complete and return output.

	Mondically:
	runcommand__a <cmd>
	Will run 1 runcommand__a <cmd>

	Examples:
	a =: '' conew 'cmdtool'
	runcommand__a 'dir'			NB.  Returns 2 boxes:  return-code;output
	0 runcommand__a 'wait 12'	NB.  Even though the wait command won't return for 12 seconds, the J call returns immediately, because x = 0
)


NB.  Make a new command tool.
create =: 3 : 0
	wd 'pc ShellObj'
	wd 'cc WshShell oleautomation:Wscript.Shell'
	wd 'cc fso oleautomation:Scripting.FileSystemObject'	
	wd 'olemethod fso base GetSpecialFolder 2'
	gTmpPath =: wd 'oleget fso temp Path'
)

NB.  Kill the command tool.
cmdtool_close =: destroy=: 3 : 0
	wd 'pclose'
	codestroy''
)

NB.  Get a temporary filename.
gettmpfile =: 3 : 0
	wd 'psel ShellObj'
	gTmpPath, '\', wd 'olemethod fso base GetTempName'
)


NB.  RunCommand:  Run a windows command; optionally wait for it to complete and return its output.
NB.  Inputs:
NB.  	x : A boolean indicating whether to wait for the command to complete before returning.
NB.  	y : A string specifying the command to be executed.
NB.
NB.  Outputs:   
NB.  	If wait is enabled, J will block until the the command is finished executing and return 2 boxes.  
NB.  	The first box is set to any error code returned by the command and the second box is the the
NB.  	command's output to stdout. 
NB.
NB.     If wait is not enabled, the command will return (i. 0 0) immediately.

runcommand =: 3 : 0
	NB. Default is to wait for the command.	
	1 runcommand y
:
	EAV =. 255{a.
	runcmd =. 'cmd /c ', y
	if. 1 = x do.
		sTempName =. gettmpfile ''
		runcmd =. runcmd, ' > ', sTempName
	end.

	NB. see http://msdn.microsoft.com/library/default.asp?url=/library/en-us/script56/html/wsMthRun.asp
	NB. for documentatio of Wscript Run method.
	wd 'psel ShellObj'
	e =. wd 'olemethod WshShell base run  ', EAV, runcmd, EAV, '0 ', ": x

	if. 1 = x do.	NB. if waiting for the app to complete
		res =. 1!:1 < sTempName
		1!:55 < sTempName
		(_1 ". e); res
	else.
		NB. We here generally because the no-wait flag has been set so just return empty.
		empty ''
	end.
)
