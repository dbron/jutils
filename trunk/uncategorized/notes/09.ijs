LUNCHCALCULATOR							=: noun define
pc lunchcalculator dialog;pn "Lunch Participation Calculator";
xywh 5 8 50 12;cc label static rightscale;cn "Participant:";
xywh 5 21 50 50;cc ParticipantName combodrop ws_vscroll cbs_sort rightscale;
xywh 73 8 50 12;cc label static leftscale rightscale;cn "Prices:";
xywh 73 21 104 11;cc ParticipantPrices edit ws_border es_autohscroll leftscale rightmove;
xywh 181 20 34 11;cc AddParticipant button leftmove rightmove;cn "Add";
xywh 5 37 210 130;cc Orders editm ws_border es_autovscroll rightmove bottommove;
xywh 5 172 36 10;cc label static topmove bottommove;cn "Quoted Price:";
xywh 43 172 60 11;cc QuotedPrice edit ws_border es_autohscroll topmove rightscale bottommove;
xywh 111 172 10 10;cc label static ss_right leftscale topmove rightscale bottommove;cn "Tip:";
xywh 122 171 93 11;cc Tip edit ws_border es_autohscroll leftscale topmove rightmove bottommove;
xywh 6 188 209 15;cc label static topmove rightscale bottommove;cn "The following payments must be made by the participants:";
xywh 5 204 210 69;cc results editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly topmove rightmove bottommove;
xywh 7 276 34 12;cc ok button topmove bottommove;cn "OK";
xywh 182 276 34 12;cc cancel button leftmove topmove rightmove bottommove;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)

lunchcalculator_run						=:  verb define
	wd LUNCHCALCULATOR

	NB. initialize form here
	initializeParticipantNames''
	
	NB.  The Tip is defaulted to 0, but all other information has to be entered	
	wd 'set Tip 0'
	wd 'pshow;'
)

lunchcalculator_ParticipantName_button	=:  verb define
	NB.  Make keyboard navigation easy:  When the user pressews enter in the name field,
	NB.  move focus to the price list field.
	wd'setfocus ParticipantPrices'
)

lunchcalculator_ParticipantPrices_button=:  verb define
	NB.  Make keyboard navigation easy:  When the user pressews enter in the price list field,
	NB.  press the 'add participant' button for him
	lunchcalculator_AddParticipant_button''
)

lunchcalculator_AddParticipant_button	=:  verb define
	NB.  Make sure we have both a participant name, and a valid list of prices.
	if. (prices =. 0 -.~ 0 ". ParticipantPrices -. ',$') *.&:(*@:#) trim ParticipantName do.
		NB.  Update list of participants and prices
		NB.  but make no one appears in the list of participants more than once.
		NB.  If this participant is already on the list, just update his row.
		orders =. getOrders ''
		wd 'set Orders *', ; ('=';LF) ,~&.>"1 (/: uc@:-.&(' ',TAB)&.>) (orders ,~ participantName , < ": prices) #~ ~: ({."1 orders) ,~ participantName =. < trim ParticipantName
		
		NB.  Clear participant name and prices fields
		initializeParticipantNames''
		wd 'set ParticipantPrices *'
		
		NB.  And return focus to the beginning of the form
		wd'setfocus ParticipantName'
	else.
	
		NB.  If the data entered is invalid, inform the user, and set focus to the problematic field.
		wdinfo 'Lunch Participation Calculation Error';'Please enter the name of a participant and the prices of each of the items he ordered, as a list of numbers seperated by spaces.'

		if. 0 = # prices do.
			wd 'setselect ParticipantPrices'
			wd 'setfocus ParticipantPrices'
		else.
			wd 'setfocus ParticipantName'
		end.
	end.

	i. 0 0
)

lunchcalculator_QuotedPrice_button	=:  verb define
	NB.  Make keyboard navigation easy:  When the user pressews enter in the quote field,
	NB.  move focus to the tip field.
	wd'setselect Tip'	
	wd'setfocus Tip'
)

lunchcalculator_Tip_button				=: verb define
	NB.  Make keyboard navigation easy:  When the user pressews enter in the tip field,
	NB.  press the 'OK' button for him
	lunchcalculator_ok_button''
)


