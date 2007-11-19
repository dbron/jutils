NB.  Anonymous evoke (or nameless evoke).
NB.
NB.  Adverb that takes a string argument and "evokes" it as J code.
NB.  	*  Like  'm'~   but doesn't require the code to be assigned to 
NB.  	   a name first (like  m  ).
NB.
NB.  	*  Like  ".'code...'  but can return any part of speech.
NB.
NB.  	*  Like  gerund 5!:0  or  gerund`:6  but doesn't require 
NB.  	   a (usually hand-crafted)  gerund.  The argument is simply 
NB.  	   a string of J code.
NB.
NB.  More strictly speaking  m ae  is equivalent to:
NB.
NB.    (1) 1 : (m"_ (1) )  NB.  There is some normalization of  m  first.
NB.
NB.  That is, it is not tacit; it invokes the explicit interpreter by 
NB.  using  :  .  So technically  'u' ae  should   return the global 
NB.  value of  u  (or an undefined verb is  u  is not defined globally),
NB.  but it doesn't.  It returns the argument to the adverb; that is,
NB.  1  .  OTOH, it lets you use control words.
NB.   
NB.  Examples:
NB.
NB.	     1: '@:' ae 2:
NB.	  1:@:2:
NB.
NB.	     + '/' ae 1 2 3
NB.	  6
NB.  
NB.	     '+/ % #' ae i. 10
NB.	  4.5
NB.
NB.	     'a:' ae
NB.	  ++
NB.	  ||
NB.	  ++
NB.
NB.	     '97 101 { a.' ae
NB.	  ae
NB.  
NB.	     'if. 0 do. ''hello'' else. ''world'' end.' ae
NB.	  world
NB.
NB.  As a one-liner:
NB.  	ae =: ("_) (`a) (((<,':') <@:, a <@:, z <@:(;<) ,&>@:,@:(<^:(0=L.)))`) ev    ((a=.<1;~z=.,'0')`)ev=.`:6
NB.  	ae =: ("_) (`a) (((<,':') <@:, a <@:, z <@:(;<) ,&>@:,@:(<^:(0=L.)))`) (`:6) ((a=.<1;~z=.,'0')`) (`:6)
NB.  
NB.  As a truly nameless one liner:
NB.  	ae =: ("_) (`(<1;~,'0')) (((<,':') <@:, (<1;~,'0') <@:, (,'0') <@:(;<) ,&>@:,@:(<^:(0=L.)))`) (`:6) ((<1;~,'0')`) (`:6)

a   =. <1;~z=.,'0'
inf =. "_
ga  =. `a
ag  =. a`
col =. ((<,':') <@:, a <@:, z <@:(;<) ,&>@:,@:(<^:(0=L.)))`
ev  =. `:6

ne  =. inf ga col ev ag ev

ae  =: 'ne' f.

