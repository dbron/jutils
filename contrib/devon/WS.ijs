

NB.* WS.ijs: (partially) emulate APL WS - save variables to
NB. files.  Only works on base namespace and does not
NB. handle scripts.  Last updated 20040707 1215.

NB.* loadAllVars: load all variables into base namespace from dir
NB.* saveAllVars: save all vars in base namespace to dir specified.
NB.* fileVar: put variable named by y. (e.g. "xxx") into file (e.g.
NB.* unfileVar: get variable named by y. from file; inverse of fileVar.
NB.* unfile1Var: retrieve value of variable from file and instantiate in
NB.* getFileDir: get file-directory from directory y. or create if none.
NB.* putFileDir: put file-directory x. into directory y.
NB.* chgCase: change text to Lower or Upper given 'L' or 'U' as right
NB.* baseNum: return number y. in base with digits x.: positive
NB.* f2v: File to Vector: read file -> vector of lines.
NB.* v2f: Vector to File: write vector of lines to file as lines.
NB.* l2v: Lines to Vec: convert lines terminated by LF to vector elements.
NB.* getTempDir: get name of temporary directory.

coclass 'WS'
require&.>'strings';'winapi'
DIRFL=: '#dir.dir'       NB. Name of directory file which maps
                         NB. file names to variable names.
USAGE=: 0 : 0
The 2 top-level functions are "saveAllVars" and "loadAllVars".

   saveAllVars_WS_ ''
saves all variables from the base namespace to the temp directory.

   loadAllVars_WS_ ''
restores these variables to the base namespace.

The directory to which files are written, along with the
directory file named by "DIRFL", is the right argument of
"saveAllVars" and "loadAllVars".  The default is the temp
directory (returned by "getTempDir".)  Individual variables 
may be written to or read from file with "fileVar" and "unfileVar",
respectively.
)

loadAllVars=: 3 : 0
NB.* loadAllVars: load all variables into base namespace from dir
NB. specified (default is temp dir).
   if. 0=#y. do. unfileVar ''
   else. y. unfileVar ''
   end.
NB.EG nms=. loadAllVars '\temp\foo'
)

saveAllVars=: 3 : 0
NB.* saveAllVars: save all vars in base namespace to dir specified.
   nmlst=. <;._1 ' ',dsp,(names__ 0),"1 ' '
   if. -.dirExists y. do.               NB. Wait for dir to
       6!:3,1 [ rc=. 1!:5 <y. end.      NB.  be created.
   nmFlnms=. (<y.) fileVar&.>nmlst      NB. List files saved to.
NB.EG fileNames=. saveAllVars '\temp\foo'
)

fileVar=: 3 : 0
NB.* fileVar: put variable named by y. (e.g. "xxx") into file (e.g.
NB. "xxx.dat") under directory x..  The directory must have a directory
NB. file that matches file names to variable names.  We have to do this
NB. because in OSs that are case-insensitive, we need to distinguish
NB. distinct J names that map to same OS file name, e.g. 'aa' and 'AA'.
   (getTempDir '') fileVar y.
