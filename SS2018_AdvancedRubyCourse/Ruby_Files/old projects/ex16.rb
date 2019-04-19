filename = ARGV.first

puts "We're going to erase #{filename}" 
puts "If you don't want that, hit CTRL-C (^C)." 
puts "If you do want that, hit RETURN."

$stdin.gets

puts "Opening the file..."
target = open(filename, 'w')

puts "Truncating the file. Goodbye!"
target.truncate(0)

puts "Enter new text - you have 3 lines of input..."

print "Line 1: "
line1 = $stdin.gets.chomp
print "Line 2: "
line2 = $stdin.gets.chomp
print "Line 3: "
line3 = $stdin.gets.chomp

puts "Now writing to file..."

target.write("#{line1}\n #{line2}\n #{line3}")
puts "Now closing file..."

target.close
