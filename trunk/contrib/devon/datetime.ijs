

NB.* datetime.ijs: date and time fns.

NB. load '~addons/sfl/sfldates.ijs'   NB. Use C++ Std Template Lib for dates
load 'dates'

NB.* DateTimeCvt: Convert between DOS-style time (YYYYMMDD hh:mm[ap]) & day.fraction.
NB.* DOSTime2DayFrac: DOS date & time MM/DD/YYYY hh:mm[a|p] -> YYYYMMDD.day-fraction.
NB.* DateAdd: limited mimic of VB DateAdd - DateAdd <unit to add>;date;num
NB.* waitUntil: wait until time y. in [abbreviated] TS form: YYYY MM DD [[hh] [[mm] [[ss]]]]
NB.* adt2sqldt: MS Access date time 'M/D/Y h:m:s'->#M/D/Y#
NB.* yy2yyyy: 2-digit to 4-digit year; <:50 is pivot.
NB.* cvtIfDate2Num: assuming slash means [m]m/[d]d/[yy]yy date, convert to YYYYMMDD.
NB.* calcEOMdates: calculate End-Of-Month dates starting in year 0{y. for
NB.* cvtAT: convert vector of timestamps from MSAccess DB to numeric date YYYYMMDD.
NB.* JDCNV: Julian day conversion from http://www.astro.washington.edu/deutsch-bin/getpro/library01.html?JDCNV
NB.* TSDiff: timestamp difference - return difference between 2 timestamps
NB.* TSAdd: add 2 timestamps - return sum of 2 timestamps
NB.* cvtDateTime2numDt: convert multiple (e.g. MS Access) char date-times, e.g.
NB.* dow: Day-of-week for year month day: 0=Sunday
NB.* toJulian: convert YYYYMMDD date to Julian day number.
NB.* toGregorian: convert Julian day numbers to dates in form YYYYMMDD
NB.* cvtY4M2D22YMD: "2002-06-11" -> 20020611 (numeric)
NB.* cvtMDY2Y4M2D2: convert char [m]m/[d]d/[yy]yy -> yyyymmdd (numeric);
NB.* cvtY4M2D22MDY: convert yyyymmdd (numeric) -> [m]m/[d]d/yyyy (char)
NB.* addMos: add N months to date in form Y4M2 (YYYYMM): YYYYMM addMos N.

moAbbrevs=:
'Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';<'Dec'
baseDPM=: 31 28 31 30 31 30 31 31 30 31 30 31  NB. Base # of days per month.
weekDayAbbrevs=: 'Sun';'Mon';'Tue';'Wed';'Thu';'Fri';<'Sat'

DateTimeCvt=: 3 : 0
NB.* DateTimeCvt: Convert between DOS-style time (YYYYMMDD hh:mm[ap]) &
day.fraction
NB.  (single number=<Julian day number>.<day fraction>).
   if. ' '={.0$,y. do.                  NB. Character … number
       'dt tm'=. <;._1 ' ',dsp ,y.      NB. Seperate date and time
       dt=. (toJulian cvtMDY2Y4M2D2 dt)+DOSTime2DayFrac tm
   else. dt=. (cvtY4M2D22MDY toGregorian <.y.),' ',DOSTime2DayFrac 0|y.
   end.
   dt
)

DOSTime2DayFrac=: 3 : 0
NB.* DOSTime2DayFrac: DOS time hh:mm[a|p] -> 0.day-fraction or vice-versa.
   'DOS' DOSTime2DayFrac y.
:
   spd=. 5+*/24 60 60         NB. Seconds per day + 5 for any leap seconds.
   targ=. 'U' chgCase x.      NB. Target direction->'DOS' or 'DF' (day
fraction)
   if. -.isNum y. do. targ=. 'DF' end.
   if. targ-:'DOS' do.
       df=. (12|0{df) 0}df=. }:0 60 60#:<.0.5+spd*1|y.
       df=. ((0{df)+12*0=0{df) 0}df                         NB. 5 leap-seconds
       df=. (}:;(2 lead0s&.>df),&.>':'),(0.4999<:1|y.){'ap' NB. means noon<0.5.
   else. df=. ;n2j&.><;._1 ':',y.#~y. e. ' 0123456789:'     NB. '3:25p'->3 25
       df=. ((0{df)+12*(12~:0{df)*.'pP'e.~{:y.) 0}df
       df=. ((0{df)-12*(12= 0{df)*.'aA'e.~{:y.) 0}df
       df=. 0.999999<.(60*60#.df)%spd
   end.
   df
)

monthAdd=: 4 : 0
   mobase=. 0 12 31
   100#.todate todayno 0 1 0+mobase#:(31*y.)+mobase#.0 _1 0+0 100 100#:x.
)

DateAdd=: 3 : 0
NB.* DateAdd: limited mimic of VB DateAdd - DateAdd <unit to add>;date;num.
NB. Date in form YYYYMMDD.
   ts=. i. 0 [ units=. 'YMDW'      NB. Units are Year, Month, Day, Week.
   'unit dt addnum'=. y.
   assert (unit=. {.toupper unit) e. units
   dpu=. (372 31 1 7){~units i. unit    NB. 372=12*31: provisional "year"
   mobase=. 0 12 31
   assert. dt>18000101   NB. todayno only goes back to this date
   dt=. 0 100 100#:dt
   select. unit
   case. 'D';'W' do. 
       dt=. 100#.todate (dpu*addnum)+todayno dt
   case. 'M';'Y' do.
       fakedayno=. mobase#.0 _1 0+dt
       dt=. 100#.todate todayno 0 1 0+mobase#:fakedayno+dpu*addnum
   end.
   assert. dt>18000101   NB. todayno only goes back to this date
NB. dtdifs=. 2-/\todayno&>(<0 100 100)#:&.> dtsa=.
DateAdd&>(<'D';20050101),&.><&.>i:_10000
NB. 1 *./ . = dtdifs
NB. dtdifs=. 2-/\todayno&>(<0 100 100)#:&.> dtsa=.
DateAdd&>(<'W';20050101),&.><&.>i:_10000
NB. 7 *./ . = dtdifs
)

DateAddOLD=: 3 : 0
NB.* DateAdd: limited mimic of VB DateAdd - DateAdd <unit to add>;date;num
   ts=. i. 0 [ units=. 'YMDW'      NB. Units are Year, Month, Day, Week.
   'unit dt add'=. y.
   unit=. {.'U' chgCase unit
   assert unit e. units
   if. 'W'=unit do. add=. 7*add [ unit=. 'D' end.
   summand=. 6{.add (units i. unit)}(#units)$0
   ts=. 100#.3{.>1{summand TSAdd 6{.0 100 100#:dt
NB.EG DateAdd 'D';20040524;_45
)

waitUntil=: 3 : 0
NB.* waitUntil: wait until time y. in [abbreviated] TS form: YYYY MM DD [[hh]
[[mm] [[ss]]]]
   6!:3 (0>.>0{y. TSDiff 6!:0 '')
NB.EG 'Happy New Year!' [ waitUntil 2004 12 31 23 59 59
)

adt2sqldt=: (1&|.)@('##'&,)@((]i.&' '){.])   NB.* MS Access date time 'M/D/Y h:m:s'->#M/D/Y#

yy2yyyy=: 3 : 0
NB.* yy2yyyy: 2-digit to 4-digit year; <:50 is pivot.
   if. -.isNum yy=. y. do. yy=. _".yy end.
   yy+(yy<:50){1900 2000
)

cvtIfDate2Num=: 3 : 0
NB.* cvtIfDate2Num: assuming slash (or dash) means [m]m/[d]d/[yy]yy date,
NB. -> character yyyymmdd.
   if. +./'-/' e. y. do.
       dlim=. {.y.-.'0123456789'        NB. Assume delimiter is 1st
non-numeral.
       y.=. ":dlim cvtMDY2Y4M2D2 y. 
   end.
   y.                                   NB. Return input if not date.
)

cvtTS2Access=: 3 : 0
NB. cvtQTS2Access: convert J timestamp to MS Access date:
NB. YYYY MM DD hh mm ss.ms -> MM/DD/YYYY hh:mm:ss
   if. 0=#y. do. dt=. qts ''
   else. dt=. 6{.y. end.
   dt=. (1 2 0 3 4 5 ){dt               NB. Reorder YMD->MDY.
   dt=. (roundNums 5{dt) 5}dt           NB. Round to whole seconds.
   dt=. <("1)2 3$dt                     NB. Separate date & time.
   dt=. (>":&.>&.>dt),&.>("1 0)'/:'     NB. M D Y ->"M/D/Y/" & h m s ->"h:m:s:"
   dt=. (_3{.&.>(<'00'),&.>1{dt) 1}dt   NB. Pad time w/leading 0s.
   dt=. }:&.>dsp&.><"1 ;"1 dt           NB. Drop excess trailing delimiters,
   dt=. }:;dt,&.>' '                    NB.  join date & time -> "M/D/Y
hh:mm:ss"
NB.EG cvtTS2Access 6!:0 ''
)

normAccessDate=: 3 : 0
NB. normAccessDate: convert MS Access dates with usually useless timestamp
NB. to simple date, e.g. YYYY-MM-DD hh:mm:ss -> (numeric) YYYYMMDD.
   if. isNum 0{y. do.                   NB. YYYYMMDD -> 'MM/DD/YYYY'
       xp=. 1 1 1 1 0 1 1 0 1 1 0
       tmp=. y.
       dts=. ''
       while. 0<#tmp do.
          dd=. }.4|.xp exp ": >0{tmp         NB. 20030524 -> 05 24 2003
          dts=. dts,<'/' (b2i -.}.4|.xp)}dd  NB. -> 05/24/2003
          tmp=. }.tmp
       end.
   else.                                NB. YYYY-MM-DD hh:mm:ss -> YYYYMMDD
       dts=. boxopen y.
       dts=. ;0".&.>'-'-.~&.>dts {.~ &.> dts i. &.> ' '
   end.
   dts
)

cvtAccessIODates=: 3 : 0
NB. cvtAccessIODates: stupid MS Access exports dates in form YYYY-MM-DD that
NB. it won't accept for import: convert between this and MM/DD/YYYY form.
   y.=. y.{.~y. i. ' '        NB. 2002-01-23 12:34:46 -> 2002-01-23
   if. '-' e. y. do.          NB. Dash delimiter: YYYY-MM-DD -> MM/DD/YYYY
       y.=. (y.='-')}y.,:'/'
       dt=. y.
       wh=. >:dt i. '/'            NB. Pull off [YY]YY/
       dt=. (wh}.dt),_1|.wh{.dt    NB. YYYY/MM/DD -> MM/DD/YYYY
       y.=. dt,y.}.~y. i. ' '      NB. Put date back on first.
   elseif. '/' e. y. do.           NB. Slash delimiter: MM/DD/YYYY -> YYYY-MM-DD
       y.=. (y.='/')}y.,:'-'
       if. ' ' e. y. do.
           dt=. y.
           wh=. ->:(|.dt) i. '-'   NB. Pull off "-[YY]YY"
           dt=. (wh}.dt),~1|.wh{.dt     NB. MM-DD-YYYY -> YYYY-MM-DD
           y.=. dt,y.}.~y. i. ' '  NB. Put date back on first.
       end.
   end.
   y.
)

calcEOMdates=: 3 : 0
NB.* calcEOMdates: calculate End-Of-Month dates starting in year 0{y. for
NB. 1{y. years.  Account for weekends but not any holidays.
   'styr numyrs'=. y.
   eomdts=. (styr+i.numyrs),&.>/(i.12)                 NB. Start with YYYY MM
   eomdts=. eomdts,&.>(1{&.>eomdts) d14&.>0{&.>eomdts  NB.  ,last calendar day.
   eomdts=. eomdts+&.><0 1 0                           NB. Origin-1 months
   dd=. dow&.>eomdts                                   NB. Days-of-week
   weekdayshift=. dd{&.><2 0 0 0 0 0 1       NB. Move back 2 days for Sunday,
   eomdts=. eomdts-&.>(<0 0),&.>weekdayshift NB. or 1 for Saturday.
NB. Returns (numyrs,12)$<YYYY MM DD date numbers.
NB.EG eomdts=. calcEOMdates 2003 5
)

cvtAT=: 3 : 0
NB.* cvtAT: convert vector of timestamps between MS Access DB form
NB. 'MM/DD/YYYY hh:mm:ss' and numeric date YYYYMMDD.
   if. isNum y. do.
       cvtTS2Access 0 100 100#:y.
   else. cvtDateTime2numDt y. end.
)

JDCNV=: 3 : 0
NB.* JDCNV: Julian day conversion from
http://www.astro.washington.edu/deutsch-bin/getpro/library01.html?JDCNV
   'yr mn day hr'=. y.
NB.  yr = long(yr) & mn = long(mn) &  day = long(day);Make sure integral
   L=. (mn-14)%12        NB. In leap years, -1 for Jan, Feb, else 0
   julian=. day-32075+(1461*(yr+4800+L)%4)+(367*(mn - 2-L*12)%12) - 3*((yr+4900+L)%100)%4
   julian=. julian+(hr%24)-0.5
)

TSDiff=: 4 : 0
NB. Still has bug: will give year, month, or day of 0.
NB.* TSDiff: timestamp difference - return difference between 2 timestamps
NB. in form Y M D h m s= years months days hours minutes seconds.
   timebase=. 0 12 31 24 60 60
   'x. y.'=. (#timebase){.&.>x.;<y.     NB. Pad trailing with 0s if missing.
   secs=. ;(<timebase)#.&.>x.;<y.
   swaphilo=. 0
   if. </secs do. swaphilo=. 1 [ secs=. |.secs end.
   diff=. timebase#: ds=. -/secs
   if. swaphilo do.'ds diff'=. -&.>ds;diff end.
   ds;diff     NB. Difference in both seconds and in Y M D h m s.
NB.EG (6!:0 '') TSDiff ts [ 6!:3,10 [ ts=. 6!:0 ''  NB. 10-sec delay
)

TSAdd=: 4 : 0
NB. Still has bug: will give year, month, or day of 0.
NB.* TSAdd: add 2 timestamps - return sum of 2 timestamps
NB. in form Y M D h m s= years months days hours minutes seconds.
   timebase=. 0 12 31 24 60 60
   'x. y.'=. (-#timebase){.&.>x.;<y.    NB. Pad leading with 0s if missing.
   secs=. ;(<timebase)#.&.>x.;<y.
   sum=. timebase#: ds=. +/secs
   ds;sum      NB. Difference in both seconds and in Y M D h m s.
NB.EG (6!:0 '') TSAdd 10 15              NB. 10 min, 15 seconds from now.
)

showdate=: 3 : 0
NB. showdate: show given, or current if arg '', date & time in standard form.
NB. Can show 60 in seconds position because rounded to nearest second and
NB. carrying because of rounding gets too complicated.
   y.=. ,y.                        NB. Must be vector.
   if. 0=#y. do. y.=. 6!:0 '' end. NB. Arg is timestamp: YYYY MM DD hh mm ss
   dt=. }:;(":&.>3{.y.),&.>'/'
   if. 3=#y. do. tm=. '' else.
       tm=. }:;(_2{.&.>(<'00'),&.>' '-.~&.>2j0":&.>3}.y.),&.>':' NB. Leading 0s
   end.
   dt,((0~:#tm)#' '),tm
NB.EG showdate 1959 5 24 8 9 0
NB.EG showdate ''                  NB. Current date and time
NB.EG >}.<;._1 ' ',showdate ''     NB. Time only
NB.EG showdate 1992 12 16          NB. Date only
)

cvtDateTime2numDt=: 3 : 0
NB.* cvtDateTime2numDt: convert multiple (e.g. MS Access) char date-times, e.g.
NB. "1995-02-28 00:00:00", to numeric dates, e.g. 19950228.
   dt=. boxopen y.=. ,y.
   dlim=. ('-' e. >0{dt){'/-'
   dt=. dt {.~ &.> ' 'i.~ &.> dt
   dt=. ;dlim cvtY4M2D22YMD dt
NB.EG cvtDateTime2numDt '1995-05-31 12:34:56';<'1995-06-30 00:00:00'
)

cvtD2M3Y22MSDSY=: 3 : 0
NB. cvtD2M3Y22MSDSY: e.g. 31-Jul-02 -> 7/31/02.
   if. 0~:#y. do.
       y.=. ,y.
       dlim=. {.~.y. -. '0123456789'    NB. Assume delimiter whatever not num.
       dt=. <;._1 dlim,y.
       mo=. >:('U' chgCase &.> moAbbrevs) i. <'U' chgCase >1{dt
       }:;(":&.>mo;0 2{dt),&.>'/'
   else. y. end.
)

m11=: 0: ~:/ .= 4 100 400"_ |/ ]   NB. Is y a leap year?
m12=: 28"_ + m11@]                 NB. Number of days in February of year y
d13=: 31"_ - 2: | 7: | [           NB. days in month x, not = 1
d14=: d13`m12@.([=1:)              NB. Number of days in month x of year y
m22=: -/@:<.@(%&4 100 400)"0       NB. # of leap days in year yyyy (Clavian corr.)
m21=: >:@(365&* + m22)@(-&1601)    NB. # of New Year's Day, Gregorian year y;
m21 1601 is 1.
dowsoy=: 7&|@m21    NB. Day of week for start of year YYYY: 0=Sunday

dow=: 3 : 0
NB.* dow: Day-of-week for year month day: 0=Sunday
   7|+/(dowsoy 0{y.),(;(i. 0>. <:1{y.) d14 &.> 0{y.),<:2{y.
)

isLeapYr=: 0: ~:/ .= 4 100 400"_ |/ ]

toJulian=: 3 : 0
NB.* toJulian: convert YYYYMMDD date to Julian day number.
   dd=. |: 0 100 100 #: y.
   mm=. (12*xx=. mm<:2)+mm=. 1{dd
   yy=. (0{dd)-xx
   nc=. <.0.01*yy
   jd=. (<.365.25*yy)+(<.30.6001*1+mm)+(2{dd)+1720995+2-nc-<. 0.25*nc
NB.EG toJulian 19590524 19921216
)

toGregorian=: 3 : 0
NB.* toGregorian: convert Julian day numbers to dates in form YYYYMMDD
NB. (>15 Oct 1582).  Adapted from "Numerical Recipes in C" by Press,
NB. Teukolsky, et al.
   igreg=. 2299161        NB. Gregorian calendar conversion day (1582/10/15).
   xx=. igreg<:ja=. <. ,y.
   jalpha=. <.((<.(xx#ja)-1867216)-0.25)%36524.25
   ja=. ((-.xx) expand (-.xx)#ja)+xx expand (xx#ja)+1+jalpha-<.0.25*jalpha
   jb=. ja+1524
   jc=. <.6680+((jb-2439870)-122.1)%365.25
   jd=. <.(365*jc)+0.25*jc
   je=. <.(jb-jd)%30.6001
   id=. <.(jb-jd)-<.30.6001*je
   mm=. mm-12*12<mm=. <.je-1
   iyyy=. iyyy-0>iyyy=. (<.jc-4715)-mm>2
   gd=. (10000*iyyy)+(100*mm)+id
)

NB. Date fns: convert between different date formats.
cvtY4M2Mos=: 3 : '12#.(0 100#:y.)-0 1'  NB. 200011 -> 24011
cvtMo2Y4M2=: 3 : '100#.0 1+0 12#:y.'    NB. 24010 -> 200010
cvtMDY2Y4M2=: (".)@((_4&{.),(2&{.))     NB. "11/30/1999" -> 199911 (numeric)

cvtY4M2D22YMD=: 3 : 0
NB.* cvtY4M2D22YMD: "2002-06-11" -> 20020611 (numeric)
   '-' cvtY4M2D22YMD y.
:
   if. 0~:#y. do.
       dlim=. x.
       dts=. (dts i. &.>' '){.&.>dts=. boxopen y.
       dts=. ((5}.&.>dts),&.>dlim),&.>4{.&.>dts
       dts=. dlim cvtMDY2Y4M2D2 &.> dts
   else. y. end.
NB.EG dts=. cvtY4M2D22YMD '1959-5-24';'1992-12-16';<'1959-05-06'
)

cvtMDY2Y4M2D2=: 3 : 0
NB.* cvtMDY2Y4M2D2: convert char [m]m/[d]d/[yy]yy -> yyyymmdd (numeric);
NB. x. is optional delimiter character if not '/'.
   '/' cvtMDY2Y4M2D2 y.  NB. Assume slash delimiter.
:
   if. 0~:#y. do.
       ptn=. <;._1 ((x.~:0{y.)#x.),y.
       ymd=. ".&.>ptn
       if. 100 > year=. >2{ymd do.
           if. 80 > year do. year=. year+2000
           else. year=. year+1900 end.
           ymd=. (<year) 2}ymd
       end.
       100#.;_1|.ymd
   else. y. end.
NB.    cvtMDY2Y4M2D2&.>'3/14/01';'5/9/99';'2/6/1999';'12/16/79';'2/18/80'
NB. +--------+--------+--------+--------+--------+
NB. |20010314|19990509|19990206|20791216|19800218|
NB. +--------+--------+--------+--------+--------+
)

cvtY4M2D22MDY=: 3 : 0
NB.* cvtY4M2D22MDY: convert yyyymmdd (numeric) -> mm/dd/yyyy (char)
NB. x. is optional delimiter character if not '/'.
   '/' cvtY4M2D22MDY y.  NB. Assume slash is delimiter.
:
   if. 0~:#y. do.
       y.=. ''$y.
       dlim=. x.
       dt=. (":&.>1|.0 100 100#:y.),&.>1 1 0{.&.>dlim
       ;_3 _3 _4{.&.>(<'0000'),&.>dt    NB. Pad with leading 0s
   else. y. end.
NB.EG cvtY4M2D22MDY 19730131
)

addMos=: 3 : 0
NB.* addMos: add N months to date in form Y4M2 (YYYYMM): YYYYMM addMos N.
   (100 #. 2{.6!:0 '') addMos y.        NB. Assume current date if none given.
:
   1+100#.0 12#:y.+12#.0 100#:x.-1
NB.EG    199909 addMos 16
NB.EG 200101
)

NB. From: "RISKS List Owner" <risko@csl.sri.com>
NB. Date: Sat, 27 Jul 2002 12:41:31 PDT
NB. Subject: [risks] Risks Digest 22.18
NB. To: risks@csl.sri.com
NB.
NB. Date: Wed, 24 Jul 2002 18:37:22 +0100
NB. From: John Stockton <spam@merlyn.demon.co.uk>
NB. Subject: Possible day-of-week error - Zeller
NB.
NB. Algorithms for determining the day-of-week from year-month-day -
NB. whether or not truly Zeller's - can, for certain dates, compute a negative
NB. number mod 7, which does not yield the desired result.  Zeller himself
NB. dealt with this.
NB.
NB. Tests using "current" dates in the later 1900's would not have seen
NB. this problem.
NB.
NB. A good test date is 2001-03-01 (1st March 2001); the algorithm can
NB. easily be run manually.
NB.
NB. The problem has been seen, for example, in C code in an Internet draft.
NB.
NB. Those whose systems do suitable run-time checking may already have
NB. discovered the problem.
NB.
NB. John Stockton, Surrey, UK.  http://www.merlyn.demon.co.uk/programs/
NB. Dates: miscdate.htm moredate.htm js-dates.htm pas-time.htm critdate.htm
NB. etc.
