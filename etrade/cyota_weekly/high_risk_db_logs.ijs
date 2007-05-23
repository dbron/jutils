require 'strings task csv'

risk_ach_script =: noun define
	export proxy_domn=CORP
	export proxy_user=dbron
	export proxy_pass=w00t\!W00T\!33
	export proxy_host=10.22.79.250
	export proxy_port=8080

	export http_proxy=http://$proxy_domn\\$proxy_user:$proxy_pass@$proxy_host:$proxy_port/
	export https_proxy=$http_proxy

	export etrade_file=http://logscan1m3.corp.etradegrp.com/risk/daily/links/risk_ach_payment.txt
	export post_params="TARGET=\$SM\$$etrade_file&USER=$proxy_user&PASSWORD=$proxy_pass&submit=Log On"

	export form_host=genie.corp.etradegrp.com
	export form_action=/fcc/login_corp.fcc

	export ck=cookies.txt
	export pf=post-data-file.txt

	echo -n $post_params>$pf

	wget --save-cookies $ck --keep-session-cookies --post-file $pf -O - https://$form_host$form_action
    rm $ck $pf
)

risk_wire_script =: ('ach';'wire') stringreplace risk_ach_script

verid =: noun  define
	# wget --save-cookies cookies.txt --keep-session-cookies --save-headers --http-user='andrew.wen@etrade.com' --http-password='1Dv3r1f1cat10n!' -O - 'https://netview.verid.com/transact/ViewArchiveReport.do'

	#export http_user=andrew.wen@etrade.com
	#export http_pass=1Dv3r1f1cat10n\!
	#wget --save-cookies $ck --keep-session-cookies --http-user=$http_user --http-password=$http_pass -O - https://netview.verid.com/transact/ViewArchiveReport.do
)

bash =: verb define
    NB.y bash~ 'C:\cygwin\bin\bash.exe --login -i';'C:\cygwin\bin\'
    y bash~ 'C:\cygwin\bin\bash.exe --login'NB.;'C:\cygwin\bin\'
:
	NB. y =. 'unset `set | grep ''^PS[0-9]\+='' | sed ''s/^\(PS[0-9]\+\)=.*/\1/''`',LF,y
    y =. (<,LF)-.~ (#~ '#' ~: {.&>) <;.2 ; (trim@:}: , {:)&.> <;.2 y
    NB. y =.   (' 2>/dev/null';' |/dev/null') ( (;@:[ ((,~ }:) , {:@:]) L: 0 }:@:]) , ;@:{.@:[ ((,~ }:) , {:@:]) L: 0 {:@:] )  y
	y =.   (,<' 2>/dev/null') ( (;@:[ ((,~ }:) , {:@:]) L: 0 }:@:]) , ;@:{.@:[ ((,~ }:) , {:@:]) L: 0 {:@:] )  y
	y   =.  ;y
    z =. y spawn x
	NB.z ,&<  y
	z 
)

ach_comma    =:  bash risk_ach_script
wire_comma   =:  bash risk_wire_script
ACH          =:  fixcsv  ach_comma
WIRE         =:  fixcsv  wire_comma

CLIP_ON =: 0
clip^:CLIP_ON CRLF join <@:}:@:;"1 TAB (,~ trim@:":) L: 0  }: ACH
clip^:CLIP_ON CRLF join <@:}:@:;"1 TAB (,~ trim@:":) L: 0  }: WIRE