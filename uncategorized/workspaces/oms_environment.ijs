wd 'smmfmove 0 332 786 843'
wd 'smmfshow sw_shownormal'

wd @:('winexec *'&,)@:trim;._2 noun define
	cmd /c "C:\danielb\shortcuts\custom\oms.lnk"
    c:\j406\j.exe c:\danielb\projects\work\order_manager\main\dev\TV\default\trafficviewer.ijs /size 785 332 788 841 /djbdebug /window
)

load 'c:\danielb\projects\work\order_manager\test\dev\socktest.ijs'