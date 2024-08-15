#!/usr/bin/env bash

# checkhash.sh filename [hash.txt | hash_value] [md5 | sha256]


awk=/usr/bin/awk
cat=/usr/bin/cat
grep=/usr/bin/grep
head=/usr/bin/head
md5sum=/usr/bin/md5sum
sed=/usr/bin/sed
shasum=/usr/bin/shasum
sha256sum=/usr/bin/sha256sum
sha512sum=/usr/bin/sha512sum

if [[ $# -ne 3 ]]; then
	echo "Three arguments must be passed to $0"
	echo "like this: $0 filename [hash.txt | hash_value] [md5 | sha256 | sha512]"
	echo "example 1: $0 filename hash.txt md5"
	echo "example 2: $0 filename hash_value md5"
	exit 1
fi

isHashVal=1

if [[ -s "$1" ]]; then
	filename="$1"

	if [[ -s "$2" ]]; then
		hashtxt="$2"
		isHashVal=0
	elif [[ ! -s "$2" ]]; then
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

# remove terminating \r character
HashVal=$(echo $HashVal | sed 's/\r$//')

print_color_output(){ 
	flag=-1

	if [[ $# -eq 0 ]]; then
		sflag="NOK"
	elif [[ $# == 1 ]]; then
		sflag=$1
		flag=1
	fi

	green="\e[1;32m"
	red="\e[1;31m"
	reset="\e[0m"

	if [[ $flag -eq -1 ]]; then
		echo -e "$red $sflag $reset"
	elif [[ $flag -eq 1 ]]; then
		echo -e "$green $sflag $reset"
	fi
}

if [[ $Hashtool == "md5" ]]; then
	# redirect errors to null and get the "OK" from the result
	output=$(echo $HashVal $1 | $md5sum -c - 2>/dev/null | $sed -e 's/^.*:\s*//') 
	print_color_output $output
elif [[ $Hashtool == "sha256" ]]; then
	output=$(echo $HashVal $1 | $sha256sum -c - 2>/dev/null | $sed -e 's/^.*:\s*//')
	print_color_output $output
elif [[ $Hashtool == "sha512" ]]; then
	output=$(echo $HashVal $1 | $sha512sum -c - 2>/dev/null | $sed -e 's/^.*:\s*//')
	print_color_output $output
fi