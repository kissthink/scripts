#!/usr/bin/env ruby

#
# By: Erwan Le Rousseau (RandomStorm)
#

if domains_file = ARGV[0] and subdomains_file = ARGV[1]
  domains    = File.readlines(domains_file)
  subdomains = File.readlines(subdomains_file)

  subdomains.sort.each do |subdomain|
  	domains.each do |domain|
      puts "#{subdomain.chomp}.#{domain.chomp}"
    end
  end

else
  puts 'Usage: ./subdomains-creator.rb domains-list subdomains-list'
end
