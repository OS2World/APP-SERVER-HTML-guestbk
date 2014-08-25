This guestbook is released into the public domain by myself, the author.

Purpose: 
This code provides a basic guest book for your web page. It creates a flat
test file which logs the visitor's name, email address, www page, reference,
and comments. A separate utility converts this text file to an html page
which your visitors can view.

General:
Examine the cmd and html files and edit any path statements you wish. You
should also edit the reference selections in the form to fit your site. You
should also remove all references to my WWW site and replace them with your
own - this should be easy to locate in the text files. I have provided all
the graphics images I used and you are certainly free to replace them with
your own art.

How it works:
The myguestbook.html file includes a form which the visitor fills in. This
form uses a post method which calls the guestbook.cmd file which should be
located in the cgi-bin directory. The guestbook.cmd saves the new entry
in a file called comments.txt in a last-in top-down order (the newest entry
is at the top of the list).

A cron process runs once each hour which calls getcomments.cmd which processes
this comments.txt file. My reason for doing this was to provide an opportunity
to preprocess the comments prior to making them available on the comments page.
Why? There are people out there who like to screw up fun things with vulgarity,
and there are other mischevious people who like to leave comments which will
crash your page.

What's left?
This original work has no means for serializing access to the comments.txt
and comments.html files so in the unlikely case that two or more people access
them at the same time there will be a locked file problem. I no longer have a
WWW page so will not likely complete this work but it was fun enough and
complete enough to put out there for others to carry on.

What does it cost?
Nothing, but if you use it send me your URL so I can leave a comment!!

Parting comment:
I suggest you consider leaving the following statement of appreciation on your
version as a courtesy to the inspiration for this project.

This guestbook service is based on that provided by:
<A HREF="http://lpage.com/"> Lpage.com</A>


Dennis Peterson
dpeterso@halcyon.com
OS/2 Northwest BBS
Bellevue, WA
