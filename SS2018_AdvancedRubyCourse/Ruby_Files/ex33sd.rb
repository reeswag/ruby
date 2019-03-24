user_upper_limit = ARGV.first

module Ex33

    def Ex33.num_log(upper_limit)
        i = 0
        numbers = []
        while i < upper_limit
            puts "At the top of i is #{i}"
            numbers.push(i)

            i += 1
            puts "Numbers now: ", numbers
            puts "At the bottom i is #{i}"
        end
        puts "The numbers: "
        numbers.each {|num| puts num}
    end
end

Ex33.num_log(user_upper_limit.to_i)
puts "enter Ex33.num_log(upper_limit)"
puts "> "

