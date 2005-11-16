MESSAGE=: noun define
Received: from mailrelay.mapleusa.com ([172.25.10.40]) by hess.mapleusa.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id QB95PHMV; Wed, 6 Aug 2003 07:52:38 -0400
Received: from cherry.ease.lsoft.com (cherry.ease.lsoft.com [209.119.0.109])
	by mailrelay.mapleusa.com (Postfix) with SMTP
	id 27C62430F9; Wed,  6 Aug 2003 07:55:58 -0400 (EDT)
Received: from PEAR.EASE.LSOFT.COM (209.119.0.19) by cherry.ease.lsoft.com (LSMTP for Digital Unix v1.1b) with SMTP id <14.00AC26FC@cherry.ease.lsoft.com>; Wed, 6 Aug 2003 7:52:27 -0400
Received: from PEACH.EASE.LSOFT.COM by PEACH.EASE.LSOFT.COM (LISTSERV-TCP/IP
          release 1.8e) with spool id 50366525 for JFORUM@PEACH.EASE.LSOFT.COM;
          Wed, 6 Aug 2003 07:52:09 -0400
Received: from 209.119.0.7 by WALNUT.EASE.LSOFT.COM (SMTPL release 1.0i) with
          TCP; Wed, 6 Aug 2003 07:52:09 -0400
Received: from PEACH.EASE.LSOFT.COM (lists.state.gov) by wnt.dc.lsoft.com
          (LSMTP for Windows NT v1.1b) with SMTP id
          <0.00127154@wnt.dc.lsoft.com>; Wed, 6 Aug 2003 7:51:23 -0400
Message-ID:  <LISTSERV%2003080607511618@PEACH.EASE.LSOFT.COM>
Date:         Wed, 6 Aug 2003 07:51:16 -0400
Reply-To: J Forum <JFORUM@PEACH.EASE.LSOFT.COM>
From: Paul Chapman <paul@IGBLAN.COM>
Subject: [Jforum] @:-train implementation
To: JFORUM@PEACH.EASE.LSOFT.COM
Precedence: list


I've implemented my proposed @:-train syntax as an adverb - or rather a
conjunction which inserts a conjunction of the user's choice between verbs
in a verb train.  The insertion is NOT recursively applied to nested trains.

It's not pretty, but it seems to work.

   conjs =: 2 : 0
a =. a: 0}]`x.
lh =. >@{.
rh =. >@{:
list =. <@,"0 '32'
isEmpty =. 0: = #
isTrain =. +.`*./ @: ((=&list @: {. @: rh) , isEmpty@lh)
isDone =. isEmpty@rh
curtail =. }: @: > @: {: @: rh
tail =. {: @: > @: {: @: rh
caseTrain =. (lh , curtail) ; tail
caseNotrain =. (lh , {:) ; a:"_
switch =. isTrain (+ +:) isDone
step =. caseNotrain`caseTrain`] @. switch
b =. >{.step^:_ a
c =. ({.b) , <}.b
at =. (<y.)"_
caseAtop =. (at , (<@lh <@, {.@rh)) ,&< }.@rh
d =. {.(caseAtop`] @. isDone)^:_ c
d 5!:0
							)

   ats =: conjs '@:'

   (f g)ats
f@:g
   (f g h)ats
f@:g@:h
   (f g h i)ats
f@:g@:h@:i
   (f g h i j)ats
f@:g@:h@:i@:j

   NB. Watch out for when the last verb in the train is a fork
   ((f g) h)ats       NB. OK
(f g)@:h
   (f (g h))ats       NB. OK
f@:(g h)
   ((f g h) i)ats     NB. OK
(f g h)@:i
   (f (g h i))ats     NB. Warning - interpreted as (f g h i)ats
f@:g@:h@:i
   (f (g h i)"_)ats   NB. Workaround
f@:((g h i)"_)

   NB. My original implementation of sym for Kip Murray
   perms =. i.@! A. i.
   trans =. |:~ perms@#@$
   test =. -: 1&|.
   sym =. test@trans
   sym&> a=.(i.3 3 3) ; (+//3$,:3?10)
0 1

   NB. ... using ats, perhaps excessively
   perms =. (i. !)ats A. i.
   trans =. |:~ (perms # $)ats
   test =. -: 1&|.
   sym =. (test trans)ats
   sym&> a
0 1

   NB. Roger's version of Henry Rich's implementation
   symm=: [: *./ i.@<:@#@$ (|: -: ])"0 _ ]
   symm&> a
0 1

   NB. ... using ats
   symm=: [: *./ (i. <: # $)ats (|: -: ])"0 _ ]
   symm&> a
0 1

   NB. Another example
   quad =. 2 2&$@(#&0 1 2)@(|.&1 2 1)     NB. Original - too much sugar
   quad =. [: 2 2&$ [: #&0 1 2 |.&1 2 1   NB. Using [: - too much pepper
   quad =. (2 2&$ #&0 1 2 |.&1 2 1)ats    NB. Using ats - just right

Of course, now I've implemented it as an adverb, it'll never get into J
as ): . ;)  Mind you, an adverb will never be able to deal correctly with
the case:

   (f (g h i)):

BTW, the last time I used J (or J used I) was before I'd seen an emoticon;
now I see them everywhere in J code.  I especially like the appearance of
following idiom:

   (|:~ /:)~

Cheers, Paul

--------------------------------------------------------------------------
For information about the J Forum see http://www.jsoftware.com/j_forum.htm
)

conjs =: 2 : 0
	a =. a: 0}]`x.
	lh =. >@{.
	rh =. >@{:
	list =. <@,"0 '32'
	isEmpty =. 0: = #
	isTrain =. +.`*./ @: ((=&list @: {. @: rh) , isEmpty@lh)
	isDone =. isEmpty@rh
	curtail =. }: @: > @: {: @: rh
	tail =. {: @: > @: {: @: rh
	caseTrain =. (lh , curtail) ; tail
	caseNotrain =. (lh , {:) ; a:"_
	switch =. isTrain (+ +:) isDone
	step =. caseNotrain`caseTrain`] @. switch
	b =. >{.step^:_ a
	c =. ({.b) , <}.b
	at =. (<y.)"_
	caseAtop =. (at , (<@lh <@, {.@rh)) ,&< }.@rh
	d =. {.(caseAtop`] @. isDone)^:_ c
	d 5!:0
)

   ats =: conjs '@:'