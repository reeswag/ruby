require "rack/test"
require "test/unit"
require "./bin/app.rb"
require './lib/interactive_game/map.rb'

class TestAppV2 < Test::Unit::TestCase
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    def test_outcomes
        @test_array_correct_gothon = [     #[scene, correct action, desired_outcome]
            ['GT_CENTRAL_CORRIDOR', 'tell a joke', 'Laser Weapon Armory','gothon'],
            ['GT_LASER_WEAPON_ARMORY', Map::CODE, 'The Bridge','gothon'],
            ['GT_LASER_WEAPON_ARMORY_INCORRECT', Map::CODE, 'The Bridge','gothon'],
            ['GT_THE_BRIDGE', 'slowly place the bomb', "Escape Pod",'gothon'],
            ['GT_ESCAPE_POD','2', "The End" && "Winner winner chicken dinner",'gothon']
        ]

        @test_array_correct_humpty = [     #[scene, correct action, desired_outcome]
            ['HTY_TITLE', 'Enter', 'Intro','humpty'],
            ['HTY_INTRO','Sit', 'Wall','humpty'],
            ['HTY_WALL', 'Just a few...', 'Fall','humpty'],
            ['HTY_FALL', 'Heads', 'The End' && 'Chicken Dinner','humpty']
        ]

        @test_array_wrong_gothon = [     #[scene, wrong action, expected_outcome]
            ['GT_CENTRAL_CORRIDOR', 'shoot!', 'Death','gothon' ], #&& 'blaster'
            ['GT_CENTRAL_CORRIDOR', 'dodge!', 'Death','gothon' ], #&& 'dodge'
            ['GT_LASER_WEAPON_ARMORY', '*' , 'BZZZZEDDD!','gothon' ], #&& 'buzzes'
            ['GT_LASER_WEAPON_ARMORY_INCORRECT', '*' , 'BZZZZEDDD!','gothon'],
            ['GT_THE_BRIDGE', 'throw the bomb', 'Death','gothon' ], #&& 'panic'
            ['GT_ESCAPE_POD','*', "The End" && "jam jelly",'gothon']
        ]

        def array_tester(array)
            array.each do |x|
                @scene, @correct_action, @desired_outcome, @map = x[0], x[1], x[2], x[3]
                post '/', params={:scene => @scene, :map => @map}
                follow_redirect!
                post '/game', params={:action => @correct_action}
                follow_redirect!
                assert last_response.body.include?(@desired_outcome)
            end
        end

        array_tester(@test_array_correct_gothon)
        array_tester(@test_array_wrong_gothon)
        array_tester(@test_array_correct_humpty)
    end

    def test_guesses
        get '/' # get /
        Map::ROOM_NAMES.each {|x,y| assert_equal(0, y.guesses)} # test that all room names have a guess count of 0
        
        Map::ROOM_NAMES.each do |x,y| 
            post '/', params={:scene => x, :map => 'gothon'||'humpty'}
            follow_redirect!
        end

        Map::ROOM_NAMES.each {|x,y| assert_equal(1, y.guesses)} # test that each room has a view count of 1
        get '/' # redirect back to / 
        Map::ROOM_NAMES.each {|x,y| assert_equal(0, y.guesses)} # test that all guess counts have been reset to 0
    end

    def test_game_complexity
        # get /
        # assign CODE to an instance variable
        # get //
        # check that CODE is unchanged

        # get /
        # assign CODE to an instance variable
        # Reset Game
        # check that CODE is =! to the instance variable
    end

end