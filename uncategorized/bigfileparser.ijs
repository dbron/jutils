NB. dbr 0
NB. require 'debug'
NB. dbr 1
NB. dbss''

require'jmf'

NB.  A special value indicating the LHA is not specified.
UNSPECIFIED				=:  a:

NB.  "Big file parser":  Chops a large file into columns (columns must be fixed-width)
NB.  takes a filename as a RHA and optionally a column-break mask (boolean list) as a LHA.
NB.  Returns a list of boxes which represent the columns of the file.  The columns are actually
NB.  mapped files, for efficiency reasons.
bfp						=:  bigfileparser =:  verb define

	NB.  If called monadically, then the LHA is unspecified.
	y bfp~  UNSPECIFIED
:

	NB.  Get a handle to our file, and reference instead of
	NB.  constantly referencing the name
	y					=.  'C:\danielb\temp\temp2\exfile.001'	
	fhand				=.  (1!:21 <y)

	NB. Size of the file, needed for matrix shape calculation.
	fsiz				=.  1!:4 <fhand 
	
	if. -. UNSPECIFIED -: x do.
		NB.  The nominal case:  we were told where the columns break (i.e. the location of the field delimiters)

		NB.  Account for record-delimiter (1 -: # LF)
		x 				=.  x , 1

		dbstopme''

		select. deb tolower datatype x

			NB.  Boolean cut-mask
			case. 'boolean' do.
				mask	=. x , 1
			NB.  List of field lengths
			case. 'integer' do.
				mask	=. xb +/\ x
			case. do.
				'Unsupported type of LHA' assert 0
		end.

		NB.  Account for record-delimiter (1 -: # LF)
		NB. HASK_z_ =:mask			=.  mask , 1
	else.
		NB.  Otherwise, sinec we don't know what the file is supposed to look like (i.e. we're not given a column mask),
		NB.  we have to try to figure it out (by assuming columns are delimited by a particular value).

		NB.  Current index into file (fhandle, index, length)
		fidx			=.  fhand , 0 0
		
		NB.  Flag indiciating success/failure.
		foundLFs		=.  0

		NB.  Loop over the file in small windows until we encounter a
		NB.  record delimiter (a linefeed).
		for_mx. 
			_2 ]\ fsiz ([ ,~ ] * i.@:<.@%) 1024 
		do.

			NB.  Update the index with the parameters (index, length) of the next window.
			fidx		=.  mx 1 2} fidx 

			NB.  Fetch the window, check if it contains record delimiters.
			idx			=.  LF (#@:]  _1:^:-:  i.~) 1!:11 fidx

			NB.  If a delimiter is found, record success and index,
			NB.  and stop checking.
			if. -. _1 -: idx do.
				foundLFs=.  1
				len		=.  {. mx
				break.
			end.
		end.

		NB.  Looped over entire file, but found no record delimiters.
		'File contains no linefeeds' assert  foundLFs 

		NB.  Read the first record (up to the first record delimiter)
		data			=.  1!:11 fhand,  0 , recLen =. idx + len
		
		NB.  Then find the field delimiters (spaces followed by non spaces) within the first record.
		mask			=.  1 ,~  1 0 E. ' ' = data
	end.

	NB.  Get the indicies of the column breaks.
	idex				=.  bx mask

	NB.  Create a new locale into which we'll map the columns.
	poofy				=.  > cocreate ''

	NB.  Temp directory into which we'll put the mapped files.
	mkdir thedir			=.  (1!:40''),'temp\mapped\',poofy,'\'

NB.	dbstopme''

	NB.  The "shape" of the matrix (as represented by the file)
	NB.  Which is num-records , record-length
	matShape				=.  <. fsiz ((% , |) >:) <: # mask NB. recLen

	NB.  The names of the fields
	flds					=.  'FLD_'&,@:,&":/"1] 10 #.^:_1 i.#idex

	NB.  Create the required mapped files at the appropriate sizes.
	createjmf_jmf_ "1 (theflds	=.  thedir ,"1 flds)  ;"_1 ({. matShape) * | 2 -/\ _1 , idex  NB.!  Why do I have to use _1 instead of 0 here?  Why is the first field one char bigger than I expect?

	NB.  Slap the locale name onto the field names.
	flds					=.  flds ,"1 '_' enclose poofy 

	NB.  Map the field names (with explicit locale names) onto the files created with createjmf_jmf_
	NB.  All columns mapped aa JCHAR.
	JCHAR map_jmf_"1 flds ;"1 theflds

	NB.  Read the matrix, parse it by column breaks, and assign each column to its associated mapped file.
	NB.  Conveniently returns a list of boxed columns.
	(, ;: flds)				=.  ('';mask) <;.2  SNORT =: matShape $ 1!:1 < fhand	

)

NB. bfp''