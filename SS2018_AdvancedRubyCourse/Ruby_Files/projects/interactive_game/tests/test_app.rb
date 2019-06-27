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
            ['GT_LASER_WEAPON_ARMORY', '123', 'The Bridge','gothon'],
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
            ['GT_LASER_WEAPON_ARMORY', '*' , 'Death','gothon' ], #&& 'buzzes'
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
end