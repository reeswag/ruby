require "rack/test"
require "test/unit"
require "./bin/app_v1.rb"

class TestAppV1 < Test::Unit::TestCase
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    def test_redirect()
        get '/'
        follow_redirect!
        assert last_response.ok?
        assert_equal 'http://example.org/game', last_request.url
    end

    def test_outcomes
        @test_array_correct_gothon = [     #[scene, correct action, desired_outcome]
            ['START', 'tell a joke', 'Laser Weapon Armory'],
            ['LASER_WEAPON_ARMORY', '123', 'The Bridge'],
            ['THE_BRIDGE', 'slowly place the bomb', "Escape Pod"],
            ['ESCAPE_POD','2', "The End" && "Winner winner chicken dinner"]
        ]

        @test_array_correct_humpty = [     #[scene, correct action, desired_outcome]
            ['TITLE', 'Enter', 'Intro'],
            ['INTRO','Sit', 'Wall'],
            ['WALL', 'He has had a few...', 'Fall'],
            ['FALL', 'Heads', 'The End' && 'Chicken Dinner']
        ]

        @test_array_wrong_gothon = [     #[scene, wrong action, expected_outcome]
            ['START', 'shoot!', 'Death' ], #&& 'blaster'
            ['START', 'dodge!', 'Death' ], #&& 'dodge'
            ['LASER_WEAPON_ARMORY', '*' , 'Death' ], #&& 'buzzes'
            ['THE_BRIDGE', 'throw the bomb', 'Death' ], #&& 'panic'
            ['ESCAPE_POD','*', "The End" && "jam jelly"]
        ]

        @test_array_correct_gothon.each do |x|
            @scene, @correct_action, @desired_outcome = x[0], x[1], x[2]
            post '/', params={:map => 'gothon'}
            get '/initialiser', params={:scene => @scene}
            follow_redirect!
            post '/game', params={:action => @correct_action}
            follow_redirect!
            puts last_response.body
            assert last_response.body.include?(@desired_outcome)
        end

        @test_array_correct_humpty.each do |x|
            @scene, @correct_action, @desired_outcome = x[0], x[1], x[2]
            post '/', params={:map => 'humpty'}
            get '/initialiser', params={:scene => @scene}
            follow_redirect!
            post '/game', params={:action => @correct_action}
            follow_redirect!
            puts last_response.body
            assert last_response.body.include?(@desired_outcome)
        end
=begin
        @test_array_wrong_gothon.each do |x|
            @scene, @wrong_action, @expected_outcome = x[0], x[1], x[2]
            post '/', params={:map => 'gothon'}
            get '/initialiser', params={:scene => @scene}
            follow_redirect!
            post '/game', params={:action => @wrong_action}
            follow_redirect!
            puts last_response.body
            assert last_response.body.include?(@expected_outcome)
        end
=end    
    end
=begin   
    def test_map_choice
        post '/', params={:map => 'humpty'}
        follow_redirect!
        follow_redirect!
        assert last_response.body.include?('Colchester')
    end
=end
end


=begin
Redacted Tests

    def test_engine
        @actions = [
            'tell a joke',
            '123',
            'slowly place the bomb',
            '2'
        ]

        get '/'
        follow_redirect!

        @actions.each do |x|
            post '/game', params={:action => x}
            follow_redirect!
        end

        assert last_response.body.include?("The End" && "Winner winner chicken dinner")
    end
=end