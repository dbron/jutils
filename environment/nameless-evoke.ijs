NB. (((<,':') <@:, (a=.<z;1) <@:, (z=.0) <@:(;<) >@:(<^:(0=L.)@:,))`)  ("_) (`a)   NB.!!! no display
NB. '&' ("_) (`a) (((<,':') <@:, (a=.<z;1) <@:, (z=.,'0') <@:(;<) >@:(<^:(0=L.)@:,))`) `:6 (a`)  NB. re-assignment display crash  	

NB.  This works, but not as a stand-alone adverb.  Need to find
NB.  right parenthesation.
NB. '&' ("_) (`a) (((<,':') <@:, a <@:, z <@:(;<) >@:(<^:(0=L.)@:,))`) (`:6) ((a=.<1;~z=.,'0')`)  (`:6) 

a   =: <1;~z=:,'0'
inf =: "_
ga  =: `a
ag  =: a`
col =: ((<,':') <@:, a <@:, z <@:(;<) >@:(<^:(0=L.)@:,))`
ev  =: `:6


ne =: (inf (ga (col (ev (ag ev)))))