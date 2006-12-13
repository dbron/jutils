NB.  File:  SocketServer.ijs
NB.  Desc:  Open a socket and listen for connections.  
NB.         On connect transfer to new socket and start streaming data
NB.  Auth:  Daniel Bron
NB.  Date:  02-Oct-2001 (Tues)

NB.  To do:  
NB.
NB.     *  Find out why checkServer throws unsuccessful assertion errors
NB.        (this may be because of timing issues - sync will not work unless 
NB. 	   there already exists a connection).
NB.
NB.     *  Find out when and how to close a connection gracefully.     

	load 'socket'
	
	clean =:  sdcleanup ''						NB.  Free up unused networking resources
	
	openSocket =: verb define
	NB.  This just returns a new socket

		socket =. 0 pick sdcheck sdsocket y
)

	closeSocket =: verb define
	NB.  Close and free up a socket.  Simply an alias for sdclose.
		
		socket =. y

		sdcheck sdclose socket
)
	
	bindSocket =: 4 : 0
	NB.  Bind a socket to a port

		socket =. x 
		port =. y

		sdcheck sdbind socket ; AF_INET_jsocket_ ; '' ; port
)

	listenOnSocket =: verb define
	NB.  Start listening for connections on the socket/port

		socket =. y
		maxConnections =. 1						NB.  This should be generalized.
		sdcheck sdlisten  socket , maxConnections
)

	a_syncSocket =: verb define
	NB. Do NOT block while waiting for connections or data
		
		server =. y
	
		sdcheck sdasync server	
)


	acceptConnection =: verb define
	NB.  Start accepting connections on the socket/port
		
		socket =. y

		0 pick sdcheck sdaccept socket
)
	
	syncConnection =: verb define
	NB.  Make sure server and client are sync'd	

		server =. y
		assert server e. 1 pick sdcheck sdselect ''
)

	closeConnection =: verb define
	NB.  Just another alias for sdclose
		connection =: y

		sdcheck sdclose connection
)


	startServer =: verb define
	NB.  Open a socket, bind it to a port, listen for and accept connections asynchronesly
		
		port =. y

		acceptedSockets =: ''

		SOCKET_DATA  =: ''

		socket =. openSocket ''   				NB.  Open socket

		socket bindSocket port   				NB.  Bind socket to port

		listenOnSocket socket	 				NB.  Listen for connections

		a_syncSocket socket						NB.  Don't block when waiting for streams

NB.		thisSocket =: socket

		'Listening for connections'
)

	socket_handler=: verb define
	NB.  This executes when there is activity on open sockets.
	NB.  There are really only 2 cases to deal with: 
	NB.  	1)  When a connection FIRST comes in, it needs to be accepted.
	NB.		2)  When the client wants to send data
		smoutput y

		while. (# > 1 pick sdselect '') do.
			
			socketToProcess =. 0 } > 1 pick sdselect ''

			if. socketToProcess e. acceptedSockets do.
			NB.  If this is an already accepted connection, process its data.

				processSocket socketToProcess

			else.
				if. socketToProcess e. > 2 pick sdselect '' do.
				NB.  If the process has been accepted but not sync'd, sync it

NB.					syncConnection thisSocket											NB.  Sync with client
					'Connected to client'

				else.
				NB.  If this is a completely new connection, accept it

					acceptedSockets =: acceptedSockets, acceptConnection socketToProcess   	NB.  Start servering this socket, 
					 'Accepted connection' ; # acceptedSockets						NB.  and add it to the 'accepted sockets' list.

				end.
			end.
		end.
)

	processSocket =: verb define
		socket =: y

		data =. socket read 1000 				            NB.  Read stream
		
		'toProcess SOCKET_DATA' =: (({. ,&< }.)~ >:@:i.&LF) SOCKET_DATA,data

		socket write answer =. ". _1 }. toProcess		     NB.  Echo to client
		smoutput ((acceptedSockets i. socket) + 1) ;  answer NB.  Echo to IJX
)

	getClient =: verb define
	NB.  Return the socket that a particular client is on.

		clientNumber =. (y - 1)
		clientNumber  { acceptedSockets
)

	write =: 4 : 0
	NB.  Convert data in y to streamable form and write out to server (socket) x  
		
		client =. x
		data =. y
		flags =. 0								NB.  This should be generalized

		CLAMSCLAMS =: data =. CRLF,~ toStream data
		
		sdcheck  data sdsend client , flags
)

	read =: 4 : 0
	NB.  Read in y bytes of data from server (socket) x and convert data to normal format
		
		server =. x
		maxToRead =. y
		flags =. 0								NB.  This should be generalized
		
		fromStream ; sdcheck sdrecv server, maxToRead, flags
)


	toStream =: verb define
	NB.  Convert normal data to streamable form

		data =. y
		,"_ ": data
)

	fromStream =: verb define
	NB.  Convert streamed data to normal form

		data =. y
		": data
)