FAVORITES			=: 0 : 0
pc favorites dialog nomax nomenu nomin;pn "Open Favorite";
xywh 0 1 142 50;cc favs combodrop ws_vscroll rightscale;
pas 0 0;pcenter;pmovex $XYWH$;
rem form end;
)

NB.! Leave this line as is;  It is rewritten upon running this script 
NB.! and any other logic on this line will be destroyed.
XYWH=:  '749 838 234 53'

favorites_run		=: 3 : 0
	NB.  Replace $XYWH$ with current value of noun XYWH
	wd doString FAVORITES

	NB. Initialize with non-hidden verbs from FAVLOC locale
	wd 'set favs *', ; ,&LF&.> (/: lc&.>) h_getFavs__FAVLOC ''

	NB.  Go
	wd 'pshow;'
)

favorites_favs_button	=: verb define
	NB.  Leading and trailing spaces don't count
	input			=. trim favs

	NB.  Command is first element of ;: of input
	cmd				=.  {.@:(1&{.)@:;: input

	NB.  Params are seperated by spaces unless within quotes.
	NB.  Default param is ''
	parse			=.  -.&a:@:(<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' '
	params			=.  '' (*@:#@:] {:: [ ,&< parse@:]) input }.~ # > cmd

	NB.  Could just use 'nc'. but then I would have to be case-sensitive
	NB.  verb = nc < cmd =. cmd  , '_' envelope > FAVLOC_z_
	if. a: ~: cmd	=. cmd (i.~&:(lc&.>) { ,&a:@:]) h_getFavs__FAVLOC '' do.
		NB.  If the command is a valid verb in the correct locale (ignoring case), run it on the given input
		(; cmd , '_' envelope&.> FAVLOC)~ :: empty params

		NB.  Close form
		favClose ''
	else.
		NB.  If the command doesn't exist, highlight input and give user chance to fix it
		wdinfo 'Invalid command: Drop down combo box for list of valid favorite commands'
		wd 'setfocus favs'
	end.

	empty''
)

favClose			=:  verb define :: empty
	NB.  Find location of XYWH assignement in this file and replace it with current size/location
	myXYWH			=.  < 'XYWH=:  ' , ntt '_' sr '-' ": wd 'qformx'
	FAV_FILE__FAVLOC fwrite~ ; ,&CRLF each myXYWH [`(([: i.&1@:; 1&e.@:((;:'XYWH=:')&E.)@:;: each)@:])`] } }:^:(a:"_ -: {:) CRLF arbCut fread FAV_FILE__FAVLOC

	NB.  Close form
	wd 'pclose'
	empty''
)

NB.  ESC key dismisses dialog.  
favorites_cancel_z_	=: favorites_close_z_	=:  favClose




NB.------------------------------------------------------
NB.------------------FAVORITE FUNCTIONS------------------
NB.------------------------------------------------------
cocurrent FAVLOC_z_	=:  <'djbfavorites'

NB.  Save filename 
FAV_FILE	=:  (4!:4 {:: 4!:3) < 'FAVORITES_base_'

NB.  Prefix the name of any verbs you don't want exposed with HIDE_PREFIX.
NB.  EG:  h_foo	=:  ...
HIDE_PREFIX			=: 'h_'
h_getFavs			=: (#~ [: -. beginsWith_base_&HIDE_PREFIX&>) @: (namelist bind 3)

NB.  Just for testing
ztest				=: smoutput bind 'TEST SUCCESS'

NB.  Edit this file
ef					=:  open bind FAV_FILE
config				=:  open bind ('system\extras\config\config.ijs' ,~ 1!:40'')

cons				=:  rcons=:console=:rconsole=: verb define
	load 'b:\projects\work\order_manager\main\dev\rserver\default\rconsole.ijs'
	wd 'smprompt "rconsole ''" ', ''' 1' ,~ (*@:# {:: 'oms.local.test'&;) y.
)


NB.  Verbs for each workspace - have to use full name.
('.jws'&dropIfAppended_base_&.>@:{:@splitPath_base_&>  ".@:,&.> '=: loadWorkspace_base_ bind '&,@:(QUOTE_base_&enclose_base_)&.>) listFiles_base_ 'b:\data\srccode\j\workspaces\*.jws'

NB.  Shortcuts to various workspaces (i.e. use shortedned name).
".@:;"1 ({."1 ,. (<'=: loadWorkspace_base_ bind ''b:\data\srccode\j\workspaces\')"_ ,. {:"1 ,. (<'.jws''')"_ ) '=' makeTable_base_ noun define
acct=account_fields
clear=clearing_report
dba=dbagent
canrep=fix_canreps
mom=mom
rej=new_oms_rejections
oats=oats_report
path=oms_pathing
usdps=usdesk_position_server
mgps=maple_germany_ps
exchange=exchange
)

NB.  Shortcuts to various workspaces (i.e. use shortedned name).
".@:;"1 ({."1 ,. (<'=: loadWorkspace_base_ bind ''b:\data\srccode\j\workspaces\')"_ ,. {:"1 ,. (<'.jws''')"_ ) '=' makeTable_base_ noun define
acct=account_fields
clear=clearing_report
dba=dbagent
canrep=fix_canreps
mom=mom
rej=new_oms_rejections
oats=oats_report
path=oms_pathing
usdps=usdesk_position_server
mgps=maple_germany_ps
sac=sac
trdrec=trdrec
trd=trdrec
rec=trdrec
mdf=mdf
fids=fids
)


NB.  Shortcuts to all OMS scripts
require 'dir'
".@:;"1@:(((_1: = nc)@:] # (,. '=: open bind '&, @:(QUOTE_base_&envelope_base_)&.>)~) (((}.~ >:@:i:&'\')@:{.~ i:&'.')&.>))@:({."1)@:dirtree 'b:\projects\work\order_manager\main\dev\OMS\default\*.ijs'


NB.  Start an OMS.  Config is "NULL" by default
oms					=: verb define
	load_base_ 'b:\projects\work\order_manager\main\dev\OMS\default\ordermanager.ijs'
	OMS_base_ 'Null' (*@:#@:] {:: ;) y.
)

pbng				=: verb define
   load'b:\data\srccode\j\prison_bitch_name_generator.ijs'
   pbng_base_''
)

NB.  Run form
favorites_run_base_''
