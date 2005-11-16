load  'winapi strings'

NB.  Table from Microsoft's documentation at:  
NB.  http://msdn.microsoft.com/library/default.asp?url=/library/en-us/sysinfo/base/getversion.asp
NB.  Website as of 2003-March-06 (Thurs.)
version_table=. <@:dtb;._1;._2 noun define
|Platform                   |High-order bit |Next 7 bits  |Low-order byte 
|Windows NT 3.51            |0              |Build number |3 
|Windows NT 4.0             |0              |Build number |4 
|Windows 2000 or XP         |0              |Build number |5 
|Windows 95, 98, or Me      |1              |Reserved     |4 
|Win32s w/ Win 3.1          |1              |Build number |3 
)

verIDs		=: ".@:(;:^:_1)@:(}. {~"1 i.&('High-order bit';'Low-order byte')@:{.) version_table
hob_loB		=: ({. (<;/ 0 _1) } 0: ,: _8&{.)@:(_32&{.)&.#:

getVersion	=: [: >@:{. 'GetVersion' win32api
winVersion	=: (dtb@:>@:{.@:{& (}. version_table)@:(verIDs&i.)@:hob_loB)@:getVersion bind '' f.
