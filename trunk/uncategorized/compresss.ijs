New J (504) session started on 2004-11-05 at 11:52:23
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   testC i. 2 10
|value error: fixedCompressblock_jsfl_
|       fixedCompressblock_jsfl_ prepend,int
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   testC i. 2 10
1
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   testC i. 2 10
1
   3!:0 'a'
2
   3!:1 'a'
a
   fixedcompressblock_jsfl_ 3!:1 'a'
@)sa€
   expandblock fixedcompressblock_jsfl_ 3!:1 'a'
|value error: expandblock
|       expandblock fixedcompressblock_jsfl_ 3!:1'a'
   expandblock_jsfl_ fixedcompressblock_jsfl_ 3!:1 'a'
                   
   3!:2 expandblock_jsfl_ fixedcompressblock_jsfl_ 3!:1 'a'
|domain error
|       3!:2 expandblock_jsfl_ fixedcompressblock_jsfl_ 3!:1'a'
   3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1 'a'
|domain error
|       3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1'a'
   wd'qer'
no error : 0
   expandblock_jsfl_ compressblock_jsfl_ 3!:1 'a'
                   
   $expandblock_jsfl_ compressblock_jsfl_ 3!:1 'a'
20
   expandblock_jsfl_ compressblock_jsfl_ 3!:1 'a'
                   
   3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1 'a'
|domain error
|       3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1'a'
   3!:1 expandblock_jsfl_ compressblock_jsfl_ 3!:2 'a'
|rank error
|   3!:1 expandblock_jsfl_ compressblock_jsfl_     3!:2'a'
   3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1 'a'
|domain error
|       3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1'a'
   expandblock_jsfl_ compressblock_jsfl_ 3!:1 'a'
                   
   expandblock_jsfl_ compressblock_jsfl_ ,3!:1 'a'
                   
   3!:2 expandblock_jsfl_ compressblock_jsfl_ ,3!:1 'a'
|domain error
|       3!:2 expandblock_jsfl_ compressblock_jsfl_,3!:1'a'
   a. i. expandblock_jsfl_ compressblock_jsfl_ ,3!:1 'a'
2 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32
   a. i. expandblock_jsfl_ fixedcompressblock_jsfl_ ,3!:1 'a'
2 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32
   a. i. expandblock_jsfl_ fixedcompressblock_jsfl_ 3!:1 ,a=.'a'
2 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32
   a. i. expandblock_jsfl_ compressblock_jsfl_ 3!:1 ,a=.'a'
2 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32
   a -: expandblock_jsfl_ compressblock_jsfl_ 3!:1 ,a=.'a'
0
   a -: 3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1 ,a=.'a'
|domain error
|   a-:    3!:2 expandblock_jsfl_ compressblock_jsfl_ 3!:1,a=.'a'
   a -: expandblock_jsfl_ compressblock_jsfl_ a=.'a'
|domain error: cd
|   'size source dest sourcesize'=.    compress_block source;dest;#source
   a -: expandblock_jsfl_ compressblock_jsfl_ ,a=.'a'
0
   (,a) -: expandblock_jsfl_ compressblock_jsfl_ ,a=.'a'
0
    expandblock_jsfl_ compressblock_jsfl_ ,a=.'a'
 
   a. i. expandblock_jsfl_ compressblock_jsfl_ ,a=.'a'
32
   a. i. expandblock_jsfl_ fixedcompressblock_jsfl_ ,a=.'a'
97
   a -: expandblock_jsfl_ fixedcompressblock_jsfl_ ,a=.'a'
0
   a -: , expandblock_jsfl_ fixedcompressblock_jsfl_ ,a=.'a'
0
   (,a) -:  expandblock_jsfl_ fixedcompressblock_jsfl_ ,a=.'a'
1
   (,a) -:  expandblock_jsfl_ compressblock_jsfl_ ,a=.'a'
0
   (,a) -:  expandblock_jsfl_ fixedcompressblock_jsfl_ ,a=.'a'
