(a.&i.)
TESTME=:0
BB =. (-: bb)~
0!:(TESTME { 010 2) noun define
''           BB 'xexax' 
'1234567890' BB 'xesef-disof-gytuf-katof-movif-baxux'
'Pineapple'  BB 'xigak-nyryk-humil-bosek-sonax'
)

	rshift =: 33 b.~
	and =: 17 b.

obvious =: verb define
	D =. _ , a. i. y
	K =. #D
	hK =. <.-:K
	NB.iK =. 1+i.hK
	C =. _ 1 {.~ 1+ hK 
	for_n. }. 1 + i.hK do.
		NB. C[n] = (C[n - 1] * 5 + (D[n * 2 - 3] * 7 + D[n * 2 - 2])) mod 36
		C =. C n}~ 36 | ((C{~<:n) * 5) + (7 * D{~_3++:n) + D{~_2++:n
	end.

	T =. _$~(>:hK),5

    for_i. 1+i.hK do.
 		NB.a = (((D[i * 2 - 3] >> 6) & 3) + C[i]) mod 6
		try. a =.  6 | ((((D {~ _3 + +:i) rshift 6) and 3) + i{C) catch. a =. 256 end.
		NB.b = (D[i * 2 - 3] >> 2) & 15
		try. b =. ((D{~ _3 + +: i) rshift 2) and 15 catch. b =. 256 end.
		NB.c = (((D[i * 2 - 3]) & 3) + _|C[i] / 6|_) mod 6
		try. c =. 6 | (((D{~ _3 + +: i) and 3) + <. %~ i{C)  catch. c =. 256 end.
		NB. d = (D[i * 2 - 2] >> 4) & 15
		try. d =. ((D{~_2++:i) rshift 4) and 15 catch. d =. 256 end.
		NB. e = (D[i * 2 - 3]) & 15.
		try. e =. (D{~ _3 + +: i) an 15. catch. e =. 256 end.

		T =. T i}~ a,b,c,d,e
	end.

	i =. hK NB.  I'm assuming

	if. 0 = 2 | K do.
		try. a =. 6 | (i{C) catch. a =. 256 end.
		try. b =. 16 catch. b =. 256 end.
		try. c =. <. 6%~i{C catch. c =. 256 end.
	else.
		NB. a = (((D[K] >> 6) & 3) + C[i]) mod 6
		try. a =. 6 | ((((K{D) rshift 6) and 3) +       i{C) catch. a =. 256 end.
		try. b =. ((K{D) rshift 2) and 15 catch. b =. 256 end.
 
		NB. c = (((D[K]) & 3) + _|C[i] / 6|_) mod 6
		try. c =.6 | (   (K{D)           and 3) + 6 %~ i { C catch. c =. 256 end.
	end.

	P =. a,b,c
	S =. 'x'
	for_et. }.T do.
		S =.S,ET(et)
	end.
	S =. S,EP(P)
	S =. S,'x'
	S
)

ETa =: dyad define
  'a b c d e'=.y
  'V Co' =. '!' , L: 0~ 256 {. L: 0 x
	(a{V),(b{Co),(c{V),(d{Co),'-',e{Co
)

ET =: (V;Co)&ETa

EPa =: dyad define
  'a b c'=.y
  'V Co' =. '!' , L: 0~ 256 {. L: 0 x	
   (a{V),(b{Co),(c{V)
)

EP =: (V;Co)&EPa

V =: ; {:@:;:;._2 noun define
     0 - a
     1 - e
     2 - i
     3 - o
     4 - u
     5 - y
)

Co =: ; {:@:;:;._2 noun define
     0 - b
     1 - c
     2 - d
     3 - f
     4 - g
     5 - h
     6 - k
     7 - l
     8 - m
     9 - n
    10 - p
    11 - r
    12 - s
    13 - t
    14 - v
    15 - z
    16 - x
)

CPAN =: noun define
sub bubblebabble {
    my %param = @_;
    my @dgst = map ord, split //, $param{Digest};
    my $dlen = length $param{Digest};

    my $seed = 1;
    my $rounds = ($dlen / 2) + 1;
    my $retval = 'x';
    for my $i (0..$rounds-1) {
        if ($i+1 < $rounds || $dlen % 2) {
            my $idx0 = ((($dgst[2 * $i] >> 6) & 3) + $seed) % 6;
            my $idx1 = ($dgst[2 * $i] >> 2) & 15;
            my $idx2 = (($dgst[2 * $i] & 3) + $seed / 6) % 6;
            $retval .= $VOWELS[$idx0] . $CONSONANTS[$idx1] . $VOWELS[$idx2];
            if ($i+1 < $rounds) {
                my $idx3 = ($dgst[2 * $i + 1] >> 4) & 15;
                my $idx4 = $dgst[2 * $i + 1] & 15;
                $retval .= $CONSONANTS[$idx3] . '-' . $CONSONANTS[$idx4];
                $seed = ($seed * 5 + $dgst[2 * $i] * 7 +
                        $dgst[2 * $i + 1]) % 36;
            }
        }
        else {
            my $idx0 = $seed % 6;
            my $idx1 = 16;
            my $idx2 = $seed / 6;
            $retval .= $VOWELS[$idx0] . $CONSONANTS[$idx1] . $VOWELS[$idx2];
        }
    }
    $retval .= 'x';
    $retval;
}
)

cpan =: verb define
	dgst =.  a. i. y
	dlen =.  #y
	seed =.  1
	rounds =. <. (dlen % 2) + 1
	retval =. 'x'
	for_i. i. rounds do.
		if. ((i+1)<rounds) +. (2 | dlen)  do.
			idx0 =. 6 | (((di=.dgst{~+:i) rshift 6) and 3) + seed
			idx1 =. (di rshift 2) and 15  NB. !
			idx2 =. 6 | (di and 3) + <.seed%6
			retval =. retval , (idx0{V) , (idx1{Co) , idx2{V
			if. ((i+1)<rounds) do.
				idx3 =. ((dii=.dgst{~1++:i) rshift 4) and 15  NB.!
				idx4 =. dii and 15
				retval =. retval , (idx3{Co) , '-' , idx4{Co
				seed =. 36 | (seed * 5) + (di * 7) + dii
			end.
		else.
			idx0 =. 6 | seed 
			idx1 =. 16
			idx2 =. seed % 6
			retval =. retval , (idx0{V) , (idx1{Co) , idx2{V
		end.
	end.

	retval =. retval , 'x'
	retval
)


NB. (#:&.> ,. <"_1@:#:) i.2^#_2 ]\ ;: 'file noun stop go silent display'