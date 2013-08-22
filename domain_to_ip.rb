#!/usr/bin/env ruby

#
# This script takes a file with a list of domains from STDIN and outputs the associated IP address.
# Example: ruby domain_to_ip.rb domains.txt
#
# By: Ryan Dewhurst (RandomStorm)
#

require 'socket'

if file = ARGV[0]
  domains = File.open(file)

  domains.each do |domain|
    domain.chop!

    begin
      ip = IPSocket::getaddress(domain)
      puts "#{domain} #{IPSocket::getaddress(domain)}"
    rescue
      puts "#{domain} N/A"
     end
  end
else
  puts "Usage: ./domain_to_ip.rb urls.txt"
end
