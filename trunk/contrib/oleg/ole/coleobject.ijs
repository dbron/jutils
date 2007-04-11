coclass'COleObject'

create=: 3 : 0
  ID=: ;{.boxopen y
  0
)

NB. setid 'ocxctrl obj propobj'
NB. newid setid 'ocxctrl obj propobj'
setid=: 3 : 0
  ((}.~ >:@i:&' ') y) setid y
:
  wd'oleget ',ID,' ',y
  wd'oleid ',ID,' ',x
)

NB. prop setbase value
setbase=: 4 : 0
  wd'oleset ',ID,' base ',x,' ',":y
)

NB. method dobase args
dobase=: 4 : 0
  wd'olemethod ',ID,' base ',x,' ',":y
)

NB.* [item] do 'method args'
do=: 3 : 0
  'base' do y
:
  wd'olemethod ',ID,' ',x,' ',":y
)

NB.* [item] get prop
get=: 3 : 0
  'base' get y
  :
  wd'oleget ',ID,' ',x,' ',":y
)

NB.* [item] set 'prop value'
set=: 3 : 0
  'base' set y
:
  wd'oleset ',ID,' ',x,' ',":y
)

enable=: 3 : 0
  wd'oleenable ',ID,' ',y
)

destroy=: codestroy
