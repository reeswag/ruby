puts "This is lexicon.rb"
#stuff = $stdin.gets.chomp
#words = stuff.split

module Lexicon
    @@dictionary = {'north' => 'direction', # all acceptable user inputs. I'd like to explore ways of grouping items with the same values to condense this list into something more manageable
        'south' => 'direction',
        'east' => 'direction',
        'west' => 'direction'}

    def Lexicon.scan(text)
        @words = text.split # splits stuff into an array of words
        @array_of_pairs = []
        @words.each do |x| 
            @pair = ["#{@@dictionary[x]}", "#{x}"] # takes each word and checks if it is included in the dictionary
            @array_of_pairs.push(@pair)  # pushes the the key and value to a new array
        end
        p @array_of_pairs
        return @array_of_pairs # returns a full array of all array pairs
    end
end