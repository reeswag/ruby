# reading the user_points hash total from a pre-exisitng database
user_points = eval(File.read('user_stats.txt')) #eval() converts the read_string string to code
p user_points

puts "What is your name?"
user = gets.chomp.downcase
puts "Hello #{user.capitalize}, I see you have found some shells!\nWould you like to exchange them for ponts?\n(y/n)"
exchange_choice = gets.chomp.downcase

if exchange_choice == "y"
    puts "How many shells would you like to exchange?"
      user_shells_to_exchange = gets.chomp.to_i
    user_points[user.to_sym] += (user_shells_to_exchange * 10)
    puts "You have chosen to exchange #{user_shells_to_exchange} shells. Your new points total is:\n #{user_points[user.to_sym]}"
else
    puts "Very well, come back when you want to exhange some of your shells..."
end

# saving the updated user_points total back to the database

File.write('user_stats.txt', user_points, mode: 'w')