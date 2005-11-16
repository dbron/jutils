CLAMS=:shell 'net view'
SVRS=:' ' {.@:slice &> 2 }.&.> _3 }. 3 }. LF arbCut CLAMS
PINGS =: shell@:('nslookup '&,) each SVRS

ourSVRS =: SVRS #~ (<'10') = SVRS (] {.@:('.'&slice)@:>@:{:@:(' '&slice)@:{::~ >:@:bx @:(<@:[ (1&e.)@:E.&> ]))&> LF &arbCut @:-.&CR each PINGS
ourSHARES =: #@:(1!:0)&> '\\'&,@:,&'\TEMP\NetTest' each ourSVRS
NO_TEMP_SHARE =: ourSVRS #~ 0  = ourSHARES 

NB.  Static IPS, by convention, end in a octet less than 100
ourSTATIC_IPS =: SVRS #~ ((=&(<'10')@:{."1) *.  100&>@:head@:(_&".)&>@:({:"1)) SVRS (] ({. , {:) @:('.'&slice)@:>@:{:@:(' '&slice)@:{::~ >:@:bx @:(<@:[ (1&e.)@:E.&> ]))&> LF &arbCut @:-.&CR each PINGS

BADS =: ;: toupper 'StatArb9 StatArb2 StarArb12 StatArbSvr1 Gauss'

innerHORSESHOE =: ;:'StatArbSvr1 StatArbDVD StatArb0 OEM2K StatArb12 StatArb10 EMRFIX BloombergSA StatArb5 Gauss StatArbSvr2 Allen2' 
outerHORSESHOE =: ;:'Bron Disla Allen1 StatArb19 RTTDeveloper StatArb16 Maurer StatArb20 StatArb11 StatArb4 StatArb8 StatArb3'
hub            =: ;:'StatArb9 StatArb18 StatArb13 Allen4 StatArb2'
serverRoom     =: ;:'FeedCollector1 StatArbSvr0 StatArbArchive1 StatArbSvr0Old'

weshouldhaveSVRS=:innerHORSESHOE , hub , outerHORSESHOE  , serverRoom  
missingSVRS   =: (SVRS [ ourSVRS) -.~ toupper each weshouldhaveSVRS
smoutput NVtext (,. (;:^:_1@:/:~@:#~ e.&missingSVRS@:(toupper each))@:". each) ;: 'innerHORSESHOE outerHORSESHOE hub   serverRoom     '

NB.ourSVRS2 =: SVRS #~ (<'172') ~: SVRS (] {.@:('.'&slice)@:>@:{:@:(' '&slice)@:{::~ >:@:bx @:(<@:[ (1&e.)@:E.&> ]))&> LF &arbCut each PINGS
NB.ourSHARES2 =: #@:(1!:0)&> '\\'&,@:,&'\TEMP\NetTest' each ourSVRS2
NB.ourSVRS2 #~ 0  = ourSHARES2
NB.
NB.SVRS#~(<'manefmdc01')=SVRS (] {.@:('.'&slice)@:>@:{:@:(' '&slice)@:{::~ >:@:bx @:(<@:[ (1&e.)@:E.&> ]))&> LF &arbCut each PINGS
NB. PINGS#~(<'manefmdc01')=SVRS (] {.@:('.'&slice)@:>@:{:@:(' '&slice)@:{::~ >:@:bx @:(<@:[ (1&e.)@:E.&> ]))&> LF &arbCut each PINGS



SWITCHES =: }: noun define 
Server Room:  CSCO 2950
   ILXFEED-A
   ILXFEED-B
   10.128.1.227
   StatArbSvr0Old
   StatArbSvr0
   FeedCollector1
   StatArbArchive1
   ManeFMDC01
   ManeFMDC02
Inner Horseshoe:  CSCO 2950
   HUB:  CSCO 2?0
         Gauss
         SAcollector
         StatArbDVD
         StatArb5
   Allen2
   BloombergSA (NT4)
   EMRFIX
   StatArb10 (NT4)
   StatArb12
   OEM2K
   StatArb0 (NT4)
   StatArbSvr2
   StatArbSvr1
   SataArb2
Outer Horseshoe:  CSCO 2926
   Allen4
   StatArb18
   StatArb13
   Bron
   Disla
   Allen1 (NT4)
   StatArb19
   RTTDeveloper
   StatArb16
   Maurer
   StatArb20
   StatArb11
   StatArb4
   StatArb8
   StatArb3
   StatArb9
)

   depth =. >. 0 >. 3 ^. i.&0@:=&' '&> LF arbCut SWITCHES 