COMMENTS =: noun define

	Date, time, and calendar conversion information found on:
		http://webexhibits.org/calendars/calendar-christian.html#Anchor-3807
	URL was available as of 2004-June-14.
	


	Q. Is there a formula for calculating the Julian day number?
	
	A.  Try this one (the divisions are integer divisions, in which remainders
	are discarded):
	
	   a = (14-month)/12
	   y = year+4800-a
	   m = month + 12*a - 3
	
	For a date in the Gregorian calendar:
	   JD = day + (153*m+2)/5 + y*365 + y/4 - y/100 + y/400 - 32045
	
	For a date in the Julian calendar:
	   JD = day + (153*m+2)/5 + y*365 + y/4 - 32083
	
	JD is the Julian day number that starts at noon UTC on the specified date.
)

NB.  Integer divide
d		=: <.@:%

NB. timezone - return daylight savings flag, local timezone string, bias string, and bias from UTC (in minutes)
NB. Eg -   timezone ''    ==>  dstflag;'Eastern Standard Time';'(UTC+5)';300
timezone_z_=: verb define

	'TIME_ZONE_ID_UNKNOWN' assert. rc~:0 [ 'rc z'=. 'kernel32 GetTimeZoneInformation i *c' 15!:0 <172#nil=. {.a.
	b=. (2^32)&|&.(+&(2^31)) 256#.|.a.i.4{.z NB. Bias from UTC to local time
	zone=. rc NB. timezone: 0-unknown   1-standard  2-daylight
	db=. zone{0,(2^32)&|&.(+&(2^31))256#.|."1 a.i.z{~84 168+/i.4 NB. bias for standard/daylight
	lb=. (2^32)&|&.(+&(2^31)) b+db NB. local bias including standard/daylight
	zone;(nil-.~zone{'(unknown)',64{."1 ] 2 74$4}.z);('(UTC',('+-'{~lb>0),(":|lb%60),')');lb

)

NB. Local date-time to UTC date-time
convertDateTimeStampInLocalTimeToUTC	=:  verb define

	NB.  The hour has to be in UTC; (so just add the timezone-bias / 60).
	y + 0 0 0 , (60 d~ > {: timezone '') , 0 0
)


NB.  Julian day number from Gregorian date.
julianDayFromGregorianDate =: verb define 
	
	'year month day' =. y

	a  =. (14 - month) d 12
	y  =. year + 4800 - a
	m  =. month + (12*a) - 3
	
	jd =. day + (((153*m)+2) d 5) + (y*365) + (y d 4) - (y d 100) + (y d 400) - 32045

)

NB.  Seconds since date.
getSecondsSinceEpochSinceGregorianDate =: verb define
	
	NB.  This disagrees with http://www.onlineconversion.com/unix_time.htm after leap day, 2000.
	NB.  That page uses built-in javascript date calculation functions.  The page's answers agree in all browsers 
	NB.  (and, hence, in distinct javascript implementations), therefore the page's answers are probably correct.
    ssgd =. (*/  24 60 60) * y -&:julianDayFromGregorianDate 1970 01 01

	NB.  For now, fix with a cheap hack:
	ssgd +  (*/ 2 24 60 60) * 1999 < {. y
)


NB.  Seconds since date-time in UTC.
getSecondsSinceEpochFromGregorianDateTimeInUTC =: verb define
    
	NB.  Seconds until midnight UTC today
	secondsTillToday =. getSecondsSinceEpochSinceGregorianDate 3 {. y

	NB.  Seconds passed since midnight UTC "today".
	secondDuringToday =. <. 24 60 60 #. _3 {. y

	NB.  Seconds since y is seconds up to the date-part of y + seconds passed since midnight UTC in the time-part of y
	secondsTillToday + secondDuringToday 
)

NB.  Seconds since date-time in local time.
getSecondsSinceEpochFromGregorianDateTimeInLocalTime =: verb define

	getSecondsSinceEpochFromGregorianDateTimeInUTC convertDateTimeStampInLocalTimeToUTC y
)

NB.  Seconds since epoch.
getSecondsSinceEpoch					=:  verb define

	getSecondsSinceEpochFromGregorianDateTimeInLocalTime 6!:0''
)