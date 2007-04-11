NB.  Raul Miller's fixed-width-to-delimited from 
NB.  http://www.jsoftware.com/pipermail/programming/2007-February/005054.html
NB. other SPACE DELIM
s         =:  0 10#:10*".;._2]0 :0
      2.1   0.0   1.1  NB. 0: skipping initial whitespace
      2.2   0.3   1.2  NB. 1: found delimiter
      2.0   3.2   1.2  NB. 2: found non-whitespace
      2.2   3.0   1.1  NB. 3: potentially trailing whitespace
)

fw2dl     =:  (1;s;(a.=' ')+2*a.e.LF,TAB)&;: