    NB.  15!:0  pads my argument with a  {.a.  so it seems _1+2^15 is the limit for this API call
   'SetEnvironmentVariable' win32apir 'HTTP_USER_AGENT';HTTP_USER_AGENT=:a{~?.(_2+2^15)##a=.'abcdefghijklmnopqrstuvwxyz'
1
   'SetEnvironmentVariable' win32apir 'HTTP_USER_AGENT';HTTP_USER_AGENT=:a{~?.(_1+2^15)##a=.'abcdefghijklmnopqrstuvwxyz'
0

   NB.  Whereas _4+2^15 seems the limit for its obverse.
  'SetEnvironmentVariable' win32apir 'HTTP_USER_AGENT';HTTP_USER_AGENT=:a{~?.(_4+2^15)##a=.'abcdefghijklmnopqrstuvwxyz'
1
   HTTP_USER_AGENT-:{.&>/0 2 {'GetEnvironmentVariable' win32api 'HTTP_USER_AGENT'; ($&' ' ; >:) #HTTP_USER_AGENT
1
   
  'SetEnvironmentVariable' win32apir 'HTTP_USER_AGENT';HTTP_USER_AGENT=:a{~?.(_3+2^15)##a=.'abcdefghijklmnopqrstuvwxyz'
1
   HTTP_USER_AGENT-:{.&>/0 2 {'GetEnvironmentVariable' win32api 'HTTP_USER_AGENT'; ($&' ' ; >:) #HTTP_USER_AGENT
0
   

	NB.  In setting a var, the value is the string up 
	NB.  to the first  {.a. 
   'SetEnvironmentVariable' win32apir 'foo';'bar','clams',~{.a.
1
   >{.'GetEnvironmentVariable' win32api 'foo'; ($&' ' ; >:) 400
3
   
   

	NB.  Setting a var using a null pointer (<0) causes
	NB.  the var to be erased
   >{.'GetEnvironmentVariable' win32api 'bar'; ($&' ' ; >:) 400
0
   'SetEnvironmentVariable' win32apir 'bar';'foo'
1
   >{.'GetEnvironmentVariable' win32api 'bar'; ($&' ' ; >:) 400
3
   'SetEnvironmentVariable' win32apir 'bar';(<<0)
1
   >{.'GetEnvironmentVariable' win32api 'bar'; ($&' ' ; >:) 400
0
   





   NB.  J's 2!:5 doesn't respect changes to the environment
   NB.  (changing existing, adding new, or deleting old vars)
   2!:5'PROMPT'
$P$G
  'SetEnvironmentVariable' win32apir 'PROMPT';'hello'
1
   2!:5'PROMPT'
$P$G

   2!:5'NEW_VARIABLE'
0
  'SetEnvironmentVariable' win32apir 'NEW_VARIABLE';'foo'
1
   2!:5'NEW_VARIABLE'
0

   2!:5'USERNAME'
dan
   'SetEnvironmentVariable' win32apir 'PROMPT';<<0  NB.  Erase
1
   2!:5'USERNAME'
dan
   



