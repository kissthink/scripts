#!/usr/bin/env ruby

#
# This script takes a file with a list of domains from STDIN and outputs the associated IP address.
# Example: ruby domain_to_ip.rb domains.txt
#
# By: Ryan Dewhurst (RandomStorm)
#

if file = ARGV[0]
  domains = File.open(file)

  domains.each do |domain|
    domain.chop!
    ping = `ping -c 1 #{domain}`
    ip   = ping[/\((.+)\):/, 1]

    puts "#{domain} #{ip}"
  end
else
  puts "Usage: ./domain_to_ip.rb urls.txt"
end
