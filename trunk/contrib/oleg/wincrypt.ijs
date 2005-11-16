NB. Windows API Cryptography
NB.     See MSDN for details
NB. J implementation -- (C) 2003 Oleg Kobchenko; 
NB.     GNU license; NO WARRANTY FOR ANYTHING

require 'dll convert'
coclass 'wincrypt'

or=: 23 b.
sh=: 33 b.
hexhash=: tolower@:,@:hfd@:(a.&i.)@:(>@(4&{) {. >@(3&{))

PROV_RSA_FULL=: 1
ALG_CLASS=: 13
ALG_TYPE=: 9
ALG_CLASS_HASH=: ALG_CLASS sh 4
ALG_TYPE_ANY=: ALG_TYPE sh 0
ALG_SID_MD5=: 3
CALG_MD5=: ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD5
HP_HASHVAL=: 2

AcquireContext=: {.@>@(1&{)@:('advapi32 CryptAcquireContextA i *i i i i i'&cd)
ReleaseContext=: >@{.@:('advapi32 CryptReleaseContext i i i'&cd)
CreateHash=: {.@>@{:@:('advapi32 CryptCreateHash i i i i i *i'&cd)
DestroyHash=: >@{.@:('advapi32 CryptDestroyHash i i'&cd)
HashData=: >@{.@:('advapi32 CryptHashData i i *c i i'&cd)
GetHashParam=: hexhash@:('advapi32 CryptGetHashParam i i i *c *i i'&cd)

md5=: 3 : 0
CC=. AcquireContext (,_1);0;0;PROV_RSA_FULL;0
H=. CreateHash CC;CALG_MD5;0;0;(,_1)
HashData H;y.;(0 or #y.);0
P=. GetHashParam H;HP_HASHVAL;(20#'z');(,20);0
DestroyHash H
ReleaseContext CC;0
P
)

NB. Run with Ctrl+R
0 : 0
   (>,. '='"_,. md5_wincrypt_&>@]) '';(,'a');'abc';'message digest'
              =d41d8cd98f00b204e9800998ecf8427e
a             =0cc175b9c0f1b6a831c399e269772661
abc           =900150983cd24fb0d6963f7d28e17f72
message digest=f96b697d7cb7938d525a2f31aaf161d0
   
   (,:md5_wincrypt_) (i.26)&+&.(a.&i.)'a'
abcdefghijklmnopqrstuvwxyz      
c3fcd3d76192e4007dfb496cca67e13b
   
   (,:md5_wincrypt_) a.{~(a.i.'Aa0');@:(<@(+i.)"0) 26 26 10
ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
d174ab98d277d9f5a5611c2c9f419d9f                              
   
   (,:md5_wincrypt_) 80$'1234567890'
12345678901234567890123456789012345678901234567890123456789012345678901234567890
57edf4a22be3c955ac49da2e2107b67a                                                
)
