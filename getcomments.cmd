/*REXX - Create an html comments file from guestbook form */

call syssleep 10

comments_header = "d:\gopher\comments.hdr"
comments_text = "d:\gopher\cgi-bin\comments.txt"
comments_trailer = "d:\gopher\comments.trlr"
comments_html = "d:\gopher\docs\comments.html"
crlf = "0d0a"x
working_dir = "d:\gopher"
message = ""

newq = RxQueue("create")
oq = RxQueue('set', newq)

call Directory working_dir

do while lines(comments_header)
   message = message || linein(comments_header) || crlf
end

do while lines(comments_text)
   push linein(comments_text)
end

do while queued() > 0
   parse pull queue_entry
   message = message || queue_entry || crlf
end

do while lines(comments_trailer)
   message = message || linein(comments_trailer) || crlf
end

call SysFileDelete(comments_html)
rc = lineout(comments_html, message)
rc = lineout(comments_html)
call RXQueue "delete", newq

exit
