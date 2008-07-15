smoutput (2#LF) (] (' :' (i.&1@:e. split ]) S: 0 LF cut {.)~ i.&1@:E.) S: 0 'From [^\n]+\nFrom: [^\n]+\nDate: [^\n]+\nSubject: [^\n]+\nMessage-ID: [^\n]+\n\n' (] <;.1~ rxE) 0 : 0 [ load 'regex'
From christopher.f.lett at citigroup.com  Thu Dec  1 00:55:28 2005
From: christopher.f.lett at citigroup.com (Lett, Christopher F)
Date: Thu Dec  1 00:56:29 2005
Subject: [Jbeta] Behavior of Scrollbars in Grid Control
Message-ID: <D098A951461AEA49B6962D4FBC8A95AC053353@EXNJMB61.nam.nsroot.net>

I noticed that in earlier releases of the Grid control, I could continuously scroll the window using the scrollbars by placing the mouse in an empty portion of the bar and pressing and holding the mouse button. (You can try this in the "Grid Basic Examples" lab, frame 7).

But with the new Grid control in J601, this behavior doesn't work. (Try the Grid demo, "Countries" example). I don't know if this is really a bug or just an incompatibility introduced with the new control, but it was a little unexpected and doesn't seem to follow standard Windows widget behavior.

/Christopher Lett

From gosinn at gmail.com  Thu Dec  1 01:31:35 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Thu Dec  1 01:30:01 2005
Subject: [Jbeta] gl2 - schizophrenia
Message-ID: <4031fef0511300931o73a4ecdam@mail.gmail.com>

There are two gl2.ijt files
one in
system\extras\labs\system
other in
system\extras\labs\graphics

both claim to be:
Lab: Graphics - gl2 commands
From r.e.boss at planet.nl  Thu Dec  1 02:17:39 2005
From: r.e.boss at planet.nl (R.E. Boss)
Date: Thu Dec  1 02:15:59 2005
Subject: [Jbeta] Behavior of Scrollbars in Grid Control
In-Reply-To: <D098A951461AEA49B6962D4FBC8A95AC053353@EXNJMB61.nam.nsroot.net>
Message-ID: <003401c5f5da$58d3ac30$9900000a@BOS>

I reported this before but it is repaired in the bbeta-relaease.

R.E. Boss


-----Oorspronkelijk bericht-----
Van: beta-bounces@jsoftware.com [mailto:beta-bounces@jsoftware.com] Namens
Lett, Christopher F
Verzonden: woensdag 30 november 2005 17:55
Aan: beta@jsoftware.com
Onderwerp: [Jbeta] Behavior of Scrollbars in Grid Control

I noticed that in earlier releases of the Grid control, I could continuously
scroll the window using the scrollbars by placing the mouse in an empty
portion of the bar and pressing and holding the mouse button. (You can try
this in the "Grid Basic Examples" lab, frame 7).

But with the new Grid control in J601, this behavior doesn't work. (Try the
Grid demo, "Countries" example). I don't know if this is really a bug or
just an incompatibility introduced with the new control, but it was a little
unexpected and doesn't seem to follow standard Windows widget behavior.

/Christopher Lett

----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm

From gosinn at gmail.com  Thu Dec  1 03:22:41 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Thu Dec  1 03:21:10 2005
Subject: [Jbeta] Lab: Turtle Geometry - JTurtle User Guide error
Message-ID: <4031fef0511301122g5afe9951w@mail.gmail.com>

Lab: Turtle Geometry - JTurtle User Guide

?? ((1) 4 of 30) The idea of a turtle ???????????????????????

error in jijs_ctrl_fkey
domain error: spos
f~y
From fraser.jackson at xtra.co.nz  Thu Dec  1 03:56:34 2005
From: fraser.jackson at xtra.co.nz (Fraser Jackson)
Date: Thu Dec  1 03:55:04 2005
Subject: [Jbeta] Lab: Turtle Geometry - JTurtle User Guide error
References: <4031fef0511301122g5afe9951w@mail.gmail.com>
Message-ID: <001301c5f5e8$2b442070$0101a8c0@vaio>

Bjorn,
the revisions in the gl2 handling have impacted on this script and I have 
updated it but it has not got into the beta yet.
Fraser
----- Original Message ----- 
From: "Bjorn Helgason" <gosinn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Thursday, December 01, 2005 8:22 AM
Subject: [Jbeta] Lab: Turtle Geometry - JTurtle User Guide error


> Lab: Turtle Geometry - JTurtle User Guide
>
> ?? ((1) 4 of 30) The idea of a turtle ???????????????????????
>
> error in jijs_ctrl_fkey
> domain error: spos
> f~y
>


--------------------------------------------------------------------------------


> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From gosinn at gmail.com  Thu Dec  1 04:12:04 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Thu Dec  1 04:10:34 2005
Subject: [Jbeta] Lab: Turtle Geometry - JTurtle User Guide error
In-Reply-To: <001301c5f5e8$2b442070$0101a8c0@vaio>
References: <4031fef0511301122g5afe9951w@mail.gmail.com>
	<001301c5f5e8$2b442070$0101a8c0@vaio>
Message-ID: <4031fef0511301212n2551d9bk@mail.gmail.com>

fine
I am just testing as much as I can so it does not get forgotten
seems like this j601 is a big step
not the least for graphics

2005/11/30, Fraser Jackson <fraser.jackson@xtra.co.nz>:
> Bjorn,
> the revisions in the gl2 handling have impacted on this script and I have
> updated it but it has not got into the beta yet.
> Fraser
> ----- Original Message -----
> From: "Bjorn Helgason" <gosinn@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Thursday, December 01, 2005 8:22 AM
> Subject: [Jbeta] Lab: Turtle Geometry - JTurtle User Guide error
>
>
> > Lab: Turtle Geometry - JTurtle User Guide
> >
> > ?? ((1) 4 of 30) The idea of a turtle ???????????????????????
> >
> > error in jijs_ctrl_fkey
> > domain error: spos
> > f~y
> >
>
>
> --------------------------------------------------------------------------------
>
>
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From gosinn at gmail.com  Fri Dec  2 23:09:48 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Fri Dec  2 23:08:17 2005
Subject: [Jbeta] studio advance hard coded?
Message-ID: <4031fef0512020709q5e3ade4bx@mail.gmail.com>

I was trying to change the studio advance from ctrl+j into some one
char like f11 but it seems to be hardcoded

In configure shortcuts it looks like you can change it but it does not work

When you want to step through many labs it would be nice to be able to
just press just one char instead of the little bit awkward ctrl+j
From gkirouac at riq.qc.ca  Sun Dec  4 07:40:09 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Sun Dec  4 07:38:32 2005
Subject: [Jbeta] Ill-formed error message
Message-ID: <20051203230150.M23821@riq.qc.ca>

What is the meaning of loa?

The complete session is:

   ]v=:12 23 34 44 59 70 98, 12 15 25 27 32 88 99,:15 35 78 82 90 95 97
12 23 34 44 59 70 98
12 15 25 27 32 88 99
15 35 78 82 90 95 97
   (mean; stddev ; var)"1 v
&#9474;value error: mean
&#9474;       (mean;stddev;var)"1 v
   load 'c:\j601\system\packages\stats\statfns.ijs'
   ]"1v
&#9474;ill-formed number: loa            <======
   

Gilles -)

From rsdonovan at hotmail.com  Sun Dec  4 19:44:54 2005
From: rsdonovan at hotmail.com (Richard Donovan)
Date: Sun Dec  4 19:43:15 2005
Subject: [Jbeta] Pocket PC
In-Reply-To: <20051203230150.M23821@riq.qc.ca>
Message-ID: <BAY111-F33EAA900D0ECC17CC63FB1BD4E0@phx.gbl>

Does the new J6 beta work for Pocket Pc?

Thanks in advance


From eiverson at sympatico.ca  Sun Dec  4 22:08:25 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec  4 22:06:45 2005
Subject: [Jbeta] Pocket PC
References: <BAY111-F33EAA900D0ECC17CC63FB1BD4E0@phx.gbl>
Message-ID: <001901c5f8dc$33e20070$0701a8c0@xp>

The currently available J601 beta won't work on the PocketPC. We'd hoped to 
get the PocketPc out by now, but it has slipped and won't be out til the new 
year.

----- Original Message ----- 
From: "Richard Donovan" <rsdonovan@hotmail.com>
To: <beta@jsoftware.com>
Sent: Sunday, December 04, 2005 6:44 AM
Subject: [Jbeta] Pocket PC


> Does the new J6 beta work for Pocket Pc?
>
> Thanks in advance
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From gkirouac at riq.qc.ca  Tue Dec  6 10:45:38 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Tue Dec  6 10:43:58 2005
Subject: [Jbeta] Enter_info.htm+ needs updating
Message-ID: <20051206024351.M50416@riq.qc.ca>

The line

