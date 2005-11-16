NB.executing tasks with optional timeout or I/O
NB.
NB. INSTALL
NB.   > copy task.ijs user/
NB.
NB. RUN
NB.   require '~user/task.ijs'
NB.
NB.
NB. TASKS WITHOUT I/O
NB.
NB. fork 'notepad.exe'           NB. run notepad, no wait, no I/O
NB. 5000 fork 'notepad.exe'      NB. run notepad, wait 5 sec, no I/O
NB. _1 fork 'notepad.exe'        NB. run notepad, until closed, no I/O
NB.
NB. 5000 fork 'cmd /k dir'  NB. show dir in cmd window for 5 sec and close
NB. _1 fork 'cmd /k dir'    NB. show dir in cmd window until user closes it
NB.
NB.
NB. TASKS WITH I/O
NB.
NB. spawn 'net users'                    NB. get stdout from process
NB. '+/i.3 4'spawn'jconsole'             NB. call process with I/O
NB.    12 15 18 21
NB.
NB.
NB. SHELL COMMANDS (WITH I/O)
NB.
NB.    shell'echo.|time'                    NB. get result of shell command
NB. The current time is:  8:04:13.09
NB. Enter the new time: 
NB.
NB.    (shell'dir /b')shell'find ".dll"'    NB. get all DDL names by piping
NB. j.dll
NB. jregexp.dll
NB.
NB. NOTE: the implementation uses C-type structures
NB.       by the original Method of Named Fields
NB.
NB. AUTHOR
NB.    (C) Oleg Kobchenko <olegykj@yahoo.com>, 10/19/2003
NB.        GPL, AS-IS, NO WARRANTY

require 'dll strings'

coclass 'ptask'

NB.*fork v run task and optionally wait completion
NB. [timeout=0] fork cmdline
NB.   timeout: 0 no wait, _1 infinite, >0 timeout
NB.   cmdline: 'shortcmd arg1 arg2 ...'
NB.   cmdline: '"command with space" arg1 ...'
NB. e.g. fork 'notepad.exe'
fork=: 3 : 0
  0 fork y.
:
  ph=. CreateProcess y.
  if. x. do. Wait ph;x. end.
  CloseHandle ph
  empty''
)

NB.*spawn v [monad] get stdout of executed task
NB. stdout=. spawn cmdline
NB.   stdout: _1 fail, '' or stdout stream value if success
NB.   cmdline: 'shortcmd arg1 arg2 ...'
NB.   cmdline: '"command with space" arg1 ...'
NB. e.g. spawn 'net users'

NB.*spawn v [dyad] send stdin and get stdout of task
NB. stdout=. [stdin=''] spawn cmdline
NB.   stdin: input to stream as stdin, '' no input
NB. e.g. nocr 'i.3 4'spawn'jconsole'
spawn=: 3 : 0
  '' spawn y.
:
  'or ow'=. CreatePipe 1
  'ir iw'=. CreatePipe 2,#x.
  ph=. (ow,ir) CreateProcess y.
  CloseHandle ow,ir
  if. #x. do. x. WriteAll iw end.
  CloseHandle iw
  r=. ReadAll or
  CloseHandle or,ph
  r
)

NB.*shell v [monad] get stdout of shell command
NB.   e.g. shell 'dir /b/s'

