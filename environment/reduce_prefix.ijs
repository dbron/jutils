reduce_prefix =: ($:~ 3 : '2 {."1 SYSTEMFOLDERS_j_,USERFOLDERS_j_')  : (dyad define)
NB.  To do things like 
NB.  RP =: RECENT_jijs_ reduce_prefix~ 2 {."1 SYSTEMFOLDERS_j_,USERFOLDERS_j_
NB.  assert RECENT_jijs_  -:&:(fread&.>) jpath&.> RP

	r =. 0 $ a:
	for_file. y do.
	   cutfile =. PATHSEP_j_ cut tolower^:IFWIN32 > file

	   file_candidates =. file
	   for_nick_dir. x do.
			'nick dir' =. nick_dir
			cutdir =. PATHSEP_j_ cut tolower^:IFWIN32 dir

			a          =.  i.&0@:=/ cutdir,:cutfile
			relative   =.  (a~:0) # ('~',nick) ; a }. (#cutdir) # <'..'
			candidate  =.  ; }:,(<'\') ,.~ a: -.~ relative , a }. cutfile

			file_candidates =. file_candidates , <candidate
	   end.

		r =. r , ({~ [: (i. <./) #&>) file_candidates -. a:
	end.

    r
)