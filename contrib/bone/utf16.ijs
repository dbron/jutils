NB.  Thanks to Fred Bone,
NB.  
NB.  http://www.jsoftware.com/pipermail/programming/2007-April/006284.html
NB.
NB.  From: "Fred Bone" <Fred.Bone@dial.pipex.com>
NB.  Subject: Re: [Jprogramming] regex and unicode
NB.  To: Programming forum <programming@jsoftware.com>
NB.  Date: Fri, 27 Apr 2007 17:02:31 +0100
NB.  Message-ID: <46322CA7.586.1B4423B@Fred.Bone.dial.pipex.com>
utf16be =: [:,a.{~[:}.256#.(^:_1)999,3 u:]
utf16le =: [:,[:|."1 a.{~[:}.256#.(^:_1)999,3 u:]
