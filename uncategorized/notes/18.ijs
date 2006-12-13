pff_z_=:verb define
	'get' pff y
:
	NB.  LHA should be 'get' or 'set', i.e. are we reading or writing the file?
	gs =. lc trim x

	NB.  RHA is optional; it's a filename (or dir;filename).  If y specifies only a path, then it will be used as the initial directory to the prompt
	NB.  if y specifies a filename (without a path), then the file will be expected to be found in one of the default directory.
	NB.  Note the use of 'sp', NOT 'splitPath' here.  So to pass in a filename without an extension, use the form 'dir';'filename'
	NB.  (the extension will be defaulted to 'jws').
	NB.  'd f'=.sp^:(0: = L.) y
	'd f'=.|.^:(PATHSEP_j_"_ -.@:e. >@:{. *. a:"_ = {:)@:splitPath^:(0: = L.) y

	NB.  Calculate the dir we should look for the file; this is the first valid dir of, in order,
	NB.  the dir given, my custom workspace dir, J's working directory.  If none of these are valid, choose the root ('\').
	d =. (,&(<'\') {::~ [: i.&1 >@:{.@:('shlwapi.dll PathFileExistsA i *c'&(15!:0))"0) d ; 'b:\data\srccode\j\workspaces\' ; 1!:40 ''

	NB.  If we were given a filename, manipulate it as neccesary and use it.
	if. * # f do.
		NB.  Default file extension to JWS
		if. -. '.' e. f do.
			f =. f,'.jws'
		end.
	else.
	NB.  If we weren't given a filename, prompt for one, using d (calculated above) as the initial directory.
	NB.  Note the use of 'splitPath' here; we can trust mbopen to provide us a true filename.  This way a user can select a filename without an extension in the box.
		'd f'=. splitPath wd (' "J Workspace" "',d,'" "" "J Workspaces (*.jws)|*.jws|All files(*.*)|*.*" ') ,~ > 'get/mbopen set/mbsave /mbopen' lookupWithDefault gs
	end.

	NB.  After calculating d and f, put them together.
	fn =. d,f
	
	NB.  If we're trying to read a file, make sure it exists;
	NB.  if we're trying to write a file, make sure its writable.
	select. gs
		case. 'set' do.
			ferase :: 0: fn [ badFile =. 1 = 'a' fwrite :: 0: fn 
		case. 'get' do.
			goodFile =. fexist fn
		case. do.
			'Invalid left hand argument; use ''get'' or ''set''.' assert 0
	end.
	goodFile assert~ 'Invalid Workspace filename:  "',fn,'"'
	
	NB.  If all went well, Save our filename in WORKSPACE_z_
	PFF_z_		=. fn
)