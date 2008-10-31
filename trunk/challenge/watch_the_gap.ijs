NB.  Load standard libraries for HTTP and XML/XSLT
coinsert 'jsocket' [ load 'socket ~system\examples\socket\socklab.ijs xml/xslt'

NB.  Modify standard J web-fetching function, to accomodate rosettacode.org 
NB.  (which insists on a HTTP 1.0 and a HOST header, so modify standard wget function.)
wget =:[: toJ 0: 3 : ((;:',CR,LF')([:;:^:_1]#!.(<'@:(],~'' HTTP 1.0'',~^:([:-.]-:#@:]{.[)[)CR,LF,(''Host: '',>{.host),')~1 j.</\@:E.)L:1;:&.>;2 A.(<':');{:"1&.>(1 2)<@(5!:7)<ff=.'webget_z_') ]

NB.  Fetch lists of solutions by task and language
't j'=:'rosettacode.org/wiki/Category:' wget@,L:0 ;:'Puzzles Solutions_by_Programming_Task J'

/:~ @: , @: > @: (*/&.>/) @: ((^ i.@>:)&.>/) @: (__&q:)

NB.  XSLT to pull out interesting components of lists
EXTRACT_J2=:noun define
<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">
<xsl:output method="text" encoding="UTF-8" media-type="text/plain" />
<xsl:template match="/">
        <xsl:apply-templates select="//h:td/h:ul/h:li/h:a"/>
</xsl:template>

<xsl:template match="//h:td/h:ul/h:li/h:a">
    <xsl:value-of select="." />
    <xsl:text>&#10;</xsl:text>
</xsl:template>
</xsl:stylesheet>
)

EXTRACT_J2=:noun define
<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">
<xsl:output method="text" encoding="UTF-8" media-type="text/plain" />
<xsl:template match="/">
        <xsl:apply-templates select="//h:td/h:ul/h:li/h:a"/>
</xsl:template>

<xsl:template match="//h:td/h:ul/h:li/h:a"><!-- nothing --></xsl:template>
<xsl:template match="//h:td/h:ul/h:li/h:a[not(contains(@href,'Category'))]">
    <xsl:value-of select="." />
    <xsl:text>&#10;</xsl:text>
</xsl:template>
</xsl:stylesheet>
)

EXTRACT_J2=:noun define
<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">
<xsl:output method="text" encoding="UTF-8" media-type="text/plain" />
<xsl:template match="/">
        <xsl:apply-templates select="//h:table[/h:ul/h:li/h:a"/>
</xsl:template>

<xsl:template match="//h:td/h:ul/h:li/h:a"><!-- nothing --></xsl:template>
<xsl:template match="//h:td/h:ul/h:li/h:a[not(contains(@href,'Category'))]">
    <xsl:value-of select="." />
    <xsl:text>&#10;</xsl:text>
</xsl:template>
</xsl:stylesheet>
)


has=:<;._2 toJ EXTRACT_J2 xslt (}.~ 1 i.~ (LF,LF)&E.) toJ j

NB.  Exclude pages where Talk:Page has ==opt-out== / ===language=== / excuse
NB.  Sort by http://rosettacode.org/wiki/Special:Mostrevisions 

noun define
Generate a report which identifes the gaps in your language`s representation on RosettaCode.

Fetch Category:Solutions_by_Programming_Task, Category:Puzzles and Category:Your_Language. 
For the puzzles and tasks listed, take the difference of the latter from the union of the 
two former (that is, find out which tasks and puzzles which no one has posted a solution 
for in your language).

Partition this set into two groups: those tasks & puzzles for which someone needs to 
provide a solution in your language, and those which your language is inapplicable,
or has opted out for some other reason.  Determine this partition by the existence of a
== opt-out == / === your language === section on the talk page for that puzzle.

The entire report should be formatted in Wiki markup, and posted back to the page Category_talk:your 
language, in the == unsolved tasks == section (if the program is run twice, it should overwrite the 
existing section with new data, without effecting the rest of the page). The report should have two
subsections:  === solvable ===  and  === unsolvable ===, corresponding to the two groups in the 
partition.

Sort the first subsection (tasks and puzzles which are unsolved but solvable) by (primarily) 
the number of languages which have provided solutions and (secondarily, ie. for ties 
within the primary sort) by the number of revisions of the page, as reported by 
http://rosettacode.org/wiki/Special:Mostrevisions (or, better  http://www.rosettacode.org/wiki/Special:Popularpages  ?) .

Annotate the second group (unsolvable tasks and puzzles) with a brief synopsis of the
reason given for opting out (say, the first 10 words) in the == opt-out == / === your language === 
section.

All tasks and puzzles mentioned should be links; in the first subsection, to the primary task page,
in the second subsection, to the relevant anchor on the task`s talk page (ie to the opt-out / 
your-language section of the talk page).

See [Category_talk:J#unsolved_tasks|Unsolved tasks in J] for an example.

Your goal is to inspire people to (legitimately) minimize Your_Language's index in:

	http://www.rosettacode.org/wiki/Special:Mostlinked
)

noun define
Extra credit:

Identify possibly mis-categorized tasks/puzzles (i.e. pages in the main RC namespace which are not
in Tasks or Puzzles).

Report solutions in your language tagged with {{needs-review}} and any custom text given in the task
(e.g. {{needs-review|doesn't do GC}}.

)




Exclude from this set any puzzle or task for which someone has provided a reason your 
language has opted 
Take the difference 
Take the un
)


W=:wget 'rosettacode.org/wiki/Special:Allpages' 
W2=:(LF,LF)&(] {.~ i:&1@:E.) toJ W spawn 'tidy -xml'