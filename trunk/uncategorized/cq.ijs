require'dates'
require 'jmf'

NB.  String to int, and int to string.
s2i                =:   6: s: s:
i2s                =:   s2i^:_1 f.



BLOCKSIZ           =:  2 <.@:^ 23 NB.  8MB blocks
scol               =:  dyad define
	NB.  recsiz:        The width of a record, in bytes,
	NB.  fieldoffset:   Number of bytes from into the record at which the key field starts
	NB.  fieldsiz:      Width of the key field, in bytes
	'recsiz fieldoffset fieldsiz'=.x

	NB.  Name of the file containing the records.
	fname          =.  y



	NB.   Reshape a byte vector into a N-by-recsiz table.
	getRecs        =.  recsiz&(] $~ (%~ #) , [)  

	NB.  Pull the key field out of a N-by-recsiz table.
	extractCol     =.  (0 _ ,. fieldoffset , fieldsiz)&(];.0)


	NB.  Size of the file, in bytes.
	fsiz           =.  fsize fname

	NB.  Total number of records in th efile.	
	recount        =.  <. fsiz % recsiz

	NB.  Optimal number of bytes to read per pass.
	NB.  Ie where N = number of records,
	NB.  (recsize * N) <: BLOCKSIZ, and (recsiz * >: N) > BLOCKSIZ
	blocksiz       =.  recsiz (] - |) BLOCKSIZ

	NB.  Number of blocks in the file == 
	NB.  blocks to process == 
	NB.  number of passes to make
	blockcount     =.  >. fsiz % blocksiz


	NB.  The contents of the key field will be stored as ints
	NB.  (output by s2i).  Since an int is 4 bytes, we need to reserve
	NB.  4 * recount bytes for the key field.
	colsiz         =.  4 * recount NB. recount * fieldsiz

	NB.  Create a mapped file to hold the contents of the key field.
	NB.  Slap an extra 500 bytes on the file, to account for JMF header.
    createjmf_jmf_ (500 + colsiz) ;~  tmpfname=.'d:\temp\CQ1P.tmp'
	
	NB.  Map the key field onto a variable, of type with shape (, recount)
	NB. (JINT;,recount) map_jmf_ 'ENCHILADA';tmpfname

	smoutput recount 

	NB.  I don't know why, but the shape of the variable comes out to be (1 , recount)
	NB.  instead of the specified (, recount)
	ENCHILADA      =:  recount $ {. 0 2 NB. ,  ENCHILADA


	NB.  Have processed 0 blocks, initial offset is 0.
	processed      =.   idxoffset =. 0

	smoutput ''
	smoutput 'Reading in key columns.'
	smoutput 'Iteration count:  ' , ": blockcount
	smoutput ''

	NB.  Keep some timing metrics.
	times          =.   ,: 6!:0  ''
	while. processed < blockcount do.  NB.!  < , not <:
		smoutput '--------'
		smoutput 'This is iteration:         ', ": processed

		NB.  Read the next block from the file and extract its key fields.
		NB.  '}:^:(fsiz&<@:(+/))' is because the last block may contain less 
		NB.  records than the others (i.e. fsiz < blockcount * blocksiz).
		data        =.  s2i@:extractCol@:getRecs@:fread fname ;  blocksiz }:^:( fsiz&< @: (+/) ) @: (* , [) processed
		
		NB.  Add the new data to the mapped name.	
		idx         =.  idxoffset + i. datalen =. # data
		ENCHILADA   =:  data idx } ENCHILADA

		NB.  Update counters.
		idxoffset   =.  idxoffset + datalen  
		processed   =.  >: processed 

		NB.  Make sure the user doesn't think we're hanging,
		NB.  Output some timing metrics, and an ETA.
		times       =.  times , 6!:0''
		n           =.  | 2 -&:tsrep/\ times 
		smoutput 'This iteration took:       ' , formatTimeSpan {: n
		smoutput 'Elapsed time:              ' , formatTimeSpan +/ n
		smoutput 'Estimated time remaining:  ' , 'None.'"_^:(-.@:*@:#) formatTimeSpan (blockcount - processed) * (+/ % #) n
		smoutput '--------'
		smoutput ''
	end.


	empty''
)

unmapall_jmf_ ''

ensmallulate =: 0
3 : 0 NB. ''
if. ensmallulate do.
	NB. '\\rttdeveloper\e$\Dailytaq\DailyTAQ.20050224.CQ.bin.10M' fwrite~ fread '\\rttdeveloper\e$\Dailytaq\DailyTAQ.20050224.CQ.bin';0 , 1e6 * 520
else.
	NB.52 40 10 getcol '\\rttdeveloper\e$\DailyTAQ\DailyTAQ.20050224.CQ.bin.sorted'
	NB.52 40 10 getcol '\\rttdeveloper\e$\DailyTAQ\DailyTAQ.20050224.CQ.bin'
   NB. '\\rttdeveloper\e$\Dailytaq\DailyTAQ.20050224.CQ.bin.small' fappend~ fread  '\\rttdeveloper\e$\Dailytaq\DailyTAQ.20050224.CQ.bin' ([ ; fsize@:,&'.small'@:[ , ] ) 1e6 * 52
	smoutput ' records in "small" file.' ,~ fmt 52 %~ fsize '\\rttdeveloper\e$\Dailytaq\DailyTAQ.20050224.CQ.bin.small'
	smoutput 'Run the sort now'
	unmapall_jmf_''
    erase{.;:'ENCHILADA'
	52 40 10 scol '\\rttdeveloper\e$\DailyTAQ\DailyTAQ.20050224.CQ.bin.12M.sorted'
	smoutput i2s ENCHILADA {~ ? 15 # # ENCHILADA


NB.	NUB            =: ~. ENSYMBULATE   
NB.	NUBCOUT        =: # NUB  

	NB.  Get permutation vector for file.
	NB.  Use this to slort the records.
	smoutput ''
	smoutput 'Getting permutation vector'
	time           =. (6!:0'')
	PERMUTATION    =:  /: 6&s:^:_1 ENCHILADA
	GRADE          =:  /: PERMUTATION 
	smoutput 'Elapsed time:                  ' , formatTimeSpan time -&:tsrep~ 6!:0''
	smoutput ''
end.
)