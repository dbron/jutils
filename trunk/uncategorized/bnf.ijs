BNF_SPEC=:noun define
	syntax       ::=  { rule }
	rule         ::=  identifier  "::="  expression
	expression   ::=  term { "|" term }
	term         ::=  factor { factor }
	factor       ::=  identifier     |
	                   quoted_symbol |
	                "("  expression  ")" |
	                "["  expression  "]" |
	                "{"  expression  "}"
	identifier    ::=  letter { letter | digit }
	quoted_symbol ::= """ { any_character } """
)

BNF_Whole_Number =: noun define
  S  := '-' FN |
        FN
  FN := DL |
        DL '.' DL
  DL := D |
        D DL
  D  := '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
)

EBNF_Floating_Number =: noun define
floatnumber:    pointfloat | exponentfloat
pointfloat:     [intpart] fraction | intpart "."
exponentfloat:  (nonzerodigit digit* | pointfloat) exponent
intpart:        nonzerodigit digit* | "0"
fraction:       "." digit+
exponent:       ("e"|"E") ["+"|"-"] digit+
)


NB.  I would like to implement BNF parsing using dyadic ;:.
NB.  A simple first example would be numeric constant validation,
NB.  using the BNF_Whole_Number definition.