counts					=:  #&> ticks =: -.&a:@:(trim@:({.~ i.&'#')&.>)@:(CRLF&arbCut) each files #~ mask =: (<_1)&~: files =: fread each filenames =: '\\rutherford\dfs\archive\htb\maple\YYYY\MM\DD\confirmed.txt' <@:dateToString"1 ] 6 {."1 dates =: todate (-i. 100) + todayno 3 {. 2003 10 1 11 26 22.924 NB.  6!:0''  NB.  6!:0 was replaced with today's date so this will work when I run it in a month
plot counts
pretty					=:  ls@:(":&.>)@:|:@:(\:"1 {.) freqs =: (((~. ,:~ [: <"0 #/.~))@:; (<"0@:((0.01&round)@:(100&*)@:%~ ;@:{.)~ ,: {:@:[) #) ticks
NB. smoutput pretty 
countsVsDates			=: counts (\:@:[ { ,.) mask # dates
filenamesSortedByCounts	=: counts \:~ mask # filenames

NB.  Find the days with the largest number of HTB tickers, then take the all days within a 1-day radius of those days (i.e. each big HTB day, plus the day before and after)
NB.  _3 ([: ({. -.&.>/ }.) 1 0 2&{)\ ticks #~ +./ 1 (|."0 1~ i: )~ ] 2 > /: \: counts

NB.  Take each big day, remove the 'local' information (i.e. the tickers that were HTB on the big day, the day before, and the day after),
NB.  take the remains and union them.  These will be the tickers that both days have in common that seem 'extra', ie. boh big days contain
NB.  them but the days before and after the big days do not.
extras				=: (e. # [)&>/ <@:~.@:;"1 ]  _3 ([: ({. -.&.>/ }.) 1 0 2&{)\ ticks #~ +./ 1 (|."0 1~ i: )~ 2 > /: \: counts

NB.  These are the tickers that only the big days have.
NB. onlyBigDays			=: /:~ extras #~ (0.01 round 100 * 2 % # ticks) = ; (|: |. freqs) map extras
onlyBigDays			=: bigTicks #~ 2.86 = ; (|: |. freqs) map bigTicks=.(e. # [)&>/ 2 {. counts \:~ ticks
