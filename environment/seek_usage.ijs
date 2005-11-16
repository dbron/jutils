	   pth  =.  jpath'~home'
	   fns  =.  {."1 dirtree '\*.ijs',~ pth
	   lns  =.  LF&cut@:toJ@:fread&.> fns
	   wds  =.  ;: ::(a:"_) L: 0 lns
	   mch  =.  lns (#~ (1&e.@:((;:'15!:6')&E.) :: 0:)&>) each wds
	   mch  =.  ((#pth)}.&.>fns) ((0: < #&>)@:] # (,. >&.>)) mch
