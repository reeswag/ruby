require "rack/test"
require "test/unit"
require "./bin/app.rb"

class TestApp < Test::Unit::TestCase
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
        @test_array_correct = [     #[scene, correct action, desired_outcome]
            ['START', 'tell a joke', 'Laser Weapon Armory'],
            ['LASER_WEAPON_ARMORY', '123' , 'The Bridge'],
            ['THE_BRIDGE', 'slowly place the bomb', "Escape Pod"],
            ['ESCAPE_POD','2', "The End" && "Winner winner chicken dinner"]
        ]
        
        @test_array_correct.each do |x|
            @scene, @correct_action, @desired_outcome = x[0], x[1], x[2]
            get '/', params={:scene => @scene}
            follow_redirect!
            post '/game', params={:action => @correct_action}
            follow_redirect!
            assert last_response.body.include?(@desired_outcome)
        end

        @test_array_wrong = [     #[scene, wrong action, expected_outcome]
            ['START', 'shoot!', 'Death' ], #&& 'blaster'
            ['START', 'dodge!', 'Death' ], #&& 'dodge'
            ['LASER_WEAPON_ARMORY', '*' , 'Death' ], #&& 'buzzes'
            ['THE_BRIDGE', 'throw the bomb', 'Death' ], #&& 'panic'
            ['ESCAPE_POD','*', "The End" && "jam jelly"]
        ]

        @test_array_wrong.each do |x|
            @scene, @wrong_action, @expected_outcome = x[0], x[1], x[2]
            get '/', params={:scene => @scene}
            follow_redirect!
            post '/game', params={:action => @wrong_action}
            follow_redirect!
            assert last_response.body.include?(@expected_outcome)
        end
    end
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