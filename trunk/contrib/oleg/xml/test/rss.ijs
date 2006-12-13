NB. using element character content
NB. selective processing based on element hierarchy position

require '~addons/xml/sax.ijs format'

saxclass 'prss'

startDocument=: 3 : 0
  S=: ''
)

startElement=: 4 : 0
  S=: S,<y
  if. y-:'item' do. smoutput '' end.
)

endElement=: 3 : 0
  S=: }:S
)

characters=: 3 : 0
  s2=. _2{.S
  if. s2-:;:'channel title'       do. smoutput 'Channel: ',y elseif.
      s2-:;:'channel description' do. smoutput fold y elseif.
      s2-:;:'channel pubDate'     do. smoutput 'Date: ',y elseif.
      s2-:;:'item title'          do. smoutput 'Topic: ',y elseif.
      s2-:;:'item description'    do. smoutput fold y elseif.
      s2-:;:'item link'           do. smoutput 'URL: ',y end.
)

NB. =========================================================
cocurrent 'base'

TEST3=: 0 : 0
<channel><title>qq</title><pubDate>1/1/2006</pubDate></channel>
)

0 : 0  NB. Test
process_prss_ TEST3
process_prss_ fread jpath '~addons/xml/test/cnn.rss'
)
