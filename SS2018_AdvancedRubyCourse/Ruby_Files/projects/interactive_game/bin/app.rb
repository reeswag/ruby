require 'sinatra'
require './lib/interactive_game/map.rb'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'

get '/' do
    erb :map_choice, :locals => {:scene => nil}
end

post '/' do
    map = params[:map]
    if map == 'gothon'
        scene = 'GT_CENTRAL_CORRIDOR'
    elsif map == 'humpty'
        scene ='HTY_TITLE'
    else
        redirect to('/')
    end

    if params[:scene]
        session[:room] = params[:scene]
    else
        session[:room] = scene
    end
    
    redirect to('/game') # initiates the game
end

get '/initialiser' do
    session[:room] = params[:scene] || scene # creates a new session at the start of the game
    redirect to('/game') # initiates the game
end

get '/game' do
    
    room = Map::load_room(session) # assignes the session map to the room variable
    if room
        erb :show_room, :locals => {:room => room}
    else
        erb :you_died
    end
end

post '/game' do
    room = Map::load_room(session) 
    action = params[:action]
    if room
        next_room = room.go(action) || room.go("*") # takes the user input and follows the appropriate path

        if next_room
            Map::save_room(session, next_room) # saves the next_room to the game session
        end

        redirect to('/game') # cycles back to the game and :show_room view with the latest session map
    else
        erb :you_died
    end
end

get '/game/:scene' do
    session[:room] = params[:scene]
    room = Map::load_room(session)
    if room
        erb :show_room, :locals => {:room => room}
    else
        erb :you_died
    end
end