wd `'''''pshow'

in file:///c:/j601/system/extras/help/user/enter_info.htm

looks weird and results in a domain error.

At the top of the same page, 

open 'system\examples\demo\name.ijs' should be, I think,

load jpath '~system\examples\demo\name.ijs'



The page c:/j601/system/extras/help/user/form_locales.htm

also needs adjustments around the load verb.

Gilles -)
From gkirouac at riq.qc.ca  Tue Dec  6 10:48:09 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Tue Dec  6 10:46:26 2005
Subject: [Jbeta] add folder Addons
Message-ID: <20051206024622.M51754@riq.qc.ca>


Could you  please add folder Addons to the folders accessible in Find in Files
of the JADE. Won't hurt anyone.

Gilles -)
From gkirouac at riq.qc.ca  Tue Dec  6 10:50:10 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Tue Dec  6 10:48:28 2005
Subject: [Jbeta] The new grid : for Linux?
Message-ID: <20051206024833.M67820@riq.qc.ca>

The current doc for the new grid says:

A grid is drawn in an isigraph control on a Windows form.

Does that imply that it won't be available for Linux and Mac?

Gilles -)
From gkirouac at riq.qc.ca  Tue Dec  6 12:31:54 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Tue Dec  6 12:30:12 2005
Subject: [Jbeta] New grid object : virtual grid possible?
Message-ID: <20051206043023.M62020@riq.qc.ca>


Will the new grid object allow for a virtual grid?  A virtual grid allows for
the display of a small subset of a large/long spreadsheet. The programmer
needs to catch scrollbar events and program the size and position of the
scrollbar himself. Without this, the maximum size of a displayed spreadsheet
is much smaller and takes much more preparation time.

I have not seen these event and method mentioned in the doc I read. It would
be really nice not to have to redo the new grid class ourselves, even if it is
possible. The grid class is not light stuff!

Gilles -)

From eiverson at sympatico.ca  Wed Dec  7 02:58:37 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec  7 05:03:44 2005
Subject: [Jbeta] The new grid : for Linux?
References: <20051206024833.M67820@riq.qc.ca>
Message-ID: <000901c5faa8$c845e240$0701a8c0@xp>

The same grid is available on all J601 platforms (linux, mac, pocketpc). I 
guess the doc should say:

A grid is drawn in an isigraph control on a J form.

----- Original Message ----- 
From: "Gilles Kirouac" <gkirouac@riq.qc.ca>
To: <Beta@jsoftware.com>
Sent: Monday, December 05, 2005 9:50 PM
Subject: [Jbeta] The new grid : for Linux?


> The current doc for the new grid says:
>
> A grid is drawn in an isigraph control on a Windows form.
>
> Does that imply that it won't be available for Linux and Mac?
>
> Gilles -)
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From gosinn at gmail.com  Wed Dec  7 05:34:51 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Wed Dec  7 05:34:05 2005
Subject: [Jbeta] The new grid : for Linux?
In-Reply-To: <000901c5faa8$c845e240$0701a8c0@xp>
References: <20051206024833.M67820@riq.qc.ca>
	<000901c5faa8$c845e240$0701a8c0@xp>
Message-ID: <4031fef0512061334x3ebb8349y@mail.gmail.com>

Windows is not only M$ Windows it is also X Windows

2005/12/6, Eric Iverson <eiverson@sympatico.ca>:
> The same grid is available on all J601 platforms (linux, mac, pocketpc). I
> guess the doc should say:
>
> A grid is drawn in an isigraph control on a J form.
>
> ----- Original Message -----
> From: "Gilles Kirouac" <gkirouac@riq.qc.ca>
> To: <Beta@jsoftware.com>
> Sent: Monday, December 05, 2005 9:50 PM
> Subject: [Jbeta] The new grid : for Linux?
>
>
> > The current doc for the new grid says:
> >
> > A grid is drawn in an isigraph control on a Windows form.
> >
> > Does that imply that it won't be available for Linux and Mac?
> >
> > Gilles -)
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From bobtherriault at shaw.ca  Wed Dec  7 05:36:14 2005
From: bobtherriault at shaw.ca (Bob Therriault)
Date: Wed Dec  7 05:34:27 2005
Subject: [Jbeta] Question about rank of verb #: antibase
Message-ID: <000001c5faad$16216260$6501a8c0@diane>

In the process of learning this remarkable language, every once in a while I
stumble upon something that
doesn't seem quite right. In the case of #: it looks to me as if it acts and
is expected to act like a 
monadic verb of rank 0.  However the basic function b. returns a rank of _
and I have a tough time visualizing 
how antibase would apply to an entire matrix if not on an atom by atom
basis. I eagerly await enlightenment.
  
#: 5
1 0 1
   #:i.3 2
0 0 0
0 0 1
 
0 1 0
0 1 1
 
1 0 0
1 0 1
   #: b. 0
_ 1 0
 
This also applies to J504, but it seems appropriate to address the current
beta.  My apologies in advance
if I have posted incorrectly.  Cheers, bob
From RHui000 at shaw.ca  Wed Dec  7 05:55:54 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Wed Dec  7 05:55:01 2005
Subject: [Jbeta] Question about rank of verb #: antibase
References: <000001c5faad$16216260$6501a8c0@diane>
Message-ID: <03a601c5faaf$dca1a8d0$f7c35718@lap>

The problem is that the positional number system pads
on the left, but rank in J pads on the right.  Thus:

   x=: 1 12 123 1234

   #: x
0 0 0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 1 1 0 0
0 0 0 0 1 1 1 1 0 1 1
1 0 0 1 1 0 1 0 0 1 0
   #:"0 x
1 0 0 0 0 0 0 0 0 0 0
1 1 0 0 0 0 0 0 0 0 0
1 1 1 1 0 1 1 0 0 0 0
1 0 0 1 1 0 1 0 0 1 0
   
   10&#.^:_1 x
0 0 0 1
0 0 1 2
0 1 2 3
1 2 3 4
   10&#.^:_1"0 x
1 0 0 0
1 2 0 0
1 2 3 0
1 2 3 4



----- Original Message ----- 
From: "Bob Therriault" <bobtherriault@shaw.ca>
To: <beta@jsoftware.com>
Sent: Tuesday, December 06, 2005 1:36 PM
Subject: [Jbeta] Question about rank of verb #: antibase

In the process of learning this remarkable language, every once in a while I
stumble upon something that
doesn't seem quite right. In the case of #: it looks to me as if it acts and
is expected to act like a 
monadic verb of rank 0.  However the basic function b. returns a rank of _
and I have a tough time visualizing 
how antibase would apply to an entire matrix if not on an atom by atom
basis. I eagerly await enlightenment.
  
#: 5
1 0 1
   #:i.3 2
0 0 0
0 0 1
 
0 1 0
0 1 1
 
1 0 0
1 0 1
   #: b. 0
_ 1 0
 
This also applies to J504, but it seems appropriate to address the current
beta.  My apologies in advance
if I have posted incorrectly.  Cheers, bob


From jf at dbron.net  Wed Dec  7 06:09:16 2005
From: jf at dbron.net (Dan Bron)
Date: Wed Dec  7 06:07:30 2005
Subject: [Jbeta] Question about rank of verb #: antibase
In-Reply-To: <000001c5faad$16216260$6501a8c0@diane>
Message-ID: <PC1680200512061709160484a894f034@Bron>

If  0 = {. #: b. 0  then the meaning of the output of  #:  would be different (and it would not be usefully invertible).

Fundamentally, this is because a normal fill (ala  #:"0  ) would create trailing zeros, like  > 1 ; 1 2 ; 1 2 3  .  This is a problem because LEADING zeros are insignificant, but trailing zeros are not.

To put it another way:  defining monad #:  to have infinite rank allows it to fill "backwards".  If the verb can see the entire array, then it can find the maximal atom in the input,  and thereby know the appropriate number of columns for the final output.

Examples:

   	   (<@#~ [: #:  @:i. 2: ^ #)  'abc'  NB.  All subsets of 'abc'
	++-+-+--+-+--+--+---+
	||c|b|bc|a|ac|ab|abc|
	++-+-+--+-+--+--+---+
	   (<@#~ [: #:"0  @:i. 2: ^ #) 'abc'  NB.  Not as useful
	++-+-+--+-+--+--+---+
	||a|a|ab|a|ac|ab|abc|
	++-+-+--+-+--+--+---+


           (4&{.)&.:(#:)    i. 16  NB.  Under binary space works as expected
        0 1 2 3
           (4&{.)&.:(#:"0)  i. 16  NB.  ... as long as the rank is correct
        0 8 8 12

	   #. 4 {. #:    i. 16     NB.  Where does the difference lie?
	0 1 2 3
	   #. 4 {. #:"0  i. 16
	0 8 8 12

	   4 {. #:    i. 16
	0 0 0 0
	0 0 0 1
	0 0 1 0
	0 0 1 1
	   4 {. #:"0  i. 16        NB.  Comes down to filling.
	0 0 0 0
	1 0 0 0
	1 0 0 0
	1 1 0 0

-Dan
From gkirouac at riq.qc.ca  Wed Dec  7 14:42:44 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Wed Dec  7 14:41:03 2005
Subject: [Jbeta] DrWatson dump useful?
Message-ID: <20051207064004.M87188@riq.qc.ca>


Is a V6.01 DrWatson log and .dmp of any use to you, if I do not recall the
steps leading to the crash?

Gilles -

From cburke at jsoftware.com  Wed Dec  7 16:38:33 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Wed Dec  7 16:36:49 2005
Subject: [Jbeta] New grid object : virtual grid possible?
In-Reply-To: <20051206043023.M62020@riq.qc.ca>
References: <20051206043023.M62020@riq.qc.ca>
Message-ID: <43969F89.6060502@jsoftware.com>

Gilles Kirouac wrote:
> Will the new grid object allow for a virtual grid?  A virtual grid allows for
> the display of a small subset of a large/long spreadsheet. The programmer
> needs to catch scrollbar events and program the size and position of the
> scrollbar himself. Without this, the maximum size of a displayed spreadsheet
> is much smaller and takes much more preparation time.
> 
> I have not seen these event and method mentioned in the doc I read. It would
> be really nice not to have to redo the new grid class ourselves, even if it is
> possible. The grid class is not light stuff!

Yes. The function table demo is a virtual grid, but there will be
another virtual grid demo in the next beta that displays a noun, and
this should be a better example.

The base jzgrid class has more functionality than the old jzgrid, but
the derived classes are much lighter. The intention is that it should be
fairly easy to create derived classes for specific grids.

Thanks for your other problem reports.
From eiverson at sympatico.ca  Wed Dec  7 23:14:00 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec  7 23:12:24 2005
Subject: [Jbeta] DrWatson dump useful?
References: <20051207064004.M87188@riq.qc.ca>
Message-ID: <000f01c5fb40$de50e790$0701a8c0@xp>

Not at this time. Reproducible steps always appreciated.

----- Original Message ----- 
From: "Gilles Kirouac" <gkirouac@riq.qc.ca>
To: <beta@jsoftware.com>
Sent: Wednesday, December 07, 2005 1:42 AM
Subject: [Jbeta] DrWatson dump useful?


>
> Is a V6.01 DrWatson log and .dmp of any use to you, if I do not recall the
> steps leading to the crash?
>
> Gilles -
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From bobtherriault at shaw.ca  Thu Dec  8 00:52:50 2005
From: bobtherriault at shaw.ca (Bob Therriault)
Date: Thu Dec  8 00:52:51 2005
Subject: [Jbeta] Re: Question about rank of verb #: antibase
In-Reply-To: <20051207040002.BD40674C674@alice.jsoftware.com>
Message-ID: <000001c5fb4e$ab82e3f0$6501a8c0@diane>


Thank you to both Dan and Roger for an excellent clarification.  I really am
enjoying having my mind stretched by J.  My thanks to all on the forum.
Cheers, bob

Message: 6
Date: Tue, 6 Dec 2005 17:09:16 -0500
From: Dan Bron <jf@dbron.net>
Subject: Re: [Jbeta] Question about rank of verb #: antibase
To: Beta forum <beta@jsoftware.com>
Message-ID: <PC1680200512061709160484a894f034@Bron>
Content-Type: text/plain; charset=iso-8859-1

If  0 = {. #: b. 0  then the meaning of the output of  #:  would be
different (and it would not be usefully invertible).

Fundamentally, this is because a normal fill (ala  #:"0  ) would create
trailing zeros, like  > 1 ; 1 2 ; 1 2 3  .  This is a problem because
LEADING zeros are insignificant, but trailing zeros are not.

To put it another way:  defining monad #:  to have infinite rank allows it
to fill "backwards".  If the verb can see the entire array, then it can find
the maximal atom in the input,  and thereby know the appropriate number of
columns for the final output.

Examples:

   	   (<@#~ [: #:  @:i. 2: ^ #)  'abc'  NB.  All subsets of 'abc'
	++-+-+--+-+--+--+---+
	||c|b|bc|a|ac|ab|abc|
	++-+-+--+-+--+--+---+
	   (<@#~ [: #:"0  @:i. 2: ^ #) 'abc'  NB.  Not as useful
	++-+-+--+-+--+--+---+
	||a|a|ab|a|ac|ab|abc|
	++-+-+--+-+--+--+---+


           (4&{.)&.:(#:)    i. 16  NB.  Under binary space works as expected
        0 1 2 3
           (4&{.)&.:(#:"0)  i. 16  NB.  ... as long as the rank is correct
        0 8 8 12

	   #. 4 {. #:    i. 16     NB.  Where does the difference lie?
	0 1 2 3
	   #. 4 {. #:"0  i. 16
	0 8 8 12

	   4 {. #:    i. 16
	0 0 0 0
	0 0 0 1
	0 0 1 0
	0 0 1 1
	   4 {. #:"0  i. 16        NB.  Comes down to filling.
	0 0 0 0
	1 0 0 0
	1 0 0 0
	1 1 0 0

-Dan


------------------------------

----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm

End of Beta Digest, Vol 4, Issue 6
**********************************

From gkirouac at riq.qc.ca  Fri Dec  9 13:44:27 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Fri Dec  9 13:42:43 2005
Subject: [Jbeta] Script window behaviour
Message-ID: <20051209053536.M73101@riq.qc.ca>


0) * in title bar of a script window

In J5.04 and J6.01, when opening an existing script, I expect not to see the
*. But it is always there. Why? [An execution window appears to have the same
problem, but is not a concern for me.]


1) No cancel option when running/closing a modified script window

When I run or close a modified script window, I am offered to save it or not.
Is a cancel option too much of a luxury? Without it, I necessarily lose either
the new version or the old one.

Gilles -
From gkirouac at riq.qc.ca  Fri Dec  9 23:36:47 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Fri Dec  9 23:35:01 2005
Subject: [Jbeta] Crash/freeze of J6.01b (2005-11-21)
Message-ID: <20051209153345.M3079@riq.qc.ca>

Executing this crashes J6.01b:

   m=:?.101 36$999
   m

The crash is right after the display.

Executing this freezes J6.01b:

   m=:?.81 36$999
   m
   ctl-d


Gilles -
From eiverson at sympatico.ca  Sat Dec 10 06:39:04 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 10 06:37:23 2005
Subject: [Jbeta] J 601 c beta available
Message-ID: <003e01c5fd11$5ed6e460$0701a8c0@xp>

The c beta is available:
http://www.jsoftware.com/download/j601cbeta_win.exe

User feed back on the previous beta showed we were off on the wrong foot 
with our unicode support. Web research, experiments, and working with Bill 
Lam and Bjorn, showed that adopting UTF-8 as a byte encoding of unicode data 
was the right approach. This new beta reflects that.

See Studio|Demos|unicode simple and Studio|Demos|unicode for examples of 
unicode applications and look at the code for both.

User Manual section Unicode has a very rough and preliminary discussion of 
unicode and UTF-8. Also see the documentation in the dictionary vocabulary 
on new facilities in primitive u: .

Problems with OLE/COM (OCX controls and OLE Automation) have been fixed. 
This area was quite disturbed by the unicode work and we'd appreciate users 
testing their use of these facilities. And once the old stuff is working, it 
would be nice to see examples of using unicode for non-English language 
applications with OLE/COM.

The beta fixes problems with the new grid. Study the demo and the docs.

From eiverson at sympatico.ca  Sat Dec 10 06:46:44 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 10 06:44:58 2005
Subject: [Jbeta] Crash/freeze of J6.01b (2005-11-21)
References: <20051209153345.M3079@riq.qc.ca>
Message-ID: <001201c5fd12$6f9aecf0$0701a8c0@xp>

These appear to be fixed in the new c beta.

----- Original Message ----- 
From: "Gilles Kirouac" <gkirouac@riq.qc.ca>
To: <beta@jsoftware.com>
Sent: Friday, December 09, 2005 10:36 AM
Subject: [Jbeta] Crash/freeze of J6.01b (2005-11-21)


> Executing this crashes J6.01b:
> 
>   m=:?.101 36$999
>   m
> 
> The crash is right after the display.
> 
> Executing this freezes J6.01b:
> 
>   m=:?.81 36$999
>   m
>   ctl-d
> 
> 
> Gilles -
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
From juneaftn at gmail.com  Sat Dec 10 08:40:19 2005
From: juneaftn at gmail.com (June Kim)
Date: Sat Dec 10 08:38:32 2005
Subject: [Jbeta] J 601 c beta available
In-Reply-To: <003e01c5fd11$5ed6e460$0701a8c0@xp>
References: <003e01c5fd11$5ed6e460$0701a8c0@xp>
Message-ID: <6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com>

Thank you for the new beta.

Now I can type in multibyte characters in the ijx window. However, I
have found out some problem (or my ignorance?)

   HAN=.'?'    NB. this is a korean character, which sounds as "han".
You can make the letter instead with "HAN=.8 u: u: 54620" if you don't
have the IME.

   ]codepoint=.3 u: 7 u: HAN
54620
   3!:0 HAN
2
   3!:0 (7 u: HAN)
131072
   3!:0 (4 u: 54620)
131072
   #(7 u: HAN)       NB. this is one letter
1
   (7 u: HAN) = 7 u: HAN
1
   HAN_A=.HAN,'a'    NB. append the alphabet "a"
   #7 u: HAN_A         NB. now it's two letters
2

So far so good. Until I see

   (7 u: HAN) = 7 u: HAN_A
|length error
|   (7 u:HAN)    =7 u:HAN_A

But somehow I found out a working(but ugly and painful) version

   (4 u: 0{3 u: 7 u: HAN) = 7 u: HAN_A
1 0



June Kim

On 12/10/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> The c beta is available:
> http://www.jsoftware.com/download/j601cbeta_win.exe
>
> User feed back on the previous beta showed we were off on the wrong foot
> with our unicode support. Web research, experiments, and working with Bill
> Lam and Bjorn, showed that adopting UTF-8 as a byte encoding of unicode data
> was the right approach. This new beta reflects that.
>
> See Studio|Demos|unicode simple and Studio|Demos|unicode for examples of
> unicode applications and look at the code for both.
>
> User Manual section Unicode has a very rough and preliminary discussion of
> unicode and UTF-8. Also see the documentation in the dictionary vocabulary
> on new facilities in primitive u: .
>
> Problems with OLE/COM (OCX controls and OLE Automation) have been fixed.
> This area was quite disturbed by the unicode work and we'd appreciate users
> testing their use of these facilities. And once the old stuff is working, it
> would be nice to see examples of using unicode for non-English language
> applications with OLE/COM.
>
> The beta fixes problems with the new grid. Study the demo and the docs.
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From juneaftn at gmail.com  Sat Dec 10 08:50:45 2005
From: juneaftn at gmail.com (June Kim)
Date: Sat Dec 10 08:49:06 2005
Subject: [Jbeta] J 601 c beta available
In-Reply-To: <6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com>
References: <003e01c5fd11$5ed6e460$0701a8c0@xp>
	<6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com>
Message-ID: <6f80c1520512091650n135e2f23x6bda771f839e6a1@mail.gmail.com>

Okay, I have discovered a simpler version.

   (0{7 u: HAN) = 7 u: HAN_A
1 0

And there seems like a difference between one lettered ascii and one
lettered unicode

   $'a'

   $ 7 u: HAN
1
   #'a'
1
   # 7 u: HAN
1


On 12/10/05, June Kim <juneaftn@gmail.com> wrote:
> Thank you for the new beta.
>
> Now I can type in multibyte characters in the ijx window. However, I
> have found out some problem (or my ignorance?)
>
>   HAN=.'?'    NB. this is a korean character, which sounds as "han".
> You can make the letter instead with "HAN=.8 u: u: 54620" if you don't
> have the IME.
>
>   ]codepoint=.3 u: 7 u: HAN
> 54620
>   3!:0 HAN
> 2
>   3!:0 (7 u: HAN)
> 131072
>   3!:0 (4 u: 54620)
> 131072
>   #(7 u: HAN)       NB. this is one letter
> 1
>   (7 u: HAN) = 7 u: HAN
> 1
>   HAN_A=.HAN,'a'    NB. append the alphabet "a"
>   #7 u: HAN_A         NB. now it's two letters
> 2
>
> So far so good. Until I see
>
>   (7 u: HAN) = 7 u: HAN_A
> |length error
> |   (7 u:HAN)    =7 u:HAN_A
>
> But somehow I found out a working(but ugly and painful) version
>
>   (4 u: 0{3 u: 7 u: HAN) = 7 u: HAN_A
> 1 0
>
>
>
> June Kim
>
> On 12/10/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> > The c beta is available:
> > http://www.jsoftware.com/download/j601cbeta_win.exe
> >
> > User feed back on the previous beta showed we were off on the wrong foot
> > with our unicode support. Web research, experiments, and working with Bill
> > Lam and Bjorn, showed that adopting UTF-8 as a byte encoding of unicode data
> > was the right approach. This new beta reflects that.
> >
> > See Studio|Demos|unicode simple and Studio|Demos|unicode for examples of
> > unicode applications and look at the code for both.
> >
> > User Manual section Unicode has a very rough and preliminary discussion of
> > unicode and UTF-8. Also see the documentation in the dictionary vocabulary
> > on new facilities in primitive u: .
> >
> > Problems with OLE/COM (OCX controls and OLE Automation) have been fixed.
> > This area was quite disturbed by the unicode work and we'd appreciate users
> > testing their use of these facilities. And once the old stuff is working, it
> > would be nice to see examples of using unicode for non-English language
> > applications with OLE/COM.
> >
> > The beta fixes problems with the new grid. Study the demo and the docs.
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
From juneaftn at gmail.com  Sat Dec 10 09:37:44 2005
From: juneaftn at gmail.com (June Kim)
Date: Sat Dec 10 09:35:58 2005
Subject: [Jbeta] J 601 c beta available
In-Reply-To: <003e01c5fd11$5ed6e460$0701a8c0@xp>
References: <003e01c5fd11$5ed6e460$0701a8c0@xp>
Message-ID: <6f80c1520512091737l6b0d99c8k51f8695b37fb8e8d@mail.gmail.com>

In some fonts (like "Bitstream Vera Sans Mono"), the box-drawing looks
broken. I had to Toggle Ascii Box Drawing from the Tools menu
everytime I run J. Is there anyway I can toggle it programmatically,
like putting some sentence on the startup file?

On 12/10/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> The c beta is available:
> http://www.jsoftware.com/download/j601cbeta_win.exe
>
> User feed back on the previous beta showed we were off on the wrong foot
> with our unicode support. Web research, experiments, and working with Bill
> Lam and Bjorn, showed that adopting UTF-8 as a byte encoding of unicode data
> was the right approach. This new beta reflects that.
>
> See Studio|Demos|unicode simple and Studio|Demos|unicode for examples of
> unicode applications and look at the code for both.
>
> User Manual section Unicode has a very rough and preliminary discussion of
> unicode and UTF-8. Also see the documentation in the dictionary vocabulary
> on new facilities in primitive u: .
>
> Problems with OLE/COM (OCX controls and OLE Automation) have been fixed.
> This area was quite disturbed by the unicode work and we'd appreciate users
> testing their use of these facilities. And once the old stuff is working, it
> would be nice to see examples of using unicode for non-English language
> applications with OLE/COM.
>
> The beta fixes problems with the new grid. Study the demo and the docs.
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From eiverson at sympatico.ca  Sat Dec 10 11:50:24 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 10 11:48:46 2005
Subject: [Jbeta] J 601 c beta available
References: <003e01c5fd11$5ed6e460$0701a8c0@xp><6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com>
	<6f80c1520512091650n135e2f23x6bda771f839e6a1@mail.gmail.com>
Message-ID: <003c01c5fd3c$dfc59460$0701a8c0@xp>

The problem is that the result of 7 u: for a 2 or 3 character sequence that 
returns a single wchar is a list. As the argument is a list there is no way 
to determine if the result should be a scalar or a list. The ASCII arg to 7 
u: is currently returned as unchanged. It might be more consistent to make 7 
u: always return a list even in the ASCII case. But this wouldn't help your 
situation.

A possible change would be to make 7 u: return a scalar rather than a list 
if there was only 1 wchar in the result, but then when you wanted a list 
you'd be upset and I suspect this would just move the problem around.

The problem is that the these transformation don't have the nice shape and 
rank conformation of typical J primitives. That is, 1, 2, or 3 char 
sequences in the arg make 1 wchar in the result.

Feedback and suggestions welcome.

I could redo all your HAN experiments, but the character doesn't display 
properly for me in ijs or ijx. It does display properly for me in your email 
and in notepad. What font are you using in ijs? Do you know why it won't 
display in my ijs window? I can display Chinese, Icelandic, etc ok.


----- Original Message ----- 
From: "June Kim" <juneaftn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Friday, December 09, 2005 7:50 PM
Subject: Re: [Jbeta] J 601 c beta available


> Okay, I have discovered a simpler version.
>
>   (0{7 u: HAN) = 7 u: HAN_A
> 1 0
>
> And there seems like a difference between one lettered ascii and one
> lettered unicode
>
>   $'a'
>
>   $ 7 u: HAN
> 1
>   #'a'
> 1
>   # 7 u: HAN
> 1
>
>
> On 12/10/05, June Kim <juneaftn@gmail.com> wrote:
>> Thank you for the new beta.
>>
>> Now I can type in multibyte characters in the ijx window. However, I
>> have found out some problem (or my ignorance?)
>>
>>   HAN=.'?'    NB. this is a korean character, which sounds as "han".
>> You can make the letter instead with "HAN=.8 u: u: 54620" if you don't
>> have the IME.
>>
>>   ]codepoint=.3 u: 7 u: HAN
>> 54620
>>   3!:0 HAN
>> 2
>>   3!:0 (7 u: HAN)
>> 131072
>>   3!:0 (4 u: 54620)
>> 131072
>>   #(7 u: HAN)       NB. this is one letter
>> 1
>>   (7 u: HAN) = 7 u: HAN
>> 1
>>   HAN_A=.HAN,'a'    NB. append the alphabet "a"
>>   #7 u: HAN_A         NB. now it's two letters
>> 2
>>
>> So far so good. Until I see
>>
>>   (7 u: HAN) = 7 u: HAN_A
>> |length error
>> |   (7 u:HAN)    =7 u:HAN_A
>>
>> But somehow I found out a working(but ugly and painful) version
>>
>>   (4 u: 0{3 u: 7 u: HAN) = 7 u: HAN_A
>> 1 0
>>
>>
>>
>> June Kim
>>
>> On 12/10/05, Eric Iverson <eiverson@sympatico.ca> wrote:
>> > The c beta is available:
>> > http://www.jsoftware.com/download/j601cbeta_win.exe
>> >
>> > User feed back on the previous beta showed we were off on the wrong 
>> > foot
>> > with our unicode support. Web research, experiments, and working with 
>> > Bill
>> > Lam and Bjorn, showed that adopting UTF-8 as a byte encoding of unicode 
>> > data
>> > was the right approach. This new beta reflects that.
>> >
>> > See Studio|Demos|unicode simple and Studio|Demos|unicode for examples 
>> > of
>> > unicode applications and look at the code for both.
>> >
>> > User Manual section Unicode has a very rough and preliminary discussion 
>> > of
>> > unicode and UTF-8. Also see the documentation in the dictionary 
>> > vocabulary
>> > on new facilities in primitive u: .
>> >
>> > Problems with OLE/COM (OCX controls and OLE Automation) have been 
>> > fixed.
>> > This area was quite disturbed by the unicode work and we'd appreciate 
>> > users
>> > testing their use of these facilities. And once the old stuff is 
>> > working, it
>> > would be nice to see examples of using unicode for non-English language
>> > applications with OLE/COM.
>> >
>> > The beta fixes problems with the new grid. Study the demo and the docs.
>> >
>> > ----------------------------------------------------------------------
>> > For information about J forums see http://www.jsoftware.com/forums.htm
>> >
>>
>


--------------------------------------------------------------------------------


> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From cburke at jsoftware.com  Sat Dec 10 13:06:33 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Sat Dec 10 13:04:48 2005
Subject: [Jbeta] J 601 c beta available
In-Reply-To: <6f80c1520512091737l6b0d99c8k51f8695b37fb8e8d@mail.gmail.com>
References: <003e01c5fd11$5ed6e460$0701a8c0@xp>
	<6f80c1520512091737l6b0d99c8k51f8695b37fb8e8d@mail.gmail.com>
Message-ID: <439A6259.6080709@jsoftware.com>

June Kim wrote:
> In some fonts (like "Bitstream Vera Sans Mono"), the box-drawing looks
> broken. I had to Toggle Ascii Box Drawing from the Tools menu
> everytime I run J. Is there anyway I can toggle it programmatically,
> like putting some sentence on the startup file?

   9!:7 '+++++++++|-'


From rdmiller at usatoday.com  Sat Dec 10 16:01:01 2005
From: rdmiller at usatoday.com (Miller, Raul D)
Date: Sat Dec 10 15:59:15 2005
Subject: [Jbeta] J 601 c beta available
References: <003e01c5fd11$5ed6e460$0701a8c0@xp><6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com><6f80c1520512091650n135e2f23x6bda771f839e6a1@mail.gmail.com>
	<003c01c5fd3c$dfc59460$0701a8c0@xp>
Message-ID: <BCA120F033651846B2F069EF43A486F2736C04@usat-vocex13.usatoday.us.ad.gannett.com>

Eric Iverson wrote:
> The problem is that the result of 7 u: for a 2 or 3 character sequence that 
> returns a single wchar is a list. As the argument is a list there is no way 
> to determine if the result should be a scalar or a list. The ASCII arg to 7 
> u: is currently returned as unchanged. It might be more consistent to make 7 
> u: always return a list even in the ASCII case. But this wouldn't help your 
> situation.

I don't understand that last comment.

I'd think that having 7 u: always return a list would be the right answer,
and I don't know enough about the interpreter internals to understand
why that would be a bad solution.

Could you elaborate a bit?

Thanks,

-- 
Raul
From bill_lam at myrealbox.com  Sat Dec 10 16:53:49 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sat Dec 10 16:52:05 2005
Subject: [Jbeta] missing gl2 commands
Message-ID: <1134204829.c8296adcbill_lam@myrealbox.com>

I found many gl2 commands are missing in J601,
especially glmap and printer support. Will they be add back later, or is there any new equivalent commands?


From bill_lam at myrealbox.com  Sat Dec 10 17:19:14 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sat Dec 10 17:17:26 2005
Subject: [Jbeta] 1!:x and unicode
Message-ID: <1134206354.c8296adcbill_lam@myrealbox.com>

It appears 1!:x family is not unicode aware.
e.g. file name supplied to 1!:0 must be multibyte character. 
unicode and utf8 is not supported.
The file names returned is also in multibyte (code page dependent).


From bill_lam at myrealbox.com  Sat Dec 10 17:29:52 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sat Dec 10 17:28:06 2005
Subject: [Jbeta] tolower and toupper
Message-ID: <1134206992.c8296adcbill_lam@myrealbox.com>

tolower and toupper will give index error for character above 255.
Chinese (and Japanese?) does not have this but Many European languages
(Islandic?) do have lower/upper case alphabets. It will be nice to
make tolower/toupper also work for them.

From gosinn at gmail.com  Sat Dec 10 17:46:22 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sat Dec 10 17:44:34 2005
Subject: [Jbeta] tolower and toupper
In-Reply-To: <1134206992.c8296adcbill_lam@myrealbox.com>
References: <1134206992.c8296adcbill_lam@myrealbox.com>
Message-ID: <4031fef0512100146j168c9700g@mail.gmail.com>

a=.   'a?bc?de?fghi?jklmno?pqrstu?vwxy?z???A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???'

 +/255<a. i. a
0

?slandish is all below 255

cpcount=: #@(9&u:)

cpcount is not working

2005/12/10, bill lam <bill_lam@myrealbox.com>:
> tolower and toupper will give index error for character above 255.
> Chinese (and Japanese?) does not have this but Many European languages
> (Islandic?) do have lower/upper case alphabets. It will be nice to
> make tolower/toupper also work for them.
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From cburke at jsoftware.com  Sat Dec 10 18:36:34 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Sat Dec 10 18:34:49 2005
Subject: [Jbeta] tolower and toupper
In-Reply-To: <4031fef0512100146j168c9700g@mail.gmail.com>
References: <1134206992.c8296adcbill_lam@myrealbox.com>
	<4031fef0512100146j168c9700g@mail.gmail.com>
Message-ID: <439AAFB2.1060709@jsoftware.com>

Bj?rn Helgason wrote:
> cpcount=: #@(9&u:)
> 
> cpcount is not working

It won't, because 9 u: is not defined in the cbeta. See the docs for u:
and the definition for ucpcount (renamed from cpcount) in the cbeta.
From bill_lam at myrealbox.com  Sat Dec 10 18:36:50 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sat Dec 10 18:35:03 2005
Subject: [Jbeta] tolower and toupper
Message-ID: <1134211010.c7ea4ebcbill_lam@myrealbox.com>

now it uses 7&u: and 8&u: as stated in Vocabulary.
In J504, I use something like
toupperw=: (toupper :: ])"0
but is doesn't work with accent characters either.
In your example
a=. 'a?bc?de?fghi?jklmno?pqrstu?vwxy?z???A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???'
   #a
92
   #@(7&u:) a
72
   toupper a
A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???
   toupper&.(7&u:) a
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

I suppose both toupper and toupper&.(7&u:) give incorrect result for ?slandish.


From cburke at jsoftware.com  Sat Dec 10 18:58:24 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Sat Dec 10 18:56:39 2005
Subject: [Jbeta] missing gl2 commands
In-Reply-To: <1134204829.c8296adcbill_lam@myrealbox.com>
References: <1134204829.c8296adcbill_lam@myrealbox.com>
Message-ID: <439AB4D0.7030108@jsoftware.com>

bill lam wrote:
> I found many gl2 commands are missing in J601,
> especially glmap and printer support. Will they be add back later, or is there any new equivalent commands?

The gl2 family has been simplified in J601, but the new set should cover
all requirements, unless we missed something.

glmap is no longer required, because only pixels mode is supported (the
old raw mapping mode), see the gl2 commands reference.

Printing is now handled by drawing on the printer, just as you would
draw on an isigraph, except only for page handling. There is a lab on
this, but I notice that the lab has not been updated since it was first
written a few months back, and is unfinished. But that and the print
scripts should give you some idea of how it works.
From r.e.boss at planet.nl  Sat Dec 10 21:03:54 2005
From: r.e.boss at planet.nl (R.E. Boss)
Date: Sat Dec 10 21:02:05 2005
Subject: [Jbeta] J 601 c beta available
In-Reply-To: <003e01c5fd11$5ed6e460$0701a8c0@xp>
Message-ID: <000001c5fd8a$2c8f7340$9900000a@BOS>

http://www.jsoftware.com/beta.htm still mentions b beta

R.E. Boss



From gosinn at gmail.com  Sat Dec 10 21:30:36 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sat Dec 10 21:28:49 2005
Subject: [Jbeta] missing gl2 commands
In-Reply-To: <439AB4D0.7030108@jsoftware.com>
References: <1134204829.c8296adcbill_lam@myrealbox.com>
	<439AB4D0.7030108@jsoftware.com>
Message-ID: <4031fef0512100530y57d5457do@mail.gmail.com>

Will there be a new grid lab?

2005/12/10, Chris Burke <cburke@jsoftware.com>:
> bill lam wrote:
> > I found many gl2 commands are missing in J601,
> > especially glmap and printer support. Will they be add back later, or is there any new equivalent commands?
>
> The gl2 family has been simplified in J601, but the new set should cover
> all requirements, unless we missed something.
>
> glmap is no longer required, because only pixels mode is supported (the
> old raw mapping mode), see the gl2 commands reference.
>
> Printing is now handled by drawing on the printer, just as you would
> draw on an isigraph, except only for page handling. There is a lab on
> this, but I notice that the lab has not been updated since it was first
> written a few months back, and is unfinished. But that and the print
> scripts should give you some idea of how it works.
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From bill_lam at myrealbox.com  Sat Dec 10 21:53:35 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sat Dec 10 21:51:48 2005
Subject: [Jbeta] missing gl2 commands
Message-ID: <1134222815.c82b7ddcbill_lam@myrealbox.com>

glqdevmode,glzdevmode and glzorientation are essential for printing 
under win32, without them it is difficult to do professional printing.  
Are they still available under J601 or docs showing how to get it done?



From gosinn at gmail.com  Sat Dec 10 22:25:19 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sat Dec 10 22:23:32 2005
Subject: [Jbeta] tolower and toupper
In-Reply-To: <1134211010.c7ea4ebcbill_lam@myrealbox.com>
References: <1134211010.c7ea4ebcbill_lam@myrealbox.com>
Message-ID: <4031fef0512100625xf371ba5o@mail.gmail.com>

(a.&i. { (a. ((a. i.
'??????????'),97+i.26)}~'??????????ABCDEFGHIJKLMNOPQRSTUVWXYZ')"_)  a
A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???


2005/12/10, bill lam <bill_lam@myrealbox.com>:
> now it uses 7&u: and 8&u: as stated in Vocabulary.
> In J504, I use something like
> toupperw=: (toupper :: ])"0
> but is doesn't work with accent characters either.
> In your example
> a=. 'a?bc?de?fghi?jklmno?pqrstu?vwxy?z???A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???'
>    #a
> 92
>    #@(7&u:) a
> 72
>    toupper a
> A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???A?BC?DE?FGHI?JKLMNO?PQRSTU?VWXY?Z???
>    toupper&.(7&u:) a
> ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
>
> I suppose both toupper and toupper&.(7&u:) give incorrect result for ?slandish.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From ramacd at nbnet.nb.ca  Sat Dec 10 22:46:38 2005
From: ramacd at nbnet.nb.ca (Randy MacDonald)
Date: Sat Dec 10 22:44:42 2005
Subject: [Jbeta] tolower and toupper
References: <1134206992.c8296adcbill_lam@myrealbox.com>
Message-ID: <00c101c5fd98$86842270$0302a8c0@LONDON4Y78ST8>

toupper and tolower working on Unicode is certainly nice-to-have.

In which script are toupper and tolower defined?

I wonder if there's a upper/lower codepoint mapping defined by Unicode.org.

-----------------------------------------------------------------------
|\/| Randy A MacDonald             | you can't pay for it,
|/\| ramacd@nbnet.nb.ca            |       even if you want to.
BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
Natural Born APL'er                | Demo website: http://142.166.105.166/
----------------------------------------------------(INTP)----{ gnat }-

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 5:29 AM
Subject: [Jbeta] tolower and toupper


tolower and toupper will give index error for character above 255.
Chinese (and Japanese?) does not have this but Many European languages
(Islandic?) do have lower/upper case alphabets. It will be nice to
make tolower/toupper also work for them.

----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm


From gosinn at gmail.com  Sat Dec 10 22:51:26 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sat Dec 10 22:49:39 2005
Subject: [Jbeta] tolower and toupper
In-Reply-To: <00c101c5fd98$86842270$0302a8c0@LONDON4Y78ST8>
References: <1134206992.c8296adcbill_lam@myrealbox.com>
	<00c101c5fd98$86842270$0302a8c0@LONDON4Y78ST8>
Message-ID: <4031fef0512100651x4cb4a740j@mail.gmail.com>

system/main/stdlib.ijs
NB.*tolower v convert text to lower case
NB.*toupper v convert text to upper case
'l u'=. (a.i.'aA') +each <i.26
tolower=: a.&i. { ((l{a.) u} a.)"_
toupper=: a.&i. { ((u{a.) l} a.)"_




2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> toupper and tolower working on Unicode is certainly nice-to-have.
>
> In which script are toupper and tolower defined?
>
> I wonder if there's a upper/lower codepoint mapping defined by Unicode.org.
>
> -----------------------------------------------------------------------
> |\/| Randy A MacDonald             | you can't pay for it,
> |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> Natural Born APL'er                | Demo website: http://142.166.105.166/
> ----------------------------------------------------(INTP)----{ gnat }-
>
> ----- Original Message -----
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 5:29 AM
> Subject: [Jbeta] tolower and toupper
>
>
> tolower and toupper will give index error for character above 255.
> Chinese (and Japanese?) does not have this but Many European languages
> (Islandic?) do have lower/upper case alphabets. It will be nice to
> make tolower/toupper also work for them.
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From ramacd at nbnet.nb.ca  Sat Dec 10 23:04:05 2005
From: ramacd at nbnet.nb.ca (Randy MacDonald)
Date: Sat Dec 10 23:02:23 2005
Subject: [Jbeta] tolower and toupper
References: <1134206992.c8296adcbill_lam@myrealbox.com><00c101c5fd98$86842270$0302a8c0@LONDON4Y78ST8>
	<4031fef0512100651x4cb4a740j@mail.gmail.com>
Message-ID: <014801c5fd9a$f6f30600$0302a8c0@LONDON4Y78ST8>

Thanks for the pointer (and the actual script... who needs bandwidth when
one has J)!

It looks like extending toupper and tolower is an exercise for the reader,
something to share perhaps on the jwiki.


The following link looks like a workable standard:

http://www.unicode.org/reports/tr21/tr21-5.html

-----------------------------------------------------------------------
|\/| Randy A MacDonald             | you can't pay for it,
|/\| ramacd@nbnet.nb.ca            |       even if you want to.
BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
Natural Born APL'er                | Demo website: http://142.166.105.166/
----------------------------------------------------(INTP)----{ gnat }-

----- Original Message ----- 
From: "Bj?rn Helgason" <gosinn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 10:51 AM
Subject: Re: [Jbeta] tolower and toupper


system/main/stdlib.ijs
NB.*tolower v convert text to lower case
NB.*toupper v convert text to upper case
'l u'=. (a.i.'aA') +each <i.26
tolower=: a.&i. { ((l{a.) u} a.)"_
toupper=: a.&i. { ((u{a.) l} a.)"_




2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> toupper and tolower working on Unicode is certainly nice-to-have.
>
> In which script are toupper and tolower defined?
>
> I wonder if there's a upper/lower codepoint mapping defined by
Unicode.org.
>
> -----------------------------------------------------------------------
> |\/| Randy A MacDonald             | you can't pay for it,
> |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> Natural Born APL'er                | Demo website: http://142.166.105.166/
> ----------------------------------------------------(INTP)----{ gnat }-
>
> ----- Original Message -----
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 5:29 AM
> Subject: [Jbeta] tolower and toupper
>
>
> tolower and toupper will give index error for character above 255.
> Chinese (and Japanese?) does not have this but Many European languages
> (Islandic?) do have lower/upper case alphabets. It will be nice to
> make tolower/toupper also work for them.
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm


From eiverson at sympatico.ca  Sat Dec 10 23:05:10 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 10 23:15:03 2005
Subject: [Jbeta] J 601 c beta available
References: <003e01c5fd11$5ed6e460$0701a8c0@xp><6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com><6f80c1520512091650n135e2f23x6bda771f839e6a1@mail.gmail.com><003c01c5fd3c$dfc59460$0701a8c0@xp>
	<BCA120F033651846B2F069EF43A486F2736C04@usat-vocex13.usatoday.us.ad.gannett.com>
Message-ID: <003f01c5fd9c$bffc84d0$0701a8c0@xp>

The users complaint was that what they thought of as a scalar single char 
ended up as a list after 7 u: and required something like 0{ or {. or ''$ to 
get the scalar they wanted. Making 7 u: always return a list (that is even 
for ASCII data which currently is returned as is) would make 7 u: more 
consistent and is probably what we will do, but it doesn't remove the need 
for {. in the stated problem.

----- Original Message ----- 
From: "Miller, Raul D" <rdmiller@usatoday.com>
To: "Beta forum" <beta@jsoftware.com>; "Beta forum" <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 3:01 AM
Subject: RE: [Jbeta] J 601 c beta available


Eric Iverson wrote:
> The problem is that the result of 7 u: for a 2 or 3 character sequence 
> that
> returns a single wchar is a list. As the argument is a list there is no 
> way
> to determine if the result should be a scalar or a list. The ASCII arg to 
> 7
> u: is currently returned as unchanged. It might be more consistent to make 
> 7
> u: always return a list even in the ASCII case. But this wouldn't help 
> your
> situation.

I don't understand that last comment.

I'd think that having 7 u: always return a list would be the right answer,
and I don't know enough about the interpreter internals to understand
why that would be a bad solution.

Could you elaborate a bit?

Thanks,

-- 
Raul
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Sat Dec 10 23:16:47 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 10 23:15:04 2005
Subject: [Jbeta] missing gl2 commands
References: <1134204829.c8296adcbill_lam@myrealbox.com>
Message-ID: <004001c5fd9c$c1243bf0$0701a8c0@xp>

The notes in Release Highlights should be made stronger. There are MAJOR 
incompatible changes in gl2 with this release. Mapping modes are decommitted 
as well as many commands. The gl2 commands and implementation are 
streamlined to improve performance, provide a more basic core implemented in 
C++ and JAVA, more functionality provided in J code, and better portability 
across platforms.

Any old gl2 code will need careful thought and conversion. The problems are 
much greater if you used mapping modes.

Probably the place to start is to work through the new gl2 commands lab and 
read the new User Manual docs.

We know this is going to be a big nuisance for some users and will help as 
much as we can through the beta forum. My main confidence that this was the 
right thing to do was that Chris drove many of the changes in his 
requirements for grid and was happy to make the changes for plot. No pain, 
no gain.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 3:53 AM
Subject: [Jbeta] missing gl2 commands


I found many gl2 commands are missing in J601,
especially glmap and printer support. Will they be add back later, or is 
there any new equivalent commands?


----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From gosinn at gmail.com  Sat Dec 10 23:18:19 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sat Dec 10 23:16:33 2005
Subject: [Jbeta] tolower and toupper
In-Reply-To: <014801c5fd9a$f6f30600$0302a8c0@LONDON4Y78ST8>
References: <1134206992.c8296adcbill_lam@myrealbox.com>
	<00c101c5fd98$86842270$0302a8c0@LONDON4Y78ST8>
	<4031fef0512100651x4cb4a740j@mail.gmail.com>
	<014801c5fd9a$f6f30600$0302a8c0@LONDON4Y78ST8>
Message-ID: <4031fef0512100718s12a4c925k@mail.gmail.com>

I used to need these kind of verbs a lot earlier
(maybe in the future??!!??)
There are several codepages for ?slandish chars
So there are hell of a lot of files created in one operating system
with one codepage and when you receive such a file using another
codepage you need to these kind of exercises to move the chars around
codepage 850, 861, EBCDIC, Roman8, 1262, some special codepages as well

>From now on I hope to only need to move the chars up to Unicode and
not bother with them ever again after that (wishful thinking!!)

That is one of the reasons I am very very happy about get such a
strong support for Unicode in J

There are similar considerations with the APL chars between different
implementations of Quad AV - they will also get easier in Unicode
You can actually display APL chars very nicely with this new Unicode
support in J

As usual J is way ahead of the other APL dialects

2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> Thanks for the pointer (and the actual script... who needs bandwidth when
> one has J)!
>
> It looks like extending toupper and tolower is an exercise for the reader,
> something to share perhaps on the jwiki.
>
>
> The following link looks like a workable standard:
>
> http://www.unicode.org/reports/tr21/tr21-5.html
>
> -----------------------------------------------------------------------
> |\/| Randy A MacDonald             | you can't pay for it,
> |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> Natural Born APL'er                | Demo website: http://142.166.105.166/
> ----------------------------------------------------(INTP)----{ gnat }-
>
> ----- Original Message -----
> From: "Bj?rn Helgason" <gosinn@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 10:51 AM
> Subject: Re: [Jbeta] tolower and toupper
>
>
> system/main/stdlib.ijs
> NB.*tolower v convert text to lower case
> NB.*toupper v convert text to upper case
> 'l u'=. (a.i.'aA') +each <i.26
> tolower=: a.&i. { ((l{a.) u} a.)"_
> toupper=: a.&i. { ((u{a.) l} a.)"_
>
>
>
>
> 2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> > toupper and tolower working on Unicode is certainly nice-to-have.
> >
> > In which script are toupper and tolower defined?
> >
> > I wonder if there's a upper/lower codepoint mapping defined by
> Unicode.org.
> >
> > -----------------------------------------------------------------------
> > |\/| Randy A MacDonald             | you can't pay for it,
> > |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> > BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> > Natural Born APL'er                | Demo website: http://142.166.105.166/
> > ----------------------------------------------------(INTP)----{ gnat }-
> >
> > ----- Original Message -----
> > From: "bill lam" <bill_lam@myrealbox.com>
> > To: <beta@jsoftware.com>
> > Sent: Saturday, December 10, 2005 5:29 AM
> > Subject: [Jbeta] tolower and toupper
> >
> >
> > tolower and toupper will give index error for character above 255.
> > Chinese (and Japanese?) does not have this but Many European languages
> > (Islandic?) do have lower/upper case alphabets. It will be nice to
> > make tolower/toupper also work for them.
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>           /|_      .-----------------------------------.
>          ,'  .\  /  | Me? l?ttri lund ver?ur        |
>      ,--'    _,'   | Dagurinn ? dag                     |
>     /       /       | Enn betri en g?rdagurinn  |
>    (   -.  |        `-----------------------------------'
>    |     ) |
>   (`-.  '--.)
>    `. )----'
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From eiverson at sympatico.ca  Sat Dec 10 23:22:42 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 10 23:20:57 2005
Subject: [Jbeta] missing gl2 commands
References: <1134222815.c82b7ddcbill_lam@myrealbox.com>
Message-ID: <005b01c5fd9d$93a11f30$0701a8c0@xp>

Please work your way through the gl2 printing lab. Some capabilities were 
dropped in favor of making J printing identical across platforms. I don't 
recall the details right now. Let us know if you feel critical stuff is 
missing and we can see about adding it back in as appropriate.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 8:53 AM
Subject: Re: [Jbeta] missing gl2 commands


glqdevmode,glzdevmode and glzorientation are essential for printing
under win32, without them it is difficult to do professional printing.
Are they still available under J601 or docs showing how to get it done?



----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Sat Dec 10 23:32:40 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 10 23:30:55 2005
Subject: [Jbeta] 1!:x and unicode
References: <1134206354.c8296adcbill_lam@myrealbox.com>
Message-ID: <006901c5fd9e$f6e46330$0701a8c0@xp>

There are some nasty issues here that we have not faced up to yet. I'll dig 
into the problem and see what can be done. I assume you'd like the 1!:x 
filename interface to be based on utf8. I'm not sure how this works out in 
windows and java.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 4:19 AM
Subject: [Jbeta] 1!:x and unicode


