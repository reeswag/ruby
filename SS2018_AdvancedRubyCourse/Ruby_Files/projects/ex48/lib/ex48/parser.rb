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
end

def peek(word_list)
    begin
        if word_list #where word_list != nil, this will will run
            word = word_list[0] # isolates the 1st words pair
            return word[0] # #returns the identifier from the word pair, i.e. 'noun', 'verb' etc.
        else
            return nil
        end
    rescue
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

def parse_object(word_list)
    skip(word_list, 'stop')
    next_word = peek(word_list)

    if next_word == 'noun'
        return match(word_list, 'noun')
    elsif next_word == 'direction'
        return match(word_list, 'direction')
    else
        raise ParserError.new("Expecting a noun or direction next.")
    end
end

def parse_subject(word_list)
    skip(word_list, 'stop')
    next_word = peek(word_list)

    if next_word == 'noun'
        return match(word_list, 'noun')
    elsif next_word == 'verb'
        return ['noun', 'player']
    else
        raise ParserError.new("Expected a noun or verb next.")
    end
end

def parse_sentence(word_list)
    puts "original_word_list: #{word_list}"
    subj = parse_subject(word_list)
    puts "post_subj_word_list: #{word_list}"
    verb = parse_verb(word_list)
    puts "post_verb_word_list: #{word_list}"
    obj = parse_object(word_list)
    puts "post_obj_word_list: #{word_list}"
    return Sentence.new(subj, verb, obj)
end

x = parse_sentence([['verb', 'run'], ['direction', 'north']])
p x
y = parse_sentence([['noun', 'bear'], ['verb', 'eats'], ['noun', 'human']])
p y 
z = parse_sentence([['stop', 'the'], ['noun', 'bear'], ['verb', 'sits'], ['stop', 'on' ], ['stop', 'the'], ['noun', 'human']])
p z 
puts x.obj
