#!/usr/bin/env ruby

#
# This script takes a domain name or an IP address and retrieve it's neighbours
# Example: ./neighbours.rb randomstorm.com
#
# By: Erwan Le Rousseau (RandomStorm)
#

require 'typhoeus'
require 'nokogiri'

if address = ARGV[0]
  api_url  = 'http://www.ipneighbour.com/'
  response = Typhoeus.post(api_url, :body => { 'domainName' => address })
  doc      = Nokogiri::HTML(response.body)

  doc.search('div#resultsContainer ul li a').each do |node|
    puts node.text.strip
  end
else
  puts 'Usage: ./neighbours.rb domain_name_or_ip'
end
