yay
====

yay adds colour to your log files so you can spot things you're looking for easily  

    $ echo "i have some cheese" | yay cheese is yellow  

    $ echo "i want to see error, warning and info differently" | ./yay error is red, warning is yellow and info is green  

> i want to see error, warning and info differently  

features
----

* a simple language for creating rules  
* regexps can be used to match things like dates  
* complex rules can be stored in .yay files  
* yay files can be shared using *github gists*  

more
----

if the syntax in the earlier examples seemed a bit too wordy, words like "and", "a", "are" and "is" are completely optional.  

    $ echo "[error] [warning] [info]" | yay error warning red info green  

in fact, each word can be a Ruby regular expression  

    $ echo "[error] [warning] [info]" | yay "(error|warning)" red, info green  

coming soon
----

the default configuration works well for log4x and syslog outputs  

    $ tail /var/log/nginx/error.log | yay  

you can load rules from .yay files, some of which are included  

    $ yay installed  

you can download and install rules from gists  

    $ yay install https://gist.github.com/1361474

have fun! :D  