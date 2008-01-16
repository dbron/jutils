NB.  IPC
require 'task jmf socket guid'
coinsert 'jsocket'

A                =:  verb define
	NB. Long-winded way to parse the command line
	'BL port'    =:  1 {.`(_1 ".&.> {.);.1 (,&(<'_1')@:] {~ ('lr p'=.'-bl';'-port') i.~ [)/|:_ 2{._2]\ 2 }. ARGV -.<'-jijx'

	if. _1 = port do.
		parent   =:  1  NB. parent/server
	
NB. 		try.
			port =.  startServer '' 
			BL   =:  'break_',":guidsx_z_ ''
	
			createjmf_jmf_ 4;~fn=.jpath'~temp\','.jmf',~BL
			map_jmf_ BL;fn;BL;0
	
			scriptName =.  (4!:4{.;:'cs'){::4!:3''
			fork 'j  ','"',scriptName,'" ',lr,' ',BL,' ',p,' ',":port  NB.  -jijx
	
			NB. logic continues in socket_handler, when we accept the connection from our child.
NB. 		catch.
NB. 			sdcleanup''
NB. 			unmapall_jmf_''
NB. 			1!:55 ::0: fn
NB. 			'error in startup'
NB. 		end.
	
	else.
		parent   =:  0  NB.  child/client
	
		try.
			share_jmf_ ;~BL
			startClient port
			send BL,CRLF
	
			NB. logic continues in socket_handler, when our parent tells us he's start the loop
		catch.
			2!:55^:0:13!:11''
		end.	
	end.
)

socket_handler    =:  verb define
	if. parent do.  NB.  parent/server
		'in out err' =. sdcheck sdselect ''

		NB.  Accept socket connection
		NB. 0 pick sdcheck sdaccept socket
		NB. send "starting loop"
		NB.  start loop
		NB.  disable
		NB.  wd msgs
		NB.  test BL ...
		NB.  if broken send "loop stopped msg"
		NB.  cleanup:  send "death" message to client
		NB.  cleanup:  expect "socket shutdown" msg
		NB.  cleanup:  just in case, use client's PID to kill it
		NB.  cleanup:  unmap file
		NB.  cleanup:  erase file
		NB.  cleanup:  shut down
	else.  	        NB.  child/client
		NB.  When get loop msg, pop up msgbox (centered over parent's disabled forms)
		NB.  when button pressed, update BL
		NB.  when get loop stop msg, drop form.
		NB.  when get shutdown msg, close socket connection and then 2!:55 .
	end.
)


startServer       =:  verb define
	try.
		NB.  Open socket
		socket    =.  0 pick sdcheck sdsocket ''
		
		NB.  Bind socket to any available port
		sdcheck sdbind socket ; AF_INET_jsocket_ ; '' ; 0 

		NB. Listen for connections (max 1)
		sdcheck sdlisten  socket , 1

		NB.  Don't block when waiting for streams
		sdcheck sdasync socket

		NB.  Bind socket to communication verbs,
		NB.  so I don't have to pass globals around.
		write     =: socket&$: : write
		read      =: socket&$: : read

		NB. Publish portno
		2 pick sdcheck sdgetsockname socket

	catch.
		sdcleanup''
		'couldn''t start socket server' assert 0
	end.
)

startClient       =:  verb define
NB.  Create a connection to a port on the local machine.

		port      =.  y
		localhost =. 0 pick sdcheck sdgethostbyname 'localhost'
		socket    =. 0 pick sdcheck sdsocket''

		NB.  Bind socket to communication verbs,
		NB.  so I don't have to pass globals around.
		write     =:  socket&$: : write
		read      =:  socket&$: : read

		NB.  Get connection to port on local machine
		sdcheck sdconnect socket ; localhost ; port

		socket
)

write             =:  dyad define
NB.  x is socket, y is data, 0 is flags.
		sdcheck y sdsend x , 0
)

read              =:  dyad define
NB.  x is socket, y is max number of bytes to read, 0 is flags.
		sdcheck   sdrecv x, y,0
)

smoutput A''