yay
====

yay adds colour to your log files so you can spot things you're looking for easily  

    $ echo "i have some cheese" | yay cheese is yellow  
    $ echo "i want to see errors, warnings and info differently" | yay errors are red, warnings are yellow and info is green  

features
----

* a simple language for creating rules  
* regexps can be used to match things like dates  
* complex, multi-lined rules can be stored in .yay files  
* yay files can be shared using gists!  

more
----

the syntax is designed to be easy to use but if the other examples seemed a bit too wordy, words like "and", "a", "are" and "is" are completely optional  

    $ echo "[error] [warning] [info]" | yay error and warning are red and info is green  
    $ echo "[error] [warning] [info]" | yay error warning red info green  

you can set both foreground and background colours and use all the VT100 commands  

    $ echo "this is a match" | yay match is a dim blue red  

if you want to make something really stand out, you can colour an entire line  

    $ echo "this line has matches" | yay matches are red yellow lines  

you can treat matching words like regular expressions  

    $ echo "[error] something bad" | yay "(error|warning)" red  
    $ echo "[ERROR] something bad" | yay "/error/i" red  

the default configuration works well for log4x and syslog outputs  

    $ tail /var/log/nginx/error.log | yay  

you can load rules from .yay files, some of which are included  

    $ yay installed  

you can download and install yay files from anywhere, including github gists  

    $ yay install my_rule https://raw.github.com/gist/1361474/cf1c2522f1c4df7f8d2d49da2d6186b530f5a3dd/log4x  
    $ echo "omg we have an unhandled exception" | yay my_rule  

have fun! :D  
