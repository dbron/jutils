   IFCONSOLE_z_ =.  IFCONSOLE_z_"_ :: (0 -: (11!:0) :: 0:) ''
   IFUNIX_z_    =.  5 -: 9!:12''
   9!:7^:IFCONSOLE '+++++++++|-'

   init         =.  _&;

   failsafe     =.  :: err =. [: (13!:11 ,&:< 13!:12) ''"_
   
   Read         =.  1!:1@:1:


   StdOrErr     =.     2: + IFUNIX * 5 - e.&0 _                 NB.  Windows: always use 2.  Unix: 4 if standard, 5 if error.
   Print        =.  [  (1!:2 StdOrErr)~&>/
   Loop         =.  (^:(_ -: >@:{.)) (^:_)                      NB.  Could replace _ with a: to accumulate all input lines
   
   ReadPrint    =.  Read :. Print                               
   
   R_PL         =:  failsafe (&.: ReadPrint) Loop failsafe (@:init)
   R_PL         =:  'R_PL' f.
   NB.   R_PL   =:  ( :: err) (&.: (1!:1@:1: :. ([(1!:2 (IFCONSOLE =: 0 -: (11!:0) :: 0: '') { 2,  5: - e.&0 _)~&>/))) (^:(_ -: >@:{.)) (^:_) ( :: err =. [: (13!:11 ,&:< 13!:12) ''"_) (@: (_&;) ) 
   
   r_pl         =:  1 : '3 : (''9!:29[1[9!:27            ''''('', (5!:5{.;:''u'') , '')R_PL '''',5!:5{.;:''''y'''''')'
   r_plx        =:  1 : '3 : (''9!:29[1[9!:27 ''''2!:55 > {. ('', (5!:5{.;:''u'') , '')R_PL '''',5!:5{.;:''''y'''''')'
   NB.  r_plx is like r_pl but exits J at the end.



