MATRIX=: 0 : 0
pc matrix closeok dialog nomax nomenu nomin nosize owner;
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
xywh 136 8 44 12;cc increment button;cn "+1";
xywh 137 40 44 12;cc close button;cn "Close";
xywh 136 24 44 12;cc reloaded button;cn "Reload";
xywh 8 9 124 43;cc counter static;cn "counter";
pas 6 6;pcenter;
rem form end;
)

matrix_run=: 3 : 0
	wdreset''
	wd MATRIX
	NB. initialize form here
	wd 'set counter ',":COUNTER =: 0
	wd 'pshow;'
)

matrix_close=: 3 : 0
	wd'pclose'
)

matrix_close_button=: 3 : 0
	matrix_close''
)

matrix_reloaded_button=: 3 : 0
	smoutput 'hi'
	staph=.12
	(smoutput ] load) (4!:4<'staph') { 4!:3$0
	smoutput 'bye'
)


matrix_increment_button=: 3 : 0
	wd 'set counter ',":COUNTER=:>:COUNTER	
)

wdinfo 'Setting counter to zero (this msg only occurs on load)'
matrix_run''