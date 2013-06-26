#!/usr/bin/env ruby

#
# By: Erwan Le Rousseau (RandomStorm)
#

require 'terminal-table'
require 'ruby-progressbar'

ssl_test_bin = File.expand_path(File.dirname(__FILE__) + '/' + (ARGV[1] || 'SSLTest.jar'))
beast = %r{BEAST status: vulnerable}i
crime = %r{CRIME status: vulnerable}i
sslv2 = %r{SSLv2}
rc4   = %r{RC4_}
cn    = %r{CN=([^,]+)}
ciphers_min = %r{Minimal encryption strength: [^\(]+\(([^\)]+)\)}
ciphers_max = %r{Achievable encryption strength: [^\(]+\(([^\)]+)\)}

if file = ARGV[0]
  if File.exists?(ssl_test_bin)
    begin
      rows     = []
      targets  = File.readlines(file)
      headings = ['Target', 'CN', 'SSLv2', 'Ciphers Strength (min - achievable)', 'BEAST', 'CRIME', 'RC4']
      bar      = ProgressBar.create(format: '%a <%B> (%c / %C) %P%% %e', total: targets.size)
      
      targets.each do |target|
        target.chomp!

        row     = [target]
        command = %x{java -jar #{ssl_test_bin} #{target}}

        if cn_value = command[cn, 1] 
          row << cn_value
          row << (command.match(sslv2) ? 'Yes' : 'No')
          row << (command[ciphers_min, 1] + ' - ' + command[ciphers_max, 1])
          row << (command.match(beast) ? 'Yes' : 'No')
          row << (command.match(crime) ? 'Yes' : 'No')
          row << (command.match(rc4) ? 'Yes' : 'No')
        else
          row << { :value => 'Error: ' + command, :colspan => 6 }
        end

        rows << row
        bar.progress += 1
      end
    ensure
      puts
      puts Terminal::Table.new(:headings => headings, :rows => rows).to_s
      puts
    end
  else
    puts "The file #{ssl_test_bin} does not exist"
  end
else
  puts 'Usage: ./mass-ssl-test.rb targets.txt [/path/to/SSLTest.jar]'
  puts ' If the path to SSLTest.jar is not supllied, SSLTest.jar must be in the current directory'
  puts ' Targets format is the same than SSLTest.jar : IP/servername [port]'
end