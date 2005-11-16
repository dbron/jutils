   CreateProcessAsUserA
  LogonUserA 

CONSTA =: (,. }:&.>)/|: '=' makeTable noun define
LOGON32_LOGON_INTERACTIVE = 2,
LOGON32_LOGON_NETWORK = 3,
LOGON32_PROVIDER_WINNT50 = 3,
LOGON32_PROVIDER_DEFAULT = 0,
LOGON32_LOGON_BATCH = 4,
LOGON32_LOGON_SERVICE = 5;
)

'=:' ".@:join "1 CONSTA

LogonUser =: 'Advapi32 LogonUserA i *c *c *c i i i'&15!:0 
CreateProcessAsUser =: 'CreateProcessAsUserA'win32api



CLAMS =: LogonUser 'danielb' ;'mapleusa';'R2$fQ1Q1';LOGON32_LOGON_BATCH ;LOGON32_PROVIDER_DEFAULT ;0
