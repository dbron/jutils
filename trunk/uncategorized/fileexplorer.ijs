load 'files'
load 'misc'

TEST=: 0 : 0
	pc test;
	xywh 14 6 34 11;cc fileOpen button;cn "Open";
	xywh 6 32 50 50;cc fileDisplay editm ws_border es_autovscroll;
	pas 6 6;pcenter;
	rem form end;
)

test_run=: 3 : 0
	wd TEST
	NB. initialize form here
	wd 'pshow;'
)

test_close=: 3 : 0
	wd'pclose'
)

test_fileOpen_button=: 3 : 0

	params =: ' "" "" "" "Text(*.txt)|*.txt" ofn_filemustexist'

	fileName =: wd 'mbopen ' , params

	text =: , ": 1!:1 < fileName 

	if. 0 ~: #fileName do.
		wd 'set fileDisplay *', text
	end.
)