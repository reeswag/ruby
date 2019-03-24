filename = ARGV.first

txt = open(filename)

puts "Here is your file #{filename}:"
print txt.read

puts """
Do you have any other files you'd like to read.
If so, enter the name now: 
"""

filename_2 = $stdin.gets.chomp

txt_2 = open(filename_2)

puts "Here is your file #{filename_2}:"
print txt_2.read

