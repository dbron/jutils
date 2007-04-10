require 'csv'
0!:010 <'c:\app\j\current\user\uncategorized\danutils.ijs'

   'A B'=.<"_1 psql toJ fread 'C:\projects\rma_data_dump\edvisors.2006-08-01.rpt'
   'C:\projects\rma_data_dump\edvisors.2006-08-01.csv' writecsv~ A,>,.&.>/ trim L: 0 <"_1 each B
