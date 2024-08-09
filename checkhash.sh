#!/usr/bin/env bash

# checkhash.sh filename [hash.txt | hash_value] [md5 | sha256]

# $@ represents all the arguments passed at the command line

#echo $*
#echo $@
#echo $$
#echo $#

awk=/usr/bin/awk
cat=/usr/bin/cat
grep=/usr/bin/grep
head=/usr/bin/head
md5=/usr/bin/md5
sed=/usr/bin/sed
sha256=/usr/bin/sha256
sha512=/usr/bin/sha512

if [[ $# -ne 3 ]]; then
	echo "Two arguments must be passed to $0"
	echo "like this: $0 filename [hash.txt | hash_value] [md5 | sha256 | sha512]"
	echo "example 1: $0 filename hash.txt md5"
	echo "example 2: $0 filename hash_value md5"
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

Hashtool="md5"

if [[ $3 == "sha256" ]]; then
	Hashtool="sha256"
elif [[ $3 == "sha512" ]]; then
	Hashtool="sha512"
fi

if [[ isHashVal -eq 0 ]]; then
	HashType=$($cat $2 | $grep -i $Hashtool | $head -n 1 | $awk '{ print $1 }')
	HashVal=`$cat $2 | $grep -i $Hashtool | $head -n 1 | $awk '{ print $2 }'`
else
	HashVal=$2
fi

echo $HashVal