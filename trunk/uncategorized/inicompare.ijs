require 'c:\danielb\projects\work\order_manager\main\dev\util\default\ini.ijs'
require 'c:\danielb\data\srccode\j\contrib\oleg\map.ijs'

   
mapcompare=: dyad define
	nubKeys =. ([ #~ e.)&.>/ pooky =. 'PKEYS QKEYS' =. tolower L: 0 {."1 each snooky =. x ,&:< y
	horses  =. (pooky i.&.> nubKeys) {&> snooky    
	outs =. snooky {&.>~ pooky  ([ i. -.)&.> nubKeys 
	horses ,&< outs
)




emptyTable =: (0 2 $ <'')"_^:(0: -: */@:$)  NB.  Replace empties with empty tables.
inicompare =: dyad define

NB.  Obviously a lot of repetition here; 
NB.  With the mapcompare twice and the 
NB.  M ,&.>~ and the ,&.>~ <"_1
NB.  also should use something like x &:fread  y etc
'N M'=. mapcompare&>/ 'P Q'=.emptyTable each @:(emptyTable)@:iniparse@:fread each x;y  
pooken=.mapcompare&>/   {:"1 N  
> {: M ,&.>~ ({."1 N) <@:,."1 |: (,&.>~ <"_1)~&>/ |: pooken
inin =. M ,&.>~ ({."1 N) <@:,."1 |: (,&.>~ <"_1)~&>/ |: pooken
data =. (LF ,&.>~ x;y) ,&.> ([: toHOST@:((LF,LF)&join ) (,&LF@:('[]'&enclose)@:[ ;@:; ;@:,@:(2&A.&.|:)@:(,"1&(<"0'=',LF))@:])&.>/@:|:) each inin 
files =. getTemporaryFile&.>2#<''
data fwrite&.> files

wd 'winexec *' , ;:^:_1 '"' enclose each 'C:\danielb\applications\utils\compare_and_merge\Compare.exe' ; files

)