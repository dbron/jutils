require 'registry printf'

ie       =. 'Software\Microsoft\Windows\CurrentVersion\Internet Settings\'
acu      =. 'AutoConfigURL'
readonly =.  1

regfilt  =. (#~ (<0)&=)~/@:|:                     NB.  If the reg- call didn't succeed, return 0$a:

hives    =. HKEY_CURRENT_USER,HKEY_LOCAL_MACHINE  NB.  Sorted descending from most preferred location.
hnds     =.        regfilt hives regcreatekey @:;"_1 _ ie;readonly
proxy    =. > {. , regfilt hnds  regqueryvalue@:,"_1 _ <acu

resp     =. <;._2 TAB -.~ noun define
	Sorry, your proxy couldn't be determined.
	Your proxy is (or is determined by):\n\t%s
)

resp (({::~ 0~:#) printf <@:]) proxy