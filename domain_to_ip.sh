#!/bin/bash

#Gets the ips for the specified list of domains
#
# Usage: ./resolves.sh urls.txt
#
# By: Leon Teale (RandomStorm)
#


## Check for correct usage
if [ -z "$1" ];
then
echo ""
echo "please provide a file of URLs"
echo "   Usage: ./resolves.sh urls.txt"
echo ""
else
echo ""

for urls in `cat $1`; do
host $urls | grep '[^\.][0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}[^\.]' | awk {'print $1 " " $4'}
done
