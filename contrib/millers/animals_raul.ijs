NB. Animals Game by Raul Miller
NB. http://www.jsoftware.com/pipermail/programming/2006-August/002960.html

Know=:0 0$Animals=:Questions=:''

NB. x is boxed strings
NB. y is integers (return it),
NB. or boxed strings (find its index in x)
NB. or a string (find index of boxed string in x)
index=:4 :0"1
 select. {.0#y
 case. 0 do. y
 case. a: do. x i.y
 case. ' ' do. x i.<y
 end.
)

animal=:3 :0
 if.0=#y do. y return.end.
 r=. Animals index y
 if. r = #Animals do.
 Animals=: Animals,<y
 Know=: Know,.'M'
 end. r
)

question=:3 :0
 if.0=#y do. y return.end.
 r=. Questions index y
 if. r = #Questions do.
 assert. 0<#y
 Questions=: Questions,<y
 Know=: Know,'M'
 end. r
)

NB. assert that question x is true for animal y
has=:4 :0
 q=. question x
 a=. animal y
 Know=: 'Y' (<q,a)} Know
)

NB. invert yes/no/maybe truth value
not=: 3 :0
 ('YNM'i.y){'NYM'
)

NB. merge yes/no/maybe values
merge=:4 :0"0
 r=. -.&'M' ~.x,y
 'contradiction' assert 2>#r
 {.r,'M'
)

NB. y is animals;questions;answers
NB. remember that those questions have
NB. those answers for those animals
learn=:3 :0
 a=. animal 0{::y
 q=. question 1{::y
 b=. 2{::y
 if.#b do.
 inds=. q <@,"0 a
 Know=: (b merge inds { Know)  inds} Know
 end.
)

NB. find the most interesting remaining question,
NB. given asked questions x and possible animals y
interesting=:4 :0
 q=. (?~#Questions) -. question x
 if. 0=#q do. q return.end.
 a=. animal y
 rating=. 'Y' *&.>:&([: +/"1 =&(q{a{"1 Know)) 'N'
 if. 0=best=.>./rating do. i.0 return.end.
 q {~ rating i. best
)

NB. delete extra blanks
deb=:3 :0
 }:}.(#~ '  ' -.@E. ])' ',y,' '
)

NB. prompt is not compatible between jconsole
NB. and windowed j.  This is an attempt to work
NB. around that problem.
NB. Also, jbreak will not interrupt prompt in
NB. windowed j.  As an emergency escape, a two space
NB. response will force an error.
query=:3 :0
 require 'misc'
 r=. prompt y
 t=. y }.~ LF i:~ LF,y
 if. t=(#t) {. r do.
 r=. (#t)}.r
 end.
 assert. -.r-:'  '
 deb r
)

NB. ask a yes or no question
ask=:3 :0
 whilst. ' '=yn do.
 yn=. {.-.&' ' 'YNYN '{~'ynYN'i.query y
 end. yn
)

NB. english reference to animal
anAnimal=:3 :0
 ('a',((tolower{.a)e.'aeiou')#'n'),' ',a=.y {:: Animals
)


NB. confirm that we've guessed (or not) the right animal
NB. x is list of asked questions, for learning purposes
confirm=:4 :0
 t=.'N'
 other=.'the other animals'
 note=.''
 pick=.{.y
 if.0<#y do.
 other=. anAnimal pick
 t=.ask 'Is it ',other,'? '
 if. 'Y'=t do. learn ({.y);x end.
 else.
 note=.'I give up.',CRLF
 end.
 if.t='N' do.
 a=.animal tmp=.query note,'What animal were you thinking of? '
 learn a;x
 this=.anAnimal a
 q1=.'What is a yes/no question that distinguishes'
 q2=. this,' from ',other,'? '
 q=.question '? ',~-.&'?' query q1,CRLF,q2,CRLF
 final=.ask 'For ',this,': ',CRLF,' ',q {:: Questions
 learn a;q;final
 learn pick;q;not final
 end.
)

NB. use go'' to begin q&a session about an animal
go=:3 :0
 R=.?~#Animals NB. possible animals
 Q=.'' NB. asked questions
 A=.'' NB. corresponding answers
 while. (1<#R) *. 0<#q=. Q interesting R do.
 A=.A,a=. ask q {:: Questions
 R=.R -. I. (not a) = q{Know
 Q=.Q,q
 end.
 (Q;A) confirm R
 ''
)

NB. some sample initial knowledge:
learn (animal'mouse');(question'Does it have fur? ');'Y'
learn (animal'lizard');(question'Does it have fur? ');'N'

NB. diagnostic routine: display current knowledge:
know=:3 :0
 ('';Animals),Questions,.]&.>Know
)

NB. end.
