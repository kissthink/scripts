#!/usr/bin/bash

#
# This script takes the urls.txt file from the same directory and performs a TRACE request on each of the URLs.
# Useful when you have to verify that the TRACE method is enabled across multiple domains.
#
# By: Ryan Dewhurst (RandomStorm)
#

while read url; do
  curl -X TRACE $url --insecure
done < urls.txt