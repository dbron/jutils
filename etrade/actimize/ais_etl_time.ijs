require'dd'
SQL =: noun define dateToString"_ 1 ] 6 {."1 SPLOO=:]2007 03 07 (] + i.@:-)&.:(todayno :. todate)~ 2007 03 28 [ 3{.6!:0''
	select 
           datediff(minute, min(job_st_time), max(job_end_time)) 
    from 
		"actimize_etl"."etl_job_status" 
	where load_date='YYYY-MM-DD' 
)

   A =:  ddcon 'dsn=IQ_SHAHAB;uid=ACTIMIZE_ETL;pwd=ACTIMIZE_ETL'
   B =:  SQL ddsel"1 _  A
   C =:  ddfch_jdd_"1 B,._1
   D =: 3 : '". 3 : ''5!:5{.;: ''''y'''' '' {. ; , <@:, S: 0 y'"_1 C

RPT =: _2 }. ;,&CRLF&.> trim&.> (] ((__ = [) {"0 1 ] ,.&:(<"1) 'Unknown'"_) [: formatTimeSpan&> (60 * 1000) * ]) D

FOONS =: '\\Atlp1amlais1\C$\Program Files\BMC Software\CONTROL-M Agent\Default\SYSOUT'
E=:(fread&.> ([[fwrite&.>) (([ mkdir) dateToString 'C:\documents and settings\dbron\my documents\proj\actimize\YYYY-MM-DD\') , L: 0 {:@:splitPath&>) listFiles FOONS,'\*'




SNOOF =: 'C:\Documents and Settings\dbron\Desktop\ETCBO_ETC_bpsaLoadIqTables'

