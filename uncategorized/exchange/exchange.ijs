NB.  When I re-load this script, I can use >./ ORDINAL to just retreive the new rows (messages) from Exchange.

NB.  Dependencies
require 'dd jmf'

NB.  Globals
'MY_PATH MY_SCRIPT' 	=:  getPath	''

DATABASE				=:  'Exchange'
TABLE	 				=:  'JForum' NB.'DAS'
CXN						=:  ddcon 'dsn=' , DATABASE

NB.  Utils
sql						=:  verb define
	ddfch _1 ,~ y. ddsel CXN
)


NB.  Execution
GO =: verb define
	
	mapped_dir			=:  '\' ,~ '\' collapseMultiples '\' join MY_PATH;'mapped';TABLE
	smoutput 'Mapping directory:  ' , mapped_dir
	mkdir mapped_dir

	ROW_COUNT			=:  {. , > {. sql 'select count (*) from ',TABLE
	smoutput 'Rows in ',TABLE,':  ',": ROW_COUNT
	column_definition_header =. {. column_definitions =. TABLE ddcol CXN  NB.  getColNms 'JForum';CXN

	NB.  Create named constants for the different data types
	(column_definition_header)   =. <@:>"1 |: }. column_definitions
	(dts =. s:^:_1 s: 'DT_' ,"1 > {: n) =. > {. n =. DATA_TYPE ,&<&:~. TYPE_NAME
	smoutput'Data types used in ' , TABLE ,':  ' listToEnglish dts
	
	NB.  Don't let previous definitions of column_definition_header interfere with defs. created in 
	NB.  for_coldef. loop.
	erase column_definition_header

	smoutput 'Will now map columns',CRLF

	NB.  I might want to do this all at once, instead of in a loop.
	NB.  However, I have to find out which is faster; grabbing and mapping
	NB.  all the columns at once, or one at a time.
	NB.  at the very least I should make a verb do to this and call it "1 }. column_definitions.
	for_coldef. }. column_definitions do.
		(column_definition_header) =. coldef
		if. -. COLUMN_NAME -:&(trim@:lc) 'BODY' do.
			COL_NAME				 =. ' ' sr '_' uc trim COLUMN_NAME
			smoutput 'Working on column ',COL_NAME
	
			COL_FILE =. mapped_dir , COL_NAME , '.jmf'
			smoutput 'Will map into ',COL_FILE
			
			try.
				if. -. fexist COL_FILE do.
					smoutput 'File does not exist.  Will create.'
					createjmf_jmf_ COL_FILE;ROW_COUNT * COLUMN_SIZE >. 4 NB.  Bits will be represented as ints, so 4 is the min col size
				end.

				smoutput 'Mapping file.'
				map_jmf_  COL_NAME;COL_FILE  NB.  Careful here; this old version of the file may not be of the same length as the more recently downloaded files.
	
				smoutput 'Created mapped file successfully.  Will now retrieve column.'
				NB.  Want numbers as vectors, strings as matricies.  Problem is RECEIVED says it's numeric, 
				NB.  but it's returned as string.
				(COL_NAME)=:,^:(DATA_TYPE ~: DT_VARCHAR)>{.sql'select [' , COLUMN_NAME , '] from ',TABLE
				smoutput 'Column mapped successfully.'
			catch.
				smoutput 'Couldn''t map column. Attempt resulted in:  ', ;:^:_1 ": each ((13!:11 ; (}.@:{.~ i.&LF)@:(13!:12)) bind '') ''
				unmap_jmf_ :: 0: COL_NAME
				ferase :: 0: COL_FILE
			end.
		else.
			smoutput 'Skipping BODY column.  It always fails to map, because it would require ' , (fmt ROW_COUNT * x: COLUMN_SIZE >. 4) , ' bytes of storage.'
			smoutput 'The trouble with treating Exchange like a DB is that it acts like a DB, fixed width columns and all...'
		end.
	
		smoutput CRLF
	end.

	NB.  f is the sorted nub of (the normalized) F.  I want to handle aliases here, (such as Daniel Bron and D. Bron)
	NB.  and I should probably map FROM as indicies into this alias list.  Or perhaps the result of (6 s: s: f.) {~ FROM i. f
	NB.  If I use s: in this manner I'm going to need to re-load the symbol table.
	f			=:  (/: lc) (#~ ~:@:(;:^:_1@:(' '&arbCut)@:(' '&collapseMultiples)"1)@:lc) ({.~"1 [: >./ (([: (# <. >:@:i:&1) ~:&' ')"1)) FROM
	
	NB.  Table of poster ,. post-frequency
	N 			=:  (\: ;@:({:"1)) ({&(f,'')@:~. ;"_1 # 0.01&round@:*&100@:%~ #/.~) f i.&s: FROM
	
	NB.  Received time in a usable format.  Might want to map R as 6 different columns (RECEIVED_YEAR RECEIVED_MONTH, etc).
	RCVD		=:  (x: <. 10 ^ 4 2 2 2 2 2) #. 0 ". ;:^:_1 (' ' ,. R) <;._1~"1 -. DIGITS e.~ ' ' , {. R =: RECEIVED ];.1~ 0 = 19 | i. # RECEIVED

	NB.  Bron gets 1.9%! (8th rank over all)
	r =. 'My posts represent ' , '% of all messages on the forum!',~ ": p=. +/ (n =. ; {:"1 N) #~ 'bron' 1&e.@:E."1  lc > {."1 N
	r , CRLF , 'I''m rank ', ' overall!' ,~ ": p i.&1@:> n 
)



(,&'_ADDR' &.> ;: 'DAS DAN' ) =: dlb each @: }: @: (LF&arbCut) @: (TAB sr ' ') each ((noun define) ,&< (noun define))
	'Dan Bron'
	'Daniel Bron'
	Dan Bron
	Daniel Bron
	DanielB@mapleusa.com
	dan@manefm.com
)
	'2012132106@vtext.com'
	'Das (E-mail)'
	'Diana Stone (E-mail 3)'
	'Diana Stone'
	Das (E-mail)
	Dasp (E-mail)
	Diana Stone
	Diana Stone (E-mail 3)
	Diana Stone (E-mail)
	dstone@bushwellorg.com
)