It appears 1!:x family is not unicode aware.
e.g. file name supplied to 1!:0 must be multibyte character.
unicode and utf8 is not supported.
The file names returned is also in multibyte (code page dependent).


----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From ramacd at nbnet.nb.ca  Sat Dec 10 23:33:50 2005
From: ramacd at nbnet.nb.ca (Randy MacDonald)
Date: Sat Dec 10 23:31:57 2005
Subject: [Jbeta] tolower and toupper
References: <1134206992.c8296adcbill_lam@myrealbox.com><00c101c5fd98$86842270$0302a8c0@LONDON4Y78ST8><4031fef0512100651x4cb4a740j@mail.gmail.com><014801c5fd9a$f6f30600$0302a8c0@LONDON4Y78ST8>
	<4031fef0512100718s12a4c925k@mail.gmail.com>
Message-ID: <015b01c5fd9f$1ecc9ac0$0302a8c0@LONDON4Y78ST8>

As far as I can tell, a codepage is a way to map i.256 onto glyphs. This
suggests a verb that takes a code page and an element of i.256, or a
character noun, and returns a Unicode character:

   850 unicode_of_cp_n 'a'
a
   850 unicode_of_cp_n 97
a

This demo, of course, would need to be extended to character values >127.

-----------------------------------------------------------------------
|\/| Randy A MacDonald             | you can't pay for it,
|/\| ramacd@nbnet.nb.ca            |       even if you want to.
BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
Natural Born APL'er                | Demo website: http://142.166.105.166/
----------------------------------------------------(INTP)----{ gnat }-

----- Original Message ----- 
From: "Bj?rn Helgason" <gosinn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 11:18 AM
Subject: Re: [Jbeta] tolower and toupper


I used to need these kind of verbs a lot earlier
(maybe in the future??!!??)
There are several codepages for ?slandish chars
So there are hell of a lot of files created in one operating system
with one codepage and when you receive such a file using another
codepage you need to these kind of exercises to move the chars around
codepage 850, 861, EBCDIC, Roman8, 1262, some special codepages as well

>From now on I hope to only need to move the chars up to Unicode and
not bother with them ever again after that (wishful thinking!!)

That is one of the reasons I am very very happy about get such a
strong support for Unicode in J

There are similar considerations with the APL chars between different
implementations of Quad AV - they will also get easier in Unicode
You can actually display APL chars very nicely with this new Unicode
support in J

As usual J is way ahead of the other APL dialects

