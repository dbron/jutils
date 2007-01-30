readdbf =: (verb define) :: _1:
	hdr              =. 1!:11 y;0 32
	number_of_records=.  (4 $ #a.) #. |. a. i. hdr {~ 4 + i. 4
	position_of_first_record =. (2 $ #a.) #. |. a. i. hdr {~ 8 + i. 2
	length_of_record =.  (2 $ #a.) #. |. a. i. hdr {~ 10 + i. 2
	
	number_of_fields =.  (position_of_first_record  - 33)%32  NB.(257 - 33)%32  

	NB. number_of_records,position_of_first_record,length_of_record

	data             =.  (number_of_records,length_of_record)$ 1!:11 y;position_of_first_record, (number_of_records * length_of_record)

	subrecord_length =.  subrecord_offset =. 32
	field_meta_data  =.  (number_of_fields, subrecord_length ) $ 1!:11 y;subrecord_offset,(position_of_first_record-1)

	field_data_type  =.  11 {"1 field_meta_data
	field_length     =.  a. i. 16 {"1 field_meta_data
	field_decimals   =.  a. i. 17 {"1 field_meta_data
	field_offset     =.  +/\ field_length
	field_names      =.  (i.10) {"1 field_meta_data 

    table			 =.  data  ((0 1 1 0 { <`([: < _9876543x&([ [^:(0: = #@:]) ". )"1)) {~ 'CDN' i. field_data_type);.2~ '';	field_offset     e.~ i. length_of_record

	table ,&:<~ field_data_type ; field_length  ; field_decimals  ; field_offset ; field_names
)

dbf2mat =: (verb define)
	'col dat'=.readdbf y
	if. col -: dat do.  NB.  if readdbf only returned one datum, then it's an error, and we should propogate it
		dat return.  
	end.

	'type length decimals offset names'=.col
	((<@:{.~ i.&(0{a.))"1 > names) , > {. , ,.&.>/ <"_1&.> dat
)