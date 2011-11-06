#!/bin/bash

tool=`which racc`
base=`dirname $0`

if [[ -z "$tool" ]]; then
	echo "Fail: Can't find racc"
	exit -1
fi

flags=
src="$base/../data/grammar.y"
dest="$base/../lib/yay/parser.rb"

command="$tool $flags $src -o $dest"

echo "Command: $command"
$command

