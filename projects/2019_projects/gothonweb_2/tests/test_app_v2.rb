require "rack/test"
require "test/unit"
require "./bin/app_v2.rb"
require './lib/gothonweb/map_v1.rb'

class TestAppV2 < Test::Unit::TestCase
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    def test_outcomes
        @test_array_correct_gothon = [     #[scene, correct action, desired_outcome]
            ['GT_CENTRAL_CORRIDOR', 'tell a joke', 'Laser Weapon Armory','gothon'],
            ['GT_LASER_WEAPON_ARMORY', '123', 'The Bridge','gothon'],
            ['GT_THE_BRIDGE', 'slowly place the bomb', "Escape Pod",'gothon'],
            ['GT_ESCAPE_POD','2', "The End" && "Winner winner chicken dinner",'gothon']
        ]

        @test_array_correct_humpty = [     #[scene, correct action, desired_outcome]
            ['HTY_TITLE', 'Enter', 'Intro','humpty'],
            ['HTY_INTRO','Sit', 'Wall','humpty'],
            ['HTY_WALL', 'He has had a few...', 'Fall','humpty'],
            ['HTY_FALL', 'Heads', 'The End' && 'Chicken Dinner','humpty']
        ]

        @test_array_wrong_gothon = [     #[scene, wrong action, expected_outcome]
            ['GT_CENTRAL_CORRIDOR', 'shoot!', 'Death','gothon' ], #&& 'blaster'
            ['GT_CENTRAL_CORRIDOR', 'dodge!', 'Death','gothon' ], #&& 'dodge'
            ['GT_LASER_WEAPON_ARMORY', '*' , 'Death','gothon' ], #&& 'buzzes'
            ['GT_THE_BRIDGE', 'throw the bomb', 'Death','gothon' ], #&& 'panic'
            ['GT_ESCAPE_POD','*', "The End" && "jam jelly",'gothon']
        ]

        def array_tester(array)
            array.each do |x|
                @scene, @correct_action, @desired_outcome, @map = x[0], x[1], x[2], x[3]
                #puts @scene, @correct_action, @desired_outcome
                post '/', params={:scene => @scene, :map => @map}
                follow_redirect!
                post '/game', params={:action => @correct_action}
                follow_redirect!
                #p last_response.body
                assert last_response.body.include?(@desired_outcome)
            end
        end

        array_tester(@test_array_correct_gothon)
        array_tester(@test_array_wrong_gothon)
        array_tester(@test_array_correct_humpty)
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

    def test_redirect()
        get '/'
        follow_redirect!
        assert last_response.ok?
        assert_equal 'http://example.org/game', last_request.url
    end

    def test_map_choice
        post '/', params={:map => 'humpty'}
        follow_redirect!
        follow_redirect!
        assert last_response.body.include?('Colchester')
    end

    @test_array_correct_gothon.each do |x|
            @scene, @correct_action, @desired_outcome = x[0], x[1], x[2]
            puts @scene, @correct_action, @desired_outcome
            post '/', params={:scene => @scene, :map => 'gothon'}
            follow_redirect!
            post '/game', params={:action => @correct_action}
            follow_redirect!
            p last_response.body
            assert last_response.body.include?(@desired_outcome)
        end

        @test_array_wrong_gothon.each do |x|
            @scene, @correct_action, @desired_outcome = x[0], x[1], x[2]
            puts @scene, @correct_action, @desired_outcome
            post '/', params={:scene => @scene, :map => 'gothon'}
            follow_redirect!
            post '/game', params={:action => @correct_action}
            follow_redirect!
            p last_response.body
            assert last_response.body.include?(@desired_outcome)
        end

        @test_array_correct_humpty.each do |x|
            @scene, @correct_action, @desired_outcome = x[0], x[1], x[2]
            puts @scene, @correct_action, @desired_outcome
            post '/', params={:scene => @scene, :map => 'humpty'}
            follow_redirect!
            post '/game', params={:action => @correct_action}
            follow_redirect!
            p last_response.body
            assert last_response.body.include?(@desired_outcome)
        end
=end