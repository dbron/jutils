NB.  File:  commandlineparser.ijs
NB.  Desc:  Contains utilities for parsing and querying the command line.
NB.  Auth:  Daniel Bron
NB.  Date:  06-Jun-2002 (Wed)
NB.  Exposes:
NB.     commandLineParser:  Monadic verb to parse command-line-formatted strings.
NB.     commandLine      :  Structured noun representing the option-parameter sets from the command line.
NB.     getOption        :  Monadic verb for querying command line options

NB.  The fret characters in the command line are slash ('/'), double-quote ('"') and space (' '). For parsing
NB.  purposes, slash has precedence over double-quote, and double-quote has precedence over space. That means
NB.  quotes can safely contain spaces, but not slashes.  There is no way to "escape" the special characters.
NB.  For example, neither "\"" nor "\/" will work.

NB.  The command line has option-parameter sets.  Each option name is preceded by a slash and suceeded by a
NB.  space or double-quote.  Option names can be of any length, but cannot contain spaces or double-quotes.
NB.  The parameters for each option are all values on the command line from the first space or double-quote
NB.  following the option name up the slash preceding the next option name or the end of the command line
NB.  (exclusive).  Values are seperated by spaces or double-quotes.  Spaces within double quotes (e.g. in
NB.  file names) are preserved.

NB.  The noun commandLine has the following format:  It is a (N+1) by 2 table of boxes, where N is the number of
NB.  named options passed on the command line.  Each row of commandLine represents an option-parameter set.  The
NB.  first box in each row contains the name of the option (without leading slash or trailing space), and the
NB.  second box contains a list of boxes containing the parameters for that option. The quotes are removed from
NB.  quoted parameter values.

NB.  The parameters of the empty option (the option whose name is null, usually the first row of commandLine)
NB.  contains all the values that preceded the first option.  These are usually the most important parameters.
NB.  Because of the way J passes its command line, the first value in this parameter list is the name of the
NB.  script J loaded when it was invoked.  That is, it is the name of your script (program).

NB.  The monad getOption takes either a string or a list of boxes. If it is given a string, it will return the
NB.  parameters (a list of boxes) for the option named in the string. If given a list of boxes, it will return
NB.  a list of boxes of the same length, each box containing the parameter list (list of boxes) for the
NB.  corresponding option name in the input list. If getOption is given the name of an option that was not
NB.  specified on the command line, it will return '' for that option. Calling getOption on '' will return the
NB.  special leading parameters, the first of which is the name of your program (discussed above).

NB.  Example of use:
NB.  C:\J406>j.exe temp\myProgram.ijs importantParam1 importantParam2 /option1 value /option2 value1 "value 2" value3 /option3 "another value" "last value"
NB.  $ commandLine                                      NB.  Returns 4 2
NB.  myProgramName   =:  {. getOption ''                NB.  Returns <'temp\myProgram.ijs'
NB.  importantParams =:  }. getOption ''                NB.  Returns 'importantParam1';'importantParam2'
NB.  anOption        =:  getOption 'option1'            NB.  Returns ,<'value'
NB.  moreOptions     =:  getOption 'option2';'option3'  NB.  Returns (<'value1';'value 2';'value3'),<'another value';'last value'
NB.  notThere        =:  getOption 'nonExistantOption'  NB.  Returns ''

findQuotes        =.  '"'&=
oddIndicies       =.  (#~ 2: | i.@:#)@:bx
quoteClass        =.  (+/\ - oddIndicies 1:`[`] } 0: #~ #)@:findQuotes
quoteParser       =.  </.~ quoteClass

spaceParser       =.  ;@:(<;._2@:,&' '`(<@:}.@:}:)@.('"'&=@:{.)&.>)
optionCutter      =.  spaceParser@:quoteParser

removeEmpties     =.  -.&a:
optionParser      =.  removeEmpties@:optionCutter

optionSplitter    =.  (({. ,&< }.)~ <./@:i.&' "');._1@:('/'&,)

commandLineParser =:  ({. , optionParser each @:{:)"1@:}.@:optionSplitter@:('/ '&,) f.

commandLine       =:  commandLineParser wd 'qcmdline'

getOption         =:  (>@{.@:])^:(L.@:[ = 0:) (,&a:@:({:"1)@:] {~ <@,@[ i.~ {."1@:])&commandLine&>@:,@:boxopen