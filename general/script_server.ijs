cocurrent 'scriptserver'
require'files jmf validate socket'
coinsert 'jsocket'
unmapall_jmf_ ''

NB.  Figure out how many bytes are required for mapped file
NB.! JSTDLIBBUG:  Feature request, create a mapped file
NB.! from a variable, using the smallest possible amount of
NB.! space.  Or, if I tell you the shape and J internal type
NB.! of the variable I want, then create a mapped file precisely
NB.! large enough to hold such a variable.
highest_port		=:  2^16
bits_per_byte		=:  2^3
byte_per_int		=:  2^2

NB.!  JSTDLIBBUG:  MUST FLOOR BYTE COUNT.
NB.!  Bug in createjmf_jmf_  if 1{:: y is floating, even 
NB.!  if  (=<.)  , you'll get errors later on in map_jmf_
NB.!  So make sure to use  <.  .
bytes_per_port		=:  <. bits_per_byte %: highest_port   

strToPort           =:  _1&". ^:((2 ^ 1 10 17) e.~ 3!:0) :: _1:
portPending			=:  -:&(pendingPort =: 0)  NB.  pendingPort=0 means we're starting up a server.
isPort				=:  ((1 , highest_port)&inrange  *. isinteger *. isscalar) :: 0: @: strToPort


SCRIPTSTOOPEN       =: (#~ fexist) 2 }. ARGV   	NB.  Drop executable name and script name

NB.  If we set the registry to launch scripts from jconsole,
NB.  then there is no IJX, and hence no IJX name.
IJXNAME				=:  (,&a: {::~ 'x'i.~{:&>) (<@(3 : 'SMNAME__y':: 0:) "0  \: (0 ". ;:^:_1) ) conl 1
'PORTFILENAME IJXNUM'	=:  (( ] (] ;~ '.port' ,~ ,) _4 }. (}.~#)) getpath_j_) IJXNAME
SHARENAME			=:  'JSCRIPTPORT_',IJXNUM
VARNAME				=:  'SCRIPTPORT_','_',~;coname''

launch              =:  open@:(#~ fexist)@:(jpath&.>)@:boxxopen

CHILDREN            =: 0 $ <''

erase'server'


GO =: verb define

	if. 0 < fsize PORTFILENAME do.

		try.
	
			NB.!  JSTDLIBBUG:  
			NB.!  Can't share readonly -- bug in share_jmf_
			share_jmf_ VARNAME;SHARENAME;0 
		catch.
			
			if. 'bad mapping' -: _2 (".@:{:: ;:) ::0: 13!:12'' do.
				map_jmf_ :: 0:  VARNAME;PORTFILENAME;1
			end.
		end.
	end.

	NB.  Another server running.
	if. noun = nc {.;:VARNAME do.

		port =. VARNAME~  NB.  Don't use  a:&{  etc here if you want portPending^:3 to work.

		NB.  Another Script Server is trying to start up -- give it max 3 seconds to do so.
		([ (6!:3)@:1:)^:portPending^:3  port

		if. isPort port do.
			NB.  Valid server port
			try.
				server =: 'scriptclient' conew VARNAME~
			catch.
			end.
		end.
	end.

	NB.  If couldn't connect to other server, 
	NB.  run one ourselves.
	if. noun ~: nc {.;: 'server' do.
		try.
		NB.!  JSTDLIBBUG:  Can't share non-JMF file as mapped
		NB.!   other J session will require JMF header,
		NB.! and since that's not stored in non-JMF files
		NB.!  the other J session can't find it.
		NB.
		NB.! PORTFILENAME fwrite~ fmt_port _1
		NB.! JCHAR map_jmf_ 'SCRIPTPORT_z_';PORTFILENAME;SHARENAME;0 NB.;1
			unmap_jmf_ :: 0: VARNAME
			ferase :: 0: PORTFILENAME
			createjmf_jmf_ PORTFILENAME;bytes_per_port
			map_jmf_ VARNAME;PORTFILENAME;SHARENAME;0 NB.;1

			NB.  Publish "pending" portno before start listening
			(VARNAME) =: pendingPort 

			NB.  Because VARNAME~ is mapped, and is passed
			NB.  in to startServer, that verb can assign
			NB.  y=.port number  and the port number will
			NB.  be available in VARNAME~ .
			if. -. startServer  VARNAME~ do.  NB. :: 0:
				(VARNAME) =: _1
				unmap_jmf_ :: 0: VARNAME
				ferase :: 0: VARNAME
			end.

		catch.
		end.

		server =: coname ''
	end.
	
	socket_handler_z_ =: socket_handler__server
	launch__server SCRIPTSTOOPEN
)

startServer =: verb define
	try.
		NB.  Open socket
		socket =. 0 pick sdcheck sdsocket ''
		
		NB.  Bind socket to any available port
		sdcheck sdbind socket ; AF_INET_jsocket_ ; '' ; 0 

		NB. Listen for connections (max 1)
		sdcheck sdlisten  socket , 1

		NB. Publish portno
		y =. 2 pick sdcheck sdgetsockname socket						

		NB.  Don't block when waiting for streams
		sdcheck sdasync server	

		1
	catch.
		y =. _1
		sdcleanup''
		0
	end.
)


socket_handler    =: verb define
	'readable writeable errors' =. sdcheck sdselect ''
	0 pick sdcheck sdaccept socket
    new =. (<'scriptsocket') conew&.>~ sdcheck :: _1:@:sdaccept&.> CHILDREN -.~ 's'(,":)&.>readable
	CHILDREN =: CHILDREN,new
	
)

socket_handler_z_ =: socket_handler

NB.verb define

NB.  while. SOCKNO e. sdcheck sdgetsockets ''
  
NB.)

coclass 'scriptsocket'
coinsert 'jsocket'

SOCKNO		=:  _1
SCRIPTS		=:  0 $ <''
SOCKSTRING  =:  ''

RECVMAX     =: <.2^16

create =: ]
destroy =: 3 : 'codestroy y [ sdcheck sdclose SOCKNO [ done__COCREATOR SCRIPTS' :: 0:
