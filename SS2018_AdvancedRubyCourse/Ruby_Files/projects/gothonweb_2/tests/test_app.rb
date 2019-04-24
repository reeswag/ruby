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

    def test_engine
    end

    def test_engine 
        @test_array = [     #[scene, correct action, desired_outcome]
            ['START', 'tell a joke', 'Laser Weapon Armory'],
            ['LASER_WEAPON_ARMORY', '123' , 'The Bridge'],
            ['THE_BRIDGE', 'slowly place the bomb', "Escape Pod"],
            ['ESCAPE_POD','2', "The End - Winner Winner Chicken Dinner"]
          ]
        
        @test_array.each do |x|
            @scene, @correct_action, @desired_outcome = x[0], x[1], x[2]
            get '/', params={:scene => @scene}
            follow_redirect!
            post '/game', params={:action => @correct_action}
            follow_redirect!
            assert last_response.body.include?(@desired_outcome)
        end
    end
end