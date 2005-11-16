

NB.* parseDir.ijs: tools to parse text of directory listing.

NB.* parseDir.ijs: tools to parse text of directory listing.
NB.* buildBatFl: build .BAT file to create target dirs and copy files to them.
NB.* makeCopyCmds: make a list of DOS copy commands after creating needed dirs.
NB.* indicateSubdirs: from boolean selecting DIRNMS, indicate all subdirs.
NB.* excludeFiles: exclude designated files from list to back up.
NB.* dirDependencies: convert list of full paths to index vector form of tree 
NB.* getDirFlInfo: get info on dirs and files starting at node specified.
NB.* ExcludeUsual: list of usual files and directories to exclude from backup.
NB.* initFlsDir: parse memory-mapped file of directory listing->file, dir info.
NB.* getInfo: get directory into into file, memory-map and parse it.
NB.* process1Subdir: parse single subdir entry->files, parent dirs as globals.
NB.* extract1SubdirList: get first full sub-directory listing out of many.
NB.* addPath: put new parent/child index in tree from text of "dir\subdirs..."
NB.* Tst0addPath_tests_: test adding path to index vec tree from text.
NB.* mcopyto: text of DOS .BAT file to do multiple copies.

NB. 'FLNMS FLDTS FLSZS FLPARENT DIRNMS DIRDEP'=: getDirFlInfo_parseDir_ 'C:\'
smoutput '6!:2 ''''''FLNMS FLDTS FLSZS FLPARENT DIRNMS DIRDEP''''=:getDirFlInfo_parseDir_ ''''C:\'''''''
NB. (<'\amisc\')
fileVar_WS_&.>'FLNMS';'FLDTS';'FLSZS';'FLPARENT';'DIRNMS';'DIRDEP'
smoutput '(<''\amisc\'')fileVar_WS_&.>''FLNMS'';''FLDTS'';''FLSZS'';''FLPARENT'';''DIRNMS'';''DIRDEP'''
NB. coclass 'parseDir'
NB. 'FLNMS FLDTS FLSZS FLPARENT DIRNMS DIRDEP'=:
FLNMS_base_;FLDTS_base_;FLSZS_base_;FLPARENT_base_;DIRNMS_base_;<DIRDEP_base_
NB. 'batfl cmds'=. buildBatFl_parseDir_ 700e6;'C:\Temp\Recent\'
smoutput '''batfl cmds''=. buildBatFl_parseDir_ 700e6;''C:\Temp\Recent\'''
NB. winexec ('cmd /c ',batfl);1
smoutput 'winexec (''cmd /c '',batfl);1'

coclass 'parseDir'
load 'jmf files dir dt'
coinsert 'base'

buildBatFl=: 3 : 0
NB.* buildBatFl: build .BAT file to create target dirs and copy files to them.
   'szlim targ'=. y.
   xclud=. excludeFiles targ
   dtdord=. xclud-.~\:FLDTS
   ss=. +/\dtdord{FLSZS

   cutoff=. 1 i.~ss>szlim
   ix=. cutoff{.dtdord
   cmds=. (0{DIRNMS),makeCopyCmds targ;<ix   NB. 0{DIRNMS gives disk to which
   tmpd=. getTempDir ''                      NB.  to copy from.
   cmds v2f batfl=. tmpd,'CDMDCopy.bat'
   batfl;<cmds
NB.EG 'batfl cmds'=. buildBatFl 700e6;'C:\Temp\Recent\'
)

makeCopyCmds=: 3 : 0
NB.* makeCopyCmds: make a list of DOS copy commands after creating needed dirs.
   'targ ix'=. y.
   fls=. ix{FLNMS
   drs=. DIRNMS{~ix{FLPARENT
   udrs=. ~.drs
   ord=. /:udrs i. drs
   ptn=. 1,2~:/\ord{udrs i. drs
   fls=. ptn<;.1 ord{fls
   newdrs=. (<targ),&.>udrs}.~&.>2+&.>udrs i.&.>':'
   mknew=. (<'mkdir "'),&.>newdrs,&.>'"'
NB. e.g. mkdir C:\Temp\Recent\amisc\jsys\user\code
   cdnext=. (<'cd "'),&.>udrs,&.>'"'
NB. e.g. cd c:\amisc\jsys\user\code
   cmds=. ''

   for_ii. i. #udrs do.
       mm=. mkMCopyTo 10;(>ii{newdrs);ii{fls
NB. e.g. mcopyto "C:\Temp\Recent\global\fof" "bmkcorr.ijx" "targetbands.xls"...
       cmds=. cmds,(ii{cdnext),(ii{mknew),,mm
   end.
   cmds
)

mkMCopyTo=: 3 : 0
NB. mkMCopyTo  10;targ;fls  NB. -> mcopyto targ fl1 fl2..fl10 ; mcopyto targ
fl11 fl12...
   'npc targ fls'=. y.   NB. Number per copy, target dir, file list
   ptn=. (#fls)$npc{.1
   fls=. ;&.>ptn<;.1 '"',&.>fls,&.><'" '
   cmd=. (<'call mcopyto "',targ,'" '),&.>fls
)

indicateSubdirs=: 3 : 0
NB.* indicateSubdirs: from boolean selecting DIRNMS, indicate all subdirs.
   xdix=. b2i y.
   childxd=. xdix-.~b2i DIRDEP e. xdix
   while. 0<#childxd do.
       xdix=. ~.xdix,childxd
       childxd=. xdix-.~b2i DIRDEP e. xdix
   end.
   xdix                       NB. Index into DIRNMS of all subdirectories.
NB.EG xdix=. indicateSubdirs DIRNMS e. 'c:\amisc';'c:\Program Files'
)

excludeFiles=: 3 : 0
NB.* excludeFiles: exclude designated files from list to back up.
   targ=. y.}.~-PATHSEP_j_={:y.
   sections=. '[ExcludeDirs]';'[ExcludeFiles]'
   xu=. <;._1 LF,ExcludeUsual-.CR
   xu=. xu#~&.>-.&.>+./\&.>(<'NB.')E.&.>xu  NB. Exclude comments
   xu=. xu#~0~:;#&.>xu
   whsect=. >+./&.>sections E.&.>/ xu
   secord=. /:sections i. ' '-.~&.>xu#~+./whsect
   'xd xf'=: secord{(+./whsect)<;._1 xu
   xd=: xd,<targ              NB. Exclude target dir to avoid recursion.
   whxd=. DIRNMS}.~&.>(2*;':'e.&.>DIRNMS)*;DIRNMS i.&.>':'
   whxd=. (toupper&.>whxd)e. PATHSEP_j_,&.>toupper&.>xd
   whxd=. (1) (indicateSubdirs whxd)}whxd
   whxf=. (toupper&.>FLNMS)e. toupper&.>xf
   xclud=. b2i whxf+.FLPARENT e. b2i whxd
NB. xclud is list of indexes into FLNMS=files to exclude.
)

dirDependencies=: 3 : 0
NB.* dirDependencies: convert list of full paths to index vector form of tree 
NB. showing directory and subdirectories as parent-child relations.
   odir=. y.
   DIRDEP=: (#odir)$_1   NB. Dummy entry for 1st node: _1->no parent.
   for_dc. i.#odir do.
       cd=. PATHSEP_j_,~&.>dc{odir
       len=. #>cd        NB. Which prefixes match only current?
       subs=. (;cd-:&.>len{.&.>odir)*.-.;PATHSEP_j_ e.&.>len}.&.>odir
       DIRDEP=: subs}DIRDEP,:dc
   end.
NB.EG dirDependencies 'c:';'c:\t1';'c:\t1\sb1';'c:\t2';'c:\t2\sb2';'c:\t1\sb3'
NB. _1 0 1 0 3 1         NB. Parent index for each input; _1 for no parent.
)

getDirFlInfo=: 3 : 0
NB.* getDirFlInfo: get info on dirs and files starting at node specified.
   tree=. dirtree y.
   DIRDEP=: dirDependencies DIRNMS=. dirpath y.        NB. Dir dependency tree
   fpths=. (}.~(<:@-@(i.&PATHSEP_j_)@|.))&.>0{"1 tree  NB. Paths w/o filenames.
   FLPARENT=: DIRNMS i. fpths                          NB. Parent dirs of files
   assert. FLPARENT *./ . <#DIRNMS                     NB. Found all paths?
   FLNMS=. ((>:@#)&.>fpths)}.&.>0}"1 tree              NB. bare filenames
   FLDTS=: ;100#.&.>3{.&.>1{"1 tree                    NB. Num yyyymmdd dates 
   max=. 5+24 60 60#.24 60 60 NB. Max secs/day + 5 for any leap seconds.
   FLDTS=: FLDTS+max%~;(<24 60 60)#.&.>_3{.&.>1{"1 tree
   FLSZS=: ;2{"1 tree                   NB. Very large files have signed sizes
   FLSZS=: FLSZS+(2^32)*FLSZS<0         NB.  so adjust them.
   FLNMS;FLDTS;FLSZS;FLPARENT;DIRNMS;<DIRDEP
NB.EG 'FLNMS FLDTS FLSZS FLPARENT DIRNMS DIRDEP'=: getDirFlInfo_parseDir_ 'C:\'
)

NB.* ExcludeUsual: list of usual files and directories to exclude from backup.
ExcludeUsual=: 0 : 0
NB. Need to include a [regexp] exclusion section to apply to files, e.g.
"saves-{d}*", "*~", etc.
NB. FD„ExcludeUsual FDST;ŒIO;FLS;DIRS;SDSK;TDSK;XD;XF;W;FLOW;DLOW;GIR
NB. Exclude the usual files and directories from being copied given list of
Files &
NB. Directories (result of munge_dir) & source Disk & target Disk[:\dir] names.
NB.  ŒIO„0 ª FLS DIRS SDSK TDSK„FDST ª SDSK„›SDSK ª XD„'' © Will exclude target
in case its a subdir of the source.
[ExcludeDirs]  NB.          © XD: list of dirs to exclude.
barrasys
CFGSAFE
Data\Aegis
DATA\SCANSOFTDOCS
Data\DailyPx
Data\RussPx
Data\US\DailyPxs
Documents and Settings
FrontPage Webs
GIR
Global\logs
Lotus
MSSQL7
My Documents
NB. (›'GTAAP\GAA\')°.,'_Data' '_Prefs' 'OUTPUTS'
Notes
Program Files
Recycled
Recycler
WINNT
WINNT\profile
amisc\code\R
amisc\comm\Juno
amisc\incoming
amisc\pix
amisc\sound\HarryPotter
amisc\sound\MP3
amisc\sound\music
charlesriver
data\barralin
data\aegis
factset
program files\opera6
samples
system volume information
temp
NB. (›TDSK),SDSK,¨XD,'WINNT\system32' 'WINNT\Debug'   © Prepend disk:, exclude
target.

[ExcludeFiles]   NB. Files to exclude from any directory
EAFE.MDB
EAFE.ZIP
EAFEMSA2K.mdb
NB. Some DBs big enough to be done separately.
Office97.zip
SECURITY
SEDOLS.MDB
SOFTWARE
SYSTEM
SYSTEM.ALT
SecyValOld.MDB
ShortInt.MDB
Trade.MDB
USER0000.log
Valuation.MDB
Valuation.zip
default.dlf
eventlog.log
fold0000.frm
hiberfil.sys
pagefile.sys
pspbrwse.jbf
)

ExcludeProcess=: 0 : 0
  XF„'L'CHGCASE¨XF ª FLOW„'L'CHGCASE¨FLS[;3]         © Lowercase all names to
match because
  FLS„(~FLOW¹XF)šFLS                                   ©  DOS doesnt
distinguish.
  XD„'L'CHGCASE¨XD ª DLOW„'L'CHGCASE¨DIRS[;0]
  W„W/¼½W„œŸ/((½¨XD)†¨¨›DLOW)¹¨›XD ª FLS„(~FLS[;2]¹W)šFLS  © Exclude any file
under this dir.
  FD„FLS DIRS
)

NB. -------- Dir listing fns: parse text file directory listing:
NB. -------- this is a separate way to accomplish what has been done above.
initFlsDir=: 3 : 0
NB.* initFlsDir: parse memory-mapped file of directory listing->file, dir info.
   JCHAR map_jmf_ 'DIRLSTFL';y.
   DBSTR=: LF,' Directory of '
   WHDB=. (CR,DBSTR) E. DIRLSTFL   NB. Where directory breaks are
   WHDB=: (b2i WHDB),<:#DIRLSTFL
   DIRNMS=: FLNMS=: ''
   FLSZS=: DIRPARENT=: FLPARENT=: i.0
   FLDTS=: 0$0.0
)

getInfo=: 3 : 0
NB.* getInfo: get directory into into file, memory-map and parse it.
NB.   winexec 'cmd /C dir /A /S C:\ > C:\allfls2.dir';1
   dirlstfl=. y.
   if. 0=#dirlstfl do.
       dirlstfl=. 'C:\allfls2.dir'
       winexec ('cmd /C dir /A /S C:\ > ',dirlstfl);1
   end.
   initFlsDir dirlstfl
   for_ix. i.<:#WHDB do.
       ch=. extract1SubdirList WHDB{~ix+0 1
       process1Subdir ch
   end.
   unmapall_jmf_ ''
)

process1Subdir=: 3 : 0
NB.* process1Subdir: parse single subdir entry->files, parent dirs as globals.
   ch=. y.
   thisdir=. (($DBSTR)}.ch) {.~ 1 i.~ LF E. ($DBSTR)}.ch
   'isnew thisdn'=. addPath thisdir
   ch=. (<;._1 ch)-.a:             NB. break into lines; no empty lines
   ch=. ch#~' '~:;{.&.>ch          NB. Get rid of lines beginning with space.
   ch=. <;._1&.>' ',&.>dsp&.>ch    NB. break apart lines by spaces
NB. re-join any names with embedded spaces
   ch=. |:>(3{.&.>ch),&.><&.>(}.@;)&.>(' '&,)&.>&.>3}.&.>ch
   chtit=. 'DATE';'TIME';'SIZE';'NAME'  NB. row titles for "ch"
   whmootdirs=. (ch{~chtit i. <'NAME')e. ,&.>'.';'..'
NB. "SIZE" column has "<DIR>" indicator for directory, size for file.
   whdir=. ((ch{~chtit i. <'SIZE')e. <'<DIR>')*.-.whmootdirs
   addPath&.>(<thisdir,'\'),&.>whdir#ch{~chtit i. <'NAME'
   whfls=. -.whdir+.whmootdirs
   ch=. whfls#"1 ch
   FLNMS=: FLNMS,ch{~chtit i. <'NAME'
   FLPARENT=: FLPARENT,(+/whfls)$thisdn
   FLSZS=: FLSZS,;n2j&.>(ch{~chtit i. <'SIZE')-.&.>','
   FLDTS=: FLDTS,;DateTimeCvt &.>,&.>/' ',&.>ch{~chtit i. 'DATE';'TIME'
   thisdn
)

extract1SubdirList=: 3 : 0
NB.* extract1SubdirList: get first full sub-directory listing out of many.
   'st end'=. y.
   ch=. CR-.~(st+i.>:end-st){DIRLSTFL
)

addPath=: 3 : 0
NB.* addPath: put new parent/child index in tree from text of "dir\subdirs..."
   p2a=. <;._1 '\',y.    NB. Path to add, e.g. 'C:\top\mid\bottom'
   p2a=. p2a-.a:
   isnew=. 0
NB.    if. 0=#wh=. b2i DIRNMS e. 0{p2a do.  NB. Completely new root
NB.        DIRPARENT=: DIRPARENT,_1    NB. "Parent Index" of _1 means root
node.
NB.        wh=. <:#DIRNMS=: DIRNMS,0{p2a
NB.        isnew=. 1
NB.    else. wh=. {.wh#~_1=wh{DIRPARENT end.     NB. or same old root
   wh=. _1
   for_nm. p2a do.                 NB. "wh" is parent index of current node...
       if. 0=#wh2=. b2i DIRNMS e. nm do. NB. new subdir
           DIRPARENT=: DIRPARENT,wh
           wh=. {.<:#DIRNMS=: DIRNMS,nm NB. will be parent of next node, if any
           isnew=. 1
       else.
           if. 0=#wh2=. wh2#~wh=wh2{DIRPARENT do. NB. Name exists but with
               DIRPARENT=: DIRPARENT,wh           NB.  different parent.
               wh=. {.<:#DIRNMS=: DIRNMS,nm
               isnew=. 1
           else. wh=. {.wh2 end.                  NB. Name exists with
       end.                                       NB.  same parent
   end.
   isnew,wh                              NB. 0 if path was already here
)

Tst0addPath_tests_=: 3 : 0
NB.* Tst0addPath_tests_: test adding path to index vec tree from text.
   coinsert 'parseDir base'
   d0=. DIRNMS=: 'C:';'Aegis';'WINNT';'Web';'printers';'foo';'Web'
   dp0=. DIRPARENT=: _1 0 0 3 4 0 0

   assert. 0 2-:addPath 'C:\WINNT' NB. Shouldn't add it again.
   assert. d0-:DIRNMS              NB. Should not have changed
   assert. dp0-:DIRPARENT          NB. Should not have changed

   td=. 'D:\foo\bar'               NB. New path starting from new root
   assert. 1 9-:addPath td         NB. but with same-named sub as existing
   assert. (d1=. DIRNMS)-:d0,<;._1 '\',td
   assert. (dp1=. DIRPARENT)-:_1 0 0 0 3 4 0 0 _1 8 9
   assert. 0 9-:addPath td    NB. Shouldn't add it again.
   assert. d1-:DIRNMS         NB. Should not have changed
   assert. dp1-:DIRPARENT     NB. Should not have changed

   assert. 1 10-:addPath 'C:\WINNT\foo'
   1
)

NB.* mcopyto: text of DOS .BAT file to do multiple copies.
mcopyto=: 0 : 0
Rem MCopyTo.bat: Multiple COPY TO %1: copy %2, %3, %4, etc.
:START
If %1/==/ goto SHOWHOW
Set tmpnm=%1
:DO1
If %2/==/ goto BYEBYE
Copy %2 %tmpnm% > nul
Shift
Goto DO1
:SHOWHOW
Echo on
Rem  MCOPY target source1 source2...sourceN
Echo off
Goto BYEBYE
:BYEBYE
Set tmpnm=
)

coclass 'base'

            