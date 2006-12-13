	   NB.  Some of my standard utilities (documentation not included).
	   sr                   =:  (&=)`(,:&) }  NB.  For J5, use 2 : '(m&=)`(,:&n) } y'
	   trim                 =:  #~ (+./\. *. +./\)@:(-.@:(e.&(9 32 { a.)))
	   beginsWith           =:  ,^:(0: -: #@:$)@:] -: ({.~ #)
	   arbCut               =:  <@:#@:[ }.&.> [ (E. <;.1 ]) ,
	   multiCut             =:  arbCut&>/@:(<"_1^:(L. = 0:)@:|.@:[ , <@:])

	   NB.  HTML table parsing code
	   prepareText          =:  -.&CRLF@:(TAB sr ' ')
	   tokenizeHTML         =:  -.&a:@:(trim&.>)@:('>'&arbCut)
	   removeTableTags      =:  }.@:}:
	   removeRowAndCellTags =:  (#~ -.) [: +./ (beginsWith&>"1 0)&(<;._1 '`<tr`<td')
	   makeHTMLManageable   =:  ;@:removeRowAndCellTags@:removeTableTags@:tokenizeHTML@:prepareText
	   parseManageableHTML  =:  (<;._1 '`</tr`</td')&multiCut
	   parseHTMLTable       =:  (0&|:@:}:)^:(#@$)@:parseManageableHTML@:makeHTMLManageable

	   TABLE =: 0 : 0
	      <table>
	        <tr>
	          <td>0 0</td>
	          <td>0 1</td>
	          <td>0 2</td>
	          <td>0 3</td>
	          <td>0 4</td>
	        </tr>
	        <tr>
	          <td>1 0</td>
	          <td>1 1</td>
	          <td>1 2</td>
	          <td>1 3</td>
	          <td>1 4</td>
	        </tr>
	        <tr>
	          <td>2 0</td>
	          <td>2 1</td>
	          <td>2 2</td>
	          <td>2 3</td>
	          <td>2 4</td>
	        </tr>
	        <tr>
	          <td>3 0</td>
	          <td>3 1</td>
	          <td>3 2</td>
	          <td>3 3</td>
	          <td>3 4</td>
	        </tr>
	        <tr>
	          <td>4 0</td>
	          <td>4 1</td>
	          <td>4 2</td>
	          <td>4 3</td>
	          <td>4 4</td>
	        </tr>
	      </table>
)

	   parseHTMLTable TABLE