2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> Thanks for the pointer (and the actual script... who needs bandwidth when
> one has J)!
>
> It looks like extending toupper and tolower is an exercise for the reader,
> something to share perhaps on the jwiki.
>
>
> The following link looks like a workable standard:
>
> http://www.unicode.org/reports/tr21/tr21-5.html
>
> -----------------------------------------------------------------------
> |\/| Randy A MacDonald             | you can't pay for it,
> |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> Natural Born APL'er                | Demo website: http://142.166.105.166/
> ----------------------------------------------------(INTP)----{ gnat }-
>
> ----- Original Message -----
> From: "Bj?rn Helgason" <gosinn@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 10:51 AM
> Subject: Re: [Jbeta] tolower and toupper
>
>
> system/main/stdlib.ijs
> NB.*tolower v convert text to lower case
> NB.*toupper v convert text to upper case
> 'l u'=. (a.i.'aA') +each <i.26
> tolower=: a.&i. { ((l{a.) u} a.)"_
> toupper=: a.&i. { ((u{a.) l} a.)"_
>
>
>
>
> 2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> > toupper and tolower working on Unicode is certainly nice-to-have.
> >
> > In which script are toupper and tolower defined?
> >
> > I wonder if there's a upper/lower codepoint mapping defined by
> Unicode.org.
> >
> > -----------------------------------------------------------------------
> > |\/| Randy A MacDonald             | you can't pay for it,
> > |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> > BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> > Natural Born APL'er                | Demo website:
http://142.166.105.166/
> > ----------------------------------------------------(INTP)----{ gnat }-
> >
> > ----- Original Message -----
> > From: "bill lam" <bill_lam@myrealbox.com>
> > To: <beta@jsoftware.com>
> > Sent: Saturday, December 10, 2005 5:29 AM
> > Subject: [Jbeta] tolower and toupper
> >
> >
> > tolower and toupper will give index error for character above 255.
> > Chinese (and Japanese?) does not have this but Many European languages
> > (Islandic?) do have lower/upper case alphabets. It will be nice to
> > make tolower/toupper also work for them.
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>           /|_      .-----------------------------------.
>          ,'  .\  /  | Me? l?ttri lund ver?ur        |
>      ,--'    _,'   | Dagurinn ? dag                     |
>     /       /       | Enn betri en g?rdagurinn  |
>    (   -.  |        `-----------------------------------'
>    |     ) |
>   (`-.  '--.)
>    `. )----'
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm


From gosinn at gmail.com  Sat Dec 10 23:37:42 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sat Dec 10 23:35:55 2005
Subject: [Jbeta] tolower and toupper
In-Reply-To: <015b01c5fd9f$1ecc9ac0$0302a8c0@LONDON4Y78ST8>
References: <1134206992.c8296adcbill_lam@myrealbox.com>
	<00c101c5fd98$86842270$0302a8c0@LONDON4Y78ST8>
	<4031fef0512100651x4cb4a740j@mail.gmail.com>
	<014801c5fd9a$f6f30600$0302a8c0@LONDON4Y78ST8>
	<4031fef0512100718s12a4c925k@mail.gmail.com>
	<015b01c5fd9f$1ecc9ac0$0302a8c0@LONDON4Y78ST8>
Message-ID: <4031fef0512100737k5b0b4fdn@mail.gmail.com>

a=.'????'
   ucpcount a
4
   #a
8
   a. i. a
195 190 195 166 195 182 195 176

2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> As far as I can tell, a codepage is a way to map i.256 onto glyphs. This
> suggests a verb that takes a code page and an element of i.256, or a
> character noun, and returns a Unicode character:
>
>    850 unicode_of_cp_n 'a'
> a
>    850 unicode_of_cp_n 97
> a
>
> This demo, of course, would need to be extended to character values >127.
>
> -----------------------------------------------------------------------
> |\/| Randy A MacDonald             | you can't pay for it,
> |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> Natural Born APL'er                | Demo website: http://142.166.105.166/
> ----------------------------------------------------(INTP)----{ gnat }-
>
> ----- Original Message -----
> From: "Bj?rn Helgason" <gosinn@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 11:18 AM
> Subject: Re: [Jbeta] tolower and toupper
>
>
> I used to need these kind of verbs a lot earlier
> (maybe in the future??!!??)
> There are several codepages for ?slandish chars
> So there are hell of a lot of files created in one operating system
> with one codepage and when you receive such a file using another
> codepage you need to these kind of exercises to move the chars around
> codepage 850, 861, EBCDIC, Roman8, 1262, some special codepages as well
>
> >From now on I hope to only need to move the chars up to Unicode and
> not bother with them ever again after that (wishful thinking!!)
>
> That is one of the reasons I am very very happy about get such a
> strong support for Unicode in J
>
> There are similar considerations with the APL chars between different
> implementations of Quad AV - they will also get easier in Unicode
> You can actually display APL chars very nicely with this new Unicode
> support in J
>
> As usual J is way ahead of the other APL dialects
>
> 2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> > Thanks for the pointer (and the actual script... who needs bandwidth when
> > one has J)!
> >
> > It looks like extending toupper and tolower is an exercise for the reader,
> > something to share perhaps on the jwiki.
> >
> >
> > The following link looks like a workable standard:
> >
> > http://www.unicode.org/reports/tr21/tr21-5.html
> >
> > -----------------------------------------------------------------------
> > |\/| Randy A MacDonald             | you can't pay for it,
> > |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> > BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> > Natural Born APL'er                | Demo website: http://142.166.105.166/
> > ----------------------------------------------------(INTP)----{ gnat }-
> >
> > ----- Original Message -----
> > From: "Bj?rn Helgason" <gosinn@gmail.com>
> > To: "Beta forum" <beta@jsoftware.com>
> > Sent: Saturday, December 10, 2005 10:51 AM
> > Subject: Re: [Jbeta] tolower and toupper
> >
> >
> > system/main/stdlib.ijs
> > NB.*tolower v convert text to lower case
> > NB.*toupper v convert text to upper case
> > 'l u'=. (a.i.'aA') +each <i.26
> > tolower=: a.&i. { ((l{a.) u} a.)"_
> > toupper=: a.&i. { ((u{a.) l} a.)"_
> >
> >
> >
> >
> > 2005/12/10, Randy MacDonald <ramacd@nbnet.nb.ca>:
> > > toupper and tolower working on Unicode is certainly nice-to-have.
> > >
> > > In which script are toupper and tolower defined?
> > >
> > > I wonder if there's a upper/lower codepoint mapping defined by
> > Unicode.org.
> > >
> > > -----------------------------------------------------------------------
> > > |\/| Randy A MacDonald             | you can't pay for it,
> > > |/\| ramacd@nbnet.nb.ca            |       even if you want to.
> > > BSc(Math) UNBF'83 Sapere Aude      | APL: If you can say it, it's done..
> > > Natural Born APL'er                | Demo website:
> http://142.166.105.166/
> > > ----------------------------------------------------(INTP)----{ gnat }-
> > >
> > > ----- Original Message -----
> > > From: "bill lam" <bill_lam@myrealbox.com>
> > > To: <beta@jsoftware.com>
> > > Sent: Saturday, December 10, 2005 5:29 AM
> > > Subject: [Jbeta] tolower and toupper
> > >
> > >
> > > tolower and toupper will give index error for character above 255.
> > > Chinese (and Japanese?) does not have this but Many European languages
> > > (Islandic?) do have lower/upper case alphabets. It will be nice to
> > > make tolower/toupper also work for them.
> > >
> > > ----------------------------------------------------------------------
> > > For information about J forums see http://www.jsoftware.com/forums.htm
> > >
> > >
> > > ----------------------------------------------------------------------
> > > For information about J forums see http://www.jsoftware.com/forums.htm
> > >
> >
> >
> > --
> > Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> > Fugl&Fiskur ehf, ?erneyjarsund 23,
> > 802 Selfoss ,t-p?st: gosinn@gmail.com
> > http://www.linux.is/forritun/data/J/grunnur.pdf
> >
> >
> > T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
> >
> > g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
> >           /|_      .-----------------------------------.
> >          ,'  .\  /  | Me? l?ttri lund ver?ur        |
> >      ,--'    _,'   | Dagurinn ? dag                     |
> >     /       /       | Enn betri en g?rdagurinn  |
> >    (   -.  |        `-----------------------------------'
> >    |     ) |
> >   (`-.  '--.)
> >    `. )----'
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>           /|_      .-----------------------------------.
>          ,'  .\  /  | Me? l?ttri lund ver?ur        |
>      ,--'    _,'   | Dagurinn ? dag                     |
>     /       /       | Enn betri en g?rdagurinn  |
>    (   -.  |        `-----------------------------------'
>    |     ) |
>   (`-.  '--.)
>    `. )----'
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From bill_lam at myrealbox.com  Sun Dec 11 00:46:29 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sun Dec 11 00:44:43 2005
Subject: [Jbeta] missing gl2 commands
Message-ID: <1134233189.c822e55cbill_lam@myrealbox.com>

I tried gl2 printing lab and realised J601 try to make  printing on printer 
the same as painting on screen. I suppose this is a mistake. 
Physically, screen is in a state of constant change, therefore an
event handler is called to repaint, but printing on paper is immutable
once paper is ejected.  In programming logic, if I need to print a report
of 1000 records, I will write a loop to print each record, test if the
page is full, eject one page and start a new page and continue to
write next record.  The paint event handler is suitable for printing 
plots but not for printing text reports.

glqdevmode,glzdevmode are critical because they can be used to select paper 
size, set custom form size, number of copy. Also it can get the printable 
paper size before actually starting print job.

IMHO, it is unreasonable to cut functionality that was previously available in win32
just because they are absent in Linux/Mac.


From gosinn at gmail.com  Sun Dec 11 00:55:39 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sun Dec 11 00:53:54 2005
Subject: [Jbeta] missing gl2 commands
In-Reply-To: <1134233189.c822e55cbill_lam@myrealbox.com>
References: <1134233189.c822e55cbill_lam@myrealbox.com>
Message-ID: <4031fef0512100855r6bc2d99bh@mail.gmail.com>

Can you not paint out to a printfile and send it later to a printer?

2005/12/10, bill lam <bill_lam@myrealbox.com>:
> I tried gl2 printing lab and realised J601 try to make  printing on printer
> the same as painting on screen. I suppose this is a mistake.
> Physically, screen is in a state of constant change, therefore an
> event handler is called to repaint, but printing on paper is immutable
> once paper is ejected.  In programming logic, if I need to print a report
> of 1000 records, I will write a loop to print each record, test if the
> page is full, eject one page and start a new page and continue to
> write next record.  The paint event handler is suitable for printing
> plots but not for printing text reports.
>
> glqdevmode,glzdevmode are critical because they can be used to select paper
> size, set custom form size, number of copy. Also it can get the printable
> paper size before actually starting print job.
>
> IMHO, it is unreasonable to cut functionality that was previously available in win32
> just because they are absent in Linux/Mac.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From gosinn at gmail.com  Sun Dec 11 01:32:29 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sun Dec 11 01:30:42 2005
Subject: [Jbeta] missing gl2 commands
In-Reply-To: <005b01c5fd9d$93a11f30$0701a8c0@xp>
References: <1134222815.c82b7ddcbill_lam@myrealbox.com>
	<005b01c5fd9d$93a11f30$0701a8c0@xp>
Message-ID: <4031fef0512100932i70abc47eo@mail.gmail.com>

These two

system\extras\labs\graphics\gl2.ijt

system\extras\labs\system\gl2.ijt

Are both

LABTITLE=: 'Graphics - gl2 commands'

I guess I need to delete one of them

Probably
system\extras\labs\system\gl2.ijt

Right?


2005/12/10, Eric Iverson <eiverson@sympatico.ca>:
> Please work your way through the gl2 printing lab. Some capabilities were
> dropped in favor of making J printing identical across platforms. I don't
> recall the details right now. Let us know if you feel critical stuff is
> missing and we can see about adding it back in as appropriate.
>
> ----- Original Message -----
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 8:53 AM
> Subject: Re: [Jbeta] missing gl2 commands
>
>
> glqdevmode,glzdevmode and glzorientation are essential for printing
> under win32, without them it is difficult to do professional printing.
> Are they still available under J601 or docs showing how to get it done?
>
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From davidvj at verizon.net  Sun Dec 11 04:11:36 2005
From: davidvj at verizon.net (David Vincent-Jones)
Date: Sun Dec 11 04:10:05 2005
Subject: [Jbeta] Wdstatus display
Message-ID: <000f01c5fdc5$efcbe970$2c01a8c0@DAVID>

There appears to be something odd regarding wdstatus display on the beta.

The information box initially appears without a background colour but
changes appearance (with another odd appearance) if clicked during a long
run.

This may be a more general wd display problem.

stattest=:verb define
pos=:0
fin=:1000000
while. pos<fin do.
if. 0=1000|pos 
do.' position' wdstatus 'position ',(":pos),'  Completion
',(0j1":100*pos%$fin),'%' 
end.
pos=:pos+1
end.
wdstatus ''
)

David


From eiverson at sympatico.ca  Sun Dec 11 04:47:18 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 11 04:45:32 2005
Subject: [Jbeta] missing gl2 commands
References: <1134222815.c82b7ddcbill_lam@myrealbox.com><005b01c5fd9d$93a11f30$0701a8c0@xp>
	<4031fef0512100932i70abc47eo@mail.gmail.com>
Message-ID: <002401c5fdca$eb74f920$0701a8c0@xp>

You need to download the latest c beta. The duplicate gl2 labs is fixed 
there. Note that this c version is newer than the test c beta I gave you 
earlier when working on the uft-8 problems.

----- Original Message ----- 
From: "Bj?rn Helgason" <gosinn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 12:32 PM
Subject: Re: [Jbeta] missing gl2 commands


These two

system\extras\labs\graphics\gl2.ijt

system\extras\labs\system\gl2.ijt

Are both

LABTITLE=: 'Graphics - gl2 commands'

I guess I need to delete one of them

Probably
system\extras\labs\system\gl2.ijt

Right?


2005/12/10, Eric Iverson <eiverson@sympatico.ca>:
> Please work your way through the gl2 printing lab. Some capabilities were
> dropped in favor of making J printing identical across platforms. I don't
> recall the details right now. Let us know if you feel critical stuff is
> missing and we can see about adding it back in as appropriate.
>
> ----- Original Message -----
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 8:53 AM
> Subject: Re: [Jbeta] missing gl2 commands
>
>
> glqdevmode,glzdevmode and glzorientation are essential for printing
> under win32, without them it is difficult to do professional printing.
> Are they still available under J601 or docs showing how to get it done?
>
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From gosinn at gmail.com  Sun Dec 11 04:53:36 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sun Dec 11 04:51:49 2005
Subject: [Jbeta] missing gl2 commands
In-Reply-To: <002401c5fdca$eb74f920$0701a8c0@xp>
References: <1134222815.c82b7ddcbill_lam@myrealbox.com>
	<005b01c5fd9d$93a11f30$0701a8c0@xp>
	<4031fef0512100932i70abc47eo@mail.gmail.com>
	<002401c5fdca$eb74f920$0701a8c0@xp>
Message-ID: <4031fef0512101253q4972f283o@mail.gmail.com>

looks fine now
I renamed the old j601b and reinstalled


2005/12/10, Eric Iverson <eiverson@sympatico.ca>:
> You need to download the latest c beta. The duplicate gl2 labs is fixed
> there. Note that this c version is newer than the test c beta I gave you
> earlier when working on the uft-8 problems.
>
> ----- Original Message -----
> From: "Bj?rn Helgason" <gosinn@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Saturday, December 10, 2005 12:32 PM
> Subject: Re: [Jbeta] missing gl2 commands
>
>
> These two
>
> system\extras\labs\graphics\gl2.ijt
>
> system\extras\labs\system\gl2.ijt
>
> Are both
>
> LABTITLE=: 'Graphics - gl2 commands'
>
> I guess I need to delete one of them
>
> Probably
> system\extras\labs\system\gl2.ijt
>
> Right?
>
>
> 2005/12/10, Eric Iverson <eiverson@sympatico.ca>:
> > Please work your way through the gl2 printing lab. Some capabilities were
> > dropped in favor of making J printing identical across platforms. I don't
> > recall the details right now. Let us know if you feel critical stuff is
> > missing and we can see about adding it back in as appropriate.
> >
> > ----- Original Message -----
> > From: "bill lam" <bill_lam@myrealbox.com>
> > To: <beta@jsoftware.com>
> > Sent: Saturday, December 10, 2005 8:53 AM
> > Subject: Re: [Jbeta] missing gl2 commands
> >
> >
> > glqdevmode,glzdevmode and glzorientation are essential for printing
> > under win32, without them it is difficult to do professional printing.
> > Are they still available under J601 or docs showing how to get it done?
> >
> >
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>           /|_      .-----------------------------------.
>          ,'  .\  /  | Me? l?ttri lund ver?ur        |
>      ,--'    _,'   | Dagurinn ? dag                     |
>     /       /       | Enn betri en g?rdagurinn  |
>    (   -.  |        `-----------------------------------'
>    |     ) |
>   (`-.  '--.)
>    `. )----'
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From eiverson at sympatico.ca  Sun Dec 11 05:04:49 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 11 05:48:04 2005
Subject: [Jbeta] Wdstatus display
References: <000f01c5fdc5$efcbe970$2c01a8c0@DAVID>
Message-ID: <000c01c5fdd3$a794c9c0$0701a8c0@xp>

The problem seems to be the same in J504 so is not new to the J601 beta. If 
you do a wdstatus first and give the system a chance to paint its background 
then stattest works as you would like. The trouble is in your example 
compute loop the system never gets to paint the background whereas the text 
area is being updated immediattely. Some minor changes to how wdstatus is 
coded could fix this, but it won't be a high priority as it has been this 
way for quite some time.

----- Original Message ----- 
From: "David Vincent-Jones" <davidvj@verizon.net>
To: "JSoftware Beta" <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 3:11 PM
Subject: [Jbeta] Wdstatus display


> There appears to be something odd regarding wdstatus display on the beta.
>
> The information box initially appears without a background colour but
> changes appearance (with another odd appearance) if clicked during a long
> run.
>
> This may be a more general wd display problem.
>
> stattest=:verb define
> pos=:0
> fin=:1000000
> while. pos<fin do.
> if. 0=1000|pos
> do.' position' wdstatus 'position ',(":pos),'  Completion
> ',(0j1":100*pos%$fin),'%'
> end.
> pos=:pos+1
> end.
> wdstatus ''
> )
>
> David
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Sun Dec 11 05:49:50 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 11 05:48:06 2005
Subject: [Jbeta] missing gl2 commands
References: <1134233189.c822e55cbill_lam@myrealbox.com>
Message-ID: <000d01c5fdd3$a8a24220$0701a8c0@xp>

There are two different issues here. One is that printing of a page is done 
in an event handler and the other is the functionality of devmode etc. If 
there is missing functionality, it can be added back in to meet critical 
requirements. The more important question is the page print handler.

Although it is a slightly different view of things than existed in J504, it 
is in fact more typical of modern printing interfaces and I think with 
adjustments to your worldview works well in the mode you describe. In both 
cases there is a loop that runs printing one page and then the next. I 
suggest that it isn't a big difference if the master loop is your J while. 
or whether the master loop is in the host as the code called inside the loop 
is essentially the same. I may be wrong on this, but ask you to please take 
a careful look.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 11:46 AM
Subject: Re: [Jbeta] missing gl2 commands


I tried gl2 printing lab and realised J601 try to make  printing on printer
the same as painting on screen. I suppose this is a mistake.
Physically, screen is in a state of constant change, therefore an
event handler is called to repaint, but printing on paper is immutable
once paper is ejected.  In programming logic, if I need to print a report
of 1000 records, I will write a loop to print each record, test if the
page is full, eject one page and start a new page and continue to
write next record.  The paint event handler is suitable for printing
plots but not for printing text reports.

glqdevmode,glzdevmode are critical because they can be used to select paper
size, set custom form size, number of copy. Also it can get the printable
paper size before actually starting print job.

IMHO, it is unreasonable to cut functionality that was previously available 
in win32
just because they are absent in Linux/Mac.


----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Sun Dec 11 05:51:34 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 11 05:49:48 2005
Subject: [Jbeta] 1!:x and unicode
References: <1134206354.c8296adcbill_lam@myrealbox.com>
Message-ID: <001b01c5fdd3$e54cce70$0701a8c0@xp>

I have a test version running that has utf-8 support for 1!:x. It looks good 
and I'll probably get it out tomorrow if tests don't show up problems.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 4:19 AM
Subject: [Jbeta] 1!:x and unicode


It appears 1!:x family is not unicode aware.
e.g. file name supplied to 1!:0 must be multibyte character.
unicode and utf8 is not supported.
The file names returned is also in multibyte (code page dependent).


----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From juneaftn at gmail.com  Sun Dec 11 08:17:18 2005
From: juneaftn at gmail.com (June Kim)
Date: Sun Dec 11 08:15:30 2005
Subject: [Jbeta] J 601 c beta available
In-Reply-To: <003c01c5fd3c$dfc59460$0701a8c0@xp>
References: <003e01c5fd11$5ed6e460$0701a8c0@xp>
	<6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com>
	<6f80c1520512091650n135e2f23x6bda771f839e6a1@mail.gmail.com>
	<003c01c5fd3c$dfc59460$0701a8c0@xp>
Message-ID: <6f80c1520512101617k1321733av98e211768925aeea@mail.gmail.com>

Thank you for the explanation.

On 12/10/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> The problem is that the result of 7 u: for a 2 or 3 character sequence that
> returns a single wchar is a list. As the argument is a list there is no way
> to determine if the result should be a scalar or a list. The ASCII arg to 7
> u: is currently returned as unchanged. It might be more consistent to make 7
> u: always return a list even in the ASCII case. But this wouldn't help your
> situation.
>
> A possible change would be to make 7 u: return a scalar rather than a list
> if there was only 1 wchar in the result, but then when you wanted a list
> you'd be upset and I suspect this would just move the problem around.
>
> The problem is that the these transformation don't have the nice shape and
> rank conformation of typical J primitives. That is, 1, 2, or 3 char
> sequences in the arg make 1 wchar in the result.
>
> Feedback and suggestions welcome.

I think, when any character(in any encoding) is decoded into unicode,
all of them should be treated equally, whether it be korean or not,
and that's one reason of why unicode was born.

>
> I could redo all your HAN experiments, but the character doesn't display
> properly for me in ijs or ijx. It does display properly for me in your email
> and in notepad. What font are you using in ijs? Do you know why it won't
> display in my ijs window? I can display Chinese, Icelandic, etc ok.
>

I use Bitstream Vera Sans Mono usually(you can download it free from
the internet) but the font doesn't have korean characters and when I
try to use korean characters using the font, the system automatically
fall back to other korean default font instead. So I explicitly
changed the J system font into Arial Unicode MS and it worked. If you
use Arial Unicode MS, it should show the korean character.

Also note that the HAN character as in UTF8(that is, no conversion or
no explicit encoding/decoding) is shown correctly but the unicode form
(7 u: HAN) is not shown properly.
From gosinn at gmail.com  Sun Dec 11 08:31:39 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sun Dec 11 08:29:51 2005
Subject: [Jbeta] J 601 c beta available
In-Reply-To: <6f80c1520512101617k1321733av98e211768925aeea@mail.gmail.com>
References: <003e01c5fd11$5ed6e460$0701a8c0@xp>
	<6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com>
	<6f80c1520512091650n135e2f23x6bda771f839e6a1@mail.gmail.com>
	<003c01c5fd3c$dfc59460$0701a8c0@xp>
	<6f80c1520512101617k1321733av98e211768925aeea@mail.gmail.com>
Message-ID: <4031fef0512101631v7e0422cx@mail.gmail.com>

It displays fine with
"@Arial Unicode MS" 12

   ucpcount HAN
1
   #HAN
3
   a. i. HAN
237 149 156


2005/12/11, June Kim <juneaftn@gmail.com>:
> Thank you for the explanation.
>
> On 12/10/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> > The problem is that the result of 7 u: for a 2 or 3 character sequence that
> > returns a single wchar is a list. As the argument is a list there is no way
> > to determine if the result should be a scalar or a list. The ASCII arg to 7
> > u: is currently returned as unchanged. It might be more consistent to make 7
> > u: always return a list even in the ASCII case. But this wouldn't help your
> > situation.
> >
> > A possible change would be to make 7 u: return a scalar rather than a list
> > if there was only 1 wchar in the result, but then when you wanted a list
> > you'd be upset and I suspect this would just move the problem around.
> >
> > The problem is that the these transformation don't have the nice shape and
> > rank conformation of typical J primitives. That is, 1, 2, or 3 char
> > sequences in the arg make 1 wchar in the result.
> >
> > Feedback and suggestions welcome.
>
> I think, when any character(in any encoding) is decoded into unicode,
> all of them should be treated equally, whether it be korean or not,
> and that's one reason of why unicode was born.
>
> >
> > I could redo all your HAN experiments, but the character doesn't display
> > properly for me in ijs or ijx. It does display properly for me in your email
> > and in notepad. What font are you using in ijs? Do you know why it won't
> > display in my ijs window? I can display Chinese, Icelandic, etc ok.
> >
>
> I use Bitstream Vera Sans Mono usually(you can download it free from
> the internet) but the font doesn't have korean characters and when I
> try to use korean characters using the font, the system automatically
> fall back to other korean default font instead. So I explicitly
> changed the J system font into Arial Unicode MS and it worked. If you
> use Arial Unicode MS, it should show the korean character.
>
> Also note that the HAN character as in UTF8(that is, no conversion or
> no explicit encoding/decoding) is shown correctly but the unicode form
> (7 u: HAN) is not shown properly.
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From bill_lam at myrealbox.com  Sun Dec 11 14:47:34 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sun Dec 11 14:45:47 2005
Subject: [Jbeta] missing gl2 commands
Message-ID: <1134283654.c82f09bcbill_lam@myrealbox.com>

>it is in fact more typical of modern printing interfaces and I think with 
>adjustments to your worldview works well in the mode you describe.

Thank you for pointing out the world has changed this way.  I still consider it
counter productive.  I did web search and found out in Net framework, gui boys'
primary concern is how to paint graphics on printer.  This is unfortunate but
I have to live with it. May be I can use workaround like wrapper or direct window
api call.


From bill_lam at myrealbox.com  Sun Dec 11 14:56:51 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sun Dec 11 14:55:04 2005
Subject: [Jbeta] utf8 and EAV
Message-ID: <1134284211.c82f09bcbill_lam@myrealbox.com>

EAV is used extensively as delimiter in wd commands, but I found there are
some problems in J601.
1. fe and ff should be illegal characters inside utf-8 encoding.
7&u: should give domain error if string contains them.
2. EAV either as single char (255{a.) or as utf-8 (195 191{a.) does not function as
delimiter.  For example, replacing LF in unisimple demo by EAV.


From bill_lam at myrealbox.com  Sun Dec 11 18:12:34 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sun Dec 11 18:10:48 2005
Subject: [Jbeta] olesetlic
Message-ID: <1134295954.c826347cbill_lam@myrealbox.com>

I believe olesetlic is not working. although olegetlic
can still get the license key (is it cached?),but it
will cause domain error when try to create a form with 
ocx.


From bill_lam at myrealbox.com  Sun Dec 11 18:25:23 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sun Dec 11 18:23:35 2005
Subject: [Jbeta] 0.3 ":
Message-ID: <1134296723.c7f8399cbill_lam@myrealbox.com>

there is a 0.3 ": inside C:\j601\system\main\dates.ijs
it should be changed to 0j3

From eiverson at sympatico.ca  Sun Dec 11 22:58:58 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 11 22:57:16 2005
Subject: [Jbeta] J 601 c beta available
References: <003e01c5fd11$5ed6e460$0701a8c0@xp><6f80c1520512091640k1843c528p7ff7c92fa73896e4@mail.gmail.com><6f80c1520512091650n135e2f23x6bda771f839e6a1@mail.gmail.com><003c01c5fd3c$dfc59460$0701a8c0@xp><6f80c1520512101617k1321733av98e211768925aeea@mail.gmail.com>
	<4031fef0512101631v7e0422cx@mail.gmail.com>
Message-ID: <001a01c5fe63$6ca5f4c0$0701a8c0@xp>

Your suggestions don't work for me. It would seem (even though I've 
installed the MS east asian language stuff) that I don't have a font on my 
machine with Korean.

Note the following:
k=:  237 149 156{a. NB.Korean utf8 character
c=:  229 137 172{a. NB. Chinese utf8 character

k utf16 value  is 16bd55c and c is 16b526c

When I look in Character map for the courier new font I normally use I see 
that neither of these characters is in that font. But when I display k the 
system manages to find the character (presumably in some other font) and do 
the display. But it can't find the k character so the display is a box.

My conclusion is that I don't have a font on my machine with the Korean 
characters. And font stuff is always more complicated and mysterious than 
one imagines.

That said, I do think utf-8 is going to work well for the J community.

----- Original Message ----- 
From: "Bj?rn Helgason" <gosinn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Saturday, December 10, 2005 7:31 PM
Subject: Re: [Jbeta] J 601 c beta available


It displays fine with
"@Arial Unicode MS" 12

   ucpcount HAN
1
   #HAN
3
   a. i. HAN
237 149 156


2005/12/11, June Kim <juneaftn@gmail.com>:
> Thank you for the explanation.
>
> On 12/10/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> > The problem is that the result of 7 u: for a 2 or 3 character sequence 
> > that
> > returns a single wchar is a list. As the argument is a list there is no 
> > way
> > to determine if the result should be a scalar or a list. The ASCII arg 
> > to 7
> > u: is currently returned as unchanged. It might be more consistent to 
> > make 7
> > u: always return a list even in the ASCII case. But this wouldn't help 
> > your
> > situation.
> >
> > A possible change would be to make 7 u: return a scalar rather than a 
> > list
> > if there was only 1 wchar in the result, but then when you wanted a list
> > you'd be upset and I suspect this would just move the problem around.
> >
> > The problem is that the these transformation don't have the nice shape 
> > and
> > rank conformation of typical J primitives. That is, 1, 2, or 3 char
> > sequences in the arg make 1 wchar in the result.
> >
> > Feedback and suggestions welcome.
>
> I think, when any character(in any encoding) is decoded into unicode,
> all of them should be treated equally, whether it be korean or not,
> and that's one reason of why unicode was born.
>
> >
> > I could redo all your HAN experiments, but the character doesn't display
> > properly for me in ijs or ijx. It does display properly for me in your 
> > email
> > and in notepad. What font are you using in ijs? Do you know why it won't
> > display in my ijs window? I can display Chinese, Icelandic, etc ok.
> >
>
> I use Bitstream Vera Sans Mono usually(you can download it free from
> the internet) but the font doesn't have korean characters and when I
> try to use korean characters using the font, the system automatically
> fall back to other korean default font instead. So I explicitly
> changed the J system font into Arial Unicode MS and it worked. If you
> use Arial Unicode MS, it should show the korean character.
>
> Also note that the HAN character as in UTF8(that is, no conversion or
> no explicit encoding/decoding) is shown correctly but the unicode form
> (7 u: HAN) is not shown properly.
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Sun Dec 11 23:06:45 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 11 23:05:00 2005
Subject: [Jbeta] utf8 and EAV
References: <1134284211.c82f09bcbill_lam@myrealbox.com>
Message-ID: <002501c5fe64$84179590$0701a8c0@xp>

Yes, there is a problem with the 'old' wd use of EAV (255{a.) as a 
delimiter. I need to point this out clearly in the release highlights.

As you point out the use of utf8 means we can't use EAV as the delimiter. 
With hindsight this was a bad decision made many years ago. To move to utf-8 
we need to abandon EAV as a wd delimiter. Chris has now defined DEL as 
127{a. and this is now the delimiter recognized by wd.

Chris and I weren't sure what the easiest migration path was. By default we 
picked:
1. define DEL as 127{a. and do careful search/replace of EAV by DEL

If this doesn't work fairly easily for you, perhaps you could suggest a 
better approach.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Sunday, December 11, 2005 1:56 AM
Subject: [Jbeta] utf8 and EAV


EAV is used extensively as delimiter in wd commands, but I found there are
some problems in J601.
1. fe and ff should be illegal characters inside utf-8 encoding.
7&u: should give domain error if string contains them.
2. EAV either as single char (255{a.) or as utf-8 (195 191{a.) does not 
function as
delimiter.  For example, replacing LF in unisimple demo by EAV.


----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From donguinn at pvtnetworks.net  Sun Dec 11 23:20:16 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Sun Dec 11 23:18:35 2005
Subject: [Jbeta] gl2 labs
In-Reply-To: <006901c5fd9e$f6e46330$0701a8c0@xp>
References: <1134206354.c8296adcbill_lam@myrealbox.com>
	<006901c5fd9e$f6e46330$0701a8c0@xp>
Message-ID: <439C43B0.1080104@pvtn.net>

Just playing with the gl2 labs.  Looks good.  Might I suggest that you add
   gl2lab_jctrl_fkey=: jijs_labadvance_button_jijs_
to the lab.  Then one doesn't have to switch to some ij? window before 
advancing.  I find that I am in the lab window a lot when I press ctrl-j 
and nothing happens.

From bill_lam at myrealbox.com  Sun Dec 11 23:23:03 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sun Dec 11 23:21:15 2005
Subject: [Jbeta] gl2 docs
Message-ID: <1134314583.c80201dcbill_lam@myrealbox.com>

In gl2 docs
gltext text ; write text in the glfont font. Where and how the text is displayed is affected by the gltextalign and gltextxy commands.
but gltextalign has been decommited, how to do gltextalign in J601?

fontspec
The size is in logical units. For wd commands this is generally point size. In gl2, size is in mapping mode units. In gl3, size is in pixels.

gl print lab said font size is in point for printer, but for screen,
is font size also always in point, or the fontspec docs is correct?

isigraph events
An isigraph control supports character and mouse events. The Code Dialog in the form editor lists all events for an isigraph control.

size      resize event (OpenGL, gl2 must request with glwantresize)
but glwantresize is decommitted.

For mouse events the wdhandler variable sysdata contains:
x y width height leftbutton rightbutton ctrl shift
In J504 lower left is 0 0 but in J601 upper left is 0 0, 
J601 seems more reasonable, is this an intended change?

in Window Driver Command Reference Overview
It still point to a mapping mode page, but glmap is already decommitted.
now screen always use MM_RAW and printer always use MM_TWIPS.
Also in win32, origin of MM_TWIPS is at lower left corner, is J601 
use upper left corner as origin for MM_TWIPS.

From eiverson at sympatico.ca  Sun Dec 11 23:28:55 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 11 23:27:07 2005
Subject: [Jbeta] gl2 docs
References: <1134314583.c80201dcbill_lam@myrealbox.com>
Message-ID: <00a101c5fe67$9b2384d0$0701a8c0@xp>

Thank you for pointing out these many documentation errors. I'll go through 
them and get to you in detail as required.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Sunday, December 11, 2005 10:23 AM
Subject: [Jbeta] gl2 docs


In gl2 docs
gltext text ; write text in the glfont font. Where and how the text is 
displayed is affected by the gltextalign and gltextxy commands.
but gltextalign has been decommited, how to do gltextalign in J601?

fontspec
The size is in logical units. For wd commands this is generally point size. 
In gl2, size is in mapping mode units. In gl3, size is in pixels.

gl print lab said font size is in point for printer, but for screen,
is font size also always in point, or the fontspec docs is correct?

isigraph events
An isigraph control supports character and mouse events. The Code Dialog in 
the form editor lists all events for an isigraph control.

size      resize event (OpenGL, gl2 must request with glwantresize)
but glwantresize is decommitted.

For mouse events the wdhandler variable sysdata contains:
x y width height leftbutton rightbutton ctrl shift
In J504 lower left is 0 0 but in J601 upper left is 0 0,
J601 seems more reasonable, is this an intended change?

in Window Driver Command Reference Overview
It still point to a mapping mode page, but glmap is already decommitted.
now screen always use MM_RAW and printer always use MM_TWIPS.
Also in win32, origin of MM_TWIPS is at lower left corner, is J601
use upper left corner as origin for MM_TWIPS.

----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From bill_lam at myrealbox.com  Sun Dec 11 23:55:39 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Sun Dec 11 23:53:51 2005
Subject: [Jbeta] utf8 and EAV
Message-ID: <1134316539.c809ee3cbill_lam@myrealbox.com>

>Chris and I weren't sure what the easiest migration path was. By default we picked:
>1. define DEL as 127{a. and do careful search/replace of EAV by DEL
>
>If this doesn't work fairly easily for you, perhaps you could suggest a better approach. 

127{a. is a good choice. I also use it as delimiter is DOS many years ago. It was displayed as a triangle.


From gosinn at gmail.com  Mon Dec 12 00:14:05 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Mon Dec 12 00:12:21 2005
Subject: [Jbeta] utf8 and EAV
In-Reply-To: <1134316539.c809ee3cbill_lam@myrealbox.com>
References: <1134316539.c809ee3cbill_lam@myrealbox.com>
Message-ID: <4031fef0512110814r58d6892fk@mail.gmail.com>

Sounds like a good choice


Looks like a house in some fonts
like
--- one char below - del
d
 e
   l
----------- del ends
in others
127    7F    Del

In EBCDIC
EBCDIC Codepage 1026 (Turkish)
7F  	127  	?  	220  	LATIN CAPITAL LETTER U WITH DIAERESIS

2005/12/11, bill lam <bill_lam@myrealbox.com>:
> >Chris and I weren't sure what the easiest migration path was. By default we picked:
> >1. define DEL as 127{a. and do careful search/replace of EAV by DEL
> >
> >If this doesn't work fairly easily for you, perhaps you could suggest a better approach.
>
> 127{a. is a good choice. I also use it as delimiter is DOS many years ago. It was displayed as a triangle.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From bill_lam at myrealbox.com  Mon Dec 12 00:50:10 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Mon Dec 12 00:48:24 2005
Subject: [Jbeta] verb verb undefname
Message-ID: <1134319810.c82c593cbill_lam@myrealbox.com>

Has 'verb verb undefname' as originally purposed by Henry Rich been implemented in J601?


From RHui000 at shaw.ca  Mon Dec 12 05:52:25 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Mon Dec 12 05:50:59 2005
Subject: [Jbeta] verb verb undefname
References: <1134319810.c82c593cbill_lam@myrealbox.com>
Message-ID: <001101c5fe9d$36e31720$f7c35718@lap>

If it is not in the release notes it has not been implemented yet.

What is the original proposal for verb verb undefname?
And how is it to be distinguished from verb verb verb
since an undefined name is assumed to be a verb?



----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Sunday, December 11, 2005 8:50 AM
Subject: [Jbeta] verb verb undefname

Has 'verb verb undefname' as originally purposed by Henry Rich been implemented in J601?


From HenryHRich at nc.rr.com  Mon Dec 12 10:10:01 2005
From: HenryHRich at nc.rr.com (Henry Rich)
Date: Mon Dec 12 10:08:14 2005
Subject: [Jbeta] verb verb undefname
In-Reply-To: <001101c5fe9d$36e31720$f7c35718@lap>
Message-ID: <200512120210.jBC2A01u028168@ms-smtp-04-eri0.southeast.rr.com>

If I recall, the idea was to have a sentence that produced
a non-noun and didn't start with a copula, produce the
'otiose sentence' error.  Refinements were proposed.

Henry Rich

> -----Original Message-----
> From: beta-bounces@jsoftware.com 
> [mailto:beta-bounces@jsoftware.com] On Behalf Of Roger Hui
> Sent: Sunday, December 11, 2005 4:52 PM
> To: Beta forum
> Subject: Re: [Jbeta] verb verb undefname
> 
> If it is not in the release notes it has not been implemented yet.
> 
> What is the original proposal for verb verb undefname?
> And how is it to be distinguished from verb verb verb
> since an undefined name is assumed to be a verb?
> 
> 
> 
> ----- Original Message ----- 
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Sunday, December 11, 2005 8:50 AM
> Subject: [Jbeta] verb verb undefname
> 
> Has 'verb verb undefname' as originally purposed by Henry 
> Rich been implemented in J601?
> 
> 
> ----------------------------------------------------------------------
> For information about J forums see 
> http://www.jsoftware.com/forums.htm

From bill_lam at myrealbox.com  Mon Dec 12 18:41:33 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Mon Dec 12 18:39:45 2005
Subject: [Jbeta] passing ole/ocx parameter
Message-ID: <1134384093.c7e176dcbill_lam@myrealbox.com>

It seems ole/ocx has problem in passing parameter, only the first
character is read.  I try using delimiter and using *, same result.

xlopen=: 3 : 0
wd 'pc xlauto'
wd 'cc xl oleautomation:excel.application'
wd 'oleget xl base workbooks;oleid xl wb'
wd 'olemethod xl wb open *C:\j601\system\examples\data\expense.xls'
)

   xlopen''
|domain error: wd
|       wd'olemethod xl wb open *C:\j601\system\examples\data\expense.xls'
    wd'qer'
ole - 'C.xls' could not be found. Check the spelling of the file name, and verify that the file location is correct.

If you are trying to open the file from your list of most recently used files on the File menu, make sure that the file has not been renamed, moved, or deleted. : 0
   

From HenryHRich at nc.rr.com  Tue Dec 13 00:53:35 2005
From: HenryHRich at nc.rr.com (Henry Rich)
Date: Tue Dec 13 00:51:47 2005
Subject: [Jbeta] J6 grid: requests
In-Reply-To: <200512120210.jBC2A01u028168@ms-smtp-04-eri0.southeast.rr.com>
Message-ID: <200512121653.jBCGrYWe022159@ms-smtp-01-eri0.southeast.rr.com>

Trying to port my application that uses glgridxxx calls to the new
grid, I find I need clarifications/extensions.

0.  I use CTRL+leftclick, CTRL+leftdoubleclick, CTRL+richtclick
  in addition to those same clicks without the CTRL key.

  a.  Am I right that left-clicking a cell will cause
 
      grid_handler 'click'

     to be called?  And that I should look at the code for
     click to see what globals are set for this call?
     Can I find out what the button and shift-key state was?

  b.  I don't see rclick and rdblclick events.  Can they be added?

1.  I use boldface in some of my cells.  I see that support for boldface
  is listed as a not-too-hard feature.  Any chance of getting that
  soon?

Henry Rich

 

From gkirouac at riq.qc.ca  Tue Dec 13 01:03:09 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Tue Dec 13 01:01:20 2005
Subject: [Jbeta] 0.3 ":
In-Reply-To: <1134296723.c7f8399cbill_lam@myrealbox.com>
References: <1134296723.c7f8399cbill_lam@myrealbox.com>
Message-ID: <20051212165539.M74561@riq.qc.ca>

Same problem also on page j601/system/extras/help/user/grid_class.htm

P.S. The insert button on the Find in files page is a little marvel of
usefulness, helping to build regex expressions and look for things like above.
Thanks Chris!

Gilles

---------- Original Message -----------
From: "bill lam" <bill_lam@myrealbox.com>
To: beta@jsoftware.com
Sent: Sun, 11 Dec 2005 10:25:23 +0000
Subject: [Jbeta] 0.3 ":

> there is a 0.3 ": inside C:\j601\system\main\dates.ijs
> it should be changed to 0j3
> 
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
------- End of Original Message -------

From HenryHRich at nc.rr.com  Tue Dec 13 01:13:55 2005
From: HenryHRich at nc.rr.com (Henry Rich)
Date: Tue Dec 13 01:12:06 2005
Subject: [Jbeta] J6 grid: requests
In-Reply-To: <200512121653.jBCGrYWe022159@ms-smtp-01-eri0.southeast.rr.com>
Message-ID: <200512121713.jBCHDs1u013285@ms-smtp-04-eri0.southeast.rr.com>

I also need to connect a scrollbar to my grid.  There must be some
way to indicate the index of the top-left displayed cell, but
I can't find it.  What is it?  And do I have to support the scrollbar
in code of my own?

Henry Rich 

> -----Original Message-----
> From: beta-bounces@jsoftware.com 
> [mailto:beta-bounces@jsoftware.com] On Behalf Of Henry Rich
> Sent: Monday, December 12, 2005 11:54 AM
> To: 'Beta forum'
> Subject: [Jbeta] J6 grid: requests
> 
> Trying to port my application that uses glgridxxx calls to the new
> grid, I find I need clarifications/extensions.
> 
> 0.  I use CTRL+leftclick, CTRL+leftdoubleclick, CTRL+richtclick
>   in addition to those same clicks without the CTRL key.
> 
>   a.  Am I right that left-clicking a cell will cause
>  
>       grid_handler 'click'
> 
>      to be called?  And that I should look at the code for
>      click to see what globals are set for this call?
>      Can I find out what the button and shift-key state was?
> 
>   b.  I don't see rclick and rdblclick events.  Can they be added?
> 
> 1.  I use boldface in some of my cells.  I see that support 
> for boldface
>   is listed as a not-too-hard feature.  Any chance of getting that
>   soon?
> 
> Henry Rich
> 
>  
> 
> ----------------------------------------------------------------------
> For information about J forums see 
> http://www.jsoftware.com/forums.htm

From cburke at jsoftware.com  Tue Dec 13 05:58:57 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Tue Dec 13 05:57:13 2005
Subject: [Jbeta] J6 grid: requests
In-Reply-To: <200512121713.jBCHDs1u013285@ms-smtp-04-eri0.southeast.rr.com>
References: <200512121713.jBCHDs1u013285@ms-smtp-04-eri0.southeast.rr.com>
Message-ID: <439DF2A1.8030802@jsoftware.com>

Henry Rich wrote:
> I also need to connect a scrollbar to my grid.  There must be some
> way to indicate the index of the top-left displayed cell, but
> I can't find it.  What is it?  And do I have to support the scrollbar
> in code of my own?

The grid displays scrollbars as needed. You don't need code for this.
Take a look at the grid demos, and try resizing the windows.

If you need to find the position after an event, then:

CELLMARK = current marked cell or region

Scrollr,Scrollc = amount the grid has been scrolled (so top left).
From cburke at jsoftware.com  Tue Dec 13 06:15:07 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Tue Dec 13 06:13:24 2005
Subject: [Jbeta] J6 grid: requests
In-Reply-To: <200512121653.jBCGrYWe022159@ms-smtp-01-eri0.southeast.rr.com>
References: <200512121653.jBCGrYWe022159@ms-smtp-01-eri0.southeast.rr.com>
Message-ID: <439DF66B.9040103@jsoftware.com>

Henry Rich wrote:
> Trying to port my application that uses glgridxxx calls to the new
> grid, I find I need clarifications/extensions.
> 
> 0.  I use CTRL+leftclick, CTRL+leftdoubleclick, CTRL+richtclick
>   in addition to those same clicks without the CTRL key.
> 
>   a.  Am I right that left-clicking a cell will cause
>  
>       grid_handler 'click'
> 
>      to be called?  And that I should look at the code for
>      click to see what globals are set for this call?
>      Can I find out what the button and shift-key state was?

Yes. The click code is below, and the globals should give you what is
needed.

NB. click, after mbldown event
NB.
NB. Px, Py      mouse pixel position (0,0)=top left
NB. Row, Col    index into visible cells
NB.             (0,0) = top left data area
NB.             negative values for headers
NB. Ctrl,Shift  flags
click=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y.
if. gridhandler 'click' do.
  clickx''
end.
)

>   b.  I don't see rclick and rdblclick events.  Can they be added?

Yes, I'll do that for the next beta (this week).

> 1.  I use boldface in some of my cells.  I see that support for boldface
>   is listed as a not-too-hard feature.  Any chance of getting that
>   soon?

Probably for the next but one beta.
From eiverson at sympatico.ca  Tue Dec 13 06:35:14 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Tue Dec 13 06:33:30 2005
Subject: [Jbeta] J601 d beta available
Message-ID: <006001c5ff6c$5486fa10$0701a8c0@xp>

The d beta is available:
http://www.jsoftware.com/download/j601dbeta_win.exe

This beta fixes some, but not all, problem reports for the previous version.

1!:x family (file function) now support utf8 file and directory names

7 u: always returns list

display of wchar data now works

olesetlic - a bug has been fixed, but I currently don't have a licensed ocx 
for testing. Please confirm if it works or if there is still a problem

xlopen (olemethod call fails) - fixed



From HenryHRich at nc.rr.com  Tue Dec 13 07:24:54 2005
From: HenryHRich at nc.rr.com (Henry Rich)
Date: Tue Dec 13 07:23:04 2005
Subject: [Jbeta] Function Plots
In-Reply-To: <439DF66B.9040103@jsoftware.com>
Message-ID: <200512122324.jBCNOr1u008362@ms-smtp-04-eri0.southeast.rr.com>

I would like to call the attention of members of this list to
a new feature in J6 called Function Plots (you can
see a pointer to the description on the main plot page).  This
feature grew out of some suggestions Kip Murray made.  I had a
part in the coding, and I would like to know if users need
anything added or changed.

Function Plot is a quick way to call for the plot of a function.
Examples:

   plot _10 10 ; 'sin`cos'  NB. sin & cos from _10 to +10

   plot 0.01 0.1 ; 'sin % y.'  NB. 1/sin(x)

Henry Rich

From gosinn at gmail.com  Tue Dec 13 16:56:07 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Tue Dec 13 16:54:16 2005
Subject: [Jbeta] J601 d beta available
In-Reply-To: <006001c5ff6c$5486fa10$0701a8c0@xp>
References: <006001c5ff6c$5486fa10$0701a8c0@xp>
Message-ID: <4031fef0512130056j2bd0937ar@mail.gmail.com>

I downloaded and installed the new beta
Trying to start J601 I got

?file name error
?   ({.a.)    1!:12 fn;0

I restarted the pc
renamed J601 to J601c

Downloaded again
Trying to start J601 i get

?file name error
?   ({.a.)    1!:12 fn;0

again

Trying Jconsole gives
?file name error
?   ({.a.)    1!:12 fn;0

Anything I should try ?

2005/12/12, Eric Iverson <eiverson@sympatico.ca>:
> The d beta is available:
> http://www.jsoftware.com/download/j601dbeta_win.exe
>
> This beta fixes some, but not all, problem reports for the previous version.
>
> 1!:x family (file function) now support utf8 file and directory names
>
> 7 u: always returns list
>
> display of wchar data now works
>
> olesetlic - a bug has been fixed, but I currently don't have a licensed ocx
> for testing. Please confirm if it works or if there is still a problem
>
> xlopen (olemethod call fails) - fixed
>
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From eiverson at sympatico.ca  Tue Dec 13 22:23:41 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Tue Dec 13 22:22:17 2005
Subject: [Jbeta] J601 d beta available
References: <006001c5ff6c$5486fa10$0701a8c0@xp>
	<4031fef0512130056j2bd0937ar@mail.gmail.com>
Message-ID: <002401c5fff0$de04fd30$0701a8c0@xp>

Thanks for the problem report. It is an interesting one. I haven't dug into 
it completely yet so my analysis may be somewhat off or incomplete.

The line with the error ({.a.)    1!:12 fn;0 is from break.ijs and it is 
setting up the break file that shares the byte with the external break 
program (the new yellow J icon).

The break file name comes from host API GetTempPathA and GetLongPathNameA. 
The A suffix indicates these are the char versions, not the unicode 
versions. This means the path returned is an ANSI path with the code page 
required for the proper meaning. But the 1!:x family in the d beta require 
utf8 format of the unicode file name and this won't exist as it is trying to 
use an ANSI filename as a utf8 filename.

When you get the failure, please report the following results to me:
   9!:46''           NB. break file name in temp directory
   a. i. 9!:46''     NB. values in the file name

This bug will affect anyone with non-ascii (7 bit) values in the temp path 
results.

I'll provide a version of break.ijs shortly that uses the W flavours of the 
temp path api and expect this will fix the problem.

----- Original Message ----- 
From: "Bj?rn Helgason" <gosinn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Tuesday, December 13, 2005 3:56 AM
Subject: Re: [Jbeta] J601 d beta available


>I downloaded and installed the new beta
> Trying to start J601 I got
>
> ?file name error
> ?   ({.a.)    1!:12 fn;0
>
> I restarted the pc
> renamed J601 to J601c
>
> Downloaded again
> Trying to start J601 i get
>
> ?file name error
> ?   ({.a.)    1!:12 fn;0
>
> again
>
> Trying Jconsole gives
> ?file name error
> ?   ({.a.)    1!:12 fn;0
>
> Anything I should try ?
>
> 2005/12/12, Eric Iverson <eiverson@sympatico.ca>:
>> The d beta is available:
>> http://www.jsoftware.com/download/j601dbeta_win.exe
>>
>> This beta fixes some, but not all, problem reports for the previous 
>> version.
>>
>> 1!:x family (file function) now support utf8 file and directory names
>>
>> 7 u: always returns list
>>
>> display of wchar data now works
>>
>> olesetlic - a bug has been fixed, but I currently don't have a licensed 
>> ocx
>> for testing. Please confirm if it works or if there is still a problem
>>
>> xlopen (olemethod call fails) - fixed
>>
>>
>>
>> ----------------------------------------------------------------------
>> For information about J forums see http://www.jsoftware.com/forums.htm
>>
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>          /|_      .-----------------------------------.
>         ,'  .\  /  | Me? l?ttri lund ver?ur        |
>     ,--'    _,'   | Dagurinn ? dag                     |
>    /       /       | Enn betri en g?rdagurinn  |
>   (   -.  |        `-----------------------------------'
>   |     ) |
>  (`-.  '--.)
>   `. )----'
>


--------------------------------------------------------------------------------


> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From gosinn at gmail.com  Tue Dec 13 22:32:57 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Tue Dec 13 22:31:07 2005
Subject: [Jbeta] J601 d beta available
In-Reply-To: <002401c5fff0$de04fd30$0701a8c0@xp>
References: <006001c5ff6c$5486fa10$0701a8c0@xp>
	<4031fef0512130056j2bd0937ar@mail.gmail.com>
	<002401c5fff0$de04fd30$0701a8c0@xp>
Message-ID: <4031fef0512130632p40abffb1j@mail.gmail.com>

This happens as soon as i start J and have not started anything


?file name error
?   ({.a.)    1!:12 fn;0

    9!:46''           NB. break file name in temp directory

  a. i. 9!:46''     NB. values in the file name

   9!:14''
j601/beta/2005-12-08/17:30

Results just empty - nothing
Same for jconsole

2005/12/13, Eric Iverson <eiverson@sympatico.ca>:
> Thanks for the problem report. It is an interesting one. I haven't dug into
> it completely yet so my analysis may be somewhat off or incomplete.
>
> The line with the error ({.a.)    1!:12 fn;0 is from break.ijs and it is
> setting up the break file that shares the byte with the external break
> program (the new yellow J icon).
>
> The break file name comes from host API GetTempPathA and GetLongPathNameA.
> The A suffix indicates these are the char versions, not the unicode
> versions. This means the path returned is an ANSI path with the code page
> required for the proper meaning. But the 1!:x family in the d beta require
> utf8 format of the unicode file name and this won't exist as it is trying to
> use an ANSI filename as a utf8 filename.
>
> When you get the failure, please report the following results to me:
>    9!:46''           NB. break file name in temp directory
>    a. i. 9!:46''     NB. values in the file name
>
> This bug will affect anyone with non-ascii (7 bit) values in the temp path
> results.
>
> I'll provide a version of break.ijs shortly that uses the W flavours of the
> temp path api and expect this will fix the problem.
>
> ----- Original Message -----
> From: "Bj?rn Helgason" <gosinn@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Tuesday, December 13, 2005 3:56 AM
> Subject: Re: [Jbeta] J601 d beta available
>
>
> >I downloaded and installed the new beta
> > Trying to start J601 I got
> >
> > ?file name error
> > ?   ({.a.)    1!:12 fn;0
> >
> > I restarted the pc
> > renamed J601 to J601c
> >
> > Downloaded again
> > Trying to start J601 i get
> >
> > ?file name error
> > ?   ({.a.)    1!:12 fn;0
> >
> > again
> >
> > Trying Jconsole gives
> > ?file name error
> > ?   ({.a.)    1!:12 fn;0
> >
> > Anything I should try ?
> >
> > 2005/12/12, Eric Iverson <eiverson@sympatico.ca>:
> >> The d beta is available:
> >> http://www.jsoftware.com/download/j601dbeta_win.exe
> >>
> >> This beta fixes some, but not all, problem reports for the previous
> >> version.
> >>
> >> 1!:x family (file function) now support utf8 file and directory names
> >>
> >> 7 u: always returns list
> >>
> >> display of wchar data now works
> >>
> >> olesetlic - a bug has been fixed, but I currently don't have a licensed
> >> ocx
> >> for testing. Please confirm if it works or if there is still a problem
> >>
> >> xlopen (olemethod call fails) - fixed
> >>
> >>
> >>
> >> ----------------------------------------------------------------------
> >> For information about J forums see http://www.jsoftware.com/forums.htm
> >>
> >
> >
> > --
> > Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> > Fugl&Fiskur ehf, ?erneyjarsund 23,
> > 802 Selfoss ,t-p?st: gosinn@gmail.com
> > http://www.linux.is/forritun/data/J/grunnur.pdf
> >
> >
> > T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
> >
> > g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
> >          /|_      .-----------------------------------.
> >         ,'  .\  /  | Me? l?ttri lund ver?ur        |
> >     ,--'    _,'   | Dagurinn ? dag                     |
> >    /       /       | Enn betri en g?rdagurinn  |
> >   (   -.  |        `-----------------------------------'
> >   |     ) |
> >  (`-.  '--.)
> >   `. )----'
> >
>
>
> --------------------------------------------------------------------------------
>
>
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From bill_lam at myrealbox.com  Tue Dec 13 23:01:06 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Tue Dec 13 22:59:16 2005
Subject: [Jbeta] J601 d beta available
Message-ID: <1134486066.c7dcc2dcbill_lam@myrealbox.com>

I tested and confirm olesetlic working properly.
After some modification, my old application almost run except
the 3!:1/3!:2 problem that I reported early.
3!:1 of J601 being not compatible with J504 is documented and
reasonable, however 3!:2 of J601 can not decode results from J504
is a nasty problem, it means data can not migrate from J504 to 
J601 because these data may inside component file or sql database.
Is there any workaround such as J script that can decode 3!:1 of J504?

Also, has the "bug in cd with *w parameter" (missing trailing 0 0 when passing *w in cd)
that reported in J504 been fixed in J601?



From HenryHRich at nc.rr.com  Tue Dec 13 23:16:55 2005
From: HenryHRich at nc.rr.com (Henry Rich)
Date: Tue Dec 13 23:15:04 2005
Subject: [Jbeta] J601 d beta available
In-Reply-To: <1134486066.c7dcc2dcbill_lam@myrealbox.com>
Message-ID: <200512131516.jBDFGr1u027160@ms-smtp-04-eri0.southeast.rr.com>

I must have missed this earlier.  All my data is stored as
the output of 3!:1 and I read it in with 3!:2.  I will need
to know how to read these files into J6.

Henry Rich 

> -----Original Message-----
> From: beta-bounces@jsoftware.com 
> [mailto:beta-bounces@jsoftware.com] On Behalf Of bill lam
> Sent: Tuesday, December 13, 2005 10:01 AM
> To: beta@jsoftware.com
> Subject: Re: [Jbeta] J601 d beta available
> 
> I tested and confirm olesetlic working properly.
> After some modification, my old application almost run except
> the 3!:1/3!:2 problem that I reported early.
> 3!:1 of J601 being not compatible with J504 is documented and
> reasonable, however 3!:2 of J601 can not decode results from J504
> is a nasty problem, it means data can not migrate from J504 to 
> J601 because these data may inside component file or sql database.
> Is there any workaround such as J script that can decode 3!:1 of J504?
> 
> Also, has the "bug in cd with *w parameter" (missing trailing 
> 0 0 when passing *w in cd)
> that reported in J504 been fixed in J601?
> 
> 
> 
> ----------------------------------------------------------------------
> For information about J forums see 
> http://www.jsoftware.com/forums.htm

From RHui000 at shaw.ca  Tue Dec 13 23:19:26 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Tue Dec 13 23:18:01 2005
Subject: [Jbeta] verb verb undefname
References: <200512120210.jBC2A01u028168@ms-smtp-04-eri0.southeast.rr.com>
Message-ID: <010501c5fff8$a363dbd0$f7c35718@lap>

I found the thread from 2005-09-13.  At that time I said:

   It probably makes sense to change the syntax to signal 
   error in an explicit definition on a sentence which:
     is not the executed last sentence, and
     does not have assignment as the last operation, and
     does not result in a noun
   This will necessarily be a dynamic rather than static
   analysis, as the conditions will only be known at
   the time the explicit definition is executed.

Looking at it again today, I believe the rule should
apply only to an explicit verb, or to an explicit adverb
or conjunction which has both the x./y. and u./v./m./n.
arguments.  Moreover, the "executed last sentence" is
unnecessary, as that is already an error.  Thus:

   A "redundant sentence" error is signalled in an explicit verb, 
   or in an explicit adverb or conjunction which has both the x./y. 
   and u./v./m./n. arguments, if a sentence is executed which
   - does not have assignment as the last operation, and
   - does not result in a noun

The idea is that under such conditions it is likely that
the program has a typographical mistake, and signalling
error at the point of the mistake facilitates debugging.



----- Original Message ----- 
From: "Henry Rich" <HenryHRich@nc.rr.com>
To: "'Beta forum'" <beta@jsoftware.com>
Sent: Sunday, December 11, 2005 6:10 PM
Subject: RE: [Jbeta] verb verb undefname


If I recall, the idea was to have a sentence that produced
a non-noun and didn't start with a copula, produce the
'otiose sentence' error.  Refinements were proposed.

Henry Rich



> -----Original Message-----
> From: beta-bounces@jsoftware.com 
> [mailto:beta-bounces@jsoftware.com] On Behalf Of Roger Hui
> Sent: Sunday, December 11, 2005 4:52 PM
> To: Beta forum
> Subject: Re: [Jbeta] verb verb undefname
> 
> If it is not in the release notes it has not been implemented yet.
> 
> What is the original proposal for verb verb undefname?
> And how is it to be distinguished from verb verb verb
> since an undefined name is assumed to be a verb?
> 
> 
> 
> ----- Original Message ----- 
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Sunday, December 11, 2005 8:50 AM
> Subject: [Jbeta] verb verb undefname
> 
> Has 'verb verb undefname' as originally purposed by Henry 
> Rich been implemented in J601?


From HenryHRich at nc.rr.com  Tue Dec 13 23:45:44 2005
From: HenryHRich at nc.rr.com (Henry Rich)
Date: Tue Dec 13 23:43:54 2005
Subject: [Jbeta] verb verb undefname
In-Reply-To: <010501c5fff8$a363dbd0$f7c35718@lap>
Message-ID: <200512131545.jBDFjhWe022693@ms-smtp-01-eri0.southeast.rr.com>

That sounds good to me.  I expect to find several such redundant
sentences in heavily-maintained apps.

Henry Rich 

> -----Original Message-----
> From: beta-bounces@jsoftware.com 
> [mailto:beta-bounces@jsoftware.com] On Behalf Of Roger Hui
> Sent: Tuesday, December 13, 2005 10:19 AM
> To: Beta forum
> Subject: Re: [Jbeta] verb verb undefname
> 
> I found the thread from 2005-09-13.  At that time I said:
> 
>    It probably makes sense to change the syntax to signal 
>    error in an explicit definition on a sentence which:
>      is not the executed last sentence, and
>      does not have assignment as the last operation, and
>      does not result in a noun
>    This will necessarily be a dynamic rather than static
>    analysis, as the conditions will only be known at
>    the time the explicit definition is executed.
> 
> Looking at it again today, I believe the rule should
> apply only to an explicit verb, or to an explicit adverb
> or conjunction which has both the x./y. and u./v./m./n.
> arguments.  Moreover, the "executed last sentence" is
> unnecessary, as that is already an error.  Thus:
> 
>    A "redundant sentence" error is signalled in an explicit verb, 
>    or in an explicit adverb or conjunction which has both the x./y. 
>    and u./v./m./n. arguments, if a sentence is executed which
>    - does not have assignment as the last operation, and
>    - does not result in a noun
> 
> The idea is that under such conditions it is likely that
> the program has a typographical mistake, and signalling
> error at the point of the mistake facilitates debugging.
> 
> 
> 
> ----- Original Message ----- 
> From: "Henry Rich" <HenryHRich@nc.rr.com>
> To: "'Beta forum'" <beta@jsoftware.com>
> Sent: Sunday, December 11, 2005 6:10 PM
> Subject: RE: [Jbeta] verb verb undefname
> 
> 
> If I recall, the idea was to have a sentence that produced
> a non-noun and didn't start with a copula, produce the
> 'otiose sentence' error.  Refinements were proposed.
> 
> Henry Rich
> 
> 
> 
> > -----Original Message-----
> > From: beta-bounces@jsoftware.com 
> > [mailto:beta-bounces@jsoftware.com] On Behalf Of Roger Hui
> > Sent: Sunday, December 11, 2005 4:52 PM
> > To: Beta forum
> > Subject: Re: [Jbeta] verb verb undefname
> > 
> > If it is not in the release notes it has not been implemented yet.
> > 
> > What is the original proposal for verb verb undefname?
> > And how is it to be distinguished from verb verb verb
> > since an undefined name is assumed to be a verb?
> > 
> > 
> > 
> > ----- Original Message ----- 
> > From: "bill lam" <bill_lam@myrealbox.com>
> > To: <beta@jsoftware.com>
> > Sent: Sunday, December 11, 2005 8:50 AM
> > Subject: [Jbeta] verb verb undefname
> > 
> > Has 'verb verb undefname' as originally purposed by Henry 
> > Rich been implemented in J601?
> 
> 
> ----------------------------------------------------------------------
> For information about J forums see 
> http://www.jsoftware.com/forums.htm

From eiverson at sympatico.ca  Wed Dec 14 00:04:47 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec 14 00:11:05 2005
Subject: [Jbeta] J601 d beta available
References: <1134486066.c7dcc2dcbill_lam@myrealbox.com>
Message-ID: <000d01c60000$14fcce30$0701a8c0@xp>

 I now see that the bug your report with 3!:1/2 between 504 and 601 is only 
with wchar data (u:). This is not related to any change in the flag field as 
mentioned in Release Highlights.

The bug/difference I strongly suspect is related to the change (I think 
requested by you) that wchar strings have a terminating null for use with cd 
etc.

We will dig into this and get back to you.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Tuesday, December 13, 2005 10:01 AM
Subject: Re: [Jbeta] J601 d beta available


I tested and confirm olesetlic working properly.
After some modification, my old application almost run except
the 3!:1/3!:2 problem that I reported early.
3!:1 of J601 being not compatible with J504 is documented and
reasonable, however 3!:2 of J601 can not decode results from J504
is a nasty problem, it means data can not migrate from J504 to
J601 because these data may inside component file or sql database.
Is there any workaround such as J script that can decode 3!:1 of J504?

Also, has the "bug in cd with *w parameter" (missing trailing 0 0 when 
passing *w in cd)
that reported in J504 been fixed in J601?



----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Tue Dec 13 23:52:14 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec 14 00:11:07 2005
Subject: [Jbeta] J601 d beta available
References: <1134486066.c7dcc2dcbill_lam@myrealbox.com>
Message-ID: <000b01c60000$1099c230$0701a8c0@xp>

The intended incompatibility in 3!:1/3!:2 is very minor. It will not affect 
the reading of 504 data by 601. And with luck won't affect the reading of 
601 data by 504. I don't believe these changes have been made yet.

I missed your earlier problem report and will dig into it now.

The intended incompatibility only affects the flag bits. The flag bits are 
currently 32 0 bits to indicate 32 bit data and 64 1 bits to indicate 64 bit 
data. The endiannes of the data is currently a bit tricky to figure out and 
we'd like to add that info to the flag bits.

Bottom line: You can definitely depend on 601 being able to read 504 3!:1 
data. You can probably depend on 504 being able to read 601 data, but we 
need to check on that.

If the the trouble report is a bug  I don't think it is related to this 
change and it will be fixed.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Tuesday, December 13, 2005 10:01 AM
Subject: Re: [Jbeta] J601 d beta available


I tested and confirm olesetlic working properly.
After some modification, my old application almost run except
the 3!:1/3!:2 problem that I reported early.
3!:1 of J601 being not compatible with J504 is documented and
reasonable, however 3!:2 of J601 can not decode results from J504
is a nasty problem, it means data can not migrate from J504 to
J601 because these data may inside component file or sql database.
Is there any workaround such as J script that can decode 3!:1 of J504?

Also, has the "bug in cd with *w parameter" (missing trailing 0 0 when 
passing *w in cd)
that reported in J504 been fixed in J601?



----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Wed Dec 14 00:15:37 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec 14 00:14:02 2005
Subject: [Jbeta] J601 d beta available
References: <1134486066.c7dcc2dcbill_lam@myrealbox.com>
Message-ID: <002401c60000$766c0af0$0701a8c0@xp>

I think you'll find that wchar data (*w in cd) now has the trailing null. 
And that this is probably the cause of the 3!:1/2 troubles.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Tuesday, December 13, 2005 10:01 AM
Subject: Re: [Jbeta] J601 d beta available


I tested and confirm olesetlic working properly.
After some modification, my old application almost run except
the 3!:1/3!:2 problem that I reported early.
3!:1 of J601 being not compatible with J504 is documented and
reasonable, however 3!:2 of J601 can not decode results from J504
is a nasty problem, it means data can not migrate from J504 to
J601 because these data may inside component file or sql database.
Is there any workaround such as J script that can decode 3!:1 of J504?

Also, has the "bug in cd with *w parameter" (missing trailing 0 0 when 
passing *w in cd)
that reported in J504 been fixed in J601?



----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From RHui000 at shaw.ca  Wed Dec 14 00:38:04 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Wed Dec 14 00:36:32 2005
Subject: [Jbeta] J601 d beta available
References: <200512131516.jBDFGr1u027160@ms-smtp-04-eri0.southeast.rr.com>
Message-ID: <018901c60003$a1cbd5b0$f7c35718@lap>

I believe the incompatibility only occurs on the unicode
datatype (131072).  The change was that like 1-byte 
character data, unicode data now also has a trailing
0-byte.  I'll see if the 3!:2 code can be relaxed
to tolerate data that do not have the trailing 0 byte.



----- Original Message ----- 
From: "Henry Rich" <HenryHRich@nc.rr.com>
To: "'Beta forum'" <beta@jsoftware.com>
Sent: Tuesday, December 13, 2005 7:16 AM
Subject: RE: [Jbeta] J601 d beta available

I must have missed this earlier.  All my data is stored as
the output of 3!:1 and I read it in with 3!:2.  I will need
to know how to read these files into J6.

Henry Rich 


From donguinn at pvtnetworks.net  Wed Dec 14 00:39:15 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Wed Dec 14 00:37:37 2005
Subject: [Jbeta] J601 d beta available
In-Reply-To: <000b01c60000$1099c230$0701a8c0@xp>
References: <1134486066.c7dcc2dcbill_lam@myrealbox.com>
	<000b01c60000$1099c230$0701a8c0@xp>
Message-ID: <439EF933.9040304@pvtn.net>

So does 1!:x support file sizes over 4GB in J6?

Eric Iverson wrote:

> The intended incompatibility in 3!:1/3!:2 is very minor. It will not 
> affect the reading of 504 data by 601. And with luck won't affect the 
> reading of 601 data by 504. I don't believe these changes have been 
> made yet.
>
> I missed your earlier problem report and will dig into it now.
>
> The intended incompatibility only affects the flag bits. The flag bits 
> are currently 32 0 bits to indicate 32 bit data and 64 1 bits to 
> indicate 64 bit data. The endiannes of the data is currently a bit 
> tricky to figure out and we'd like to add that info to the flag bits.
>
> Bottom line: You can definitely depend on 601 being able to read 504 
> 3!:1 data. You can probably depend on 504 being able to read 601 data, 
> but we need to check on that.
>
> If the the trouble report is a bug  I don't think it is related to 
> this change and it will be fixed.
>
> . . .


From eiverson at sympatico.ca  Wed Dec 14 01:23:06 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec 14 01:21:33 2005
Subject: [Jbeta] J601 d beta available
References: <1134486066.c7dcc2dcbill_lam@myrealbox.com><000b01c60000$1099c230$0701a8c0@xp>
	<439EF933.9040304@pvtn.net>
Message-ID: <002301c60009$e41f25b0$0701a8c0@xp>

The limit on file size support is unrelated to any of the current unicode 
driven changes.  I'm pretty sure J32 has the same restrictions it has always 
had and there is no intent to change them. J64 (all releases and platforms) 
does not have the restriction.

----- Original Message ----- 
From: "Don Guinn" <donguinn@pvtnetworks.net>
To: "Beta forum" <beta@jsoftware.com>
Sent: Tuesday, December 13, 2005 11:39 AM
Subject: Re: [Jbeta] J601 d beta available


> So does 1!:x support file sizes over 4GB in J6?
>
> Eric Iverson wrote:
>
>> The intended incompatibility in 3!:1/3!:2 is very minor. It will not 
>> affect the reading of 504 data by 601. And with luck won't affect the 
>> reading of 601 data by 504. I don't believe these changes have been made 
>> yet.
>>
>> I missed your earlier problem report and will dig into it now.
>>
>> The intended incompatibility only affects the flag bits. The flag bits 
>> are currently 32 0 bits to indicate 32 bit data and 64 1 bits to indicate 
>> 64 bit data. The endiannes of the data is currently a bit tricky to 
>> figure out and we'd like to add that info to the flag bits.
>>
>> Bottom line: You can definitely depend on 601 being able to read 504 3!:1 
>> data. You can probably depend on 504 being able to read 601 data, but we 
>> need to check on that.
>>
>> If the the trouble report is a bug  I don't think it is related to this 
>> change and it will be fixed.
>>
>> . . .
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Wed Dec 14 02:03:52 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec 14 02:02:11 2005
Subject: [Jbeta] new version of d beta available
Message-ID: <004201c6000f$9970e520$0701a8c0@xp>

A new version of the d beta is available
http://www.jsoftware.com/download/j601dbeta_win.exe

This version has a fix forthe problem Bjorn reported. That is,
| file name error
| ({.a.) 1!:12 fn:0

Bjorn, please let me know if the problem isn't fixed.


From gosinn at gmail.com  Wed Dec 14 06:04:33 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Wed Dec 14 06:02:45 2005
Subject: [Jbeta] new version of d beta available
In-Reply-To: <004201c6000f$9970e520$0701a8c0@xp>
References: <004201c6000f$9970e520$0701a8c0@xp>
Message-ID: <4031fef0512131404y39267bd8q@mail.gmail.com>

Well....

Now it is like this

?domain error
?       9!:47 fn


this here above comes after starting

I then tried this as before

   9!:46''


   a. i. 9!:46''

   9!:14''
j601/beta/2005-12-08/17:30

jconsole is same as this

------------------ another matter
I tried to run through the files lab and got this

?? ((7) 2 of 8) fview ?????
   fview jpath '~system\main\files.ijs'
?value error: wdview
?   empty(>{.y)    wdview dat


2005/12/13, Eric Iverson <eiverson@sympatico.ca>:
> A new version of the d beta is available
> http://www.jsoftware.com/download/j601dbeta_win.exe
>
> This version has a fix forthe problem Bjorn reported. That is,
> | file name error
> | ({.a.) 1!:12 fn:0
>
> Bjorn, please let me know if the problem isn't fixed.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From eiverson at sympatico.ca  Thu Dec 15 01:07:48 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Thu Dec 15 01:05:59 2005
Subject: [Jbeta] e beta available
Message-ID: <000f01c600d0$eb5fa7b0$0701a8c0@xp>

e beta available
http://www.jsoftware.com/download/j601ebeta_win.exe

This version has some (not all) of the library and documentation problems 
fixed. It also fixes (again) Bjorn's problem with 9!:47 setting the break 
file name with utf8 characters.

Bjorn, please let me know if the problem isn't fixed.


From eiverson at sympatico.ca  Thu Dec 15 01:29:43 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Thu Dec 15 01:30:01 2005
Subject: [Jbeta] glbkmode
Message-ID: <000a01c600d4$4620a890$0701a8c0@xp>

I've looked into glbkmode a bit more and now see why it was decommitted for 
601 and why this is OK.

504 default for text background is opaque with color white. Color can be 
changed with glbkcolor and opaque can be changed to transparent with 
glbkmode. Transparent is much more useful and you need to do glbkmode 1 to 
get that.

601 text is always drawn transparent as this is most useful. If you really 
want a text background then you can draw a rectangle of the size of the text 
in the color of your choice.

This allows us to kill of glbkmode and glcolor in 601. These are not 
supported directly in Java and can be easily supported by simple J code. The 
push on gl2 is to provide a core portable set and to let J do the 
computation where reasonable.

So glbkmode and glcolor stay decomitted in j601.

On the original question about printing text tightly together:
1. in 501 use glbkmode 1 as Bill suggests
2. in 601 the default is transparent and you'll get what you want 

From gosinn at gmail.com  Thu Dec 15 02:41:42 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Thu Dec 15 02:39:50 2005
Subject: [Jbeta] e beta available
In-Reply-To: <000f01c600d0$eb5fa7b0$0701a8c0@xp>
References: <000f01c600d0$eb5fa7b0$0701a8c0@xp>
Message-ID: <4031fef0512141041j6defa159k@mail.gmail.com>

I am not at home
I did download and try this out where I am now
I did not get the problem now



2005/12/14, Eric Iverson <eiverson@sympatico.ca>:
> e beta available
> http://www.jsoftware.com/download/j601ebeta_win.exe
>
> This version has some (not all) of the library and documentation problems
> fixed. It also fixes (again) Bjorn's problem with 9!:47 setting the break
> file name with utf8 characters.
>
> Bjorn, please let me know if the problem isn't fixed.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>


--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.
         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From gkirouac at riq.qc.ca  Thu Dec 15 06:49:37 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Thu Dec 15 06:47:45 2005
Subject: [Jbeta] Problem tracing execution
Message-ID: <20051214224819.M77367@riq.qc.ca>

J601ebeta, trace.ijs of 1 d?cembre, 2005, 12:37:04.

   plus=: +
   load'trace'
   trace'2 plus 3'
 --------------- 2 Dyad -------
 2
 plus
 3
&#9474;value error: plus
&#9474;   t_z=.(2)    (plus)(3)
      

Gilles -
From RHui000 at shaw.ca  Thu Dec 15 07:36:22 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Thu Dec 15 07:35:14 2005
Subject: [Jbeta] Problem tracing execution
References: <20051214224819.M77367@riq.qc.ca>
Message-ID: <00a101c60107$36114c60$f7c35718@lap>

Instead of   trace '2 plus 3'  , use   trace '2 plus__ 3'



----- Original Message -----
From: "Gilles Kirouac" <gkirouac@riq.qc.ca>
To: <beta@jsoftware.com>
Sent: Wednesday, December 14, 2005 2:49 PM
Subject: [Jbeta] Problem tracing execution

J601ebeta, trace.ijs of 1 d?cembre, 2005, 12:37:04.

   plus=: +
   load'trace'
   trace'2 plus 3'
 --------------- 2 Dyad -------
 2
 plus
 3
&#9474;value error: plus
&#9474;   t_z=.(2)    (plus)(3)



From steve at ni.aist.go.jp  Thu Dec 15 10:20:26 2005
From: steve at ni.aist.go.jp (Steven Phillips)
Date: Thu Dec 15 10:18:39 2005
Subject: [Jbeta] e beta available
In-Reply-To: <000f01c600d0$eb5fa7b0$0701a8c0@xp>
References: <000f01c600d0$eb5fa7b0$0701a8c0@xp>
Message-ID: <43A0D2EA.7030905@ni.aist.go.jp>

The unicode verb u: has 1&u: and 2&u: , 3&u: and 4&u: , and 7&u: and 8&u:
as inverse pairs. This departs from the "convention" of having
(-x)&f as the inverse of x&f for verbs o. , 3!:5 ,  and s: .

Why not also define the inverse of 1&u: as _1&u: , etc?

Steve

----------------------------------------------------------
Steven Phillips, PhD
Cognitive and Behavioral Sciences Group,
Neuroscience Research Institute, AIST
1-1-1 Umezono, Tsukuba Central 2, Tsukuba, Ibaraki 305-8568 Japan
Tel: +81 298 61 5165 (PHS: 45165)	Fax: +81 298 61 5857
WWW: <http://staff.aist.go.jp/steven.phillips>
----------------------------------------------------------



Eric Iverson wrote:
> e beta available
> http://www.jsoftware.com/download/j601ebeta_win.exe
>
> This version has some (not all) of the library and documentation 
> problems fixed. It also fixes (again) Bjorn's problem with 9!:47 
> setting the break file name with utf8 characters.
>
> Bjorn, please let me know if the problem isn't fixed.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
>

From bill_lam at myrealbox.com  Thu Dec 15 21:37:18 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Thu Dec 15 21:35:25 2005
Subject: [Jbeta] glbkmode
Message-ID: <1134653838.c7d16e9cbill_lam@myrealbox.com>

in isigraph events
size      resize event (OpenGL, gl2 must request with glwantresize)
since glwantresize is decommitted so will the size event.

I suppose gltextalign is useful, will it be added back, or some
workaround suggested?

From donguinn at pvtnetworks.net  Thu Dec 15 21:48:15 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Thu Dec 15 21:46:32 2005
Subject: [Jbeta] glbkmode
In-Reply-To: <1134653838.c7d16e9cbill_lam@myrealbox.com>
References: <1134653838.c7d16e9cbill_lam@myrealbox.com>
Message-ID: <43A1741F.4080200@pvtn.net>

It looks like the resize event is always enabled so glwantresize is not 
necessary.

bill lam wrote:

>in isigraph events
>size      resize event (OpenGL, gl2 must request with glwantresize)
>since glwantresize is decommitted so will the size event.
>
>I suppose gltextalign is useful, will it be added back, or some
>workaround suggested?
>
>----------------------------------------------------------------------
>For information about J forums see http://www.jsoftware.com/forums.htm
>
>  
>

From bill_lam at myrealbox.com  Thu Dec 15 22:20:15 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Thu Dec 15 22:18:22 2005
Subject: [Jbeta] unicode odbc ?
Message-ID: <1134656415.c7d16e9cbill_lam@myrealbox.com>

as odbc api already has a unicode interface, is there any plan to update odbc.ijs to make it unicode aware?

From bill_lam at myrealbox.com  Thu Dec 15 22:26:31 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Thu Dec 15 22:24:37 2005
Subject: [Jbeta] glbkmode
Message-ID: <1134656791.c7d16e9cbill_lam@myrealbox.com>

>It looks like the resize event is always enabled so glwantresize is not necessary.

No, it looks like there is no resize event anymore. It now uses paint event to redraw.


From donguinn at pvtnetworks.net  Thu Dec 15 22:30:30 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Thu Dec 15 22:28:45 2005
Subject: [Jbeta] glbkmode
In-Reply-To: <1134656791.c7d16e9cbill_lam@myrealbox.com>
References: <1134656791.c7d16e9cbill_lam@myrealbox.com>
Message-ID: <43A17E06.1020701@pvtn.net>

Well, somehow it knows when the isi object is resized.  Maybe it's 
called something else now.  I am anxious to see the new lab for grid.

bill lam wrote:

>>It looks like the resize event is always enabled so glwantresize is not necessary.
>>    
>>
>
>No, it looks like there is no resize event anymore. It now uses paint event to redraw.
>
>
>----------------------------------------------------------------------
>For information about J forums see http://www.jsoftware.com/forums.htm
>
>  
>

From bill_lam at myrealbox.com  Thu Dec 15 22:55:59 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Thu Dec 15 22:54:06 2005
Subject: [Jbeta] 4!:3
Message-ID: <1134658559.c7d16e9cbill_lam@myrealbox.com>

Besides 1!:x family, I suppose 0!:x also use utf8 now.
But it seems file names returned by 4!:3 are still not yet utf8.

PS. I am also anxious to see the new lab for grid. (^o^)


From eiverson at sympatico.ca  Thu Dec 15 23:07:35 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Thu Dec 15 23:06:05 2005
Subject: [Jbeta] glbkmode
References: <1134653838.c7d16e9cbill_lam@myrealbox.com>
Message-ID: <001d01c60189$4a68fe60$0701a8c0@xp>

In 601 glwantresize is decomitted. In 601 an opengl only gets paint events 
(there is no longer a size event). The documentation on opengl need to be 
updated.

Wd do not plan to add gltextalign back in. With glqextent and the new 
glqextentw you can determine the size of the text you display and can 
calculate and maintain whatever poisition information you want directly in 
J. Again, this is part of the move to let J do all the calculations and 
state management that is reasonable possible as this is more open and 
general. Doing glqextent and gltextxy is a complete (and more general) 
replacement for gltextalign. But it is very incompatible and if you need to 
manually do conversions of old systems that used it. If your use of gltext 
and gltextalign was consistent and simple it can probably be replaced with a 
utility that does the required calculations and steps.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Thursday, December 15, 2005 8:37 AM
Subject: Re: [Jbeta] glbkmode


in isigraph events
size      resize event (OpenGL, gl2 must request with glwantresize)
since glwantresize is decommitted so will the size event.

I suppose gltextalign is useful, will it be added back, or some
workaround suggested?

----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Thu Dec 15 23:11:47 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Thu Dec 15 23:10:29 2005
Subject: [Jbeta] unicode odbc ?
References: <1134656415.c7d16e9cbill_lam@myrealbox.com>
Message-ID: <002801c60189$e0534a20$0701a8c0@xp>

This (unicode version odbc.ijs) is not a high priority for Jsoftware. It 
would be an excellent project for someone to contribute back to the 
community. The original work was done by John Baker and there have been 
minor changes since then. A unicode version would be nice. Do I see a raised 
hand out there in netland?

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Thursday, December 15, 2005 9:20 AM
Subject: [Jbeta] unicode odbc ?


as odbc api already has a unicode interface, is there any plan to update 
odbc.ijs to make it unicode aware?

----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Thu Dec 15 23:16:39 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Thu Dec 15 23:21:29 2005
Subject: [Jbeta] 4!:3
References: <1134658559.c7d16e9cbill_lam@myrealbox.com>
Message-ID: <004501c6018b$75ea9e70$0701a8c0@xp>

Thanks for pointing out that 4!:3 (and probably a few related places) also 
need utf8 changes.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Thursday, December 15, 2005 9:55 AM
Subject: [Jbeta] 4!:3


Besides 1!:x family, I suppose 0!:x also use utf8 now.
But it seems file names returned by 4!:3 are still not yet utf8.

PS. I am also anxious to see the new lab for grid. (^o^)


----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From bakerjd99 at gmail.com  Thu Dec 15 23:29:45 2005
From: bakerjd99 at gmail.com (John Baker)
Date: Thu Dec 15 23:27:52 2005
Subject: [Jbeta] VB jsvr1 example broken in e beta
Message-ID: <377611440512150729u16643d9ahf05a580b606d8772@mail.gmail.com>

I just compiled the J VB example   ..\system\examples\ole\vb  for the latest
e beta
and it is still broken.

It would be useful if these examples ( C++ and VB ) were reworked and made
to
run in the new unicode'fied J.
From eiverson at sympatico.ca  Fri Dec 16 00:48:10 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Fri Dec 16 00:46:49 2005
Subject: [Jbeta] VB jsvr1 example broken in e beta
References: <377611440512150729u16643d9ahf05a580b606d8772@mail.gmail.com>
Message-ID: <001101c60197$59c1f250$0701a8c0@xp>

I don't have VB immediately available. Could you provide a little more info 
about the failure? If it is a simple problem in a particular area I could 
probably find and fix without having to go through the reinstall of VB right 
now.

----- Original Message ----- 
From: "John Baker" <bakerjd99@gmail.com>
To: <beta@jsoftware.com>
Sent: Thursday, December 15, 2005 10:29 AM
Subject: [Jbeta] VB jsvr1 example broken in e beta


I just compiled the J VB example   ..\system\examples\ole\vb  for the latest
e beta
and it is still broken.

It would be useful if these examples ( C++ and VB ) were reworked and made
to
run in the new unicode'fied J.
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From christopher.f.lett at citigroup.com  Fri Dec 16 00:55:47 2005
From: christopher.f.lett at citigroup.com (Lett, Christopher F)
Date: Fri Dec 16 00:55:45 2005
Subject: [Jbeta] Stop Manager in Debugger
Message-ID: <D098A951461AEA49B6962D4FBC8A95AC053396@EXNJMB61.nam.nsroot.net>

Using the e-beta, in a new J session:

   (9!:12 '');9!:14 ''
+-+--------------------------+
|6|j601/beta/2005-12-08/17:30|
+-+--------------------------+

If I type:

   scrout=: [: wd 'smappend "'"_ , ,&'" 0'

At this point I bring up the debugger by pressing Ctrl+K, then click on the Stop Manager button. I get:

?domain error: jdb_isexplicit
?jdb_isexplicit[0]

I realize this is an old wd command (in fact, none of my code uses it any more), but the Debugger/Stop Manager in 504 copes with this assignment without complaint.

/Chris Lett
From bakerjd99 at gmail.com  Fri Dec 16 01:33:44 2005
From: bakerjd99 at gmail.com (John Baker)
Date: Fri Dec 16 01:31:51 2005
Subject: [Jbeta] VB jsvr1 example broken in e beta
In-Reply-To: <001101c60197$59c1f250$0701a8c0@xp>
References: <377611440512150729u16643d9ahf05a580b606d8772@mail.gmail.com>
	<001101c60197$59c1f250$0701a8c0@xp>
Message-ID: <377611440512150933m7f9739d9o8abfc2c00ce025fa@mail.gmail.com>

I've done a bit of poking around with the sample.

The error occurs on the first call of js.do.  The argument is a string
that causes a spelling error in J.  Usually a symptom of improper
VB string to J string conversion.

The js.setb and js.getb verbs appear to work.  I would suggest adding
a variant of the js.do verb  js.dob   so there is no confunsion about how
the vb string will be converted.

js.show and js.log do not seem to work.  I cannot make the J exe server
visible.

The testing was done with VB6.  I haven't tried the sample with VB.NET

Hope this helps.


On 12/15/05, Eric Iverson <eiverson@sympatico.ca> wrote:
>
> I don't have VB immediately available. Could you provide a little more
> info
> about the failure? If it is a simple problem in a particular area I could
> probably find and fix without having to go through the reinstall of VB
> right
> now.
>
> ----- Original Message -----
> From: "John Baker" <bakerjd99@gmail.com>
> To: <beta@jsoftware.com>
> Sent: Thursday, December 15, 2005 10:29 AM
> Subject: [Jbeta] VB jsvr1 example broken in e beta
>
>
> I just compiled the J VB example   ..\system\examples\ole\vb  for the
> latest
> e beta
> and it is still broken.
>
> It would be useful if these examples ( C++ and VB ) were reworked and made
> to
> run in the new unicode'fied J.
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From gosinn at gmail.com  Fri Dec 16 02:10:30 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Fri Dec 16 02:08:36 2005
Subject: [Jbeta] Re: junklab not created
In-Reply-To: <4031fef0511300218y748bb9c5i@mail.gmail.com>
References: <4031fef0511300218y748bb9c5i@mail.gmail.com>
Message-ID: <4031fef0512151010n40610bc6r@mail.gmail.com>

 Lab: DLL: Using System DLLs (file examples)

  9!:14''
j601/beta/2005-12-08/17:30

?? (29 of 35) CreateDirectory ????????????????????   createdirectory=: 3 :
'CreateDirectory y.;<<0'
   createdirectory 'user\junklab'   NB. 0 is failure
?domain error: CreateDirectory
?       CreateDirectory y.;<<0


2005/11/30, Bj?rn Helgason <gosinn@gmail.com>:
>
> Lab: DLL: Using System DLLs (file examples)
>
> First the text seems to me to be wrong
>
> ?? (11 of 35) CreateFile (ctd) ??????????????????????????????
>
> In our examples we use access GENERIC_READ+GENERIC_READ,
> share 0, and attributes 0.
> )
>
> should be Write
>
> ?? (11 of 35) CreateFile (ctd) ??????????????????????????????
>
> In our examples we use access GENERIC_READ+GENERIC_WRITE,
> share 0, and attributes 0.
> )
>
> junklab dir does not get created
>
> ---------------
> createdirectory 'user\junklab'   NB. 0 is failure
> ?domain error: CreateDirectory
> ?       CreateDirectory y.;<<0
>



--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.

         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From eiverson at sympatico.ca  Fri Dec 16 04:54:34 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Fri Dec 16 04:55:41 2005
Subject: [Jbeta] Re: junklab not created
References: <4031fef0511300218y748bb9c5i@mail.gmail.com>
	<4031fef0512151010n40610bc6r@mail.gmail.com>
Message-ID: <004f01c601ba$2a2b8d80$0701a8c0@xp>

Thanks for the bug report. The problem is the win32api gives an incorrect 
prototype for CreateDirectoryA. After the domain error a cder'' shows the 
2nd parameter is bad. The prototype from win32api is:

kernel32 CreateDirectoryA i *c i

This requires the second argument to be an integer and instead a null 
pointer <<0 is passed.

The proper prototype is:

kernel32 CreateDirectoryA i *c *

The second parameter is a pointer to a security structure.

This problem will probably be fixed by our changing the prototype. If you 
are at the failure point in the lab you can fix it by doing:
   CreateDirectory=: 'kernel32 CreateDirectoryA i *c *'&(15!:0)
   createdirectory 'user\morejunk' NB. should work now with new prototype

There is a more interesting problem with this lab. It uses the ansi version 
of all host api (that is, CreateFileA, DeleteFileA, CreateDirectoryA) where 
the filename arguments are ansi character strings. For unicode support the 
lab needs to be reworked (or have an alternate version) that uses 
CreateFileW etc and provides unicode arguments (from 7 u: of utf8 arguments.

For now we'll probably just add a caution at the front of the lab that it 
uses ansi filenames. After all, it is a demo of dll calls not file 
operations.

----- Original Message ----- 
From: "Bj?rn Helgason" <gosinn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Thursday, December 15, 2005 1:10 PM
Subject: [Jbeta] Re: junklab not created


> Lab: DLL: Using System DLLs (file examples)
>
>  9!:14''
> j601/beta/2005-12-08/17:30
>
> ?? (29 of 35) CreateDirectory ????????????????????   createdirectory=: 3 :
> 'CreateDirectory y.;<<0'
>   createdirectory 'user\junklab'   NB. 0 is failure
> ?domain error: CreateDirectory
> ?       CreateDirectory y.;<<0
>
>
> 2005/11/30, Bj?rn Helgason <gosinn@gmail.com>:
>>
>> Lab: DLL: Using System DLLs (file examples)
>>
>> First the text seems to me to be wrong
>>
>> ?? (11 of 35) CreateFile (ctd) ??????????????????????????????
>>
>> In our examples we use access GENERIC_READ+GENERIC_READ,
>> share 0, and attributes 0.
>> )
>>
>> should be Write
>>
>> ?? (11 of 35) CreateFile (ctd) ??????????????????????????????
>>
>> In our examples we use access GENERIC_READ+GENERIC_WRITE,
>> share 0, and attributes 0.
>> )
>>
>> junklab dir does not get created
>>
>> ---------------
>> createdirectory 'user\junklab'   NB. 0 is failure
>> ?domain error: CreateDirectory
>> ?       CreateDirectory y.;<<0
>>
>
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>          /|_      .-----------------------------------.
>
>         ,'  .\  /  | Me? l?ttri lund ver?ur        |
>     ,--'    _,'   | Dagurinn ? dag                     |
>    /       /       | Enn betri en g?rdagurinn  |
>   (   -.  |        `-----------------------------------'
>   |     ) |
>  (`-.  '--.)
>   `. )----'
>


--------------------------------------------------------------------------------


> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From gosinn at gmail.com  Fri Dec 16 05:03:47 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Fri Dec 16 05:01:56 2005
Subject: [Jbeta] Re: junklab not created
In-Reply-To: <004f01c601ba$2a2b8d80$0701a8c0@xp>
References: <4031fef0511300218y748bb9c5i@mail.gmail.com>
	<4031fef0512151010n40610bc6r@mail.gmail.com>
	<004f01c601ba$2a2b8d80$0701a8c0@xp>
Message-ID: <4031fef0512151303m71faecaeh@mail.gmail.com>

Thx
works great!

2005/12/15, Eric Iverson <eiverson@sympatico.ca>:

This problem will probably be fixed by our changing the prototype. If you
> are at the failure point in the lab you can fix it by doing:
>    CreateDirectory=: 'kernel32 CreateDirectoryA i *c *'&(15!:0)
>    createdirectory 'user\morejunk' NB. should work now with new prototype
>
>
From eiverson at sympatico.ca  Fri Dec 16 06:07:53 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Fri Dec 16 06:06:05 2005
Subject: [Jbeta] VB jsvr1 example broken in e beta
References: <377611440512150729u16643d9ahf05a580b606d8772@mail.gmail.com><001101c60197$59c1f250$0701a8c0@xp>
	<377611440512150933m7f9739d9o8abfc2c00ce025fa@mail.gmail.com>
Message-ID: <004d01c601c4$033b8d10$0701a8c0@xp>

John,

There is an obvious coding error with the change to unicode for js.do for 
jexeserver. jdllserver probably works. You can get a j.exe with this fixed 
at:
http://www.jsoftware.com/download/jexe.zip
js.do may work with this j.exe or it may just uncover the next problem.

The failure of show and log may be because no js.do was done to create an 
ijx window. If js.do works, please try them again.

I haven't run vb in at least two years and haven't missed it at all. I don't 
have it installed on my current dev system and will have to dig out some old 
cds if this doesn't sort out fairly easily. Your time and patience on this 
is much appreciated.

----- Original Message ----- 
From: "John Baker" <bakerjd99@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Thursday, December 15, 2005 12:33 PM
Subject: Re: [Jbeta] VB jsvr1 example broken in e beta


I've done a bit of poking around with the sample.

The error occurs on the first call of js.do.  The argument is a string
that causes a spelling error in J.  Usually a symptom of improper
VB string to J string conversion.

The js.setb and js.getb verbs appear to work.  I would suggest adding
a variant of the js.do verb  js.dob   so there is no confunsion about how
the vb string will be converted.

js.show and js.log do not seem to work.  I cannot make the J exe server
visible.

The testing was done with VB6.  I haven't tried the sample with VB.NET

Hope this helps.


On 12/15/05, Eric Iverson <eiverson@sympatico.ca> wrote:
>
> I don't have VB immediately available. Could you provide a little more
> info
> about the failure? If it is a simple problem in a particular area I could
> probably find and fix without having to go through the reinstall of VB
> right
> now.
>
> ----- Original Message -----
> From: "John Baker" <bakerjd99@gmail.com>
> To: <beta@jsoftware.com>
> Sent: Thursday, December 15, 2005 10:29 AM
> Subject: [Jbeta] VB jsvr1 example broken in e beta
>
>
> I just compiled the J VB example   ..\system\examples\ole\vb  for the
> latest
> e beta
> and it is still broken.
>
> It would be useful if these examples ( C++ and VB ) were reworked and made
> to
> run in the new unicode'fied J.
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From gkirouac at riq.qc.ca  Fri Dec 16 07:51:58 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Fri Dec 16 07:50:04 2005
Subject: [Jbeta] verb verb undefname
In-Reply-To: <010501c5fff8$a363dbd0$f7c35718@lap>
References: <200512120210.jBC2A01u028168@ms-smtp-04-eri0.southeast.rr.com>
	<010501c5fff8$a363dbd0$f7c35718@lap>
Message-ID: <20051215234348.M4429@riq.qc.ca>


---------- Original Message -----------
From: Roger Hui <RHui000@shaw.ca>
Sent: Tue, 13 Dec 2005 07:19:26 -0800
Subject: Re: [Jbeta] verb verb undefname

... 
>    A "redundant sentence" error is signalled in an explicit verb, 
>    or in an explicit adverb or conjunction which has both the x./y. 
>    and u./v./m./n. arguments, if a sentence is executed which
>    - does not have assignment as the last operation, and
>    - does not result in a noun
> 
------- End of Original Message -------

If I understand correctly, the error can happen only if a verb is called
dyadically, so that both x. and y. are defined.

Why is the requirement of having both the x. and y. defined?

Gilles -)
From HenryHRich at nc.rr.com  Fri Dec 16 08:11:07 2005
From: HenryHRich at nc.rr.com (Henry Rich)
Date: Fri Dec 16 08:09:14 2005
Subject: [Jbeta] verb verb undefname
In-Reply-To: <20051215234348.M4429@riq.qc.ca>
Message-ID: <200512160011.jBG0B5We014536@ms-smtp-01-eri0.southeast.rr.com>

He means one of more of x./y.  and one or more of u./v./m./n.
defined.

In early J, x. and y. meant what u. and v. do now.  When u. and
v. were introduced, for compatibility x. and y. kept the old
interpretation if u./v. etc. were not present, otherwise they
had their current meanings.

Henry Rich 

> -----Original Message-----
> From: beta-bounces@jsoftware.com 
> [mailto:beta-bounces@jsoftware.com] On Behalf Of Gilles Kirouac
> Sent: Thursday, December 15, 2005 6:52 PM
> To: Beta forum
> Subject: Re: [Jbeta] verb verb undefname
> 
> 
> ---------- Original Message -----------
> From: Roger Hui <RHui000@shaw.ca>
> Sent: Tue, 13 Dec 2005 07:19:26 -0800
> Subject: Re: [Jbeta] verb verb undefname
> 
> ... 
> >    A "redundant sentence" error is signalled in an explicit verb, 
> >    or in an explicit adverb or conjunction which has both the x./y. 
> >    and u./v./m./n. arguments, if a sentence is executed which
> >    - does not have assignment as the last operation, and
> >    - does not result in a noun
> > 
> ------- End of Original Message -------
> 
> If I understand correctly, the error can happen only if a 
> verb is called
> dyadically, so that both x. and y. are defined.
> 
> Why is the requirement of having both the x. and y. defined?
> 
> Gilles -)
> ----------------------------------------------------------------------
> For information about J forums see 
> http://www.jsoftware.com/forums.htm

From RHui000 at shaw.ca  Fri Dec 16 08:27:14 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Fri Dec 16 08:25:35 2005
Subject: [Jbeta] verb verb undefname
References: <200512120210.jBC2A01u028168@ms-smtp-04-eri0.southeast.rr.com>
	<010501c5fff8$a363dbd0$f7c35718@lap> <20051215234348.M4429@riq.qc.ca>
Message-ID: <01d101c601d7$7a9d1870$f7c35718@lap>

The x./y. and u./v./m./n. comment applies to "an explicit adverb 
or conjunction".  Thus a redundant error can not be signalled 
for "key" but can be signalled for "slashdot".

key=: 1 : '=@[ u.@# ]'

slashdot=: 1 : 0
 (oind y.) u.@osub"0 1 ,@(<"_2) y.
:
 (=x.) u.@# y.
)

osub=: >@]`(>@[ >@:{ ]) @. (*@#@])
oind=: (+/&i./ </.&, i.)@(2&{.)@(,&1 1)@$
ob  =: 1 : 'oind x.@osub"0 1 ,@(<"_2)'



----- Original Message ----- 
From: "Gilles Kirouac" <gkirouac@riq.qc.ca>
To: "Beta forum" <beta@jsoftware.com>
Sent: Thursday, December 15, 2005 3:51 PM
Subject: Re: [Jbeta] verb verb undefname

---------- Original Message -----------
From: Roger Hui <RHui000@shaw.ca>
Sent: Tue, 13 Dec 2005 07:19:26 -0800
Subject: Re: [Jbeta] verb verb undefname

... 
>    A "redundant sentence" error is signalled in an explicit verb, 
>    or in an explicit adverb or conjunction which has both the x./y. 
>    and u./v./m./n. arguments, if a sentence is executed which
>    - does not have assignment as the last operation, and
>    - does not result in a noun
> 
------- End of Original Message -------

If I understand correctly, the error can happen only if a verb is called
dyadically, so that both x. and y. are defined.

Why is the requirement of having both the x. and y. defined?

Gilles -)


From bakerjd99 at gmail.com  Fri Dec 16 23:16:25 2005
From: bakerjd99 at gmail.com (John Baker)
Date: Fri Dec 16 23:14:30 2005
Subject: [Jbeta] VB jsvr1 example broken in e beta
In-Reply-To: <004d01c601c4$033b8d10$0701a8c0@xp>
References: <377611440512150729u16643d9ahf05a580b606d8772@mail.gmail.com>
	<001101c60197$59c1f250$0701a8c0@xp>
	<377611440512150933m7f9739d9o8abfc2c00ce025fa@mail.gmail.com>
	<004d01c601c4$033b8d10$0701a8c0@xp>
Message-ID: <377611440512160716j13a024f8rb259919150bc68b5@mail.gmail.com>

I'll take a look - we are buried in snow up in Ottawa today so I am home.
I'll try
your exe.


On 12/15/05, Eric Iverson <eiverson@sympatico.ca> wrote:
>
> John,
>
> There is an obvious coding error with the change to unicode for js.do for
> jexeserver. jdllserver probably works. You can get a j.exe with this fixed
> at:
> http://www.jsoftware.com/download/jexe.zip
> js.do may work with this j.exe or it may just uncover the next problem.
>
> The failure of show and log may be because no js.do was done to create an
> ijx window. If js.do works, please try them again.
>
> I haven't run vb in at least two years and haven't missed it at all. I
> don't
> have it installed on my current dev system and will have to dig out some
> old
> cds if this doesn't sort out fairly easily. Your time and patience on this
> is much appreciated.
>
> ----- Original Message -----
> From: "John Baker" <bakerjd99@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Thursday, December 15, 2005 12:33 PM
> Subject: Re: [Jbeta] VB jsvr1 example broken in e beta
>
>
> I've done a bit of poking around with the sample.
>
> The error occurs on the first call of js.do.  The argument is a string
> that causes a spelling error in J.  Usually a symptom of improper
> VB string to J string conversion.
>
> The js.setb and js.getb verbs appear to work.  I would suggest adding
> a variant of the js.do verb  js.dob   so there is no confunsion about how
> the vb string will be converted.
>
> js.show and js.log do not seem to work.  I cannot make the J exe server
> visible.
>
> The testing was done with VB6.  I haven't tried the sample with VB.NET
>
> Hope this helps.
>
>
> On 12/15/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> >
> > I don't have VB immediately available. Could you provide a little more
> > info
> > about the failure? If it is a simple problem in a particular area I
> could
> > probably find and fix without having to go through the reinstall of VB
> > right
> > now.
> >
> > ----- Original Message -----
> > From: "John Baker" <bakerjd99@gmail.com>
> > To: <beta@jsoftware.com>
> > Sent: Thursday, December 15, 2005 10:29 AM
> > Subject: [Jbeta] VB jsvr1 example broken in e beta
> >
> >
> > I just compiled the J VB example   ..\system\examples\ole\vb  for the
> > latest
> > e beta
> > and it is still broken.
> >
> > It would be useful if these examples ( C++ and VB ) were reworked and
> made
> > to
> > run in the new unicode'fied J.
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From eiverson at sympatico.ca  Fri Dec 16 23:27:48 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Fri Dec 16 23:27:44 2005
Subject: [Jbeta] f beta available
Message-ID: <006001c60255$80716a70$0701a8c0@xp>

f beta available
http://www.jsoftware.com/download/j601fbeta_win.exe

This version fixes problems reported with J as an OLE automation client.
From eiverson at sympatico.ca  Sat Dec 17 08:23:22 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 17 08:21:29 2005
Subject: [Jbeta] holidays
Message-ID: <000b01c602a0$19875400$0701a8c0@xp>

There probably won't be a new beta until early in the new year.
From donguinn at pvtnetworks.net  Sat Dec 17 22:29:18 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Sat Dec 17 22:30:29 2005
Subject: [Jbeta] Scripts rank error
Message-ID: <43A420BE.7010304@pvtn.net>

Why is it a rank error when I try to use the 3-digit form for scripts?  
I tried this in J5 and it fails there too.

   (0!:1) 'xxx=:3+4'
   xxx=:3+4
   (0!:1 0 1) 'xxx=:3+4'
|rank error
|   (    0!:1 0 1)'xxx=:3+4'
   9!:14''
j601/beta/2005-12-08/17:30

I had always wondered how the form 0!:0 could determine whether the 
input was from a noun or a file.  I played with it a little and found 
that if y was boxed it assumed that it named a file but if unboxed it 
executed y as a noun.  Shouldn't this information be added to the 
Dictionary?


From jf at dbron.net  Sat Dec 17 23:28:50 2005
From: jf at dbron.net (Dan Bron)
Date: Sat Dec 17 23:26:49 2005
Subject: [Jbeta] Scripts rank error
In-Reply-To: <43A420BE.7010304@pvtn.net>
Message-ID: <20051217152647.B301A74C64D@alice.jsoftware.com>

The 3 digit form refers to a single number with 3 decimal digits.  

That is, in place of:

	   (0!:1 0 1) 'xxx=:3+4'
use

	   (0!:101  ) 'xxx=:3+4'
	   xxx=:3+4
	
	   xxx
	7
 
-Dan

From donguinn at pvtnetworks.net  Sat Dec 17 23:33:44 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Sat Dec 17 23:31:57 2005
Subject: [Jbeta] Scripts rank error
In-Reply-To: <20051217152647.B301A74C64D@alice.jsoftware.com>
References: <20051217152647.B301A74C64D@alice.jsoftware.com>
Message-ID: <43A42FD8.2040505@pvtn.net>

Of course, how stupid of me!  Thanks.

Dan Bron wrote:

>The 3 digit form refers to a single number with 3 decimal digits.  
>
>That is, in place of:
>
>	   (0!:1 0 1) 'xxx=:3+4'
>use
>
>	   (0!:101  ) 'xxx=:3+4'
>	   xxx=:3+4
>	
>	   xxx
>	7
> 
>-Dan
>
>----------------------------------------------------------------------
>For information about J forums see http://www.jsoftware.com/forums.htm
>
>  
>

From juneaftn at gmail.com  Mon Dec 19 02:44:09 2005
From: juneaftn at gmail.com (June Kim)
Date: Mon Dec 19 02:42:10 2005
Subject: [Jbeta] line number not shown in the window title
Message-ID: <6f80c1520512181044x6b81f95fje8c002883d1a521e@mail.gmail.com>

Hi

As far as I know, the only way to know the current line number where
the curson is on is to see the window title (supposing the Window
Title Style set properly beforehand).

In the j601 betas, the line number does not change after a file is
first loaded, or sometimes not shown at all( displayed as [] instead).

j504 shows the line number properly. (not the column though).
From gosinn at gmail.com  Mon Dec 19 04:02:37 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Mon Dec 19 04:00:39 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512181044x6b81f95fje8c002883d1a521e@mail.gmail.com>
References: <6f80c1520512181044x6b81f95fje8c002883d1a521e@mail.gmail.com>
Message-ID: <4031fef0512181202v3e77160ah@mail.gmail.com>

In my J601 beta the line numbers list fine within the brackets[<nr>] with no
prior settings
When I create a new ijs it starts [] but changes to a linenumber as soon as
I type anything
When I open a script it displays properly

   9!:14''
j601/beta/2005-12-08/17:30


2005/12/18, June Kim <juneaftn@gmail.com>:
>
> Hi
>
> As far as I know, the only way to know the current line number where
> the curson is on is to see the window title (supposing the Window
> Title Style set properly beforehand).
>
> In the j601 betas, the line number does not change after a file is
> first loaded, or sometimes not shown at all( displayed as [] instead).
>
> j504 shows the line number properly. (not the column though).
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>



--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.

         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From juneaftn at gmail.com  Mon Dec 19 04:07:10 2005
From: juneaftn at gmail.com (June Kim)
Date: Mon Dec 19 04:05:13 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <4031fef0512181202v3e77160ah@mail.gmail.com>
References: <6f80c1520512181044x6b81f95fje8c002883d1a521e@mail.gmail.com>
	<4031fef0512181202v3e77160ah@mail.gmail.com>
Message-ID: <6f80c1520512181207l51fa8b54sef32cd4c26f3d3ee@mail.gmail.com>

Could you please test moving your cursor around in an ijs window after
you type in a couple of lines, and see if the linenumber changes? In
j504 it changed but not in the lastest beta.

On 12/19/05, Bj?rn Helgason <gosinn@gmail.com> wrote:
> In my J601 beta the line numbers list fine within the brackets[<nr>] with no
> prior settings
> When I create a new ijs it starts [] but changes to a linenumber as soon as
> I type anything
> When I open a script it displays properly
>
>   9!:14''
> j601/beta/2005-12-08/17:30
>
>
> 2005/12/18, June Kim <juneaftn@gmail.com>:
> >
> > Hi
> >
> > As far as I know, the only way to know the current line number where
> > the curson is on is to see the window title (supposing the Window
> > Title Style set properly beforehand).
> >
> > In the j601 betas, the line number does not change after a file is
> > first loaded, or sometimes not shown at all( displayed as [] instead).
> >
> > j504 shows the line number properly. (not the column though).
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>          /|_      .-----------------------------------.
>
>         ,'  .\  /  | Me? l?ttri lund ver?ur        |
>     ,--'    _,'   | Dagurinn ? dag                     |
>    /       /       | Enn betri en g?rdagurinn  |
>   (   -.  |        `-----------------------------------'
>   |     ) |
>  (`-.  '--.)
>   `. )----'
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From thomasarneson at comcast.net  Mon Dec 19 05:17:03 2005
From: thomasarneson at comcast.net (tom arneson)
Date: Mon Dec 19 05:15:31 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512181207l51fa8b54sef32cd4c26f3d3ee@mail.gmail.com>
Message-ID: <20051218211529.CD00C74C648@alice.jsoftware.com>

It is working for me in beta:   
JVERSION
Binary: j601binfbeta_win 
Library: j601libfbeta 
Help: j601hlpfbeta 
Engine: j601/beta/2005-12-08/17:30


-----Original Message-----
From: beta-bounces@jsoftware.com [mailto:beta-bounces@jsoftware.com] On
Behalf Of June Kim
Sent: Sunday, December 18, 2005 14:07
To: Beta forum
Subject: Re: [Jbeta] line number not shown in the window title

Could you please test moving your cursor around in an ijs window after
you type in a couple of lines, and see if the linenumber changes? In
j504 it changed but not in the lastest beta.

On 12/19/05, Bj?rn Helgason <gosinn@gmail.com> wrote:
> In my J601 beta the line numbers list fine within the brackets[<nr>] with
no
> prior settings
> When I create a new ijs it starts [] but changes to a linenumber as soon
as
> I type anything
> When I open a script it displays properly
>
>   9!:14''
> j601/beta/2005-12-08/17:30
>
>
> 2005/12/18, June Kim <juneaftn@gmail.com>:
> >
> > Hi
> >
> > As far as I know, the only way to know the current line number where
> > the curson is on is to see the window title (supposing the Window
> > Title Style set properly beforehand).
> >
> > In the j601 betas, the line number does not change after a file is
> > first loaded, or sometimes not shown at all( displayed as [] instead).
> >
> > j504 shows the line number properly. (not the column though).
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
>
>
> --
> Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
> Fugl&Fiskur ehf, ?erneyjarsund 23,
> 802 Selfoss ,t-p?st: gosinn@gmail.com
> http://www.linux.is/forritun/data/J/grunnur.pdf
>
>
> T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans
>
> g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
>          /|_      .-----------------------------------.
>
>         ,'  .\  /  | Me? l?ttri lund ver?ur        |
>     ,--'    _,'   | Dagurinn ? dag                     |
>    /       /       | Enn betri en g?rdagurinn  |
>   (   -.  |        `-----------------------------------'
>   |     ) |
>  (`-.  '--.)
>   `. )----'
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm


From bill_lam at myrealbox.com  Mon Dec 19 18:07:17 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Mon Dec 19 18:05:18 2005
Subject: [Jbeta] CELLDATA/CELLDRAW in jzgrid
Message-ID: <1134986837.c7f52e7cbill_lam@myrealbox.com>

I try jzgrid and can not tell the difference between
CELLDATA and CELLDRAW. It seems CELLDATA is more useful,
but what's CELLDRAW for?


From bill_lam at myrealbox.com  Mon Dec 19 18:32:35 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Mon Dec 19 18:30:36 2005
Subject: [Jbeta] line number not shown in the window title
Message-ID: <1134988355.c80da1fcbill_lam@myrealbox.com>

I suppose it is broken or changed in J601(fbeta)
in J504 there is 2 numbers within [], the first is line
number inside script and the second is line number
within explicit definition.
in J601, the second line number is missing.


From bakerjd99 at gmail.com  Mon Dec 19 22:43:20 2005
From: bakerjd99 at gmail.com (John Baker)
Date: Mon Dec 19 22:41:22 2005
Subject: [Jbeta] VB jsvr1 example broken in e beta
In-Reply-To: <377611440512160716j13a024f8rb259919150bc68b5@mail.gmail.com>
References: <377611440512150729u16643d9ahf05a580b606d8772@mail.gmail.com>
	<001101c60197$59c1f250$0701a8c0@xp>
	<377611440512150933m7f9739d9o8abfc2c00ce025fa@mail.gmail.com>
	<004d01c601c4$033b8d10$0701a8c0@xp>
	<377611440512160716j13a024f8rb259919150bc68b5@mail.gmail.com>
Message-ID: <377611440512190643t7948dcd2t592a6c9693d05a7c@mail.gmail.com>

The jsrv1 demo now works.  I have also tested this with my psm.exe
application that uses the vb ole/com interface and so far things look good.
I will be testing more throughly over the holidays.


On 12/16/05, John Baker <bakerjd99@gmail.com> wrote:
>
> I'll take a look - we are buried in snow up in Ottawa today so I am home.
> I'll try
> your exe.
>
>
>  On 12/15/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> >
> > John,
> >
> > There is an obvious coding error with the change to unicode for js.dofor
> > jexeserver. jdllserver probably works. You can get a j.exe with this
> > fixed
> > at:
> > http://www.jsoftware.com/download/jexe.zip
> > js.do may work with this j.exe or it may just uncover the next problem.
> >
> > The failure of show and log may be because no js.do was done to create
> > an
> > ijx window. If js.do works, please try them again.
> >
> > I haven't run vb in at least two years and haven't missed it at all. I
> > don't
> > have it installed on my current dev system and will have to dig out some
> > old
> > cds if this doesn't sort out fairly easily. Your time and patience on
> > this
> > is much appreciated.
> >
> > ----- Original Message -----
> > From: "John Baker" <bakerjd99@gmail.com >
> > To: "Beta forum" <beta@jsoftware.com>
> > Sent: Thursday, December 15, 2005 12:33 PM
> > Subject: Re: [Jbeta] VB jsvr1 example broken in e beta
> >
> >
> > I've done a bit of poking around with the sample.
> >
> > The error occurs on the first call of js.do.  The argument is a string
> > that causes a spelling error in J.  Usually a symptom of improper
> > VB string to J string conversion.
> >
> > The js.setb and js.getb verbs appear to work.  I would suggest adding
> > a variant of the js.do verb  js.dob   so there is no confunsion about
> > how
> > the vb string will be converted.
> >
> > js.show and js.log do not seem to work.  I cannot make the J exe server
> > visible.
> >
> > The testing was done with VB6.  I haven't tried the sample with VB.NET<http://vb.net/>
> >
> > Hope this helps.
> >
> >
> > On 12/15/05, Eric Iverson < eiverson@sympatico.ca> wrote:
> > >
> > > I don't have VB immediately available. Could you provide a little more
> > > info
> > > about the failure? If it is a simple problem in a particular area I
> > could
> > > probably find and fix without having to go through the reinstall of VB
> > > right
> > > now.
> > >
> > > ----- Original Message -----
> > > From: "John Baker" < bakerjd99@gmail.com>
> > > To: <beta@jsoftware.com>
> > > Sent: Thursday, December 15, 2005 10:29 AM
> > > Subject: [Jbeta] VB jsvr1 example broken in e beta
> > >
> > >
> > > I just compiled the J VB example   ..\system\examples\ole\vb  for the
> > > latest
> > > e beta
> > > and it is still broken.
> > >
> > > It would be useful if these examples ( C++ and VB ) were reworked and
> > made
> > > to
> > > run in the new unicode'fied J.
> > > ----------------------------------------------------------------------
> > > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> > >
> > > ----------------------------------------------------------------------
> > > For information about J forums see http://www.jsoftware.com/forums.htm
> > >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
>
From gosinn at gmail.com  Mon Dec 19 23:36:14 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Mon Dec 19 23:34:17 2005
Subject: [Jbeta] f beta available
In-Reply-To: <006001c60255$80716a70$0701a8c0@xp>
References: <006001c60255$80716a70$0701a8c0@xp>
Message-ID: <4031fef0512190736h2babfc42v@mail.gmail.com>

There was a question recently about background colour

I was then looking at background and changed the background of the J session
- ijx

It works fine

I then open an ijs window and it has the same colour

If I change the background colour it changes both ijx and all ijs windows

I have no idea if it would be difficult to change so that it would be
possible to have the background in the ijs windows different from the ijx
window

It would be nice to have such an option

Not to mention that if there is some background colour when you open an ijs
that it would stay the same even if you change in config and next opened
would get the new colour from config

It would thus be easier to distinguish between open windows by the colours


2005/12/16, Eric Iverson <eiverson@sympatico.ca>:
>
> f beta available
> http://www.jsoftware.com/download/j601fbeta_win.exe
>
> This version fixes problems reported with J as an OLE automation client.
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>



--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.

         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From rdmiller at usatoday.com  Tue Dec 20 07:35:50 2005
From: rdmiller at usatoday.com (Miller, Raul D)
Date: Tue Dec 20 07:33:54 2005
Subject: [Jbeta] Bug? (not really specific to beta)
Message-ID: <BCA120F033651846B2F069EF43A486F27D3FA2@usat-vocex13.usatoday.us.ad.gannett.com>

According to the dictionary, u b. 1 is the identity function for u.

However, experimentation shows that currently it's a list of characters.  Likewise for the obverse (that is: assigning rank to one of these produces a constant function which returns the indicated display form).

Checking back, j504 had the same kind of behavior.

-- 
Raul 
From RHui000 at shaw.ca  Tue Dec 20 07:49:39 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Tue Dec 20 07:48:45 2005
Subject: [Jbeta] Bug? (not really specific to beta)
References: <BCA120F033651846B2F069EF43A486F27D3FA2@usat-vocex13.usatoday.us.ad.gannett.com>
Message-ID: <013f01c604f6$e90913f0$f7c35718@lap>

The description in the dictionary needs to be corrected.



----- Original Message -----
From: "Miller, Raul D" <rdmiller@usatoday.com>
To: <beta@jsoftware.com>
Sent: Monday, December 19, 2005 3:35 PM
Subject: [Jbeta] Bug? (not really specific to beta)

According to the dictionary, u b. 1 is the identity function for u.

However, experimentation shows that currently it's a list of characters.  Likewise for the obverse (that is: assigning rank to one
of these produces a constant function which returns the indicated display form).

Checking back, j504 had the same kind of behavior.


From cburke at jsoftware.com  Tue Dec 20 09:35:00 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Tue Dec 20 09:33:03 2005
Subject: [Jbeta] CELLDATA/CELLDRAW in jzgrid
In-Reply-To: <1134986837.c7f52e7cbill_lam@myrealbox.com>
References: <1134986837.c7f52e7cbill_lam@myrealbox.com>
Message-ID: <43A75FC4.3010000@jsoftware.com>

bill lam wrote:
> I try jzgrid and can not tell the difference between
> CELLDATA and CELLDRAW. It seems CELLDATA is more useful,
> but what's CELLDRAW for?

CELLDRAW (raw data) is for the built-in sort only. If present, then the
data is sorted on it, instead of on CELLDATA.
From bakerjd99 at gmail.com  Fri Dec 23 03:34:35 2005
From: bakerjd99 at gmail.com (John Baker)
Date: Fri Dec 23 03:32:34 2005
Subject: [Jbeta] image3 first lab fails on step 7 of 30
Message-ID: <377611440512221134r177fb49eg4a4951c1954f4e41@mail.gmail.com>

I realize that jsoftware is not responsible for addons but the image3 addon
lab fails on step 7 of 30 for the f beta.  The error is caused by a value
error
glwindowext.
From reiterc at mail.lafayette.edu  Fri Dec 23 03:39:30 2005
From: reiterc at mail.lafayette.edu (Cliff Reiter)
Date: Fri Dec 23 03:37:27 2005
Subject: [Jbeta] image3 first lab fails on step 7 of 30
In-Reply-To: <377611440512221134r177fb49eg4a4951c1954f4e41@mail.gmail.com>
References: <377611440512221134r177fb49eg4a4951c1954f4e41@mail.gmail.com>
Message-ID: <43AB00F2.2020103@mail.lafayette.edu>

I have noticed that image3 and many other of my utilities are broken 
under J6.01. Since the default mapping mode is now raw (did I say
that correctly?) I suspect that the fix will amount to removing or
commentling out the offending lines :), this is on my to do list for 
January.
Best,
Cliff

John Baker wrote:

> I realize that jsoftware is not responsible for addons but the image3 addon
> lab fails on step 7 of 30 for the f beta.  The error is caused by a value
> error
> glwindowext.
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
> 

-- 
Clifford A. Reiter
Mathematics Department, Lafayette College
Easton, PA 18042 USA,   610-330-5277
http://www.lafayette.edu/~reiterc

From donguinn at pvtnetworks.net  Fri Dec 23 04:57:57 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Fri Dec 23 04:56:21 2005
Subject: [Jbeta] Form Edit
Message-ID: <43AB1355.40304@pvtn.net>

Just noticed two new controls - editijs and editijx.  What are they?  
How do they work?  I stuck an editijx in a form and I couldn't get any 
events from it.

Also, when I wanted to delete it to do something else I couldn't get the 
del button to remove it.  It was selected.  I got it to go away by 
pressing Undo.

   9!:14''
j601/beta/2005-12-08/17:30
  

From cburke at jsoftware.com  Fri Dec 23 05:15:16 2005
From: cburke at jsoftware.com (Chris Burke)
Date: Fri Dec 23 05:13:13 2005
Subject: [Jbeta] Form Edit
In-Reply-To: <43AB1355.40304@pvtn.net>
References: <43AB1355.40304@pvtn.net>
Message-ID: <43AB1764.4060509@jsoftware.com>

Don Guinn wrote:
> Just noticed two new controls - editijs and editijx.  What are they? 
> How do they work?  I stuck an editijx in a form and I couldn't get any
> events from it.
> 
> Also, when I wanted to delete it to do something else I couldn't get the
> del button to remove it.  It was selected.  I got it to go away by
> pressing Undo.

These controls are the J session windows, and were introduced in J5.

They probably should not be shown in the form editor. I suspect that
originally we had the idea that the controls could be put on any form.
At least, the editijx cannot be put on a form, since only one ijx window
is supported at the moment.
From lorin.lund at gmail.com  Fri Dec 23 09:54:30 2005
From: lorin.lund at gmail.com (Lorin Lund)
Date: Fri Dec 23 09:52:28 2005
Subject: [Jbeta] no error message for trailing undefined
Message-ID: <123898aa0512221754kcaa689aye3315ef81ab7fbdd@mail.gmail.com>

I just joined the beta list recently.  Maybe this is a known and
accepted difference.  Sorry If I'm covery old ground.

With j504:
   asdf
|value error: asdf
   echo 'asdf: ',asdf
asdf:
|syntax error
|       echo'asdf: ',asdf



With J6
   asdf
?value error: asdf
   echo 'asdf: ',asdf
??????????????????????
?echo?????????????????
?    ??asdf: ?,?asdf??
?    ?????????????????
??????????????????????

when something like
 echo 'asdf: ',asdf

occurs in an explicit verb there is no error message.
From donguinn at pvtnetworks.net  Fri Dec 23 10:30:08 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Fri Dec 23 10:28:23 2005
Subject: [Jbeta] Form Edit
In-Reply-To: <43AB1764.4060509@jsoftware.com>
References: <43AB1355.40304@pvtn.net> <43AB1764.4060509@jsoftware.com>
Message-ID: <43AB6130.1020609@pvtn.net>

Another Form Edit problem.  Pressing escape on the form to be edited 
cancels the edit session without saving and changes.  In version 5 it 
canceled a command in progress on the edit window.

From RHui000 at shaw.ca  Fri Dec 23 11:25:50 2005
From: RHui000 at shaw.ca (Roger Hui)
Date: Fri Dec 23 11:24:45 2005
Subject: [Jbeta] no error message for trailing undefined
Message-ID: <048a01c60770$975094d0$f7c35718@lap>

The difference is that  n v1 v2 is a verb in J6.01 but
an error in J5.04.  'asdf:',asdf is the pattern n v1 v2.
(An undefined name is assumed to be a verb.)

Yestday I came across two more occurrences of
the n v1 v2 train:

   ctf=: 3 #. #:

Cantor ternary function.  ctf i is the i-th number whose
base-3 representation consists of only 0 and 1

   primerace=: [: +/\ _2 + 4 | p:

The surplus or deficit of primes that are 3 mod 4
(equiv. to _1 mod 4) vs. those that are 1 mod 4.



----- Original Message -----
From: "Lorin Lund" <lorin.lund@gmail.com>
To: <beta@jsoftware.com>
Sent: Thursday, December 22, 2005 5:54 PM
Subject: [Jbeta] no error message for trailing undefined

I just joined the beta list recently.  Maybe this is a known and
accepted difference.  Sorry If I'm covery old ground.

With j504:
   asdf
|value error: asdf
   echo 'asdf: ',asdf
asdf:
|syntax error
|       echo'asdf: ',asdf



With J6
   asdf
?value error: asdf
   echo 'asdf: ',asdf
??????????????????????
?echo?????????????????
?    ??asdf: ?,?asdf??
?    ?????????????????
??????????????????????

when something like
 echo 'asdf: ',asdf

occurs in an explicit verb there is no error message.



From bakerjd99 at gmail.com  Fri Dec 23 21:57:35 2005
From: bakerjd99 at gmail.com (John Baker)
Date: Fri Dec 23 21:55:32 2005
Subject: [Jbeta] image3 first lab fails on step 7 of 30
In-Reply-To: <43AB00F2.2020103@mail.lafayette.edu>
References: <377611440512221134r177fb49eg4a4951c1954f4e41@mail.gmail.com>
	<43AB00F2.2020103@mail.lafayette.edu>
Message-ID: <377611440512230557i490369e6xe139382c729fbc10@mail.gmail.com>

Sounds good.

My addon also broken in j6.01.  I've decided to rename
it and do some things I've been thinking about for awhile.
But not over the holidays.

Cheers.


On 12/22/05, Cliff Reiter <reiterc@mail.lafayette.edu> wrote:
>
> I have noticed that image3 and many other of my utilities are broken
> under J6.01. Since the default mapping mode is now raw (did I say
> that correctly?) I suspect that the fix will amount to removing or
> commentling out the offending lines :), this is on my to do list for
> January.
> Best,
> Cliff
>
> John Baker wrote:
>
> > I realize that jsoftware is not responsible for addons but the image3
> addon
> > lab fails on step 7 of 30 for the f beta.  The error is caused by a
> value
> > error
> > glwindowext.
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
> --
> Clifford A. Reiter
> Mathematics Department, Lafayette College
> Easton, PA 18042 USA,   610-330-5277
> http://www.lafayette.edu/~reiterc
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From eiverson at sympatico.ca  Sat Dec 24 04:37:39 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 24 04:35:41 2005
Subject: [Jbeta] line number not shown in the window title
References: <6f80c1520512181044x6b81f95fje8c002883d1a521e@mail.gmail.com>
Message-ID: <005a01c60800$b97b3700$77dad1d8@xp>

As far as I can tell the line numbering in the title bar works properly in 
the latest J f beta. Please verify that you are using the f beta and give 
the simplest sequence of steps to show the problem.

----- Original Message ----- 
From: "June Kim" <juneaftn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Sunday, December 18, 2005 1:44 PM
Subject: [Jbeta] line number not shown in the window title


Hi

As far as I know, the only way to know the current line number where
the curson is on is to see the window title (supposing the Window
Title Style set properly beforehand).

In the j601 betas, the line number does not change after a file is
first loaded, or sometimes not shown at all( displayed as [] instead).

j504 shows the line number properly. (not the column though).
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Sat Dec 24 05:53:31 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sat Dec 24 05:51:40 2005
Subject: [Jbeta] line number not shown in the window title
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
Message-ID: <01c001c6080b$572edfb0$77dad1d8@xp>

Bill, thanks, the 2nd number (line number in explicit) is broken in 601 and 
will be fixed.

June, unless I hear otherwise I'll assume that fixing the above will fix 
your problem as well.

----- Original Message ----- 
From: "bill lam" <bill_lam@myrealbox.com>
To: <beta@jsoftware.com>
Sent: Monday, December 19, 2005 5:32 AM
Subject: RE: [Jbeta] line number not shown in the window title


I suppose it is broken or changed in J601(fbeta)
in J504 there is 2 numbers within [], the first is line
number inside script and the second is line number
within explicit definition.
in J601, the second line number is missing.


----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From juneaftn at gmail.com  Sat Dec 24 09:48:34 2005
From: juneaftn at gmail.com (June Kim)
Date: Sat Dec 24 09:46:29 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <01c001c6080b$572edfb0$77dad1d8@xp>
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
	<01c001c6080b$572edfb0$77dad1d8@xp>
Message-ID: <6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>

I am using the 601 f beta and following the steps shown below I can
demonstrate the problem in my windows machine(windows xp sp1 with
korean language):

Run the J window and see the ijx window shown with the title : 3.ijx*
[0] c:\j601\temp\3.ijx

Now I type in three lines:
   1
1
   2
2
   3
3

I can see the line no change in the title from 0 to 2,4, and 6. Now I
move the cursor up to the first line and the line no does not change.

Similar thing happens on ijs windows as well.

On 12/24/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> Bill, thanks, the 2nd number (line number in explicit) is broken in 601 and
> will be fixed.
>
> June, unless I hear otherwise I'll assume that fixing the above will fix
> your problem as well.
>
> ----- Original Message -----
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Monday, December 19, 2005 5:32 AM
> Subject: RE: [Jbeta] line number not shown in the window title
>
>
> I suppose it is broken or changed in J601(fbeta)
> in J504 there is 2 numbers within [], the first is line
> number inside script and the second is line number
> within explicit definition.
> in J601, the second line number is missing.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From r.e.boss at planet.nl  Sat Dec 24 20:13:02 2005
From: r.e.boss at planet.nl (R.E. Boss)
Date: Sat Dec 24 20:10:55 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
Message-ID: <001d01c60883$63334440$9900000a@BOS>

I tried the same in 601 a beta (j601/beta/2005-11-17/08:10) and the line no
just worked fine.

R.E. Boss


-----Oorspronkelijk bericht-----
Van: beta-bounces@jsoftware.com [mailto:beta-bounces@jsoftware.com] Namens
June Kim
Verzonden: zaterdag 24 december 2005 2:49
Aan: Beta forum
Onderwerp: Re: [Jbeta] line number not shown in the window title

I am using the 601 f beta and following the steps shown below I can
demonstrate the problem in my windows machine(windows xp sp1 with
korean language):

Run the J window and see the ijx window shown with the title : 3.ijx*
[0] c:\j601\temp\3.ijx

Now I type in three lines:
   1
1
   2
2
   3
3

I can see the line no change in the title from 0 to 2,4, and 6. Now I
move the cursor up to the first line and the line no does not change.

Similar thing happens on ijs windows as well.

From eiverson at sympatico.ca  Sun Dec 25 03:40:03 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 25 03:38:05 2005
Subject: [Jbeta] line number not shown in the window title
References: <1134988355.c80da1fcbill_lam@myrealbox.com><01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
Message-ID: <001301c608c1$d8388190$3151d0d8@xp>

Strange. It works properly for me here, and by various reports works for 
most other users. The mechanism is pretty simple and curious that it fails. 
What font are you using? Could you please revert back to "courier new" and 
see if it works any differently. (can't see what font has to do with it, but 
can't think of anything else). Is this the f beta out of the box, or do you 
have startup scripts that you run?

----- Original Message ----- 
From: "June Kim" <juneaftn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Friday, December 23, 2005 8:48 PM
Subject: Re: [Jbeta] line number not shown in the window title


I am using the 601 f beta and following the steps shown below I can
demonstrate the problem in my windows machine(windows xp sp1 with
korean language):

Run the J window and see the ijx window shown with the title : 3.ijx*
[0] c:\j601\temp\3.ijx

Now I type in three lines:
   1
1
   2
2
   3
3

I can see the line no change in the title from 0 to 2,4, and 6. Now I
move the cursor up to the first line and the line no does not change.

Similar thing happens on ijs windows as well.

On 12/24/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> Bill, thanks, the 2nd number (line number in explicit) is broken in 601 
> and
> will be fixed.
>
> June, unless I hear otherwise I'll assume that fixing the above will fix
> your problem as well.
>
> ----- Original Message -----
> From: "bill lam" <bill_lam@myrealbox.com>
> To: <beta@jsoftware.com>
> Sent: Monday, December 19, 2005 5:32 AM
> Subject: RE: [Jbeta] line number not shown in the window title
>
>
> I suppose it is broken or changed in J601(fbeta)
> in J504 there is 2 numbers within [], the first is line
> number inside script and the second is line number
> within explicit definition.
> in J601, the second line number is missing.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
----------------------------------------------------------------------
For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Sun Dec 25 03:48:46 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Sun Dec 25 03:46:46 2005
Subject: [Jbeta] line number not shown in the window title
References: <1134988355.c80da1fcbill_lam@myrealbox.com><01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
Message-ID: <004301c608c3$0fa563e0$3151d0d8@xp>

Does the 2nd number behave properly? That is, line position in explicit defn 
ending in ) .

----- Original Message ----- 
From: "June Kim" <juneaftn@gmail.com>
To: "Beta forum" <beta@jsoftware.com>
Sent: Friday, December 23, 2005 8:48 PM
Subject: Re: [Jbeta] line number not shown in the window title


I am using the 601 f beta and following the steps shown below I can
demonstrate the problem in my windows machine(windows xp sp1 with
korean language):

Run the J window and see the ijx window shown with the title : 3.ijx*
[0] c:\j601\temp\3.ijx

Now I type in three lines:
   1
1
   2
2
   3
3

I can see the line no change in the title from 0 to 2,4, and 6. Now I
move the cursor up to the first line and the line no does not change.

Similar thing happens on ijs windows as well.


From gosinn at gmail.com  Sun Dec 25 03:59:36 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sun Dec 25 03:57:34 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
	<01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
Message-ID: <4031fef0512241159r144851aey@mail.gmail.com>

Does not behave like this at my end

   9!:14''
j601/beta/2005-12-08/17:30
   9!:12''
6

I am using win xp

Are you using old windows?

2005/12/24, June Kim <juneaftn@gmail.com>:
>
> I am using the 601 f beta and following the steps shown below I can
> demonstrate the problem in my windows machine(windows xp sp1 with
> korean language):
>
> Run the J window and see the ijx window shown with the title : 3.ijx*
> [0] c:\j601\temp\3.ijx
>
> Now I type in three lines:
>    1
> 1
>    2
> 2
>    3
> 3
>
> I can see the line no change in the title from 0 to 2,4, and 6. Now I
> move the cursor up to the first line and the line no does not change.
>
> Similar thing happens on ijs windows as well.
>
> On 12/24/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> > Bill, thanks, the 2nd number (line number in explicit) is broken in 601
> and
> > will be fixed.
> >
> > June, unless I hear otherwise I'll assume that fixing the above will fix
> > your problem as well.
> >
> > ----- Original Message -----
> > From: "bill lam" <bill_lam@myrealbox.com>
> > To: <beta@jsoftware.com>
> > Sent: Monday, December 19, 2005 5:32 AM
> > Subject: RE: [Jbeta] line number not shown in the window title
> >
> >
> > I suppose it is broken or changed in J601(fbeta)
> > in J504 there is 2 numbers within [], the first is line
> > number inside script and the second is line number
> > within explicit definition.
> > in J601, the second line number is missing.
> >
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>



--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.

         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From juneaftn at gmail.com  Sun Dec 25 09:53:05 2005
From: juneaftn at gmail.com (June Kim)
Date: Sun Dec 25 09:51:00 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <004301c608c3$0fa563e0$3151d0d8@xp>
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
	<01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
	<004301c608c3$0fa563e0$3151d0d8@xp>
Message-ID: <6f80c1520512241753y773376ffgaccd2fe1b3b53a80@mail.gmail.com>

  9!:14''
j601/beta/2005-12-08/17:30
  9!:12''
6

I am using windows xp sp1.

504 works right but j601 doesn't work as I mentioned in the original
post. I once copied the j.exe file from the j601 folder to the j504
folder and ran the j601 exe file in the j504 folder to test with the
same environment and the line numbers didn't change as I moved the
cursor.


On 12/25/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> Does the 2nd number behave properly? That is, line position in explicit defn
> ending in ) .

Interestingly, the current line number changes as I move the cursor
back and forth while in explicit define is on.

x=:monad define
<and then I move the cursor up and down and see the current line number change>

but the right behavior ends as I close the definition with a paranthesis.

June
>
> ----- Original Message -----
> From: "June Kim" <juneaftn@gmail.com>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Friday, December 23, 2005 8:48 PM
> Subject: Re: [Jbeta] line number not shown in the window title
>
>
> I am using the 601 f beta and following the steps shown below I can
> demonstrate the problem in my windows machine(windows xp sp1 with
> korean language):
>
> Run the J window and see the ijx window shown with the title : 3.ijx*
> [0] c:\j601\temp\3.ijx
>
> Now I type in three lines:
>   1
> 1
>   2
> 2
>   3
> 3
>
> I can see the line no change in the title from 0 to 2,4, and 6. Now I
> move the cursor up to the first line and the line no does not change.
>
> Similar thing happens on ijs windows as well.
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>
From juneaftn at gmail.com  Sun Dec 25 09:58:05 2005
From: juneaftn at gmail.com (June Kim)
Date: Sun Dec 25 09:55:59 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512241753y773376ffgaccd2fe1b3b53a80@mail.gmail.com>
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
	<01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
	<004301c608c3$0fa563e0$3151d0d8@xp>
	<6f80c1520512241753y773376ffgaccd2fe1b3b53a80@mail.gmail.com>
Message-ID: <6f80c1520512241758w34529f91q746ae6d1f536ca95@mail.gmail.com>

Oh, I missed one thing. In j504, if I open up the explicit define
mode, there are two numbers shown in the title bar and as I move the
cursor both the numbers change.

However in j601, in explicit define mode, there are only one number
shown(the line number of the whole window), and it changes as I move
the cursor.

On 12/25/05, June Kim <juneaftn@gmail.com> wrote:
>  9!:14''
> j601/beta/2005-12-08/17:30
>  9!:12''
> 6
>
> I am using windows xp sp1.
>
> 504 works right but j601 doesn't work as I mentioned in the original
> post. I once copied the j.exe file from the j601 folder to the j504
> folder and ran the j601 exe file in the j504 folder to test with the
> same environment and the line numbers didn't change as I moved the
> cursor.
>
>
> On 12/25/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> > Does the 2nd number behave properly? That is, line position in explicit defn
> > ending in ) .
>
> Interestingly, the current line number changes as I move the cursor
> back and forth while in explicit define is on.
>
> x=:monad define
> <and then I move the cursor up and down and see the current line number change>
>
> but the right behavior ends as I close the definition with a paranthesis.
>
> June
> >
> > ----- Original Message -----
> > From: "June Kim" <juneaftn@gmail.com>
> > To: "Beta forum" <beta@jsoftware.com>
> > Sent: Friday, December 23, 2005 8:48 PM
> > Subject: Re: [Jbeta] line number not shown in the window title
> >
> >
> > I am using the 601 f beta and following the steps shown below I can
> > demonstrate the problem in my windows machine(windows xp sp1 with
> > korean language):
> >
> > Run the J window and see the ijx window shown with the title : 3.ijx*
> > [0] c:\j601\temp\3.ijx
> >
> > Now I type in three lines:
> >   1
> > 1
> >   2
> > 2
> >   3
> > 3
> >
> > I can see the line no change in the title from 0 to 2,4, and 6. Now I
> > move the cursor up to the first line and the line no does not change.
> >
> > Similar thing happens on ijs windows as well.
> >
> >
> > ----------------------------------------------------------------------
> > For information about J forums see http://www.jsoftware.com/forums.htm
> >
>
From juneaftn at gmail.com  Sun Dec 25 10:25:55 2005
From: juneaftn at gmail.com (June Kim)
Date: Sun Dec 25 10:23:49 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512241758w34529f91q746ae6d1f536ca95@mail.gmail.com>
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
	<01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
	<004301c608c3$0fa563e0$3151d0d8@xp>
	<6f80c1520512241753y773376ffgaccd2fe1b3b53a80@mail.gmail.com>
	<6f80c1520512241758w34529f91q746ae6d1f536ca95@mail.gmail.com>
Message-ID: <6f80c1520512241825q552a0feag544600c86373f7dd@mail.gmail.com>

I think I have identified the cause of this malfunction.

I opened up my task manager(ctrl-alt-esc) and kill the Tablet.exe
process. Now magically the line numbering works right in j601fbeta as
well.

Tablet.exe is wacom tablet driver loader:
http://www.windowsstartup.com/wso/detail.php?id=2824

I didn't connect the tablet to my computer's usb port even. I think
you can reproduce the same malfunction if you download and run the
Tablet.exe (maybe from the wacom site?).

Somehow, there got in a conflict between Tablet.exe and J, since J601.
There was no conflict with J504.


On 12/25/05, June Kim <juneaftn@gmail.com> wrote:
> Oh, I missed one thing. In j504, if I open up the explicit define
> mode, there are two numbers shown in the title bar and as I move the
> cursor both the numbers change.
>
> However in j601, in explicit define mode, there are only one number
> shown(the line number of the whole window), and it changes as I move
> the cursor.
>
> On 12/25/05, June Kim <juneaftn@gmail.com> wrote:
> >  9!:14''
> > j601/beta/2005-12-08/17:30
> >  9!:12''
> > 6
> >
> > I am using windows xp sp1.
> >
> > 504 works right but j601 doesn't work as I mentioned in the original
> > post. I once copied the j.exe file from the j601 folder to the j504
> > folder and ran the j601 exe file in the j504 folder to test with the
> > same environment and the line numbers didn't change as I moved the
> > cursor.
> >
> >
> > On 12/25/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> > > Does the 2nd number behave properly? That is, line position in explicit defn
> > > ending in ) .
> >
> > Interestingly, the current line number changes as I move the cursor
> > back and forth while in explicit define is on.
> >
> > x=:monad define
> > <and then I move the cursor up and down and see the current line number change>
> >
> > but the right behavior ends as I close the definition with a paranthesis.
> >
> > June
> > >
> > > ----- Original Message -----
> > > From: "June Kim" <juneaftn@gmail.com>
> > > To: "Beta forum" <beta@jsoftware.com>
> > > Sent: Friday, December 23, 2005 8:48 PM
> > > Subject: Re: [Jbeta] line number not shown in the window title
> > >
> > >
> > > I am using the 601 f beta and following the steps shown below I can
> > > demonstrate the problem in my windows machine(windows xp sp1 with
> > > korean language):
> > >
> > > Run the J window and see the ijx window shown with the title : 3.ijx*
> > > [0] c:\j601\temp\3.ijx
> > >
> > > Now I type in three lines:
> > >   1
> > > 1
> > >   2
> > > 2
> > >   3
> > > 3
> > >
> > > I can see the line no change in the title from 0 to 2,4, and 6. Now I
> > > move the cursor up to the first line and the line no does not change.
> > >
> > > Similar thing happens on ijs windows as well.
> > >
> > >
> > > ----------------------------------------------------------------------
> > > For information about J forums see http://www.jsoftware.com/forums.htm
> > >
> >
>
From juneaftn at gmail.com  Sun Dec 25 11:06:54 2005
From: juneaftn at gmail.com (June Kim)
Date: Sun Dec 25 11:04:48 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512241825q552a0feag544600c86373f7dd@mail.gmail.com>
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
	<01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
	<004301c608c3$0fa563e0$3151d0d8@xp>
	<6f80c1520512241753y773376ffgaccd2fe1b3b53a80@mail.gmail.com>
	<6f80c1520512241758w34529f91q746ae6d1f536ca95@mail.gmail.com>
	<6f80c1520512241825q552a0feag544600c86373f7dd@mail.gmail.com>
Message-ID: <6f80c1520512241906g190eb74fu50809d18ed646842@mail.gmail.com>

I have solved the problem by updating the tablet driver with a newer version.

My driver's version was 4.7.6.8, which caused the problem with J.
Those versions above 4.9.x.x doesn't interfere with J's line number
display in the title bar.

I think a caution in the README file or somewhere in the distribution
would help users who might be using wacom's previous drivers.

However, the line number thing is not perfect yet. In j504, I see two
numbers displayed when in explicit define mode but I see only one
number in j601f. Is it already a known problem here?

On 12/25/05, June Kim <juneaftn@gmail.com> wrote:
> I think I have identified the cause of this malfunction.
>
> I opened up my task manager(ctrl-alt-esc) and kill the Tablet.exe
> process. Now magically the line numbering works right in j601fbeta as
> well.
>
> Tablet.exe is wacom tablet driver loader:
> http://www.windowsstartup.com/wso/detail.php?id=2824
>
> I didn't connect the tablet to my computer's usb port even. I think
> you can reproduce the same malfunction if you download and run the
> Tablet.exe (maybe from the wacom site?).
>
> Somehow, there got in a conflict between Tablet.exe and J, since J601.
> There was no conflict with J504.
>
>
> On 12/25/05, June Kim <juneaftn@gmail.com> wrote:
> > Oh, I missed one thing. In j504, if I open up the explicit define
> > mode, there are two numbers shown in the title bar and as I move the
> > cursor both the numbers change.
> >
> > However in j601, in explicit define mode, there are only one number
> > shown(the line number of the whole window), and it changes as I move
> > the cursor.
> >
> > On 12/25/05, June Kim <juneaftn@gmail.com> wrote:
> > >  9!:14''
> > > j601/beta/2005-12-08/17:30
> > >  9!:12''
> > > 6
> > >
> > > I am using windows xp sp1.
> > >
> > > 504 works right but j601 doesn't work as I mentioned in the original
> > > post. I once copied the j.exe file from the j601 folder to the j504
> > > folder and ran the j601 exe file in the j504 folder to test with the
> > > same environment and the line numbers didn't change as I moved the
> > > cursor.
> > >
> > >
> > > On 12/25/05, Eric Iverson <eiverson@sympatico.ca> wrote:
> > > > Does the 2nd number behave properly? That is, line position in explicit defn
> > > > ending in ) .
> > >
> > > Interestingly, the current line number changes as I move the cursor
> > > back and forth while in explicit define is on.
> > >
> > > x=:monad define
> > > <and then I move the cursor up and down and see the current line number change>
> > >
> > > but the right behavior ends as I close the definition with a paranthesis.
> > >
> > > June
> > > >
> > > > ----- Original Message -----
> > > > From: "June Kim" <juneaftn@gmail.com>
> > > > To: "Beta forum" <beta@jsoftware.com>
> > > > Sent: Friday, December 23, 2005 8:48 PM
> > > > Subject: Re: [Jbeta] line number not shown in the window title
> > > >
> > > >
> > > > I am using the 601 f beta and following the steps shown below I can
> > > > demonstrate the problem in my windows machine(windows xp sp1 with
> > > > korean language):
> > > >
> > > > Run the J window and see the ijx window shown with the title : 3.ijx*
> > > > [0] c:\j601\temp\3.ijx
> > > >
> > > > Now I type in three lines:
> > > >   1
> > > > 1
> > > >   2
> > > > 2
> > > >   3
> > > > 3
> > > >
> > > > I can see the line no change in the title from 0 to 2,4, and 6. Now I
> > > > move the cursor up to the first line and the line no does not change.
> > > >
> > > > Similar thing happens on ijs windows as well.
> > > >
> > > >
> > > > ----------------------------------------------------------------------
> > > > For information about J forums see http://www.jsoftware.com/forums.htm
> > > >
> > >
> >
>
From gosinn at gmail.com  Sun Dec 25 18:24:36 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Sun Dec 25 18:22:31 2005
Subject: [Jbeta] line number not shown in the window title
In-Reply-To: <6f80c1520512241906g190eb74fu50809d18ed646842@mail.gmail.com>
References: <1134988355.c80da1fcbill_lam@myrealbox.com>
	<01c001c6080b$572edfb0$77dad1d8@xp>
	<6f80c1520512231748q66238cc5j6ab6bb4eba48ca3a@mail.gmail.com>
	<004301c608c3$0fa563e0$3151d0d8@xp>
	<6f80c1520512241753y773376ffgaccd2fe1b3b53a80@mail.gmail.com>
	<6f80c1520512241758w34529f91q746ae6d1f536ca95@mail.gmail.com>
	<6f80c1520512241825q552a0feag544600c86373f7dd@mail.gmail.com>
	<6f80c1520512241906g190eb74fu50809d18ed646842@mail.gmail.com>
Message-ID: <4031fef0512250224i32ffac3dq@mail.gmail.com>

---------- Forwarded message ----------
From: Eric Iverson <eiverson@sympatico.ca>
Date: 23.12.2005 21:53
Subject: Re: [Jbeta] line number not shown in the window title
To: Beta forum <beta@jsoftware.com>

Bill, thanks, the 2nd number (line number in explicit) is broken in 601 and
will be fixed.


2005/12/25, June Kim <juneaftn@gmail.com>:
>
> However, the line number thing is not perfect yet. In j504, I see two
> numbers displayed when in explicit define mode but I see only one
> number in j601f. Is it already a known problem here?
>
From bill_lam at myrealbox.com  Mon Dec 26 23:35:40 2005
From: bill_lam at myrealbox.com (bill lam)
Date: Mon Dec 26 23:33:33 2005
Subject: [Jbeta] J601 gui wish list
Message-ID: <1135611340.c7d3d83cbill_lam@myrealbox.com>

1. treeview list
2. textbox for integer
3. textbox for decimal number
4. textbox for date/time

although there are ocx available, it will be nice if J have them.

From davidmitchell at att.net  Tue Dec 27 00:50:40 2005
From: davidmitchell at att.net (David Mitchell)
Date: Tue Dec 27 00:47:52 2005
Subject: [Jbeta] SFL Library lab section 9
Message-ID: <43B01F60.5060300@att.net>

The SFL Library lab dies in section 9 after:

expandblock_jsfl_ compressblock_jsfl_ 20#'a'

J has encountered a problem and needs to close.  We are sorry for the 
inconvenience.

AppName: j.exe	 AppVer: 5.0.5.0	 ModName: ntdll.dll
ModVer: 5.1.2600.1217	 Offset: 00033905

    9!:14''
j601/beta/2005-12-08/17:30

If I run the sentence outside of the lab, it works fine.

Dave Mitchell
From gkirouac at riq.qc.ca  Tue Dec 27 13:39:46 2005
From: gkirouac at riq.qc.ca (Gilles Kirouac)
Date: Tue Dec 27 13:37:41 2005
Subject: [Jbeta] ocx support needs updating
Message-ID: <20051227053547.M93902@riq.qc.ca>


What follows applies to V5.04 and V6 ebeta.

0)ocxutils.ijs

After changing the last few lines of ocxutils.ijs as below, ocxinfo runs ok:

ocxchar=:  2 : 'ocxset (@ocx_char)'              NB. character
ocxnum =:  2 : 'ocxset (@ocx_num)'               NB. numeric
ocxindex=: 2 : 'ocxset (&.>) (@ocx_index) (;@)'  NB. index
ocxclist=: 2 : 'ocxset (&.>) (@ocx_clist) (;@)'  NB. character list
ocxnlist=: 2 : 'ocxset (&.>) (@ocx_nlist) (;@)'  NB. numeric list
ocxilist=: 2 : 'ocxset (&.>) (@ocx_ilist) (;@)'  NB. numeric index
ocxdata =: 2 : 'ocxset (@ocxfmt)'                NB. data

This follows from the bident (C A) deprecated with V5.
Surprisingly this was not updated with any 5.0x.

However ocxdialog still has a problem.
ocxdialog'Shell.Explorer.2'
&#9474;domain error: wd
&#9474;       wd'oledlg x0'
   wd'qer'
command failed : 0


1)These pages refer to ".js" scripts which are long outdated.

file:///c:/j601/system/extras/help/user/isigraph_events.htm
file:///c:/j601/system/extras/help/user/j_ole_client.htm
file:///c:/j601/system/extras/help/user/ole_examples.htm

Gilles ~
From viton.1 at osu.edu  Wed Dec 28 01:15:47 2005
From: viton.1 at osu.edu (Philip A. Viton)
Date: Wed Dec 28 02:13:42 2005
Subject: [Jbeta] z fmt
Message-ID: <7.0.0.16.2.20051227131115.0222fd30@osu.edu>


Is there any way to get the effect of the 'z' modifier in the old fmt 
verb in the format package, using the new format foreign? That is, 
under j5, 'z2' fmt 2 -> '02'.

If this isn't possible, mightn't it be reasonable to make the old fmt 
verb available in j6's format package, but under a different name, 
for compatibility's sake? Or are there now some cases where the old 
fmt just doesn't work on j6 data?





------------------------
Philip A. Viton
City Planning, Ohio State University
275 West Woodruff Avenue, Columbus OH 43210
viton.1@osu.edu

From gosinn at gmail.com  Wed Dec 28 02:38:52 2005
From: gosinn at gmail.com (=?ISO-8859-1?Q?Bj=F6rn_Helgason?=)
Date: Wed Dec 28 02:36:43 2005
Subject: [Jbeta] z fmt
In-Reply-To: <7.0.0.16.2.20051227131115.0222fd30@osu.edu>
References: <7.0.0.16.2.20051227131115.0222fd30@osu.edu>
Message-ID: <4031fef0512271038o4458b621q@mail.gmail.com>

If you take the fmt verb from
c:\j504\system\main\format.ijs
and run it in j601
    'z2' fmt 2
02

2005/12/27, Philip A. Viton <viton.1@osu.edu>:
>
>
> Is there any way to get the effect of the 'z' modifier in the old fmt
> verb in the format package, using the new format foreign? That is,
> under j5, 'z2' fmt 2 -> '02'.
>
> If this isn't possible, mightn't it be reasonable to make the old fmt
> verb available in j6's format package, but under a different name,
> for compatibility's sake? Or are there now some cases where the old
> fmt just doesn't work on j6 data?
>
>
>
>
>
> ------------------------
> Philip A. Viton
> City Planning, Ohio State University
> 275 West Woodruff Avenue, Columbus OH 43210
> viton.1@osu.edu
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>



--
Bj?rn Helgason, Verkfr??ingur, gsm: +354698 5532
Fugl&Fiskur ehf, ?erneyjarsund 23,
802 Selfoss ,t-p?st: gosinn@gmail.com
http://www.linux.is/forritun/data/J/grunnur.pdf


T?knikunn?tta h?ndlar hi? fl?kna, sk?punarg?fa er meistari einfaldleikans

g??ur kennari getur stigi? ? t?r ?n ?ess a? glansinn fari af sk?num
          /|_      .-----------------------------------.

         ,'  .\  /  | Me? l?ttri lund ver?ur        |
     ,--'    _,'   | Dagurinn ? dag                     |
    /       /       | Enn betri en g?rdagurinn  |
   (   -.  |        `-----------------------------------'
   |     ) |
  (`-.  '--.)
   `. )----'
From donguinn at pvtnetworks.net  Wed Dec 28 03:19:48 2005
From: donguinn at pvtnetworks.net (Don Guinn)
Date: Wed Dec 28 03:17:42 2005
Subject: [Jbeta] z fmt
In-Reply-To: <7.0.0.16.2.20051227131115.0222fd30@osu.edu>
References: <7.0.0.16.2.20051227131115.0222fd30@osu.edu>
Message-ID: <43B193D4.6040306@pvtn.net>

A trick I pulled in the past for this was

   x=.2
   }.":100+x
02

If you only need this part of fmt this might be easier than running fmt.

Philip A. Viton wrote:

>
> Is there any way to get the effect of the 'z' modifier in the old fmt 
> verb in the format package, using the new format foreign? That is, 
> under j5, 'z2' fmt 2 -> '02'.
>
> If this isn't possible, mightn't it be reasonable to make the old fmt 
> verb available in j6's format package, but under a different name, for 
> compatibility's sake? Or are there now some cases where the old fmt 
> just doesn't work on j6 data?
>
>
>
>
>
> ------------------------
> Philip A. Viton
> City Planning, Ohio State University
> 275 West Woodruff Avenue, Columbus OH 43210
> viton.1@osu.edu
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
>

From eiverson at sympatico.ca  Wed Dec 28 06:14:15 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec 28 06:12:18 2005
Subject: [Jbeta] ocx support needs updating
References: <20051227053547.M93902@riq.qc.ca>
Message-ID: <006401c60b32$e7771810$0701a8c0@xp>

Chris will fix the script problems you point out.

   ocxdialog'Shell.Explorer.2'
fails because this ocx doesn't provide a dialog and this failure is the same 
in previous versions.

Instead try:

   ocxdialog'MSCAL.Calendar.7'

----- Original Message ----- 
From: "Gilles Kirouac" <gkirouac@riq.qc.ca>
To: <beta@jsoftware.com>
Sent: Tuesday, December 27, 2005 12:39 AM
Subject: [Jbeta] ocx support needs updating


>
> What follows applies to V5.04 and V6 ebeta.
>
> 0)ocxutils.ijs
>
> After changing the last few lines of ocxutils.ijs as below, ocxinfo runs 
> ok:
>
> ocxchar=:  2 : 'ocxset (@ocx_char)'              NB. character
> ocxnum =:  2 : 'ocxset (@ocx_num)'               NB. numeric
> ocxindex=: 2 : 'ocxset (&.>) (@ocx_index) (;@)'  NB. index
> ocxclist=: 2 : 'ocxset (&.>) (@ocx_clist) (;@)'  NB. character list
> ocxnlist=: 2 : 'ocxset (&.>) (@ocx_nlist) (;@)'  NB. numeric list
> ocxilist=: 2 : 'ocxset (&.>) (@ocx_ilist) (;@)'  NB. numeric index
> ocxdata =: 2 : 'ocxset (@ocxfmt)'                NB. data
>
> This follows from the bident (C A) deprecated with V5.
> Surprisingly this was not updated with any 5.0x.
>
> However ocxdialog still has a problem.
> ocxdialog'Shell.Explorer.2'
> &#9474;domain error: wd
> &#9474;       wd'oledlg x0'
>   wd'qer'
> command failed : 0
>
>
> 1)These pages refer to ".js" scripts which are long outdated.
>
> file:///c:/j601/system/extras/help/user/isigraph_events.htm
> file:///c:/j601/system/extras/help/user/j_ole_client.htm
> file:///c:/j601/system/extras/help/user/ole_examples.htm
>
> Gilles ~
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From eiverson at sympatico.ca  Wed Dec 28 06:32:22 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Wed Dec 28 06:30:15 2005
Subject: [Jbeta] SFL Library lab section 9
References: <43B01F60.5060300@att.net>
Message-ID: <008701c60b35$69f00e30$0701a8c0@xp>

I haven't dug into this but the cd code in expandblock looks suspicious. My 
quick guess is that it is in error and the problem is unrelated to the beta. 
The verb expandblock does 2 cd calls as is typical for this kind of routine. 
The first call is to find out how large the result will be and then 
allocates the space and the second call fill it with the result. The 1st 
call in expand block looks wrong. It allocates 10 bytes and calls the 
routine. The routine has no way to know this is just a call for the size and 
will overwrites memory with any result greater than 10 bytes. The 1st call 
should probably be with a null pointer (<<0). If you track this down, let me 
know what you find and suggest a fix for the lab. Otherwise I'll eventually 
find the spec for the routine and fix the lab.

----- Original Message ----- 
From: "David Mitchell" <davidmitchell@att.net>
To: "Beta forum" <beta@jsoftware.com>
Sent: Monday, December 26, 2005 11:50 AM
Subject: [Jbeta] SFL Library lab section 9


> The SFL Library lab dies in section 9 after:
>
> expandblock_jsfl_ compressblock_jsfl_ 20#'a'
>
> J has encountered a problem and needs to close.  We are sorry for the 
> inconvenience.
>
> AppName: j.exe AppVer: 5.0.5.0 ModName: ntdll.dll
> ModVer: 5.1.2600.1217 Offset: 00033905
>
>    9!:14''
> j601/beta/2005-12-08/17:30
>
> If I run the sentence outside of the lab, it works fine.
>
> Dave Mitchell
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From davidmitchell at att.net  Wed Dec 28 11:13:50 2005
From: davidmitchell at att.net (David Mitchell)
Date: Wed Dec 28 11:11:00 2005
Subject: [Jbeta] SFL Library lab section 9
In-Reply-To: <008701c60b35$69f00e30$0701a8c0@xp>
References: <43B01F60.5060300@att.net> <008701c60b35$69f00e30$0701a8c0@xp>
Message-ID: <43B202EE.2080108@att.net>

You were correct to suspect the cd code.  As far as I can tell, the code 
fails with a null pointer for the result buffer also.  The code 
published at http://www.imatix.com/html/sfl/sfl19.htm#TOC32
has no provision for sizing the result.

The doc for expand_block says (about the result buffer size):
"dst must be large enough to accommodate the largest possible 
decompressed block."

This is in general not easily calculated.  I suspect the simplest work 
around is to capture the size of the uncompressed data at compress time 
and use the saved size to build the buffer:

compress_block=: 'compress_block + s *c *c s'cdm
expand_block=: 'expand_block + s *c *c s'cdm

compressblock=: verb define
source=. y.
osize=. #source
dest=. osize#' '
'size source dest sourcesize'=. compress_block source;dest;#source
osize;size{.dest
)

expandblock=: verb define
'osize source'=. y.
source=. ,source
dest=. osize#{.a.
'size source dest sourcesize'=. expand_block source;dest;#source
size{.dest
)

This could be done for all of the expand_ verbs.

Eric Iverson wrote:
> I haven't dug into this but the cd code in expandblock looks suspicious. 
> My quick guess is that it is in error and the problem is unrelated to 
> the beta. The verb expandblock does 2 cd calls as is typical for this 
> kind of routine. The first call is to find out how large the result will 
> be and then allocates the space and the second call fill it with the 
> result. The 1st call in expand block looks wrong. It allocates 10 bytes 
> and calls the routine. The routine has no way to know this is just a 
> call for the size and will overwrites memory with any result greater 
> than 10 bytes. The 1st call should probably be with a null pointer 
> (<<0). If you track this down, let me know what you find and suggest a 
> fix for the lab. Otherwise I'll eventually find the spec for the routine 
> and fix the lab.
> 
> ----- Original Message ----- From: "David Mitchell" <davidmitchell@att.net>
> To: "Beta forum" <beta@jsoftware.com>
> Sent: Monday, December 26, 2005 11:50 AM
> Subject: [Jbeta] SFL Library lab section 9
> 
> 
>> The SFL Library lab dies in section 9 after:
>>
>> expandblock_jsfl_ compressblock_jsfl_ 20#'a'
>>
>> J has encountered a problem and needs to close.  We are sorry for the 
>> inconvenience.
>>
>> AppName: j.exe AppVer: 5.0.5.0 ModName: ntdll.dll
>> ModVer: 5.1.2600.1217 Offset: 00033905
>>
>>    9!:14''
>> j601/beta/2005-12-08/17:30
>>
>> If I run the sentence outside of the lab, it works fine.
>>
>> Dave Mitchell
>> ----------------------------------------------------------------------
>> For information about J forums see http://www.jsoftware.com/forums.htm 
> 
> 
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
> 
From eiverson at sympatico.ca  Thu Dec 29 02:54:01 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Thu Dec 29 02:51:54 2005
Subject: [Jbeta] SFL Library lab section 9
References: <43B01F60.5060300@att.net> <008701c60b35$69f00e30$0701a8c0@xp>
	<43B202EE.2080108@att.net>
Message-ID: <001e01c60be0$139eec80$0701a8c0@xp>

I have fixed sflcompress.ijs and the lab and there is a new version of the 
sfl addon at the web site. Thanks for pointing out this problem.

----- Original Message ----- 
From: "David Mitchell" <davidmitchell@att.net>
To: "Beta forum" <beta@jsoftware.com>
Sent: Tuesday, December 27, 2005 10:13 PM
Subject: Re: [Jbeta] SFL Library lab section 9


> You were correct to suspect the cd code.  As far as I can tell, the code 
> fails with a null pointer for the result buffer also.  The code published 
> at http://www.imatix.com/html/sfl/sfl19.htm#TOC32
> has no provision for sizing the result.
>
> The doc for expand_block says (about the result buffer size):
> "dst must be large enough to accommodate the largest possible decompressed 
> block."
>
> This is in general not easily calculated.  I suspect the simplest work 
> around is to capture the size of the uncompressed data at compress time 
> and use the saved size to build the buffer:
>
> compress_block=: 'compress_block + s *c *c s'cdm
> expand_block=: 'expand_block + s *c *c s'cdm
>
> compressblock=: verb define
> source=. y.
> osize=. #source
> dest=. osize#' '
> 'size source dest sourcesize'=. compress_block source;dest;#source
> osize;size{.dest
> )
>
> expandblock=: verb define
> 'osize source'=. y.
> source=. ,source
> dest=. osize#{.a.
> 'size source dest sourcesize'=. expand_block source;dest;#source
> size{.dest
> )
>
> This could be done for all of the expand_ verbs.
>
> Eric Iverson wrote:
>> I haven't dug into this but the cd code in expandblock looks suspicious. 
>> My quick guess is that it is in error and the problem is unrelated to the 
>> beta. The verb expandblock does 2 cd calls as is typical for this kind of 
>> routine. The first call is to find out how large the result will be and 
>> then allocates the space and the second call fill it with the result. The 
>> 1st call in expand block looks wrong. It allocates 10 bytes and calls the 
>> routine. The routine has no way to know this is just a call for the size 
>> and will overwrites memory with any result greater than 10 bytes. The 1st 
>> call should probably be with a null pointer (<<0). If you track this 
>> down, let me know what you find and suggest a fix for the lab. Otherwise 
>> I'll eventually find the spec for the routine and fix the lab.
>>
>> ----- Original Message ----- From: "David Mitchell" 
>> <davidmitchell@att.net>
>> To: "Beta forum" <beta@jsoftware.com>
>> Sent: Monday, December 26, 2005 11:50 AM
>> Subject: [Jbeta] SFL Library lab section 9
>>
>>
>>> The SFL Library lab dies in section 9 after:
>>>
>>> expandblock_jsfl_ compressblock_jsfl_ 20#'a'
>>>
>>> J has encountered a problem and needs to close.  We are sorry for the 
>>> inconvenience.
>>>
>>> AppName: j.exe AppVer: 5.0.5.0 ModName: ntdll.dll
>>> ModVer: 5.1.2600.1217 Offset: 00033905
>>>
>>>    9!:14''
>>> j601/beta/2005-12-08/17:30
>>>
>>> If I run the sentence outside of the lab, it works fine.
>>>
>>> Dave Mitchell
>>> ----------------------------------------------------------------------
>>> For information about J forums see http://www.jsoftware.com/forums.htm
>>
>>
>> ----------------------------------------------------------------------
>> For information about J forums see http://www.jsoftware.com/forums.htm
>>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From PGauthier at checkfree.com  Thu Dec 29 22:45:34 2005
From: PGauthier at checkfree.com (PGauthier@checkfree.com)
Date: Thu Dec 29 22:42:36 2005
Subject: [Jbeta] The turtle lab generates an error
In-Reply-To: <006401c60b32$e7771810$0701a8c0@xp>
Message-ID: <OFC9A7EEA0.88C33E02-ON852570E6.0050DDD1-862570E6.005113C3@checkfree.com>

The following error appears when I try to {Ctrl+J} through the Turtle 
Geometry Lab.

wdhandler
error in :jijs_jctrl_fkey

domain error: spos
    f~v

Paul Gauthier
APL Software Developer - Senior
pgauthier@checkfree.com
Phone: 312-739-3467
Fax: 312-739-3496

CheckFree. The Company that Powers Payment on the WebSM.
http://www.checkfree.com/paybillsonline
From geomap at freesurf.ch  Thu Dec 29 22:42:34 2005
From: geomap at freesurf.ch (David Vincent-Jones)
Date: Thu Dec 29 23:59:28 2005
Subject: [Jbeta] J in the Background
Message-ID: <000001c60c86$1e411310$0201a8c0@DAVID>

Not sure what is going on .. this may be my system and ..
I have recently switched to a new computer and from W2K to XPpro with 1 gb.
memory.

I have always been able to run J in the background but find that I cannot
even watch TaskManager running at the same time as J

I am able to run multiple other programs and do background work but with J
the program just stops responding.

If I start a second J session the first stops responding but the second
continues just fine.

Priority is set for the foreground application but not to exclude the
background.

I have never been aware of this problem in the past. Should I be using a
special start-up profile?

David


From eiverson at sympatico.ca  Fri Dec 30 06:47:19 2005
From: eiverson at sympatico.ca (Eric Iverson)
Date: Fri Dec 30 06:45:07 2005
Subject: [Jbeta] J in the Background
References: <000001c60c86$1e411310$0201a8c0@DAVID>
Message-ID: <002b01c60cc9$d4f3b8e0$0701a8c0@xp>

This sounds very strange. The first thing is to confirm whether it has 
anything to do with the new beta. That is, try your experiments on your new 
platform and see if J504 behaves properly. Let's determine if the problem is 
J vs your new platform or J6 vs your new platform.

----- Original Message ----- 
From: "David Vincent-Jones" <geomap@freesurf.ch>
To: "JSoftware Beta" <beta@jsoftware.com>
Sent: Thursday, December 29, 2005 9:42 AM
Subject: [Jbeta] J in the Background


> Not sure what is going on .. this may be my system and ..
> I have recently switched to a new computer and from W2K to XPpro with 1 
> gb.
> memory.
>
> I have always been able to run J in the background but find that I cannot
> even watch TaskManager running at the same time as J
>
> I am able to run multiple other programs and do background work but with J
> the program just stops responding.
>
> If I start a second J session the first stops responding but the second
> continues just fine.
>
> Priority is set for the foreground application but not to exclude the
> background.
>
> I have never been aware of this problem in the past. Should I be using a
> special start-up profile?
>
> David
>
>
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm 

From reiterc at mail.lafayette.edu  Fri Dec 30 21:13:11 2005
From: reiterc at mail.lafayette.edu (Cliff Reiter)
Date: Fri Dec 30 21:11:02 2005
Subject: [Jbeta] J in the Background
In-Reply-To: <000001c60c86$1e411310$0201a8c0@DAVID>
References: <000001c60c86$1e411310$0201a8c0@DAVID>
Message-ID: <43B53267.5020307@mail.lafayette.edu>

David,
When you changed machines, did you switch from a machine that had
hyperthreading (or dual processing) to one without? Or did
hyperthreading get turned off on the new machine? While what you
describe sounds pretty extreme, I know when J is running, the
status of hyperthreading makes a huge difference on our lab machines.
Best,
Cliff

David Vincent-Jones wrote:

> Not sure what is going on .. this may be my system and ..
> I have recently switched to a new computer and from W2K to XPpro with 1 gb.
> memory.
> 
> I have always been able to run J in the background but find that I cannot
> even watch TaskManager running at the same time as J
> 
> I am able to run multiple other programs and do background work but with J
> the program just stops responding.
> 
> If I start a second J session the first stops responding but the second
> continues just fine.
> 
> Priority is set for the foreground application but not to exclude the
> background.
> 
> I have never been aware of this problem in the past. Should I be using a
> special start-up profile?
> 
> David
> 
> 
> ----------------------------------------------------------------------
> For information about J forums see http://www.jsoftware.com/forums.htm
> 

-- 
Clifford A. Reiter
Mathematics Department, Lafayette College
Easton, PA 18042 USA,   610-330-5277
http://www.lafayette.edu/~reiterc

From fraser.jackson at xtra.co.nz  Fri Dec 30 16:43:19 2005
From: fraser.jackson at xtra.co.nz (Fraser Jackson)
Date: Sat Dec 31 14:24:22 2005
Subject: [Jbeta] The turtle lab generates an error
References: <OFC9A7EEA0.88C33E02-ON852570E6.0050DDD1-862570E6.005113C3@checkfree.com>
Message-ID: <000001c60dd3$262afd90$502558db@vaio>

This lab is broken with J601 and some reworking will be done in the New Year 
to get it working again.
)