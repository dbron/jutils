all_types     =: '|boolean|literal|integer|floating point|complex|boxed|extended integer|rational|||sparse boolean|sparse literal|sparse integer|sparse floating point|sparse complex|sparse boxed|symbol|unicode'
all_types     =:  <;._1 all_types

categories    =: '(chr: literal, unicode) (sym: symbol) (box: boxed, sparse boxed) (num: *)'
categories    =: {:"1 category_table =: trim L: 0 ((({. ; <@:(','&slice)@:}.@:}.)~ i.&':')@:}.@:}:@:trim;.1~ [: 1&(0}) ')'&= +: *@parenDepth) categories


amenable_types=:  REMOVE_ME { ((;:'box') (3 : 'REMOVE_ME=:<<<y'@:i.~ ] ]) {."1 category_table) ,. (<all_types) (2: ^ i.)&.> -.~&.>/\&.:(a:&,) (<;:'*')  sr (<all_types -. a:) categories
unique_atoms  =: 3 : '({."1 amenable_types) ,. (RAMS  ,~ a: #~ #amenable_types) <@:/:~@:~.@:;/.~ (i.#amenable_types),, I. ({:"1 amenable_types) e.&>"0 1~  3!:0&> RAMS =. a: -.~ <@:, S: 0 y'

ALL_NOUNS     =: ".&.> a: -.~ , ;: 0 ln ''
ATOMS_USED    =: unique_atoms ALL_NOUNS
