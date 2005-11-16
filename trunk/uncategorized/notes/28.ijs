arbCutNoParens		=:  <@:#@:[ }.&.> [ ((E. *. 0&=@:parenDepth@:]) <;.1 ]) ,
multiCutNoParens	=:  arbCutNoParens &>/@:(<"_1^:(L. = 0:)@:|.@:[ , <@:])
keepBetween			=:  ] #~ (0&~:@:(+/\@:(-/)) -.@:+: {:)@:(E.&> boxopen)

COLUMNS				=:  2 {. }: |: trim each ', ' multiCutNoParens ('NOT NULL';'NOT_NULL') replace trim CRLF -.~ (({.~ i:&')')@:}.~ >:@:i.&'(') ; {: 'TABLE_NAME TABLE_DEF' =: 'CREATE TABLE' arbCut noun define
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Report_Parameter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Report_Parameter]
GO

CREATE TABLE [dbo].[Report_Parameter] (
	[report_parameter_id] [int] IDENTITY (1, 1) NOT NULL ,
	[short_name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[long_name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[report_id] [int] NOT NULL ,
	[type] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[is_optional] [bit] NOT NULL ,
	[formal_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[display_name] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[short_description] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[validation_regex] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[sql_expression] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[selectable_field] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
GO
)


TABLE_NAME			=:  uc@:}.@:}:@:(}.~ i:&'[') '[]' keepBetween TABLE_NAME

ROWS				=:  makeTable noun define
3	effdate	effective_date	1	Date	0	EffectiveDate	Effective Date	Date for which the currency rates are desired.		Nada	Nada
4	after	after_date	7	Date	0	AfterDate	After Date	Date for after which you want currency rates.		Nada	Nada
5	curr	currency_name	7	Enum	0	curr	Currency Name	Currency of which you want the history.		select * from currency	short_name
)

SCRIPT				=:  }: doString noun define
SET IDENTITY_INSERT $TABLE_NAME$ ON
INSERT INTO $TABLE_NAME$ ($', ' join {. COLUMNS$)
$_2 }. ; }: , (<'UNION',CRLF) ,.~ CRLF <@,"1~ 'SELECT ' ,"1 ', ' join"1 ROWS (#&QUOTE@:] envelope [)&.>"1 (1&e.@:(('char')&E.)&>@:{:) COLUMNS$
SET IDENTITY_INSERT $TABLE_NAME$ OFF
------------------------------------
)

smoutput SCRIPT