NB.  ===========  DEPENDENCY SECTION  =========== 

        NB.     'strings' is for 'deb'
        NB.     'winapi'  is for 'win32api'
        NB.     'jmf'     is for  mapped files
        require 'strings winapi jmf'


NB.  ===========    UTILITY SECTION   =========== 

        NB.  These are the elements I'm usually interested in from a.
        QUOTE                      =:  ''''	
        UCALPHA                    =:  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        LCALPHA                    =:  'abcdefghijklmnopqrstuvwxyz'
        ALPHA                      =:  LCALPHA,UCALPHA
        DIGITS                     =:  '0123456789'
        ALPHANUM                   =:  ALPHA,DIGITS
        WHITESPACE                 =:  ' ', TAB, CR, LF
        PRINTABLE                  =:  WHITESPACE , a. {~ 33 ([ + i.@:>:@:-~) 126


        NB.  Wrap in parenetheses.  EG:  parenclose 'Hi there' NB.  Returns '(Hi there)'
        parenclose                 =:  '('&,@:,&')'

        NB.  Split a filename into directory;filename.
        NB.  EG:  splitPath 'c:\temp\test.txt' NB.  Returns 'c:\temp\';'test.txt'
        splitPath                  =: (({. ,&< }.)~ # <. >:@:i:&PATHSEP_j_)

        NB.  Cut on an arbitrary-length fret.
        NB.  EG:  ' hello ' arbCut 'hi hello how hello are hello you hello today' NB.  Returns ;: 'hi how are you today'
        ac                         =:  [ (E. <;.1 ]) ,
        arbCut                     =:  <@:#@:[ }.&.> ac f.

        NB.  Another translate conjuction, only for scalars.  Repalce the scalar LHA to the conjunction with the scalar RHA to the conjunction.
        NB.  EG.  0 scalarReplace _1 ] 5 8 0 0 5 6 0 3 0 4  NB. Returns 5 8 _1 _1 5 6 _1 3 _1 4
        NB.  scalarReplace      =: 2 : '(m.&=)`(,:&n.) } y.'
        sr                         =:  2 : '(m.&=)`(,:&n.) } y.' NB.  (&=)`(,:&) }
        s                          =:  2 : ('(m. sr n.) :. (n. sr m.)')

        NB.  Tests if the end of the RHA matches the LHA.  It ravels the LHA argument if it's a scalar.
        isSuffix                   =:  ,^:(0: -: #@:$)@:[ -: ({.~ -@:#)~

        NB.  Drops the LHA from the end of the RHA iff the RHA ends with the LHA.
        dropSuffix                 =:  (}.~ -@:#)~^:isSuffix

        NB.  Make a name-value pair table from a LF-and-'=' delimited noun.
        NB.  The characters preceding the first '=' on each line become the name
        NB.  and the characters trailing the same are executed to produce the value.
        makeParamTable             =:  ((deb@:{. ,&:< ".@:}.@}.)~ i.&'=')&>@:(LF&arbCut)@:(TAB sr ' ')@:}:


        NB.  Cover adverb to string-related win32api functions.
        NB.  Just tacks the buffer onto the end of the argument list, then picks it out of the results
        NB.  and trims it.
        NB.  EG:  'GetTempFileNameA' winapiAsString ''
        winapiAsString             =.  1 : '({.~ i.&(0 { a.))@:>@:{:@:(m. win32api)@:,&(<255 # '' '')@:boxopen'
  
        NB.  Creates a temporary file, with the prefix given as the argument.
        NB.! Note that this call actually creates the file.
        NB.  EG:  getTemporaryFile 'OMSDBUPLOAD_'  NB.  Creates a .tmp file in the user's temp direcotry whose name starts with 'OMSDBUPLOAD_'.
        NB.       getTemporaryFile ''            NB.  No user-specified prefix
        getTemporaryFile           =:  'GetTempFileNameA' winapiAsString@:(('GetTempPathA' winapiAsString 255)&;)@:;&0  f.


NB.  ===========     LOGIC SECTION    =========== 

        NB.  Box the input iff it's not boxed and it's not null.  This way it's convenient to pass in one parameter, or
        NB.  none, just allowing all the defaults to take effect.
        normalizeInput             =.  <^:(# 2 b.&* L.)
        NB.
        NB.  Determines if the input's rank is at least 2.  That is, if it's 'less than' a table.
        isList                     =.  2&>@:#@:$@:]
        NB.
        NB.  Stiches on the first N parameter names to the input list (where N = # list),  allowing the user to pass in a
        NB.  list of parameters without names so long as they're in the correct order (the correct order is as defined by
        NB.  the default parameters).
        paramListToTable           =.  ([: ({."1@:[ ,. ,@:])&>/ <.&# {.&.> ,&<)^:isList
        NB.
        NB.  Appends the default param name/value pairs onto the end of the parameter table
        NB.  with booleans indicating the source map (0=left, 1=right).
        appendDefaults             =.  (paramListToTable ,&:>/@:(,&:<  (,.&.> <^:2">) 0 1"_)  [)
        NB.
        NB.  For convenience, normalizeNames lowercases and removes spaces, dashes, and underscores from parameter names.
        NB.  This is so that, for example, 'someParameter', 'Some Parameter', 'some-parameter', 'SOME_PARAMETER' are
        NB.  treated equivalently.  Doing this may result in name conflicts.  Note that the names defined, in the end,
        NB.  are in the same format as specified by the default parameter table.
        NB.! Make combineMaps an adverb with this verb as the parameter (or maybe a conjunction with a handle-missing-names-verb as the other parameter)
        normalizeNames             =.  3 : 'tolower y.'@:-.&' _-'&.>@:({."1)
        NB.
        NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
        NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to
        NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
        NB.  access).
        combineMaps                =:  ([ ({."1@:[ ,. i.~&normalizeNames { }."1@:]) (appendDefaults normalizeInput)) f.

        NB.  Give a dyad's x. lexical closure.
        lexicalClosureOnRHA        =:  conjunction define
                NB.  Get a temp file to map
                tmp                =.  getTemporaryFile , 'j'

                NB.  Calculate the noun's name from the temp file's
                nm                 =.  (#~ e.&ALPHANUM) > {: splitPath tmp

                NB.  Create the mapping (ensure we have some room for growth).
                createjmf_jmf_ tmp ; 50 * # 3!:1 n.

                NB.  Map the noun
                map_jmf_ nm;tmp

                NB.  Fill it with data
                (nm)               =:  n.

                NB.  Get a local reference
                localname          =.  nm~

                NB.  Remove the global name -- we want this data to have lexical scope.
                erase nm
  
                NB.  We're given a dyad.  When this dyad is called monadically, our lexically-scoped data
                NB.  will be passed in as x.
                (localname & $:) : u.
)

        defineAndDefaultParams     =:  conjunction define
        NB.  The input to this conjunction is a noun RHA and a explicit monadic verb LHA.
        NB.  The noun RHA is a 2xN table of boxes, specifying a default parameter table.
        NB.     
        NB.  The output of this conjunction will be a derived monadic verb that can be called
        NB.  with a parameter table, where the elements of column 0 are the names of the
        NB.  parameters and the elements of column 1 are  the values of the parameters.  The
        NB.  parameters are then defined as local names (assigned to their respective values)
        NB.  which the explicit verb can reference at its convenience.  
        NB.
        NB.  Further, a second set of names is defined, the same as the first with 
        NB.  '_is_default' appended to each name.  These names are booleans indicating
        NB.  whether the corresponding parameter came from the default table or was
        NB.  specified by the caller.
        NB.
        NB.  For the caller's convenience, instead of passing in a 2xN parameter table, it
        NB.  may use a list of boxes.  These values will be assigned to the first (#y.) names
        NB.  in the default parameter table.  If the caller passes in an unboxed value, that
        NB.  value will be assigned to the first name in the default parameter table, unless
        NB.  that value is null (0-:#,y.), in which case the default parameter table will be
        NB.  used in its entirety, with no caller-defined values.

                if. # verbBody     =. {: |: (1) 5!:7 {.;: 'u.' do.
                NB.  If this is an explicit monadic verb, then redefine it appropriately.

                        NB.  This version of defineAndDefaultParams provides 'closures'
                        NB.  However, the use may want to preserve value of some names, but not others.
                        NB.  To this end, allow him to mark parameter names with a flag indicating their state
                        NB.  is to be preserved across calls.
                        preservationFlag     =.  ,'*' NB.  If the name ends with a star, preserve its value.
                        flagAsString         =.  parenclose 5!:5 {. ;:'preservationFlag'
                        checkFlags           =.  flagAsString , '&isSuffix'
                        dropFlags            =.  flagAsString , '&dropSuffix'

                        NB.  If two parameters have the same name, use the first one, but only allow defineable names (names specified in
                        NB.  the default table).  This allows the user's parameters to over-ride the defaults, without allowing him to
                        NB.  define names the function isn't expecting (which could possibly over-ride global names the function needs to
                        NB.  access).
                        createParameterTable =.  combineMaps f.
                        cptAsString          =.  parenclose 5!:5 {. ;: 'createParameterTable'

                        NB.  We will add these lines to the top of u., thereby redefining it.

                        NB.  Apply createParameterTable to y. (the input to u.)
                        header               =.  'y. =. x.' , cptAsString , ' y.'      

                        NB.  Define some local names from the parameter table we just created.
                        NB. newHeading              =.  newHeading , CRLF , 'NB.  From the parameter name/value input table, define local names from column 0 to values from column 1'
                        header               =.  header ; '(, (,. ,&''_is_default''&.>)', dropFlags , '&.> {."1 y.) =. , }."1 y.'

                        NB.  We will add these lines to the bottom of u., further redefining it.

                        NB.  Preserve the user's original output.
                        NB.!  This only works in the case that the last line of the function provides the
                        NB.!  output of the function.  There are MANY cases where this is not true.
                        trailer              =.  'y. =. ' &,&.> {: verbBody

                        NB.  Save state of flagged names.  We'll have closure over x., so the assignment to it preserves state across calls.
                        trailer              =.  trailer , < 'x. =. }:"1 x. ' , cptAsString , ' (,. ".@:(' , dropFlags , ')&.>)~  (#~ ' , checkFlags , '&>) {."1 x.'

                        NB.  Return user's expected output (but see NB.! above).
                        trailer              =.  trailer , < 'y.' 

                        NB.  Return re-defined function.
                        NB.!  Should really only use lexicalClosureOnRHA in the case that we have at least one flagged name.
                        (4 : (header , (}: verbBody) , trailer)) lexicalClosureOnRHA n.
                else.
                NB.  If u. isn't an explicit monadic verb, don't do anything to it.
                        u.
                end.
)



NB.  ===========     EXAMPLE SECTION    =========== 

        NB.  Define a parameterized verb.  A noun-define is used to create the default parameter table,
        NB.  to enhance readability.
        parameterizedVerb          =:  (verb define) defineAndDefaultParams (makeParamTable noun define)
                filename    = 'c:\short.log'
                max         = 42
                color       = 'red'
                increment*  = 0  NB.  This is flagged, so its state is preserved across calls.
)
                smoutput LF,'======='
                smoutput 'This is ordinal call #',":increment =. >: increment
        
                smoutput 'Logging to:  ', filename
                smoutput 'Max is:  '  , ": max  NB.  Note the format;  we're expecting this parameter to be numeric (but this is not checked).
        
                if. color_is_default do.
                        smoutput 'My favorite color is ',color
                else.
                        smoutput 'Your favorite color is ',color
                end.
        
                smoutput '======='
)
        
        NB.  Use all the defaults
        parameterizedVerb ''
        
        NB.  Change the first parameter (filename).
        parameterizedVerb '\\server\share\app_logs\myapp.log'
        
        NB.  Change the first two parameters (filename & max)
        parameterizedVerb '\\server\share\app_logs\myapp.log';906
        
        NB.  Change the specified parameter (color)
        parameterizedVerb _2 ]\ ;: 'color blue'
        
        NB.  Ditto - names are normalized before testing for equivalence (see normalizeNames, which can be changed to suit your needs).
        parameterizedVerb _2 ]\ ;: 'COLOR blue'
        
        NB.  Supply new default parameter table.
        NB.  This will turn off the closure of x.
        stringToTabl                     =.  (0&".`]@.(__&e.@:(__&".))&.>)@:(_2&(]\))@:(<;._1)
        ' filename f:\output.log max 999 color verdigris increment 0'  parameterizedVerb&:stringToTabl ' max 10000'