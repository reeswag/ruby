require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'

get '/' do
    erb :map_choice
end

post '/' do
    map = params[:map]
    if map == 'gothon'
        require './lib/gothonweb/map.rb'
    elsif map == 'humpty'
        require './lib/gothonweb/humpty.rb'
    else
        redirect to('/')
    end    
    scene = params[:scene] || 'START'
    session[:room] = scene # createst a new session at the start of the game
    redirect to('/game') # initiates the game
end

get '/' do
    scene = params[:scene] || 'START'
    session[:room] = scene # creates a new session at the start of the game
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