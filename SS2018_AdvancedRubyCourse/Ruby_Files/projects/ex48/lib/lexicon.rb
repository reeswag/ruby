module Lexicon
    @@dictionary = {'north' => 'direction', # all acceptable user inputs. I'd like to explore ways of grouping items with the same values to condense this list into something more manageable
        'south' => 'direction',
        'east' => 'direction',
        'west' => 'direction',
        'go' => 'verb',
        'kill' => 'verb',
        'eat' => 'verb',
        'bear' => 'noun',
        'princess' => 'noun',
        'the' => 'stop',
        'in' => 'stop',
        'of' => 'stop'
    }

    def Lexicon.scan(text)
        @words = text.split # splits stuff into an array of words
        @array_of_pairs = []

        @words.each do |x| 
            begin 
                @number = Integer(x)
                @pair = ["number" , @number]
            rescue
                @dc = x.downcase # corrects for any issues with cases
                if @@dictionary.has_key? @dc
                    @pair = ["#{@@dictionary[@dc]}", "#{x}"] # takes each word and checks if it is included in the dictionary
                else
                    @pair = ["error", "#{x}"]
                end
            end
            @array_of_pairs.push(@pair)  # pushes the the key and value to a new array
        end
        
        return @array_of_pairs # returns a full array of all array pairs
    end
end