#!/bin/bash
for urls in `cat $1`; do
host $urls | grep '[^\.][0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}[^\.]' | awk {'print $1 " " $4'}
done
