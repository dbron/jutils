NB.  File:  commandlineparser.ijs
NB.  Desc:  Contains utilities for parsing and querying the command line.
NB.  Auth:  Daniel Bron
NB.  Date:  06-Jun-2002 (Wed)
NB.  Exposes:
NB.     getCommandLine      Monadic verb that returns the command line exactly as the OS knows it.  Input ignored.
NB.     commandLineParser:  Monadic verb to parse command-line-formatted strings.
NB.     commandLine      :  Structured noun representing the option-paramet.er sets from the command line.
NB.     getOption        :  Monadic verb for querying command line options
NB.     getParam            Cover for getOption, useful if expecting only one argument for an option.

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

NB.  The noun commandLine has the following format:  It is a (N+1) by 2 table of boxes, where N is the number
NB.  of named options passed on the command line.  Each row of commandLine represents an option-parameter
NB.  set.  The first box in each row contains the name of the option (without leading slash or trailing
NB.  space), and the second box contains a list of boxes containing the parameters for that option. The
NB.  quotes are removed from quoted parameter values.

NB.  The parameters of the empty option (the option whose name is null, usually the first row of commandLine)
NB.  contains all the values that preceded the first option.  These are usually the most important
NB.  parameters.  Because of the way the API call works, the first value in this parameter list is the name of
NB.  the J executable, and the second is the script J loaded when it was invoked.  That is, it is the name of
NB.  your script (program).

NB.  The monad getOption takes either a string or a list of boxes. If it is given a string, it will return
NB.  the parameters (a list of boxes) for the option named in the string. If given a list of boxes, it will
NB.  return a list of boxes of the same length, each box containing the parameter list (list of boxes) for
NB.  the corresponding option name in the input list. Calling getOption on '' will return the special leading
NB.  parameters, the first of which is the name of  your program (discussed above).

NB.  If getOption is given the name of an option that was not specified on the command line, it will return
NB.  a numeric 0 for that option.  Note that this is  distinct from the result of '' for an option that was
NB.  specified, but but not given any parameters.

NB.  Because it is possible to have different command line options represented by different cases of the same
NB.  character, getOption is case sensitive.

NB.  Example of use:
NB.  C:\J406\j.exe temp\myProgram.ijs importantParam1 importantParam2 /switch /option1 value /option2 value1 "value 2" value3 /option3 "another value" "last value"
NB.  $ commandLine                                      NB.  Returns 4 2
NB.  myCmdLn         =:  getCommandLine ''              NB.  Returns 'C:\J406\j.exe temp\myProgram.ijs importantParam1 importantParam2 /switch /option1 value /option2 value1 "value 2" value3 /option3 "another value" "last value"'
NB.  myProgramName   =:  {: 2 {. getOption ''           NB.  Returns <'temp\myProgram.ijs'
NB.  importantParams =:     2 }. getOption ''           NB.  Returns 'importantParam1';'importantParam2'
NB.  anOption        =:  getOption 'option1'            NB.  Returns ,<'value'
NB.  singleVal       =:  getParam 'option1'             NB.  Returns 'value'
NB.  moreOptions     =:  getOption 'option2';'option3'  NB.  Returns (<'value1';'value 2';'value3'),<'another value';'last value'
NB.  someSwitch      =:  # $ getOption 'switch'         NB.  Returns 1, would get same result from getParam
NB.  notThere        =:  # $ getOption 'op4'            NB.  Returns 0, would get same result from getParam

NB.  Note that this utility is obsoleted in J5+ (ARGV_z_ replaces it, and also allows double-quote escaping).

findQuotes        =.  '"'&=
oddIndicies       =.  (#~ 2: | i.@:#)@:bx
quoteClass        =.  (+/\ - oddIndicies 1:`[`] } 0: #~ #)@:findQuotes
quoteParser       =.  </.~ quoteClass

spaceParser       =.  ;@:(<;._2@:,&' '`(<@:}.@:}:)@.('"'&=@:{.)&.>)
optionCutter      =.  spaceParser@:quoteParser

removeEmpties     =.  -.&a:
optionParser      =.  removeEmpties@:optionCutter

NB.  Maybe a better way of cutting on quotes & spaces (i.e. a replacement for optionParser)?
NB.  (<@:-.&'"';._2~ (> ~:/\)/@:(="_ 0&' "'))@:,&' ' 'He said, "Hello there, how are you?", and I replied "Well, thank you."'  NB.  Returns <;._1 '|He|said,|Hello there, how are you?,|and|I|replied|Well, thank you.'

optionSplitter    =.  (({. ,&< }.)~ <./@:i.&' "');._1@:('/'&,)

cocurrent 'z'     [ returnTo_z_ =.  coname''

getCommandLine		=:  [: 15!:1@:,&0 _1@:> 'kernel32 GetCommandLineA *c'"_ (15!:0) ''"_
commandLineParser =:  ({. , optionParser each @:{:)"1@:}.@:optionSplitter@:('/ '&,) f.
commandLine       =:  commandLineParser getCommandLine ''
getOption         =:  ($:~ ". bind 'commandLine_z_') : (] >@{.@:]^:(L.@:[ = 0:) (((i.~ {."1)~ { ,&(<0)@:({:"1)@:[) ,@:boxopen))
getParam          =: ;^:(-.@:-:&0)@:getOption

cocurrent returnTo