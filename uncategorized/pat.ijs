p=: 'xxx hh:mm:ss'
d=: 'abc 12:34:56'
pat=: adverb def (':';'}: (x i. x,u) <@}./. x,y')

'hms' (p pat) d

