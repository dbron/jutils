require 'jserver'
js=.conew'jserver'
local__js''   
run__js;._2 noun define
	d =: 50000$'foobar'                        NB.  Anything >: 50000
	state_jeval_ =: (,.5!:1)4!:1 i.4
    4 :('(x)=:y(5!:0)';'0')/"1 state_jeval_    NB.  jep crashes here
)