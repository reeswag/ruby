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
            ['GT_LASER_WEAPON_ARMORY', Map::code_accessor(), 'The Bridge','gothon'],
            ['GT_LASER_WEAPON_ARMORY_INCORRECT', Map::code_accessor(), 'The Bridge','gothon'],
            ['GT_THE_BRIDGE', 'slowly place the bomb', "Escape Pod",'gothon'],
            ['GT_ESCAPE_POD', Map::pod_accessor(), "The End" && "Winner winner chicken dinner",'gothon']
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
        get '/'
        Map::ROOM_NAMES.each {|x,y| assert_equal(0, y.guesses)} # test that all room names have a guess count of 0
        
        Map::ROOM_NAMES.each do |x,y| 
            post '/', params={:scene => x, :map => 'gothon'||'humpty'}
            follow_redirect!
        end
       
        Map::ROOM_NAMES.each {|x,y| assert_equal(1, y.guesses)} # test that each room has a view count of 1
        get '/'
        Map::ROOM_NAMES.each {|x,y| assert_equal(0, y.guesses)} # test that all guess counts have been reset to 0
    end

    def test_random_alarm_code
        get '/' # get /
        test_code = Map::code_accessor() # assign CODE to an instance variable
        test_pod = Map::pod_accessor() 
        puts test_code
        get '/'
        assert_not_equal(test_code, Map::code_accessor()) # check that the alarm code has been randomised
    end

    def test_random_pod
        test_pod_array_1 = []
        test_pod_array_2 = []
        
        100.times do
            get '/'
            test_pod = Map::pod_accessor()
            test_pod_array_1.push(test_pod.to_i)
            get '/'
            test_pod = Map::pod_accessor()
            test_pod_array_2.push(test_pod.to_i)
        end

        p test_pod_array_1.reduce(:+)
        p test_pod_array_2.reduce(:+)
        assert_not_equal(test_pod_array_1.reduce(:+), test_pod_array_2.reduce(:+))
    end
end