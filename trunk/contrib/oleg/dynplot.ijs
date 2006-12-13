NB. dynplot - multiwindow independent animations
NB. load and run this script to start

require 'plot'

coclass 'ptimer'

LIST=: ''
BASE_INTERVAL=: 333

reset=: 3 : 0
erase'sys_timer_z_'
wd'timer 0'
)

reset''

create=: 3 : 0
'FN INTERVAL'=: 2{.boxopen y
if. a:=INTERVAL do. INTERVAL=: BASE_INTERVAL end.
LIST_ptimer_=: LIST (-. , ]) coname''
sys_timer_z_=: timer_ptimer_
wd'timer ',":INTERVAL
)

destroy=: 3 : 0
LIST_ptimer_=: LIST -. coname''
if. 0=#LIST_ptimer_ do. reset'' end.
codestroy''
)

timer=: 3 : 0
for_i. LIST do. FN__i~ '' end.
)

coclass 'pdynplot'

DP=: 0 : 0
pc dp;
xywh 0 0 200 200;cc g0 isigraph rightmove bottommove;
xywh 1 202 131 16;cc t0 trackbar topmove rightmove bottommove;
xywh 135 204 28 10;cc bLoop button leftmove topmove rightmove bottommove;cn "Loop";
xywh 167 204 28 10;cc bClone button leftmove topmove rightmove bottommove;cn "Clone";
pas 0 0;
rem form end;
)

create=: 3 : 0
wd DP
SIZE=: 10 [ OFFS=: 0 [ TIMER=: ''
pl=: conew 'jzplot'
  PForm__pl=: 'dp'
  PFormhwnd__pl=: wd 'qhwndp'
  PId__pl=: 'g0'
draw''
wd 'pshow;'
)

destroy=: 3 : 0
if. #TIMER do. destroy__TIMER'' end.
wd'psel ',PFormhwnd__pl
wd'pclose'
destroy__pl''
codestroy''
)

dp_close=: destroy

draw=: 3 : 0
'density;labelfont arial 40' plot__pl 7|i.2#2+4* OFFS
wd 'pn *dp ',": OFFS
wd 'set t0 0 ',(":OFFS),' ',(":SIZE-1),' 1 1'
)

loop=: 3 : 0
draw OFFS=: SIZE|OFFS+1
)

dp_t0_button=: 3 : 0
draw OFFS=: ".t0
)

dp_bLoop_button=: 3 : 0
if. #TIMER do.
  TIMER=: '' [ destroy__TIMER''
  wd'setcaption bLoop *Loop'
else.
  TIMER=: ('loop_',(>coname''),'_')conew'ptimer'
  wd'setcaption bLoop *Stop'
end.
)

dp_bClone_button=: 3 : 0
''conew'pdynplot'
)

dp_bClone_button''

