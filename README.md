yay does things like

echo "i have some cheese" | yay cheese is yellow
echo "i want to see [error], [warning] and [info] differently!" | yay error warning are red and info is green

it colours log files and data streams so you can more easily spot important information and patterns

if the syntax in the first two examples seemed a bit too wordy, words like "and", "a", "are" and "is" are completely optional. 

echo "[error] [warning] [info]" | yay error warning red info green

in fact, each word can be a PCRE regular expression

echo "[error] [warning] [info]" | yay "error|warning" red info green

install it and try it out!

tail -f /var/log/nginx/error.log | yay

the default configuration works well for log4x and syslog outputs

you can load rules from .yay files, some of which are 

tail -f /var/log/messages | yay syslog

you can filter out any messages that aren't coloured in

tail -f /var/log/nginx/error.log | yay syslog hide others

you can write simple rules that are passed in through the commandline or you can create more complex ones by writing .yay files




