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

    def test_start
        @test_action = 'tell a joke'
        @test_name = 'Laser Weapon Armory'
        get '/', params={:scene => 'THE_BRIDGE'}
        follow_redirect!
        p last_response.body
=begin get '/game', params={:action => @test_action}
        post '/game', params={:action => @test_action}
        assert last_response.ok?
        p last_response.body
        assert last_response.body.include?(@test_name)
=end
    end

end