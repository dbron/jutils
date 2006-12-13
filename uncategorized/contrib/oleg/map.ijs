NB. [nested] map of (,: key;value) entries
NB.
NB. INSTALL
NB.    > copy map.ijs user/
NB.
NB. RUN
NB.   require '~user/map.ijs'
NB.   coinsert 'map'
NB.
NB.
NB. FLAT MAPS
NB.
NB. creating a map:
NB.
NB.   MAP=: empty''                      NB. you should've guessed!
NB.   MAP=: 1 2 3 'one' setmap empty''   NB. with some values
NB.   MAP=: ('k1';i.3),:('k2';'qq')      NB. declaratively
NB. +--+-----+
NB. |k1|0 1 2|
NB. +--+-----+
NB. |k2|qq   |
NB. +--+-----+
NB.
NB. changing values:
NB.
NB.   MAP=: (i.3 4) 'k2' setmap MAP      NB. similar to amend, "}"
NB. +--+---------+
NB. |k1|0 1 2    |
NB. +--+---------+
NB. |k2|0 1  2  3|
NB. |  |4 5  6  7|
NB. |  |8 9 10 11|
NB. +--+---------+
NB.
NB. adding values:
NB.
NB.   MAP=: 'qq' 'k3' setmap MAP         NB. same as setting
NB. +--+---------+
NB. |k1|0 1 2    |
NB. +--+---------+
NB. |k2|0 1  2  3|
NB. |  |4 5  6  7|
NB. |  |8 9 10 11|
NB. +--+---------+
NB. |k3|qq       |
NB. +--+---------+
NB.
NB. removing entries:
NB.                                NB. i.e. setting to nothing
NB.   MAP=: 'k2' setmap MAP        NB. graceful for missing keys
NB. +--+---------+
NB. |k1|0 1 2    |
NB. +--+---------+
NB. |k3|qq       |
NB. +--+---------+
NB.
NB. getting values:
NB.                                NB. similar to From '{'
NB.   VALUE=: 'k1' getmap MAP      NB. missing keys gracefully return empty''
NB. 0 1 2
NB.
NB.    getmap MAP                 NB. catalog of keys, like '{'
NB. +--+--+--+
NB. |k1|k2|k3|
NB. +--+--+--+
NB.
NB. index of the key:
NB.
NB.   INDEX=: 'k4' ndxmap MAP
NB.
NB. existance of key:
NB.
NB.   BOOL=: 'k4' hasmap MAP
NB.
NB.
NB. NESTED MAPS
NB.
NB. build a nested map:
NB.
NB.   MAPX=: 3 'k2.k6' setmapx 'val' 'k2.k4' setmapx 1 'k1.k3' setmapx empty''
NB.   MAPX=: 3 'k2.k4.k8' setmapx (i.3 4) 'k1.k5' setmapx MAPX
NB. +--+--------------+
NB. |k1|+--+---------+|
NB. |  ||k3|1        ||
NB. |  |+--+---------+|
NB. |  ||k5|0 1  2  3||
NB. |  ||  |4 5  6  7||
NB. |  ||  |8 9 10 11||
NB. |  |+--+---------+|
NB. +--+--------------+
NB. |k2|+--+--------+ |
NB. |  ||k4|+--+---+| |
NB. |  ||  ||  |val|| |
NB. |  ||  |+--+---+| |
NB. |  ||  ||k8|3  || |
NB. |  ||  |+--+---+| |
NB. |  |+--+--------+ |
NB. |  ||k6|3       | |
NB. |  |+--+--------+ |
NB. +--+--------------+
NB.
NB. removing nested entries:
NB.                                NB. i.e. setting to nothing
NB.    'k1.k5' setmapx 'k2' setmapx MAPX
NB. +--+------+
NB. |k1|+--+-+|
NB. |  ||k3|1||
NB. |  |+--+-+|
NB. +--+------+
NB.
NB. value of deep key from nested map:
NB.
NB.    'k1.k3' getmapx MAPX
NB. 1
NB.    'k2.k4' getmapx MAPX
NB. +--+---+
NB. |  |val|
NB. +--+---+
NB. |k8|3  |
NB. +--+---+
NB.    'k2.k4.' getmapx MAPX
NB. val
NB.
NB.    getmapx MAPX               NB. catalog of nested keys, like '{'
NB. +-----+-----+------+--------+-----+
NB. |k1.k3|k1.k5|k2.k4.|k2.k4.k8|k2.k6|
NB. +-----+-----+------+--------+-----+
NB.
NB.    flatmap MAPX                NB. covert nested map to flat
NB. +--------+---------+           NB. like Spread 0
NB. |k1.k3   |1        |
NB. +--------+---------+
NB. |k1.k5   |0 1  2  3|
NB. |        |4 5  6  7|
NB. |        |8 9 10 11|
NB. +--------+---------+
NB. |k2.k4.  |val      |
NB. +--------+---------+
NB. |k2.k4.k8|3        |
NB. +--------+---------+
NB. |k2.k6   |3        |
NB. +--------+---------+
NB.
NB.    MAPX -: flatmapx flatmap MAPX      NB. reverse of flattening
NB. 1
NB.
NB.    strmap MAPX        NB. covert nested map to multiline string
NB. k1.k3    1            NB. useful for storing and restoring config
NB. k1.k5    i.3 4
NB. k2.k4.   'val'
NB. k2.k4.k8 3
NB. k2.k6    3
NB.
NB.    MAPX -: strmapx strmap MAPX        NB. reverse from string
NB. 1
NB.
NB. CMAP=: 0 : 0                  NB. build nested map from COMPACT string
NB. k1 .k3  1     .k5    i.3 4
NB. k2 .k4. 'val' .k4.k8 3     .k6 3
NB. )
NB.    MAPX -: strmapc CMAP
NB. 1
NB.
NB. AUTHOR
NB.    (C) Oleg Kobchenko <olegykj@yahoo.com>, 10/12/2003
NB.        GPL, AS-IS, NO WARRANTY
NB.
NB.    10/23/2003 added strmap[x|c]