1
   a -:  expandblock_jsfl_ fixedcompressblock_jsfl_ a=.,'a'
1
   a -:"1  expandblock_jsfl_&> (compressblock_jsfl_ ; fixedcompressblock_jsfl_) a=.,'a'
0 1
   a -:"1  expandblock_jsfl_&> (compressblock_jsfl_ ; fixedcompressblock_jsfl_) a=.,'a'
          a  -: expandblock_jsfl_ compressblock_jsfl_ a=.,'a'
          a  -: expandblock_jsfl_ compressblock_jsfl_ a=.,'a'
0
   
        (,a) -: expandblock_jsfl_ fixedcompressblock_jsfl_ a=.,'a'
        (,a) -: expandblock_jsfl_ fixedcompressblock_jsfl_ a=.,'a'
1
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   compress
3 : 0
	int =. 3!:1 y.

	if. int e.~ null =. 0 { a. do.
	NB.  Compress doesn't like nulls

		if. 0 < # freeLetters =. a. -. int do.
		NB.  If there's a free letter in the alphabet,
		NB.  encode nulls as that character.

			nullChar=.  {. freeLetters
			int		=.  null sr nullChar int
			prepend	=.  'X' , nullChar
		else.
		NB.  If the data contains all of a., base64 encode it.
		NB.  Since we only want to restrict the alphabet by one character
		NB.  (i.e. to }. a.), there is probably a more efficient encoding 
		NB.  mechanism. Base64 encoding might actually expand the data so
		NB.  much that the benefits of compression are lost.

			int		=. tobase64 int
			prepend =.  '6' 
		end.
	else.
		NB.  No 0s in int .. so leave it as-is
		NB.  int =. ] int

		prepend =. 'N'
	end.
	
...
   3!:1 b. _1
3!:2
   compressblock_jsfl_ b. _1
|domain error
|       compressblock_jsfl_ b._1
   compressblock_jsfl_ ^:_1 'a'
|domain error
|       compressblock_jsfl_^:_1'a'
   encode
|value error: encode
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   enc
encode :.decode
   enc 'clams'
