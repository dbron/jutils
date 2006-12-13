NB.  This is the earliest example of a J quine I could find.  

NB.  Author:    Josh ? <josh@cs.rutgers.edu>
NB.  Date:      1999-Oct-02 (Saturday).  This is the date of modification of the source URL.
NB.  Source:    Web
NB.  Ref:       http://www.nyx.net/~gthompso/self_j.txt
NB.  Ref-date:  Available as of 2004-Jan-16 (Friday)
QUINE_0 =: trim CRLF -.~ noun define
	".a=.'''".a=.'',q,q,~a#~1+a=q=.39{a.' 
)



NB.  The idea for this quine is to create a function that produces its input concatenated
NB.  with its input in single quotes. Since literal constants in J are specified by
NB.  enclosing them in single quotes, the quine is effected by passing the function to
NB.  itself as literal input.  My modifications do not change the scheme, they just make
NB.  the quine shorter and cleaner.

NB.  Author:    Jose Quintana <Jose.Quintana@cdcinvestments.com>
NB.  Date:      2001-Feb-02 (Tuesday)
NB.  Source:    JForum
NB.  Ref:       http://peach.ease.lsoft.com/scripts/wa.exe?A2=ind0205&L=jforum&T=0&F=&S=&X=2DB1C8228188306C84&Y=danielb%40mapleusa%2Ecom&P=49
NB.  Ref-date:  Available as of 2004-Jan-16 (Friday)
QUINE_1a =: trim CRLF -.~ noun define
	(],((39{a.)"_),],((39{a.)"_))'(],((39{a.)"_),],((39{a.)"_))'
)

NB.  Modifications:    Daniel Bron <dbron@dbron.net>
NB.  Date:             2004-Jan-14 (Wednesday)
QUINE_1b =: trim CRLF -.~ noun define
	(,(39{a.)&(,,[))'(,(39{a.)&(,,[))'
)



NB.  The idea for this quine is to create an executable file that prints its own contents.
NB.  These quines only work when stored as scripts (i.e. they do not work in J's immediate
NB.  execution window).  The original quine only works if it is stored in a script called
NB.  'foofile'.  My modifications allow the file to be stored with any name.  Note that the
NB.  nature of the quine allows us to make other quines of arbitrary length or complexity
NB.  (because any script that executes these lines will print its entire contents).

NB.  Author:    Nollaig MacKenzie <nollaig@amhuinnsuidhe.cx>
NB.  Date:      2002-May-01 (Wednesday)
NB.  Source:    JForum
NB.  Ref:       Unavailable
NB.  Ref-date:  Not applicable
QUINE_2a =: trim CRLF -.~ noun define
	(".'1!:1 <''foofile''') 1!:2 (2)  NB.  Assumes the file is stored with the name 'foofile'
)

NB.  Modifications:    Daniel Bron <dbron@dbron.net>
NB.  Date:             2004-Jan-14 (Wednesday)
QUINE_2b =: trim CRLF -.~ noun define
	2 (1!:2)~ 1!:1 (3 : '(4!:3''''){~4!:4<''y''' '')
)