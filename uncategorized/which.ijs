NB.  which 

require 'registry winapi dll'
require '~user\util\uncategorized\contrib\paul_chapman\ats.ijs'

3 : 0 ''

	REG_PATH_KEY		=: 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths'
	REG_QUERY_INFO_KEY	=: 'RegQueryInfoKeyA' win32api 
	REG_ENUM_VALUE		=: 'RegEnumValueA' win32api 

		NB.  Need MAX_PATH to initialize buffers.
		if. -. 0 -: nc {. ;: 'MAX_PATH_which_' do.
			NB.  Try to find the 'real' max path on the system (use winconst)
			if. * # d =. winconst 'MAX_PATH'[ require'winapi' do.
				MAX_PATH_which_ =:  > {: , d
			elseif. -. _1 -: data =. fread fn=.'C:\Program Files\Microsoft Visual Studio\VC98\CRT\SRC\STDLIB.H' do.	
				NB.  If not defined in winconst, try reading stdlb.h
				NB.  Look for "#define _MAX_PATH"s
				NB.  and take the minimum value (which is safest, since we don't know which #define is in effect).

				NB.load '~system\main\defs\build\sym2ijs.ijs'
				NB.  fn sym2ijs 'which_const.ijs'
				MAX_PATH_which_ =: <./ 0 ". {.&.:;:&> a: -.~ 1 { |: a: ,.~ ('#define _MAX_PATH'&arbCut)@:trim &> LF arbCut data
			elseif. 1 do.
				NB.  Default to a reasonable number.
				MAX_PATH_which_ =:  <. 2^8
			end.

	end.
)

whichwhichywhich=: verb define

   NB.  If no extension is given in y (a: -: {: '.' split y), then use 
   NB.  the executable extensions from the PATHEXT env variable.
   doota =: >,'PATHEXT' {@:(,&:< '\'&appendIfNotPresent&.>)&:(';'&slice)&:(2!:5) 'PATH'  
   hoota =: <@:;"1 ] 3 A.&.|: doota ,. <y
   poota =: fexist&> hoota
   poota # hoota

	NB.  Also want to look in 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\'
	NB.  which is the registry equivalent of the 'PATH' environment variable.
	NB.  If extension is given in y, use it, else just prefixPath y with the subkey enumeration.
	if. 0 -: > {. 'ok handle' =. regcreatekey HKEY_LOCAL_MACHINE;'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths';1 do.

			MAX_KEY_LENGTH_which_ =: 255
			MAX_VALUE_NAME_which_ =: 16383

			achClass =. mema MAX_PATH_which_ # ' '
			cchClassName =.mema  MAX_PATH_which_
			reserved	=. NULL =. 0
			cSubKeys=.mema 0
			cbMaxSubKey=.mema 0
			cchMaxClass=.mema 0
			cValues=.mema 0
			cchMaxValue=.mema 0
			cbMaxValueData=.mema 0
			cbSecurityDescriptor=.mema 0
			lpftLastWriteTime =. mema 0 0
			handle

		end.

)


NB.  DJB 2004-Dec-27
enumerateSubKeys=:verb define
)










NB.  SKip gthe rest of this



getRegPathKeyHandle =:  verb define
NB.'Couldn''t get handle for reg key
'rt hnd' =. regcreatekey 1 (, <)~ (". partition }. ~ i.&'\') REG_PATH_KEY 

recode =. REG_QUERY_INFO_KEY hnd ;(MAX_PATH_which_#' ');MAX_PATH_which_;0;0;0;0;0;0;0;0;0 0
)











NB.normalizeSpaces		=.    (' '&collapseMultiples    trim    (TAB,LF) msr '  ' ) ats
normalizeSpaces		=.    ' '&collapseMultiples@:trim@:((e.&(TAB,LF))`(,:&' ') }) 
trimmy		        =.    + 1 : ( ('(9 32{a.)';parenclose ntt '';');') replace trim f. vtt)
parseCDef			=.    (   (, [: < _2&(]\))&>/    <@:trimmy@:,"_1     }:&.:|:     '( ,'&multiCut normalizeSpaces ) ats

CJmap				=.  '=' makeTable noun define
	LONG      =  i
	HKEY      =  i
	LPTSTR    = *c
	LPDWORD   =  i
	PFILETIME = *i
)

cTojDef				=.  ;:^:_1@:(,&'A'&.>@:(1&{) , (CJmap&map)@:({. , {."1@:>@:(2&{)))@:parseCDef
PORKENDOOFY=: + 1 : (parenclose cTojDef	f. vtt)

callC				=.  2 : ('(m (, '' ''&,@:' , (parenclose cTojDef f. vtt) , ' ) n)&cd')

NB. 'Advapi32' callC (noun define)
NB.	LONG RegQueryInfoKey
NB.	( HKEY hKey,
NB.	  LPTSTR lpClass,
NB.	  LPDWORD lpcClass,
NB.	  LPDWORD lpReserved,
NB.	  LPDWORD lpcSubKeys,
NB.	  LPDWORD lpcMaxSubKeyLen,
NB.	  LPDWORD lpcMaxClassLen,
NB.	  LPDWORD lpcValues,
NB.	  LPDWORD lpcMaxValueNameLen,
NB.	  LPDWORD lpcMaxValueLen,
NB.	  LPDWORD lpcbSecurityDescriptor,
NB.	  PFILETIME lpftLastWriteTime
NB.	  );
NB.)

NB. 'Advapi32' callC (noun define)
NB.	LONG RegEnumValue
NB.	( HKEY hKey,
NB.	  DWORD dwIndex,
NB.	  LPTSTR lpValueName,
NB.	  LPDWORD lpcValueName,
NB.	  LPDWORD lpReserved,
NB.	  LPDWORD lpType,
NB.	  LPBYTE lpData,
NB.	  LPDWORD lpcbData
NB.	);
NB.)



ENUMERATE_SUB_KEYS=: noun define
	// From http://msdn.microsoft.com/library/default.asp?url=/library/en-us/sysinfo/base/enumerating_registry_subkeys.asp
	// As of:  2004-Dec-27 (Mon)
	
	
	// QueryKey - Enumerates the subkeys of key and its associated values.
	//     hKey - Key whose subkeys and values are to be enumerated.
	
	#include <windows.h>
	#include <stdio.h>
	#include <tchar.h>
	
	#define MAX_KEY_LENGTH 255
	#define MAX_VALUE_NAME 16383
	 
	void QueryKey(HKEY hKey) 
	{ 
	    TCHAR    achKey[MAX_KEY_LENGTH];   // buffer for subkey name
	    DWORD    cbName;                   // size of name string 
	    TCHAR    achClass[MAX_PATH] = TEXT("");  // buffer for class name 
	    DWORD    cchClassName = MAX_PATH;  // size of class string 
	    DWORD    cSubKeys=0;               // number of subkeys 
	    DWORD    cbMaxSubKey;              // longest subkey size 
	    DWORD    cchMaxClass;              // longest class string 
	    DWORD    cValues;              // number of values for key 
	    DWORD    cchMaxValue;          // longest value name 
	    DWORD    cbMaxValueData;       // longest value data 
	    DWORD    cbSecurityDescriptor; // size of security descriptor 
	    FILETIME ftLastWriteTime;      // last write time 
	 
	    DWORD i, retCode; 
	 
	    TCHAR  achValue[MAX_VALUE_NAME]; 
	    DWORD cchValue = MAX_VALUE_NAME; 
	 
	    // Get the class name and the value count. 
	    retCode = RegQueryInfoKey(
	        hKey,                    // key handle 
	        achClass,                // buffer for class name 
	        &cchClassName,           // size of class string 
	        NULL,                    // reserved 
	        &cSubKeys,               // number of subkeys 
	        &cbMaxSubKey,            // longest subkey size 
	        &cchMaxClass,            // longest class string 
	        &cValues,                // number of values for this key 
	        &cchMaxValue,            // longest value name 
	        &cbMaxValueData,         // longest value data 
	        &cbSecurityDescriptor,   // security descriptor 
	        &ftLastWriteTime);       // last write time 
	 
	    // Enumerate the subkeys, until RegEnumKeyEx fails.
	    
	    if (cSubKeys)
	    {
	        printf( "\nNumber of subkeys: %d\n", cSubKeys);
	
	        for (i=0; i<cSubKeys; i++) 
	        { 
	            cbName = MAX_KEY_LENGTH;
	            retCode = RegEnumKeyEx(hKey, i,
	                     achKey, 
	                     &cbName, 
	                     NULL, 
	                     NULL, 
	                     NULL, 
	                     &ftLastWriteTime); 
	            if (retCode == ERROR_SUCCESS) 
	            {
	                _tprintf(TEXT("(%d) %s\n"), i+1, achKey);
	            }
	        }
	    } 
	 
	    // Enumerate the key values. 
	
	    if (cValues) 
	    {
	        printf( "\nNumber of values: %d\n", cValues);
	
	        for (i=0, retCode=ERROR_SUCCESS; i<cValues; i++) 
	        { 
	            cchValue = MAX_VALUE_NAME; 
	            achValue[0] = '\0'; 
	            retCode = RegEnumValue(hKey, i, 
	                achValue, 
	                &cchValue, 
	                NULL, 
	                NULL,
	                NULL,
	                NULL);
	 
	            if (retCode == ERROR_SUCCESS ) 
	            { 
	                _tprintf(TEXT("(%d) %s\n"), i+1, achValue); 
	            } 
	        }
	    }
	}
	
	void _tmain(void)
	{
	   HKEY hTestKey;
	
	   if( RegOpenKeyEx( HKEY_CURRENT_USER,
	        TEXT("SOFTWARE\\Microsoft"),
	        0,
	        KEY_READ,
	        &hTestKey) == ERROR_SUCCESS
	      )
	   {
	      QueryKey(hTestKey);
	   }
	}
)