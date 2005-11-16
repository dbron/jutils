NB.  Dependencies section
load (<'b:\projects\work\order_manager\main\dev\util\default\';'.ijs') ;@:(0 _1 1&{@:, <)&.> ;: 'general ini'


NB.  Definition section
buildPath			=:  <@:('\'&join)@:,
cfgRead				=:  iniparse@:toJ@:fread
map					=:  (-.@:*@:L.@:] >@:]^:([`]) (i.~&:((deb@:tolower&.>^:(2: = (3!:0)@:>@:head)@:boxopen)) {."1)~ { {:"1@:[) :. ((map~ |."1)~)
mapWithDefault		=:  (-.@:*@:L.@:] >@:]^:([`]) (((i.~&:((deb@:tolower&.>^:(2: = (3!:0)@:>@:head)@:boxopen)) ([: }: {."1))~ { {:"1@:[)~ (] ((#~ -.) , ({~ i.&1)) =&a:@:({."1))@:,&a:)~) :.((mapWithDefault~ |."1)~)

NB.  Get the data from the new file
getNewBlocks		=:  {:"1@:]
NB.  Get the headers (block names) from the new file
getNewHeaders		=:  {."1@:]
NB.  Get the headers from the new file, extract corresponding blocks out of the old file.
getCorrOldBlocks	=:  mapWithDefault getNewHeaders

NB.  An equivalence function for ini attribute names
normalizeNames		=:  tolower@:-.&' _-'&.>
NB.  Reshape empty maps to 0 2 $ a:, so they append to non-empty maps properly.
normalizeEmpties	=:  (0 2 $ a:)"_^:(0: -: */@:$) 	
NB.  Merge two maps together, RHA takes precedence.
mergeMaps			=:  (#~ ~:@:normalizeNames@:({."1))@:,&:normalizeEmpties&.>~

mergeBlocksFromNew	=:  getNewHeaders ,. getCorrOldBlocks mergeMaps getNewBlocks
copyBlocksNotInNew	=:  [ (] ,. map) -.&:({."1)
mergeIni			=:  mergeBlocksFromNew , copyBlocksNotInNew
mergeIniFiles		=:  >@:(mergeIni&.>/)

NB.  Fetch is an N-level deep version of map.  The syntax is nested_map fetch 'level 0/level 1/level 2/..../level N-1'
fetch				=:  ] >@:]^:(L.@:[ = 0:) (<@:(mapWithDefault~ seq~ '/'&arbCut@:>) :: (a:"_)"_ 0 boxopen)


NB.  Execution section


NB.  Initial data; known Opera directories.
NB.  I might need to get this info from the registry.
OPERA_ROOT			=:	'C:\danielb\applications\net\opera'  NB.  Get this from the registry?
CURRENT_VERSION		=:  'Current'
NEW_VERSION			=:  'v7.50p3'

NB.  Get Opera configuration options.  These configuration options
NB.  are multi-tiered.  The first tier ini applies to ALL installations
NB.  of Opera on the system, and is stored in the system directory.
NB.  The second tier ini is global to a single installation of Opera, and
NB.  is stored in that installation's root folder.  The third tier ini
NB.  is a single user's profile, or customized ini.  This is stored in the
NB.  user's profile directory (the location of which is calculated from the
NB.  second tier ini).  Each tier takes precedence over the previous tier,
NB.  so third tier options override second tier options, and second tier
NB.  options override first tier options.

NB.  Start with the inis at known locations (system dir & opera dir)
INI_PATH			=:  (#~ fexist"0) ('\Opera.ini' ,~ 2!:5 'SystemRoot') ; (OPERA_ROOT;CURRENT_VERSION) buildPath"1 0 'OperaDef6.ini';'Opera6.ini'

NB.  Opera's system ini is the merge of the universal ini (in the system directory) and
NB.  the ini for the particular installation.
SYSTEM_INI			=:  mergeIniFiles cfgRead&.> INI_PATH

NB.  The opera directory is specified by the [User Prefs]/Opera Directory config attribute.
NB.  If this attribute doesn't exist, default to the already-calculated opera dir.
CURRENT_OPERA_DIR	=: SYSTEM_INI fetch :: ((OPERA_ROOT,'\',CURRENT_VERSION)"_) 'User Prefs/Opera Directory'

NB.  The opera profile directory is the 'profile' sub-directory of the opera storage directory.
NB.  The storage directory's location depends on the [System]/Multi User config attribute.  If
NB.  the opera install is multi-user, then the storage dir is in the %USERPROFILE% directory,
NB.  otherwise, it's just the current opera directory.
CURR_OPERA_PROF_DIR =: (0 ". SYSTEM_INI fetch 'System/Multi User') {:: 'profile' buildPath"0 1&:boxopen~ CURRENT_OPERA_DIR ; '\Application Data\Opera' ,~ 2!:5'USERPROFILE'

NB.  The full config is the merge of opera's system ini and the user's profile ini.
FULL_INI			=:  mergeIniFiles SYSTEM_INI ,&< cfgRead CURR_OPERA_PROF_DIR buildPath&.< 'opera6.ini'

NB.  Find out where the configuration data is stored.
NB.  The default configuraton data is stored in the 'defaults' subdirectory of
NB.  the Opera directory.  The user customized configuration data is pointed to 
NB.  by the FULL_INI map.
CONFIGURABLE		=:  ;: 'keyboard menu toolbar mouse'  NB.  Elements that can be configured.
DEFAULT_DIR			=:  'defaults'
CURR_CUSTOM_FILES	=:  FULL_INI fetch                                (<'User Prefs/';' Configuration') ;@:(0 _1 1&{@:, <)&.> CONFIGURABLE
CURR_DEFAULT_FILES	=:  (CURRENT_OPERA_DIR;DEFAULT_DIR) buildPath"1 0 (<'standard_'  ;'.ini'          ) ;@:(0 _1 1&{@:, <)&.> CONFIGURABLE

NB.  If the config doesn't point to a particular configurable element, then the user hasn't
NB.  customized it, so ignore it.
'CURR_DEFAULT_FILES CURR_CUSTOM_FILES' =: (<fexist"0 CURR_CUSTOM_FILES) #&.>  CURR_DEFAULT_FILES ,&< CURR_CUSTOM_FILES

'default custom'	=:  cfgRead L: 0 CURR_DEFAULT_FILES ,&< CURR_CUSTOM_FILES
   dc =. default ,. custom
   z0 =. {."1 dc

NB.  Enumeration of values returned by (=&a: (<. -: >: #. |: ,) ats ~:/)
NB.  assuming the 'old' map is on the left and the 'new' map is on the right:
NB.  	3 is element removed
NB.  	2 is element added
NB.  	1 is element changed
NB.		0 is element unchanged 
<@:(=&a: (<. -: >: #. |: ,) ats ~:/)@:(mapWithDefault&> <@:(#~ ~:@:normalizeNames)@:;@:({."1&.>))"1 |: > ((map {."1) ,: {:"1@:])&.>/"1 {. default ,. custom

NB.  Notes section
NB.  noun define
NB.     'cts otn' =: 'custom_to_std old_std_to_new_std' =: a: -.~ '======================' arbCut toJ fread fn
NB.     'c o'=. co =. (#~ 2: > i.&0@:=&TAB&>) @: (LF &arbCut) each cts;otn
NB.     mapWithDefault =: (-.@:*@:L.@:] >@:]^:([`]) (((i.~&:boxxopen ([: }: {."1))~ { {:"1@:[)~ (] ((#~ -.) , ({~ i.&1)) =&a:@:({."1))@:,&a:)~) :.((mapWithDefault~ |."1)~)
NB.     ({."1@:] (a:&~:@:] # ,.) {:"1@:] (e. # [)&.>~ (mapWithDefault {."1))&>/ (-.&(' []<>^',TAB)L: 0) @:(({. , <@:}.) ;.1~ [: -. i.&0@:=&TAB&>)@:-.&a: &.> |. co
NB.  )

NB.  (<'standard_') ,&.> CONFIGURABLE 
NB.  CUSTOM_DIRS			=:  ',' makeTable noun define
NB.  	Keyboard , 
NB.  )
