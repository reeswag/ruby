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

def skip(word_list, word_type) 
    while peek(word_list) == word_type
        match(word_list, word_type)
    end
end

wordy = match([['noun', 'car'],['noun', 'violin']], 'noun')
p wordy
wordy2 = match(['noun', 'car'], 'verb')
p wordy2

list = [['noun', 'car'],['noun', 'violin'], ['verb','drive'], ['stop', 'the']]

list_no_stops = skip(list, 'noun')
p list_no_stops