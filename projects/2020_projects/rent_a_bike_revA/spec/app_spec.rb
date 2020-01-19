require "spec_helper"
require "./lib/rent_a_bike.rb"
require "./bin/app.rb"

require 'rspec'
require 'rack/test'

RSpec.describe 'The Rent a Bike App' do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    context 'test redirects' do

        it "redirects new access requests to the homepage" do
            get '/welcome'
            follow_redirect!
            expect(last_response.body).to include("Welcome To Rent a Bike!")
        end
    end

    context 'Get to /' do
        before(:example) do
            get '/'
        end
        
        it "displays home page" do 
            expect(last_response).to be_ok
            expect(last_response.body).to include("Welcome To Rent a Bike!")
        end

        it "requests username" do
            expect(last_response.body).to include("Username:")
        end

    end

    context '#dock_station' do
    
        it 'initiates a new instance of a dock if none exists' do
            get '/'
            expect(session[:dock]).to be_a(DockingStation)
        end

        it 'does not overwrite an existing dock if one already exists' do
            get '/'
            expect(last_response.body).to include('Dock Initialisation Complete')
            get '/'
            expect(last_response.body).to include('Dock Already Exists')
            
          #  get '/'#expect(docking_station).to eq('Dock already Exists:')
        end
    end

    context 'Post to /' do
        before(:example) do
            get '/'
            @test_username = 'Default Username'
            post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            follow_redirect!
        end

        it 'redirects to user account when user selected' do
            #get '/'
            post '/', params = {:username => @test_username, :user_choice => 'view_user_account' }
            follow_redirect!
            expect(last_response).to be_ok
            expect(last_response.body).to include("Greetings #{@test_username}!")
        end

        it 'redirects to new user page when registration selected' do
            #post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            #follow_redirect!
            expect(last_response).to be_ok
            expect(last_response.body).to include("Welcome #{@test_username}!")
        end

        it 'assigns new user resistratons to the users session' do
            #post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            #follow_redirect!
            test_user_resistration = session[:users][0] # this only works because I have updated the rspec helper documentation
            expect(test_user_resistration.username).to eq('Default Username')
        end

        it 'redirects to newrental page when hire_bike selected' do
            #post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            #follow_redirect!
            post '/', params = {:username => @test_username, :user_choice => 'hire_bike'}
            follow_redirect!
            expect(last_response).to be_ok
            expect(last_response.body).to include("Enjoy your bike, #{@test_username}!")
        end

        it 'redirects to returnbike page when return_bike selected' do
            post '/', params = {:username => @test_username, :user_choice => 'return_bike'}
            follow_redirect!
            expect(last_response).to be_ok
            expect(last_response.body).to include("No bike to return, #{@test_username}!")
        end
    end


    context 'Get to /user' do
        before(:example) do
            @test_username = 'Default Username'
            get '/'
            post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            follow_redirect!
            post '/', params = {:username => @test_username, :user_choice => 'hire_bike'}
            follow_redirect!
            post '/', params = {:username => @test_username, :user_choice => 'view_user_account' }
            follow_redirect!
        end

        it 'displays user bike page' do
            expect(last_response).to be_ok
        end

        it 'counts user bikes' do
            expect(last_response.body).to include("Greetings #{@test_username}!")
            expect(last_response.body).to include("Bikes out to rent: 1")
        end
    end

    context 'Get to /newrental' do
        it 'assigns a working bike from the dock to the user' do
            @test_username = 'Default Username'
            get '/'
            post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            follow_redirect!
            @test_bike = double(:bike, working?: true)
            @test_dock = double(:dock, release_bike: @test_bike)
            session[:user].hire_bike(@test_dock)
            expect(session[:user].bikes).not_to be_empty
        end
    end

    context 'Get to /returnbike' do
        it 'returns a bike from the user to the dock' do
            @test_username = 'Default Username'
            get '/'
            post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            follow_redirect!
            post '/', params = {:username => @test_username, :user_choice => 'hire_bike' }
            follow_redirect!
            expect(session[:user].bikes).not_to be_empty
            expect((session[:dock].bikes).count).to eq(19)
            post '/', params = {:username => @test_username, :user_choice => 'return_bike' }
            follow_redirect!
            expect(last_response.body).to include("Thank you for returning the bike, #{@test_username}!")
            expect(session[:user].bikes).to be_empty
            expect((session[:dock].bikes).count).to eq(20)
        end
    end

    context 'Get to/logout' do
        it 'clears the user session and redirects to the landingpage' do
            @test_username = 'Default Username'
            get '/'
            post '/', params = {:username => @test_username, :user_choice => 'register_new_user' }
            follow_redirect!
            expect(session[:user]).not_to eq(nil)
            get '/logout'
            follow_redirect!
            expect(session[:user]).to eq(nil)
        end
    end
end
