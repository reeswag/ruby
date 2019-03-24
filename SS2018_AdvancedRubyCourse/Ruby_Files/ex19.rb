input_file = ARGV.first

def print_all(f)
    puts f.read #reads the file
end

def rewind(f) 
    f.seek(0) #returns to the start of the file
end

def print_a_line(line_count, f)
    puts "#{line_count}, #{f.gets.chomp}" # puts the current line count and ....
end

current_file = open(input_file) #opening the file

puts "Printing the whole file" 

print_all(current_file) #calling the function print_all on the current file

puts "Rewinding the file"

rewind(current_file) #calling rewind on the current file

puts "Printing the three consecutive lines"

current_line = 1 #starting at line 1
print_a_line(current_line, current_file)

current_line = current_line + 1 #moving to the following line
print_a_line(current_line, current_file)

current_line = current_line + 1 #moving to the following line
print_a_line(current_line, current_file)

# gets.chomp works on a line by line basis and moves to the following line after in a file after it is called. As shown below.
puts "gets.chomp works on a line by line basis and moves to the following line after in a file after it is called.\nCalling get.chomp on the current file returns the following:"
puts current_file.gets.chomp
puts "Returning a specific line with gets.chomp, requires you to seek a set line:"
rewind(current_file)
puts current_file.gets.chomp