:
   if. ' '~:{.0$y. do. 0;<'Right argument must be variable name.'
       return. end.
   if. 1<#$y. do. 0;<'Right argument must be single variable name.'
       return. end.
   y.=. ,y.
   if. 0>4!:0 <y.,'__' do. 0;<'No such variable "',(,":y.),'"' return.
   end.                                 NB. Var must exist.
   alph=. '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_'
   'dir fldir'=. getFileDir x.
   if. (<y.) e. 1{fldir do.             NB. Already have this on file?
       wh=. (1{fldir) i. <y.            NB. If so, look up its filename.
       flnm=. >wh{0{fldir
   else.                                NB. If not, create a filename.
       len=. 8<.#y.                     NB. Use <: 1st 8 chars of name
       flnm=. 'U' chgCase len{.y.
       flnm=. flnm,'.DAT'
       while. fexist dir,flnm do.       NB. Ensure it's unused filename.
           flnm=. 'U' chgCase len{.y.
           flnm=. flnm,(alph baseNum ?2147483647),'.DAT'
       end.
       (fldir,.flnm;<y.) putFileDir dir NB. put back directory.
   end.
   (3!:1 (".y.,'__')) 1!:2 <dir,flnm    NB. var->file
   1;<flnm
NB.EG (<'C:\Temp\') fileVar&.>'hdr';<'dbmat' [ hdr=: hdr [ dbmat=: dbmat
)

unfileVar=: 3 : 0
NB.* unfileVar: get variable named by y. from file; inverse of fileVar.
NB. x. is directory in which to find FILEDIR and files of vars.
   (getTempDir '') unfileVar y.
:
   'dirloc fldir'=. getFileDir x.
   if. 0 e. $fldir do. 0;'No directory in ','.',~x. return. end.
   flnm=. ''
   if. 0=#y. do.                        NB. All names if '' specified
       rc=. unfile1Var &.> (<<dirloc),&.><"1 |:fldir
   else.
       if. (<y.) e. 1{fldir do.         NB. Is this var name on file?
           wh=. (1{fldir) i. <y.        NB. If so, look up its filename.
           flnm=. >wh{0{fldir
           rc=. unfile1Var dirloc;wh{"1 fldir     NB. Instantiate it.
       else. rc=. 0;<'Var not found: ',y.
       end.
   end.
   rc
NB.EG rc=. '\GIR\Data\TC030703' unfileVar_WS_ ''
)

getFileVarVal=: 3 : 0
NB.* getFileVarVal: get value of variable named by y. from file but do NOT
NB. instantiate variable itself; x. is directory with var directory and
NB. files of var values.
   (getTempDir '') unfileVar y.
:
   'dirloc fldir'=. getFileDir x.
   flnm=. ''
   if. 0 e. $fldir do. 0;'No directory in ','.',~x. return. end.
   if. (<y.) e. 1{fldir do.         NB. Is this var name on file?
       wh=. (1{fldir) i. <y.        NB. If so, look up its filename.
       if. fexist flnm=. dirloc,>wh{0{fldir do.
           1;<3!:2 (1!:1 <flnm)
        else.
           0;<'File not found: ','.',~flnm
       end.
   else. 0;<'Var ',y.,' not found in file dir ','.',~x.
   end.
NB.EG var=. '\Data\Pxs\' getFileVarVal_WS_ 'Pxs020101_021231'
)

unfile1Var=: 3 : 0
NB.* unfile1Var: retrieve value of variable from file and instantiate in
NB. base locale given filedir entry y.: directory, file name, var name.
   'dirloc flnm varnm'=. y.
   flnm=. dirloc, flnm
   if. fexist flnm do.
       [".varnm,'__=. 3!:2 (1!:1 <flnm)'
       1;<y.
    else.
       0;<'File not found: ',flnm
   end.
)

getFileDir=: 3 : 0
NB.* getFileDir: get file-directory from directory y. or create if none.
   dirloc=. y.,('\'~:{:y.)#'\'
   dfn=. dirloc,DIRFL                   NB. Directory-File Name
   if. fexist dfn do.
       fldir=. deb&.>f2v dfn
       fldir=. |:><;._1&.>' ',&.>fldir  NB. FILENAME Varname
       fldir=. ('U' chgCase&.>0{fldir) 0}fldir
   else. fldir=. 2 0$<''                NB. start empty file directory
   end.
   dirloc;<fldir
)

putFileDir=: 4 : 0
NB.* putFileDir: put file-directory x. into directory y.
   dir=. y.,('\'~:{:y.)#'\'
   dfn=. dir,'#dir.dir'                 NB. Directory-File Name
   (}:&.>,&.>/x.,&.>' ') v2f dfn        NB. put back directory.
)

NB. --------- General utilities follow ---------------

dsp=: deb"1@dltb"1
isNum=: 3 : '0=1{.0$y.'  NB. 1 if numeric arg
nameExists=: 3 : '0<:4!:0 boxopen y.'   NB. 1 if var or fnc name exists.
dirExists=: 3 : '0~:#(1!:0)@< (-''\''={:y.)}.y.'  NB. 0: dir does not
                                                  NB. exist; 1: exists.
chgCase=: 3 : 0
NB.* chgCase: change text to Lower or Upper given 'L' or 'U' as right
NB. argument or numeric arg: 1=uppercase, else lower.
   'L' chgCase y.                 NB. Default conversion to lowercase.
:
   if. 0=1{.0$x. do. x.=. (1={.x){'LU' end.
   dir=. 2|'LUl' i. {. x.
   alp=. 'abcdefghijklmnopqrstuvwxyz';'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
   FROM=. >(-.dir){alp [ TO=. >dir{alp
   y.=. ,y. [ shape=. $y.
   wh=. y. e. FROM
   ix=. FROM i. wh#y.
   y.=. shape$(ix{TO) (wh#i.$wh)} y.
)

baseNum=: 4 : 0
NB.* baseNum: return number y. in base with digits x.: positive
NB. integers only.
   len=. #alph=. x. [ num=. y.
   if. isNum num do.
       digits=. >:<.len^.1>.num
       alph{~(digits$len)#:num
   else.                           NB. Assume "number" is character -
       len#.alph i. num            NB. convert to base 10 number.
   end.
NB.EG '0123456789ABCDEF' baseNum 255
NB.EG '0123456789ABCDEF' baseNum 'FF'
)

f2v=: 3 : 0
NB.* f2v: File to Vector: read file -> vector of lines.
   vec=. l2v 1!:1 <y.
)

v2f=: 4 : 0
NB.* v2f: Vector to File: write vector of lines to file as lines.
   if. -.nameExists 'EOL' do. EOL=. LF end.
   (;x.,&.><EOL) 1!:2 <y.
NB.EG ('line 1';'line 2';<'line 3') v2f 'C:\test.tmp'
)

l2v=: 3 : 0
NB.* l2v: Lines to Vec: convert lines terminated by LF to vector elements.
   vec=. y.
   if. 0~:#y. do.
       vec=. vec-.CR               NB. Only single-char for line delim
       vec=. vec,(LF~:{:vec)#LF    NB. Ensure terminal line delimiter
       whq=. ~:/\'"'=vec           NB. Mask interiors of quoted strings
       ptn=. LF=vec                NB. Partition lines but
       ptn=. ptn*.-.whq*.ptn       NB.  exclude quoted end-of-lines
       vec=. ptn <;._2 vec         NB. Make into vector of lines
   end.
   vec
)

getTempPath=: 'GetTempPath' win32api
getTempDir=: 3 : 0
NB.* getTempDir: get name of temporary directory.
   td=. >2{getTempPath 256;256$' '
   td=. td{.~td i. 0{a.
)

cocurrent 'base'
coinsert 'WS'
NB. Initiated by Devon H. McCormick, 20030711.

            