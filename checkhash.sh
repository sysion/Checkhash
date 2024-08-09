#!/usr/bin/env bash

# checkhash.sh filename [hash.txt | hash_value]

# $@ represents all the arguments passed at the command line

#echo $*
#echo $@
#echo $$
echo $#

if [[ $# -ne 2 ]]; then
	echo "Two arguments must be passed to $0"
	echo "like this: $0 filename [hash.txt | hash_value]"
	echo "example 1: $0 filename hash.txt"
	echo "example 2: $0 filename hash_value"
	exit 1
fi

isHashVal=1

if [[ -s "$1" ]]; then
	if [[ -s "$2" ]]; then
		filename="$1"
		hashtxt="$2"
		isHashVal=0
	elif [[ ! -s "$2" ]]; then
		filename="$1"
		hashval="$2"
	fi
else
	echo "First argument must be a file name, with size of file > 0"
	exit 1
fi

#echo $isHashVal