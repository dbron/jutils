tophone        =:  (10"_ #. +&2@:i.&1@(e.&>&(;: 'ABC DEF GHI JKL MNO PQRS TUV WXYZ')&>) )&>@:(' '&slice)@:toupper
tophone 'mane is cool'

W              =.  /:~@:~.@:;@:((6: s: s:)@:(LF&,)@:toupper@:toJ@:fread each) 'B:\data\documents\web2.txt';'B:\data\documents\WORD.LST'
fromphone      =:  >@:(;: inverse each)@:,@:/:~@:{@:((#~ e.&W@:(6: s: s:))@:,@:{@:{&(;: 'ABC DEF GHI JKL MNO PQRS TUV WXYZ')@:-&2@:(10&#. inverse)&.>)

fromphone =: + (1 : 0)

	fp =. fromphone f.
	if. (*./@:e.&DIGITS@:[ *. -:&(>{.;:')')@:])&:>/@:(2&{.)@:>@:{: 'headslice tailslice'=.(;:'e.&(i.') arbCut ;: 5!:5{.;:'fp' do.
        ".'fp =. ',;:^:_1 headslice , ((;:'<&')"_ , {. ,   2&}.) tailslice
    end.

    fp    f.
)

fromphone  6263 47 2665

phone          =: tophone :. fromphone 
phone^:_1 phone 'mane is cool'

all_types      =. '|boolean|literal|integer|floating point|complex|boxed|extended integer|rational|||sparse boolean|sparse literal|sparse integer|sparse floating point|sparse complex|sparse boxed|symbol|unicode'
all_types      =.  <;._1 all_types     
categories     =. '(chr: literal, unicode) (sym: symbol) (box: boxed, sparse boxed) (num: *)'
categories     =. {:"1 category_table =. trim L: 0 ((({. ; <@:(','&slice)@:}.@:}.)~ i.&':')@:}.@:}:@:trim;.1~ [: 1&(0}) ')'&= +: *@parenDepth) categories 

amenable_types =:  REMOVE_ME { ((;:'box') (3 : 'REMOVE_ME=:<<<y'@:i.~ ] ]) {."1 category_table) ,. (<all_types) (2: ^ i.)&.> -.~&.>/\&.:(a:&,) (<;:'*')  sr (<all_types -. a:) categories  
is_type        =: 1 : '3!:0 e. (> amenable_types map m)"_'
sense_type     =: 2 : 'u ^: (_1: ^ -.@:(n is_type))'

phon           =: phone sense_type 'chr' :. phon

phon 'mane is cool'
phon 6263 47 2665
phon phon 'mane is cool'
phon^:2 'mane is cool'

phon^:_1 'mane is cool'
phon^:_1] 6263 47 2665
phon^:_1 phon^:_1 'mane is cool'
phon^:_2 'mane is cool'
