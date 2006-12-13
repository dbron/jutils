NB.  File:  SocketClient.ijs
NB.  Desc:  Open a socket and create a connection to a server.  
NB.  Auth:  Daniel Bron
NB.  Date:  02-Oct-2001 (Tues)

NB.  To do:  
NB.
NB.		* Find a way to pass the raw socket connection
NB.
NB.     * Find out why checkClient throws unsuccessful assertion errors
NB.       (this may be because of timing issues - sync will not work unless 
NB. 	   there already exists a connection).


	require 'socket'

	clean =: sdcleanup ''						NB.  Free up unused networking resources

	getHost =: verb define
	NB.  Convert a user-friendly computer name to an IP address

		hostname =. y
		sdcheck sdgethostbyname hostname
)

	localhost =: 'localhost'					NB.  User-friendly name of this computer
	getLocalHost =: getHost localhost			NB.  Get IP of this computer


	createClient =: verb define
	NB.  Like in the server script, this opens a socket.  
    NB.  The useless y calculation is just to satisfy J's 
    NB. requirement that verbs use their parameters.
	
		client =. 0 pick sdcheck sdsocket''	
		y =. y + 3
		client
	
)

	a_syncSocket =: verb define
	NB. Do NOT block while waiting for connections or data

		client =. y
	
		sdcheck sdasync client
)

	syncClient =: verb define
	NB.  Make sure server and client are sync'd	

		client =. y
		
		assert client e. 0 pick sdcheck sdselect ''
)

	startLocalClient =: verb define
	NB.  Create an a-synchronous connection to a port on the local machine.

		numConnections =: 0
		
		port =. y

		client =. createClient 0					NB.  Open a socket

		sdcheck sdconnect client ; getLocalHost , < port	NB.  Get connection to port on local machine

NB.		syncClient client							NB.  Sync with server
		
		a_syncSocket client							NB.  Don't block waiting for a connection

		thisClient =: client

		client

)

	socket_handler =: verb  define
	
		if. numConnections = 0 do.
		NB.  Opening connection to server
			
			numConnections =: 1
			
			'Connected to server'
		else.
		NB.  Procedure to handle streans(echo to IJX)
			
			thisClient read 1000
		end.
)

	closeClient =: verb define
	NB.  Close an open socket.  Just an alias for sdclose
		
		client =: y
		
		sdcheck sdclose client
)

	write =: 4 : 0
	NB.  Convert data in y to streamable form and write out to server (socket) x  
		
		client =. x
		data =. y
		flags =. 0								NB.  This should be generalized

		data =. toStream data
		
		sdcheck data sdsend client , flags
)

	read =: 4 : 0
	NB.  Read in y bytes of data from client (socket) x and convert data to normal format	

		client =. x
		maxToRead =. y
		flags =. 0								NB.  This should be generalized
		
		fromStream ; sdcheck sdrecv client, maxToRead,flags
)

	toStream =: verb define
	NB.  Convert normal data to streamable form
	
		data =. y
		3!:1 data
)

	fromStream =: verb define
	NB.  Convert streamed data to normal form

		data =. y
		3!:2 data
)