NB.*shell v [dyad] send stdin and get stdout of shell command
NB.   e.g. (shell 'dir /b/s') shell 'find ".dll"'
shell=: (''"_ spawn 'cmd /c '&,) : (spawn 'cmd /c '&,)

NB.*nocr v removes extraneous CR's
nocr_z_=: ((13{a.);'')&stringreplace
fork_z_=: fork_ptask_
spawn_z_=: spawn_ptask_
shell_z_=: shell_ptask_

NB. ================================================ implementation

int=: {.@:(_2&ic)
sint=: 2&ic

NB. METHOD OF NAMED FIELDS
NB. struct=. 'valu' 'memb' sset structdef struct
sset=: 2 : ',@(((_4]\n.)i.m.)}) _4&(]\)'

NB. value=. 'memb' sget structdef struct
sget=: 2 : '[: ((_4]\n.)i.m.)&{ _4&(]\)'

szero=: # # (0{a.)"_

t=. 'CbytResvDeskTitlXposYposXsizYsizXcntYcnt'
STARTUPINFO=: t,'FillFlagSwRsResvInphOuthErrh'
PROCESSINFO=: 'ProhThrhPridThid'
SECURITYATTR=: 'CbytSecdInhe'

STARTF_USESTDHANDLES=: 16b100
STARTF_USESHOWWINDOW=: 1
WAIT_TIMEOUT=: 258
CREATE_NEW_CONSOLE=: 16b10
DUPLICATE_SAME_ACCESS=: 2

WaitForSingleObject=: 'kernel32 WaitForSingleObject i i i'&cd
CloseHandle=: 'kernel32 CloseHandle i i'&cd"0
TerminateProcess=: 'kernel32 TerminateProcess i i i'&cd
ReadFile=: 'kernel32 ReadFile i i *c i *c i'&cd
WriteFile=: 'kernel32 WriteFile i i *c i *c i'&cd
GetCurrentProcess=: 'kernel32 GetCurrentProcess i'&cd

DuplicateHandleF=: 'kernel32 DuplicateHandle i  i i  i *c  i i i'&cd
CreatePipeF=:'kernel32 CreatePipe i *c *c *c i'&cd
CreateProcessF=: 'kernel32 CreateProcessA i i *c i i i  i i i *c *c'&cd

DuplicateHandle=: 3 : 0
  p=. 0 pick GetCurrentProcess ''
  'r i1 i2 i3 h i4 i5 i6'=. DuplicateHandleF p;y.;p;(sint 0);0;0;DUPLICATE_SAME_ACCESS
  CloseHandle y.
  int h
)

NB. 'hRead hWrite'=. CreatePipe Inheritable=0
NB.    ... FileRead/FileWrite ...
NB. CloseHandle hRead,hWrite
NB.
NB. Inheritable: 0 none, 1 for read, 2 for write
CreatePipe=: 3 : 0
  'inh size'=. 2{.y.,0
  sa=. szero SECURITYATTR
  sa=. (sint #SECURITYATTR) 'Cbyt' sset SECURITYATTR sa
  sa=. (sint *inh) 'Inhe' sset SECURITYATTR sa
  'r hRead hWrite sa1 i1'=. CreatePipeF (sint 0);(sint 0);sa;size
  hRead=. int hRead
  hWrite=. int hWrite
  if. 1=inh do. hRead=. DuplicateHandle hRead end.
  if. 2=inh do. hWrite=. DuplicateHandle hWrite end.
  hRead,hWrite
)

NB. hProcess=. [hWriteOut[,hReadIn]] CreateProcess 'program agr1 agr2 ...'
NB.    ... 
NB. CloseHandle hProcess
CreateProcess=: 3 : 0
'' CreateProcess y.
:
  'ow ir'=. 2{.x.,0
  si=. szero STARTUPINFO
  si=. (sint #STARTUPINFO) 'Cbyt' sset STARTUPINFO si
  f=. inh=. 0
  if. +/ir,ow do.
    inh=. 1
    f=. CREATE_NEW_CONSOLE
    si=. (sint STARTF_USESTDHANDLES+STARTF_USESHOWWINDOW) 'Flag' sset STARTUPINFO si
    if. ow do. 
      si=. (sint ow) 'Outh' sset STARTUPINFO si 
      si=. (sint ow) 'Errh' sset STARTUPINFO si 
    end.
    if. ir do. si=. (sint ir) 'Inph' sset STARTUPINFO si end.
  end.
  pi=. szero PROCESSINFO
  'r i1 c i2 i3 i4 f i5 i6 si pi'=. CreateProcessF 0;y.;0;0;inh; f;0;0;si;pi
  if. 0=r do. 0 return. end.
  ph=. int 'Proh' sget PROCESSINFO pi
  th=. int 'Thrh' sget PROCESSINFO pi
  CloseHandle th
  ph
)

NB. ph=. h CreateProcess 'program agr1 agr2 ...'
NB.    ... 
NB. Wait ph;5000
NB. CloseHandle ph
Wait=: 3 : 0
  r=. 0 pick WaitForSingleObject y.
  if. WAIT_TIMEOUT=r do. TerminateProcess (0 pick y.);_1 end.
)

NB. ph=. h CreateProcess 'program agr1 agr2 ...'
NB.    ... 
NB. r=. ReadAll h
NB. CloseHandle h,ph
ReadAll=: 3 : 0
  ret=. ''
  while. 1 do.
    'r i1 str i2 len i3'=. ReadFile y.;(4096#'z');4096;(sint 0);0
    len=. int len
    if. (0=r)+.0=len do. 
      'ec es'=: cderx''
      if. -.ec e.0 109 do. ret=. _1  end.
      break.
    end.
    ret=. ret,len{.str
  end.
  ret
)

NB. ph=. hr,hw CreateProcess 'program agr1 agr2 ...'
NB. r=. WriteAll hw
NB. CloseHandle hw
NB. r=. ReadAll hr
NB. CloseHandle hr,ph
WriteAll=: 3 : 0
:
  while. #x. do.
    'r i1 str i2 len i3'=. WriteFile y.;x.;(#x.);(sint 0);0
    len=. int len
    if. (0=r)+.0=len do. 
      'ec es'=: cderx''
      if. -.ec e.0 109 do. ret=. _1  end.
      break.
    end.
    x.=. len}.x.
  end.
  1
)

NB. Examples.  Run each with Ctrl+R.  Watch .ijx window
0 : 0
fork 'notepad.exe'           NB. run notepad, no wait, no I/O
5000 fork 'notepad.exe'      NB. run notepad, wait 5 sec, no I/O
_1 fork 'notepad.exe'        NB. run notepad, until closed, no I/O

5000 fork 'cmd /k dir'  NB. show dir in cmd window for 5 sec and close
_1 fork 'cmd /k dir'    NB. show dir in cmd window until user closes it

spawn 'net users'                    NB. get stdout from process
nocr 'i.3 4'spawn'jconsole'          NB. call process with I/O

shell'echo.|time'                    NB. get result of shell command
(shell'dir /b/s')shell'find ".dll"'  NB. get all DDL names by piping
)
