NB.  == Fetch ===
L    =:  'C:\Documents and Settings\dbron\apama-work\studio_workspace\cme\POC\performance\4a1-1000-3000-180\'
F    =:  <;._1 ' client-output-20090319_165637 correlator_20090319_165614 mpstat-20090319_165614 mpstat-20090319_165637 watch-20090319_165637'

(Ls) =: cocreate&.> a:#~#Ls   =: ;:'cli corr mp1 mp2  wat'
('D__',L:0 Ls)=:L fread@:,L:0 F,L:0'.log'
3 : 'coinsert__y <''base'''@".&> Ls
3 : 'coinsert__y <''mp'''@:".&> ;: 'mp1 mp2'

NB.  == Parse ==
require'regex'
parse =: }."1@:(rxmatches rxfrom ])
ex =: <@:>"1@:|:@:parse
Ex =: 3 : '(cols) =: rx ex D'


NB.  --Client log--
rx__cli   =:  '\[java\] main: Enque \[(\d+),(\d+)\] events @ ([^.]+)\. Latency EWMA = (\d+) us, event rate over last second=(\d+) ev/s'
cols__cli =:  ;:'priorQd toQ dt latEWMA erls'
Ex__cli ''

NB. --Correlator Log--
rx__corr    =:  '([0-9:. -]+)INFO  \[(\d+)\] - Status: sm=(\d+) nctx=(\d+) ls=(\d+) rq=(\d+) eq=(\d+) iq=(\d+) oq=(\d+) rx=(\d+) tx=(\d+) rt=(\d+) nc=(\d+) vm=(\d+)'
cols__corr =:  ;:'dt unk sm nctc ls rq eq iq oq rx tx rt nt vm'
Ex__corr ''

NB.--mpstat--
rx_mp_     =: 1 ; (1 ,8#0) ; (1) 10 15 23 31 39 47 55 63 71 81} 82#0
parse_mp_  =: [: ,/ [ <;.2 (_11) 2&}.\ 1 }. ];._2@:]

NB. --Engine Watch--
wc=:noun define
Uptime(ms):                  3781
Number of monitors:          0
Number of sub-monitors:      0
Number of java applications: 0
Number of listeners:         0
Number of sub-listeners:     0
Number of event types:       0
Events on input queue:       0
Events received:             0
Events processed:            0
Events on internal queue:    0
Events routed internally:    0
Number of consumers:         0
Events on output queue:      0
Output events created:       0
Output events sent:          0
)

rx__wat    =:    '(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+),(\d+)'
cols__wat  =: ;: 'up    mon   subm  java  ls    sls   et    iq    rx    px    iiq   ri    con   oq    ec     tx   dt' 
