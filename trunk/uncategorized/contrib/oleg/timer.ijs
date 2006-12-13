NB. timer class
NB.
NB.    granularity is 1 msec
NB.
NB. names
NB.    v - (locale-qualified verb name)
NB.        both the handler and identifier of a timer element
NB.    vsync - the synchronizing exisiting other timer handler
NB.    TIMESTAMP - result form of ts=. 6!:0
NB.
NB. timer members (at index i)
NB.    i{VERBS_pt_ - handler and identifier of an event
NB.    i{STARTS_pt_ - when event was either set or last run
NB.    i{INTS_pt_ - timer before (next) triggering
NB.    i{TIMES_pt_ - times to run: 1 is single event, _1 is forever, etc.
NB.    i{PRI_pt_ - larger-first order to run simultaneous events
NB.
NB. author
NB.    "Oleg Kobchenko" <olegykj@yahoo.com>  -  05/27/2003

require 'dates'

coclass'pt'

reset=: 3 : 0
VERBS_pt_=:INTS_pt_=:TIMES_pt_=:STARTS_pt_=:PRI_pt_=:i.0
wd'timer 0'
erase'sys_timer_z_'
)

reset''
MSEC=: 1000%6!:8''
TSDIFF=: (tsrep@}: <.@- MSEC"_*{:) (6!:0,6!:9)''

now=: 3 : 'TSDIFF + MSEC <.@* 6!:9 i.0'

NB.*set v set timer
NB. form: v[;vsync] set_pt_ INTERVAL[,TIMES=_1[,PRIORITY=_1]]

set=: 4 : 0
'I T P'=. 3{.y,_1 _1
'V VS'=. 2{.boxopen x
i=.VERBS i. VB=.<V
if.(0=I) +. (i<:#VERBS) do.
  kill VB 
  if. 0=I do. return. end. end.
O=. \:PRI,P
   PRI=: O{PRI,P
 VERBS=: O{VERBS,VB
  INTS=: O{INTS,I
 TIMES=: O{TIMES,T
STARTS=: O{STARTS,sync <VS
sys_timer_z_=: handler_pt_
handler''
)

NB.*kill v kill timer
NB. form: kill_pt_ v

kill=: 3 : 0"0
if. (n=.#VERBS)>i=.VERBS i. boxopen y do.
p=. 0 i}n#1
   PRI=:p#PRI
 VERBS=:p#VERBS
  INTS=:p#INTS
 TIMES=:p#TIMES
STARTS=:p#STARTS
end.
if. 0=#PRI do.reset''end.
)

0 : 0 NB. timeline
T1 --------------------*-------------|-----?->
T2 -*-------------------------?------|------->
T3 ----*----------?----------?-------|---?--->
     START   START+INT              NOW
       ^-----------------------------^---^
                   ELAPSED            NEXT
)

handler=: 3 : 0
t=.now''
i=.(INTS<:e=.t-STARTS)#i.#STARTS            NB. [intervals <= elapsed]
(>i{VERBS) (128!:2"1 0) q=.<.e%&(i&{)INTS   NB. run with q=missed times
STARTS=: ( (i{STARTS) + (i{INTS)*q ) i } STARTS NB. adjust start by multiple of int
 TIMES=: (_1 >. <: i{TIMES) i } TIMES       NB. decr times
kill VERBS #~ 0=TIMES
wd'timer 0'
d=.>.<./INTS([-|)t-STARTS          NB. soonest next event
NB. smoutput d                     NB. ** uncomment to see next interval in sm
wd'timer ',":d
empty''
)

sync=: 3 : 'if. (#VERBS)>i=.VERBS i.y do. i{STARTS else. now i.0 end.'

NB.*resync v resync by other timer
NB. form: vsync resync_pt_ v

resync=: 4 : 0
if. (i=.VERBS i. boxopen y) >: #VERBS do. return. end.
STARTS=: (sync boxopen x) i } STARTS
empty''
)

NB.*repri v set new priority
NB. form: v repri_pt_ PRIORITY

repri=: 4 : 0
if. (i=.VERBS i. boxopen x) >: #VERBS do. return. end.
PRI=: y i } PRI
O=. \:PRI
   PRI=: O{PRI
 VERBS=: O{VERBS
  INTS=: O{INTS
 TIMES=: O{TIMES
STARTS=: O{STARTS
empty''
)

NB.*schedule v (re)schedule single event with a ts
NB. form: v schedule_pt_ TIMESTAMP

schedule=: 4 : 0
x set ((tsrep y)-now''),1
)

NB.*info v see info for single verb
info=: 3 : 0
if. (i=.VERBS i. boxopen y) >: #VERBS do. empty'' return. end.
(i{VERBS),(<1 tsrep i{STARTS),(<i{INTS),(<i{TIMES),(<i{PRI)
)

NB.*state v see summary for all verbs
state=: 3 : 0
r=. ,: ;:'verb_loc_ start interval times priority'
r,info"0 VERBS
)

NB. ================================================================

coclass'pttest'

qname=: 3 : 'y,''_'',(>coname i.0),''_'' '

create=: 3 : 0
wd'pc p;pn ',qname'p'
wd'xywh 24 16 40 60;cc c1 combolist;'
wd'xywh 24 36 40 60;cc c2 combolist;'
wd'xywh 24 56 40 60;cc c3 combolist;'
wd'xywh 74 16 30 10;cc e1 edit ws_border es_readonly;cn 0'
wd'xywh 74 36 30 10;cc e2 edit ws_border es_readonly;cn 0'
wd'xywh 74 56 30 10;cc e3 edit ws_border es_readonly;cn 0'
wd'xywh 4 76 220 120;cc es editm ws_border ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly rightmove bottommove'
wd'pas 6 6;pcenter;pshow'
s=.,LF,.~":,.0,250*2^i.4
wd'set c1 "',s,'";setselect c1 0'
wd'set c2 "',s,'";setselect c2 0'
wd'set c3 "',s,'";setselect c3 0'
wd'setfont es "Courier New" 11 default'
PH=: wd'qhwndp'
)

destroy=: 3 : 0
kill_pt_ <qname'e1inc'
kill_pt_ <qname'e2inc'
kill_pt_ <qname'e3inc'
wd'psel ',PH
wd'pclose'
codestroy''
)

p_close=: destroy

p_c1_select=: 3 : 0
wd'psel ',PH
n=. qname 'e',(1{syschild),'inc'
int=. 0".syschild~
(n;(-.syschild-:'c1')#m=.qname'e1inc') set_pt_ int,((?3){_1 20 30),?3
if. (syschild-:'c1') *. (int~:0) do.
  m resync_pt_ qname'e2inc'
  m resync_pt_ qname'e3inc'
end.
)
p_c2_select=: p_c3_select=: p_c1_select

show_state=: 3 : 0
wd'psel ',PH
wd'set es *',,LF,"1~":state_pt_''
)

e1inc=: 3 : 0
show_state''
v=.0".'e1'wdget wd'qd'
wd'set e1 ',":y+v
)
e2inc=: 3 : 0
show_state''
wd'set e2 ',":y+0".'e2'wdget wd'qd'
)
e3inc=: 3 : 0
show_state''
wd'set e3 ',":y+0".'e3'wdget wd'qd'
)

NB. ================================================================

coclass'base'

0 : 0 NB. tests
t1=:''conew'pttest'
info_pt_ 'e1inc_',(":>t1),'_'
t2=:''conew'pttest'
state_pt_''
)