coclass 'map'

NB.*ndxmap v index of the key
NB. INDEX=: 'key' ndxmap MAP

ndxmap=: (i. boxopen)~ getmap


NB.*hasmap v existance of the key
NB. BOOL=: 'key' hasmap MAP

hasmap=: ndxmap < #@]


NB.*ismap v being a map
NB. BOOL=: ismap MAP

ismap=: ((2: = {:) *. 2: = #)@$


NB.*getmap v [dyad] value for a key
NB. VALUE=: 'key' getmap MAP

NB.*getmap v [monad] list map keys
NB. KEYS=: geymap MAP

getmap=: ({."1) : ((,&1@ndxmap {:: ]) :: empty)


NB.*setmap a [dyad] add/change map value
NB. MAP=: VALUE 'key' setmap MAP

NB.*setmap a [monad] remove map entry
NB. MAP=: 'key' setmap MAP

setmap=: 1 : 0
  if. (#y) <: i=. u ndxmap y do.
    y return. end.
  (0 i } (#y)#1) # y
:
  if. (#y) <: i=. u ndxmap y do.
    y,(boxopen u),<x return. end.
  (< x) (<i,1) } y
)

NB.*DELIM v nested keys delimiter
NB. in 'k1.k2.k3' DELIM=: '.' (default)

DELIM=: '.'


NB.*getmapx v [dyad] value for a deep nexted key
NB. VALUE=: 'k1.k2.k3' getmapx MAPX

NB.*getmapx v [monad] list nested map keys
NB. KEYS=: geymapx MAP

getmapx=: 3 : 0
  r=. ''
  if. ismap y do.
    for_i. getmap y do.
      r=. r, i [`(  (, DELIM&,)&.>  )@.(*@#@]) getmapx i getmap y
  end. end.
:
  for_i. <;._2 (>x),DELIM do.
    y=. i getmap y
  end.
)

NB.*setmapx a [dyad] add/change value for a deep nexted key
NB. MAPX=: VALUE 'k1.k2.k3' setmapx MAPX

NB.*setmapx a [monad] remove a nested entry
NB. MAPX=: 'k1.k2.k3' setmapx MAPX

setmapx=: 1 : 0
  (empty'') u setmapx y
:
  E=. x -: empty''
  r=. ,< y=. y
  for_i. }:KEYS=. <;._2 (>u),DELIM do.
    y=. i getmap y
    if. (#*.-.@ismap) y do. 
      if. E do. y return. end.
      y=. ,:'';y 
    end.
    r=. r, <y
  end.
  if. E do.
    if. (<empty'') e. r do. y return. end.
    q=. ({:KEYS) setmap >{:r
  else.
    q=. x
  end.
  for_i. |.i.(#KEYS)-E do.
    q=. q (i{KEYS) setmap >i{r
  end.
)

NB.*flatmap v convert nested map to flat map of leaves
NB. MAP=: flatmap MAPX

flatmap=: ([ ,. (getmapx&.> <))~ getmapx

NB.*flatmapx v convert flat map to nested
NB. MAPX=: flatmapx MAP

flatmapx=: 3 : 0
  r=. empty''
  for_i. y do.
    'k v'=. i
    r=. v k setmapx r
  end.
)

linear=: 3 : '5!:5<''y'''
box2str=: ;@:(,&LF&.>)@(<"1@:>@{. <@(, ' '&,)&>"0 (linear&.>)@{: )@|:
str2box=: (i.&' ' ({. ; ".@}.) ]);._2

NB.*strmap v convert nested map to multiline string
NB. STR=: strmap MAPX

strmap=: box2str @: flatmap

NB.*strmapx v convert multiline string to nested map
NB. MAPX=: strmapx STR

strmapx=: flatmapx @: str2box

stemtails=: ;@:(<@(i.&' ' {. ]) (<@,  ,&LF)&>"0 ' .'&(E. <;._1 ]))

NB.*strmapc v convert compact string to nested map
NB. MAPX=: strmapc CSTR
NB.
NB. Compact string representation of a nested map is an extension
NB. of multiline string (strmap), except it allows multiple keys per line.
NB.
NB. Each line of compact string consists of
NB. stem .tail1 value1 .tail2 value2  ...
NB.   stem:   first non-space chars,
NB.           forms beggining of the key
NB.   tailI:  non-space chars preceded with ' .'
NB.           forms end of key
NB.   valueI: value of the key
NB.
NB. Both stem and tails may contain multiple parts of the key,
NB. separated with '.', but it's important that tails always
NB. begin with a '.'

strmapc=: [: strmapx [: ; <@stemtails;._2