|value error: int
|       int e.~null=.0{a.
   enc 'clams'
|value error: int
|       int e.~null=.0{a.
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   enc 'clams'
|domain error: cd
|   'size source dest sourcesize'=.    compress_block source;dest;#source
   enc 'clams'
|domain error: cd
|   'size source dest sourcesize'=.    compress_block source;dest;#source
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   enc
encode :.decode
   encode
3 : 0
	if. y. e.~ null =. 0 { a. do.
	NB.  Compress doesn't like nulls

		if. 0 < # freeLetters =. a. -. int do.
		NB.  If there's a free letter in the alphabet,
		NB.  encode nulls as that character.

			nullChar=.  {. freeLetters
			int		=.  null sr nullChar y.
			prepend	=.  'X' , nullChar
		else.
		NB.  If the data contains all of a., base64 encode it.
		NB.  Since we only want to restrict the alphabet by one character
		NB.  (i.e. to }. a.), there is probably a more efficient encoding 
		NB.  mechanism. Base64 encoding might actually expand the data so
		NB.  much that the benefits of compression are lost.

			int		=. tobase64 y.
			prepend =.  '6' 
		end.
	else.
		NB.  No 0s in y. .. so leave it as-is
		NB.  y. =. ] y.

		prepend =. 'N'
	end.
)
   encode 'clams'
N
   3!:1 'clams'
clams
   encode 3!:1 'clams'
|syntax error: encode
|   0<#freeLetters=.    a.-.int
   encode 3!:1 'clams'
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   encode 3!:1 'clams'
X
   decode encode 3!:1 'clams'

   a. i. decode encode 3!:1 'clams'

   $ decode encode 3!:1 'clams'
0
   3!:1 'clams'
clams
   a. i. 3!:1 'clams'
2 0 0 0 0 0 0 0 5 0 0 0 1 0 0 0 5 0 0 0 99 108 97 109 115 0 0 0
   encode 3!:1 'clams'
X
   #encode 3!:1 'clams'
2
   erase'compress decompress enc dec encode decode c dc testC sr fixedcompressblock_jsfl_'
1 1 1 1 1 1 1 1 1 1 1
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   dbss 'encode *:*'
|value error: dbss
|       dbss'encode *:*'
   load'debug'
   dbr 1
   dbss 'encode *:*'
   #encode 3!:1 'clams'
|stop: encode
|   y. e.~null=.0{a.
|encode[0]
      dbrun''
|stop
|   0<#freeLetters=.a.-.y.
|encode[3]
      dbrun''
|stop
|   nullChar=.{.freeLetters
|encode[7]
      dbrun''
|stop
|   int=.null sr nullChar y.
|encode[8]
      nullChar

      a. i. nullChar
3
      dbrun''
|stop
|   prepend=.'X',nullChar
|encode[9]
      dbrun''
2
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   dbr 0
      dbrun''\
|length error
|   dbrun    ''\
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   #encode 3!:1 'clams'
2
   encode
3 : 0
	if. y. e.~ null =. 0 { a. do.
	NB.  Compress doesn't like nulls

		if. 0 < # freeLetters =. a. -. y. do.
		NB.  If there's a free letter in the alphabet,
		NB.  encode nulls as that character.

			nullChar=.  {. freeLetters
			int		=.  null sr nullChar y.
			prepend	=.  'X' , nullChar
		else.
		NB.  If the data contains all of a., base64 encode it.
		NB.  Since we only want to restrict the alphabet by one character
		NB.  (i.e. to }. a.), there is probably a more efficient encoding 
		NB.  mechanism. Base64 encoding might actually expand the data so
		NB.  much that the benefits of compression are lost.

			int		=. tobase64 y.
			prepend =.  '6' 
		end.
	else.
		NB.  No 0s in y. .. so leave it as-is
		int		=.  y.
		prepend =. 'N'
	end.

	prepend 
)
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   #encode 3!:1 'clams'
30
   #decode encode 3!:1 'clams'
28
   #3!:2 decode encode 3!:1 'clams'
5
   3!:2 decode encode 3!:1 'clams'
clams
   null =. 0 { a.
   
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   c =. compress@:enc@:(3!:1)
   c
compress@:enc@:(3!:1)
   c^:_1
c^:_1
   c 'hello'
@
ÁXp@helloÀ
   c^:_1 c 'hello'
hello
   c^:_1 c 'hello'
   load 'c:\danielb\applications\compilers\j\current5\temp\4.ijs'
   squish 'hello'
@
ÁXp@helloÀ
   #squish 'hello'
24
   #squish a.
378
   #squish i. 2 10
78
   #squish 4e4 3 ,: 'Hello, world!'
|domain error
|   #squish 40000 3    ,:'Hello, world!'
   #squish 4e4 $ ,: 'Hello, world!'
29811
   fmt #squish 4e4 $ ,: 'Hello, world!'
29,811
   fmt #4e4 $ ,: 'Hello, world!'
40,000
   fmt #,4e4 $ ,: 'Hello, world!'
520,000
   compress ,4e4 $ ,: 'Hello, world!'
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ...
   compress 4e4 $ ,: 'Hello, world!'
|domain error: cd
|   'size source dest sourcesize'=.    compress_block source;dest;#source
   compress 3!:3 4e4 $ ,: 'Hello, world!'
|rank error
|   compress     3!:3 40000$,:'Hello, world!'
   compress 3!:1] 4e4 $ ,: 'Hello, world!'
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ...
   $compress 3!:1] 4e4 $ ,: 'Hello, world!'
29812
   {.compress 3!:1] 4e4 $ ,: 'Hello, world!'
 
   3!:1] 4e4 $ ,: 'Hello, world!'
@ï@œ
Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world...
   null e. 3!:1] 4e4 $ ,: 'Hello, world!'
1
   encode 3!:1] 4e4 $ ,: 'Hello, world!'
X@ï@œ
Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, wo...
   {. encode 3!:1] 4e4 $ ,: 'Hello, world!'
X
   