/***************************************************************************
 *
 *  Guestbook.cmd - a REXX script to generate a guest book file
 *
 *  Adapted from TEST-CGI.CMD - a REXX script to test CGI interface
 *
 *  Originally by:  Frankie Fan <kfan@netcom.com>  7/11/94
 *
 *  Dennis Peterson (dpeterso@halcyon.com) 1-15-96
 *
 *  An unfinished work... There is no serialization yet.
 *
 **************************************************************************/
/*
unpackur: procedure
parse arg text
unsafe=xrange('00'x,'1F'x)'$-_@.&!*"''(),=;/#?: '
out = ''
do i = 1 to length(text)
  c = substr(text,i,1)
  if pos(c,unsafe)\=0 then
    out = out'%'c2x(c)
  else
    out = out''c
end
return out
*/

Call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
Call SysLoadFuncs

Parse Arg Argv

env = "OS2ENVIRONMENT"
Argc = Words(Argv)

header = '<BODY BACKGROUND="/webart/bk_saffron.gif"'
header = header || ' BGCOLOR="#7F7F7F"'
header = header || ' TEXT="#A00000"'
header = header || ' LINK="#007F00"'
header = header || ' VLINK="#00A000">'
header = header || '<H2>Your comments will be added to our guest book!</H2><HR>'

trailer = '<A HREF="/"><IMG SRC="/webart/back.gif" alt="">Return to the OS/2 Northwest BBS</A><HR>'

Say "Content-type: text/html"
Say

/*
  len = value("CONTENT_LENGTH",,env)
  post_string = charin(,,len) /* read only the number specified 
                                 in CONTENT_LENGTH */
  query_string = post_string
  NF = ParseQueryString(query_string)
*/

NF = ParseQueryString(charin(,,value("CONTENT_LENGTH",,env)))

message = '<B>Name:</B> ' || Parms.XVal.1 '<BR>'
message = message || '<B>Email:</B> ' || '<A HREF=mailto:'Parms.XVal.2 || '>'Parms.XVal.2'</A><BR>'
message = message || '<B>Date:</B> ' || date('w') || ', ' || date('l') || ' -- ' || Time('c') || '<BR>'
message = message || '<B>Homepage:</B>  <A HREF='translate(Parms.XVal.3,'/','\') || '>' || Parms.XVal.4 || '</A><BR>'
message = message || '<B>Referred from:</B> ' || Parms.XVal.5 || '<BR>'
message = message || '<B>Comments:</B> '

/* Preserve original line breaks from message by adding <BR> to each line */
/* This is a hack until I find a cleaner way */

tempfile = SysTempFileName('d:\gopher\cgi-bin\guestbook.???')
rc = lineout(tempfile, Parms.XVal.6)
rc = lineout(tempfile)

Do while lines(tempfile) > 0
   message = message || linein(tempfile) || '<BR>'
end
message = message || '<HR>'


say  header || message  || '0d0a'x || trailer

rc = lineout(tempfile)
rc = SysFileDelete(tempfile)
rc = lineout("d:\gopher\cgi-bin\comments.txt", message)
rc = lineout("d:\gopher\cgi-bin\comments.txt")
call getcomments
return

	/* Do not modify below this line --  Important parsing code... */
ParseQueryString: procedure expose Parms. NFields
  Parse arg P
  i = 1
  do while ((P \= '') & (i < 10))
     Parse var P Parms.Text.i '&' rest
     Parse var Parms.Text.i Parms.Tag.i '=' Parms.KeyVal.i
     Parms.Tag.i = translate( Parms.Tag.i)
     Parms.XVal.i=DecodeKeyVal( Parms.KeyVal.i)
     P = rest
     i = i + 1
  end
  NFields = i - 1
  return NFields

DecodeKeyVal: procedure
  parse arg Code
  Text=''
  Code=translate(Code, ' ', '+')
  rest='%'
  do while (rest\='')
     Parse var Code T '%' rest
     Text=Text || T
     if (rest\='') then
      do
        ch = left( rest,2)
        c=X2C(ch)
        Text=Text || c
        Code=substr( rest, 3)
      end
  end
  return Text