lunchcalculator_ok_button				=:  verb define
NB.  TODO:
NB.		0)  Ensure that names aren't empty
NB.		1)  Ensure that price lists aren't empty, sum to zero, or contain zeros or negatives, and doubles (i.e. no strange J constants allowed).
NB.		2)  Ensure that total > +/ prices (i.e. payments can't be negative).

	NB.  Verify all input data and perform the calculation.
	NB.  If the data entered is invalid, inform the user, and set focus to the problematic field.
	orders =. getOrders''

	NB.  The table should be Nx2 (which means it's rank 2 and the last element of its shape is 2),
	NB.  and it has to have at least one entry.
	if. (0&~:@:{. *. # *.&:(=&2) {:) $ orders do.

		NB.  The values in the tip & quote fields should be numeric.
		numericFields =.  ;: 'QuotedPrice Tip'
		if. -. 1 e. , numericFieldProblemMatrix =. (__;a:) e.~"0 1 numericValues =. __ (". -.&'$'@:".)&.> numericFields do.
			wd 'set results *', calculateParticipations numericValues ;~  ({. ,: [: 0&". each {:)&.:|: getOrders ''
		else.
		NB.  If the data in the Tip or quote fields is not numeric, inform the user, and set focus to the problematic field.
			'problemField problemType' =. (numericFields;<'must be numeric';'cannot be empty') {::~&.> |. ($ #: i.&1@:,) numericFieldProblemMatrix
			wdinfo 'Lunch Participation Calculation Error';'The value of the "' , ((uc@:{. , }.) problemField) , '" field ' , problemType, '.'
			wd 'setselect ', problemField 
			wd 'setfocus ' , problemField 
		end.
	else.
	NB.  The shape of the orders table is wrong.
	
		NB.  Usually, this is because there is no data in the Orders field;  it could also be due to user-editing but that's is unusual
		problemField =. (;: 'ParticipantName Orders') {::~ emptyOrders =. 0 ~: # Orders
		wdinfo 'Lunch Participation Calculation Error'; emptyOrders {:: 'Please enter some participation information.';'The list of participants and prices is mal-formed.  Please correct it.'

		NB.  Focus the problematic field
		wd 'setfocus ' , problemField 

		NB.  Can't set selection in a combo box for some reason, so 
		NB.  only do the selection if the problem is in the Orders field.
		wd^:(emptyOrders) 'setselect ', problemField 
	end.
)


lunchcalculator_cancel_button	=:  lunchcalculator_cancel	=:  lunchcalculator_close	=:  verb define
	wd'pclose'
)


initializeParticipantNames				=: verb define
	NB.  For the user's convenience, a list of all the people who have participated
	NB.  in lunch group before
	wd 'set ParticipantName ',KNOWN_PARTICIPANTS
)


NB.  We should update this every time a new name is added.
KNOWN_PARTICIPANTS						=: ; ,&LF@:('"'&envelope)@:trim each LF arbCut noun define
	Daniel Bron
	Richard Saracino
	Richard Newton
	Richard Meyer
	Damon Perry
	Brian Egge
	Jeff Sargent
	Al Picolli
	Shawn Hunt
)

getOrders								=: verb define
	NB.  Get the table of participant-name and price list.
	NB.  Artificially coerce the results into the proper shape.
	(#~ a:&~:@:({."1)) ($~ -:@# , 2:) }:^:(2&|@:#) , trim each (LF;'=') multiCut Orders
)

calculateParticipations					=: verb define
	'names orders'	=. <"1 |: > {. y
	'quote tip'		=. }. y
	total			=.  quote + tip
	results			=.  <@:,&LF@:trim"1 names (,.&TAB@:>@:[ ,. [: rjust ('$'&,)@:(0j2&":)"0@:]) payments =. 0.25 round total * ((%~ +/)~&>  +/@:;) orders
	; results [`,@.(0 < | difference) <' on this deal (because payments are rounded to the nearest quarter).' ,~ 'The lunch coordinator ' , ((;: 'made lost') {::~ difference > 0) , ' $', ":, | difference =. total - +/ payments
)

lunchcalculator_run''