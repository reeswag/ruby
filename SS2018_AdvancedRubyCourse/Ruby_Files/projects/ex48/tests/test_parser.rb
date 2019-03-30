require "./lib/ex48/parser.rb"
require "test/unit"

class TestParser < Test::Unit::TestCase

    def test_peek()
        result_1 = peek([['noun', 'car']])
        result_2 = peek([['verb', 'drive']])
        result_3 = peek([['stop', 'the']])
        assert_equal(result_1, 'noun')
        assert_equal(result_2, 'verb')
        assert_equal(result_3, 'stop')
    end

    def test_match()
        test_list = [['noun', 'car'], ['verb', 'drive']]
        result_1 = match(test_list, 'noun' )
        assert_equal(result_1, ['noun', 'car'])
        assert_equal(test_list, [['verb', 'drive']])
    end

    def test_skip()
        test_list = [['stop', 'the'],['stop', 'the'], ['noun', 'car'], ['verb', 'drive']]
        skip(test_list, 'stop')
        assert_equal(test_list, [['noun', 'car'], ['verb', 'drive']])
    end

    def test_parse_verb()
        test_list = [['stop', 'the'], ['verb', 'drive'], ['noun', 'car']]
        result_1 = parse_verb(test_list)
        assert_equal(result_1, ['verb', 'drive'])

        assert_raise do
            test_list_2 = [['stop', 'the'],['noun', 'car'], ['verb', 'drive']]
            parse_verb(test_list_2)
        end
    end

    def test_parse_object()
        test_list = [['stop', 'the'], ['noun', 'car'], ['verb', 'drive']]
        result_1 = parse_object(test_list)
        assert_equal(result_1, ['noun', 'car'])

        test_list_2 = [['stop', 'the'], ['direction', 'north'], ['verb', 'drive']]
        result_2 = parse_object(test_list_2)
        assert_equal(result_2, ['direction', 'north']) 
        
        assert_raise do
            test_list_3 = [['stop', 'the'],['verb', 'drive'],['noun', 'car']]
            parse_object(test_list_3)
        end
    end

    def test_parse_subject()
        test_list = [['stop', 'the'], ['noun', 'car'], ['verb', 'drive']]
        result_1 = parse_subject(test_list)
        assert_equal(result_1, ['noun', 'car'])

        test_list_2 = [['stop', 'the'], ['verb', 'drive'], ['noun', 'car']]
        result_2 = parse_subject(test_list_2)
        assert_equal(result_2, ['noun', 'player']) 
        
        assert_raise do
            test_list_3 = [[]]
            parse_subject(test_list_3)
        end
    end

    def test_parse_sentence()
        test_sentence_1 = parse_sentence([['verb', 'drive'], ['stop', 'the'], ['noun', 'car']])
        result_1 = [test_sentence_1.subject, test_sentence_1.verb, test_sentence_1.obj]
        assert_equal(result_1, ['player', 'drive', 'car'])

        test_sentence_2 = parse_sentence([['noun', 'Greg'], ['verb', 'drives'], ['stop', 'the'], ['noun', 'car']])
        result_2 = [test_sentence_2.subject, test_sentence_2.verb, test_sentence_2.obj]
        assert_equal(result_2, ['Greg', 'drives', 'car'])


        incorrect_sentences = [[['noun', 'car']], 
            [['noun', 'car'], ['noun', 'player']], 
            [['verb', 'eat'], ['verb', 'eat']]
        ]
        incorrect_sentences.each do |x|
            assert_raise do
             parse_sentence(x)
            end
        end
    end

end