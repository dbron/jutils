   NB. load '~user/contrib/burke/fixargs.ijs'
   NB. fixpath jpath '~addons/tara/'
   require '~addons/tara/tara.ijs'  
   xls  =.  'C:\Documents and Settings\dbron\My Documents\20061129 12b-1 account level analysis.xls'
   X    =:  ('X_',L:0 n) =: xls readexcel L: 0~ n=.":&.>2003+i.4