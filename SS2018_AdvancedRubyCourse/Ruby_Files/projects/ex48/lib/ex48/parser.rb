class ParserError < Exception
end

class Sentence
    def initialize(subject, verb, obj)
        @subject = subject[1] # assuming my are inputing ['noun', 'princess'] pairs
        @verb = verb[1]
        @obj = obj[1]
    end

    attr_reader :subject
    attr_reader :verb
    attr_reader :obj

    def peek(word_list)
        if word_list #where word_list != nil, this will will run
            word = word_list[0] # isolates the 1st words pair
            return word # #returns the identifier from the word pair, i.e. 'noun', 'verb' etc.
        else
            return nil
        end
    end

    def match(word_list, expecting) #extracts a word pair and returns it if it matches an expected type.
        if word_list
            word = word_list.shift #returns the first element of the word_list array and removes it.

            if word[0] == expecting
                return word
            else 
                return nil
            end
        else
            return nil
        end
    end

    def skip(word_list, word_type) # skip takes 
        while peek(word_list) == word_type
            match(word_list, word_type)
        end
    end

    def parse_verb(word_list)
        skip(word_list, 'stop')

        if peek(word_list) == 'verb'
            return match(word_list, 'verb')
        else
            raise ParserError.new("Expected a verb next.")
        end
    end
end
