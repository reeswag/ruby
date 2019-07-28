require "./lib/lexicon.rb"
puts "Testing Types of user input and option"

user_input = $stdin.gets.chomp

result = Lexicon.scan(user_input)
p result