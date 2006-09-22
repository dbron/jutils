require 'dates strings'

SESSMAN=: 0 : 0
pc sessman;
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
xywh 276 124 12 10;cc ok button leftmove topmove rightmove bottommove;cn "K";
xywh 290 124 12 10;cc cancel button leftmove topmove rightmove bottommove;cn "x";
xywh 4 1 300 119;cc SESS richeditm es_readonly rightmove bottommove;
xywh 4 124 269 11;cc USRLINE edit topmove rightmove bottommove;
pas 6 6;pcenter;
rem form end;
)

doString		=: ;@:(":&.>)@:($&0 1@:# ".&.>@:]^:([`[`])"0 ])@:(<;._2)@:,&'%'
cleanNoun		=: }:@:;@:(,&LF@:dlb&.>)@:(LF&cut)@:((TAB;' ')&charsub)@:}:@:toJ

rtf_COLOR_TABLE =: cleanNoun noun define
	{\colortbl\red0\green0\blue0;\red255\green0\blue0;\red0\green128\blue0;\red100\green19\blue55;}
)


here_now =: isotimestamp@:(6!:0)
now =: 3 : 0
	y {.~ '.' i:~  y =. y }.~ >: ' ' i.~ y
)

rtf_PREAMBLE=: doString cleanNoun noun define
	{
	{\fonttbl{\f0\fcourier Courier New;}}
	%rtf_COLOR_TABLE%
	}
)

MAX_LINE_COUNT =: 5
LINES =: 0$a:

sess_append =: 3 : 0
	wd 'setselect  SESS _1 _1 0'
	wd 'setreplace SESS *',y
)

log_append =: 3 : 0
	if. -. 0 -: nc {.;:'FH' do.
		FH =: 1!:21 <jpath '~temp\session-','.log',~('0123456789' e.~ a)} '-',:a=.here_now''
	end.

	FH 1!:3~  k=: ,,&CRLF"1>(,. TAB&,.)&.>/ Y_z_ =: ,:^:(2 - #@:$)@:": each y
)


sess_reset =: 3 : 0
	wd 'set SESS *',rtf_PREAMBLE
)

sess =: 3 : 0
  0 sess y
:

	TIME =. now date_time =. here_now ''
	log_append date_time;x;y
	sess_append a=.(doString '{%rtf_COLOR_TABLE% [%TIME%]  '),('\cf',(":x),' ',( ('\b '#~x=2) , y)), '\par }'
	LINES =: LINES , < a

	if. MAX_LINE_COUNT<#LINES  do.
		sess_reset ''
		sess_append ;(-MAX_LINE_COUNT){.LINES  
		LINES =: 0 $ a:
	end.

)


sessOut  =:   0&sess
sessErr  =:   1&sess
sessIn   =:   2&sess
sessOthr =:   3&sess


sessman_run=: 3 : 0
	wd SESSMAN
	sess_reset ''
	log_append 'TIME';'CHANNEL';'MSG'
	sessOthr 'Welcome to your session'
	wd 'pshow;'
)

sessman_close=: 3 : 0
	if. 0 -: nc {.;:'FH' do.
		1!:22 FH
		erase{.;:'FH'
	end.
	wd'pclose'
)

sessman_cancel_button=: 3 : 0
	sessman_USRLINE_clear''
)

sessman_USRLINE_clear =: 3 : 0
	wd 'set USRLINE'
	wd 'setfocus USRLINE'
)
sessman_USRLINE_button=: 3 : 0
	sessman_ok_button''
)

sessman_ok_button=: 3 : 0
	sessIn USRLINE
	
	'rc rt' =: (0 ,&:< ]&.:".) :: ((13!:11 ,&:< 13!:12) bind '')  USRLINE
	if. rc = 0 do.
		sessOut	rt
	else.
		sessErr (<:rc){::9!:8''
	end.

	sessman_USRLINE_clear ''
)


sessman_run''
