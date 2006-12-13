coclass 'z'
NB. Routines for keyed lists (lists of key ; data [, data])

NB. y is list of key ; data
NB. If x is given, it is the list of key indices
NB. Result is the (boxed) keys
keyskld =: ({"1"_)
keyskl =: 0&keyskld : keyskld f.

NB. y is list of key ; data
NB. If x is given, it is the list of data columns
NB. Result is the (boxed) data items only, using the shape of x for each row
datakld =: ({"1)
datakl =: 1&datakld : datakld f.

NB. x is set of keys, y is keyed list, u is key columns
NB. Records with those keys are deleted
delkl_colsu =: -.@:((e.!.0)~ xuvy (]:&keyskld)) # ]
delkl =: 0 delkl_colsu f.

NB. x is set of keys, y is keyed list, u is column numbers of key
NB. Records with those keys are kept, the others are deleted
keepkl_colsu =: (e.!.0)~ xuvy (]:&keyskld)   #  ]
keepkl =: 0 keepkl_colsu f. NB. default version with key in position 0

NB. x is set of keys, y is keyed list, u is column numbers of key
NB. Result is index of x into }: keys, but _1 if there is no match
indexkl_colsu =: ( (#@]) ` (((_1"_)`((# i.@#)@:=)`])}) ` (]:&keyskld uy_vx (i.!.0)) ) `: 6
indexkl =: 0 indexkl_colsu f. NB. default version with key in position 0

NB. x is set of keys, y is keyed list, u is column numbers of key
NB. Result is 1 if x is in the list
inkl_colsu =: (e.!.0) xuvy (]:&keyskld)
inkl =: 0 inkl_colsu f.

NB. x is a (list of) boxed key value
NB. y is an n,m $ array of key ; data
NB. u is default value (verb or noun)
NB. v is (key columns;data columns)
NB. Result is BOXED requested columns, default if not found
NB. (]. (] {.) ].) is a way to get the first element of n
getkl_defu_colsv =: (( ( ((]. (] <@{.) ].)&keyskld) uy_vx (i.!.0) ) ` (((]. (] <@{:) ].)&{)@{ :: ([."_) " 0 _) ` ] ) `: 6)
NB. obsolete NB. Default value is {:y, key is column 0, return other columns (return items have rank 1)
NB. obsolete getkl =: (<_1;<<0)&{@]  getkl_defu_colsv (0;<<0) f.
NB. m is key column(s), n is data column(s).  x is key(s), y is kl.  x must be found
getkl =: <@(;&].)@([.&{"1 uy_vx i.) { ]
NB. Default value is {:y, key is column 0, return column 1 (items have rank 0)
getkl1 =: (<_1;1)&{@]  getkl_defu_colsv (0;1) f.
NB. Default value is u, key is column, return column 1
getkl1d =: getkl_defu_colsv (0;1)
NB. Default value is u, key is column, return other columns
getkld =: getkl_defu_colsv (0;<<0)

NB. x is a list of boxed key value (may be scalar if key is rank 1)
NB. y is an n,m $ array of key ; data
NB. u is key columns, v is columns to return
NB. Result is the list of all boxed lists matching the key
allgetkl_colsuv =: (].&datakld)@(((e.!.0)~ xuvy ([.&keyskld)) # ])
allgetkl =: 0 allgetkl_colsuv (<<<0) f.

NB. y is a list of key ; data, x is list of key columns (default 0)
NB. Result is the input, with duplicate keys removed (first one of multiples survives)
nubkl =: (#~ ~:@:(0&keyskld)) : (] #~ ~:@:keyskld) f.

NB. y is list of key ; data, x is list of columns to return (default 1)
NB. result is raze of one column of the data with the keys removed.  Default is first column
razekl =: (1&$:) : (; @: ({"1)) f.

NB. Conjunction: apply u to column number n of y, but only in records with keys in x
applykl =: ((([. (&.>)) @: (].&{)@])`(]."_)`] }) ^: ({. uy_vx e.) "_ 1

NB. Conjunction: u is a predicate, v is a (possibly list of) column numbers
NB. u is applied to the list of (boxed) selected elements of y and the entire x (if any)
NB. Result is only those items which produce a nonzero predicate
cullkl =: ([. bivalent (].&{"1)   #   ])   ifany