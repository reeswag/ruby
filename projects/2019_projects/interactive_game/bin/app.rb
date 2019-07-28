require 'sinatra'
require './lib/interactive_game/map.rb'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'

get '/' do
    Map::code_creator()
    Map::pod_creator()
    Map::ROOM_NAMES.each {|x,y| y.guesses = 0} # resets the numeber of guesses for each play through. Elements such as the gothon alarm code aren't reset until the game is shutdown.
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

get '/game' do
    room = Map::load_room(session) # assignes the session map to the room variable
    Map::ROOM_NAMES[session[:room]].guesses += 1 # adds to the page load count
    room_guesses = Map::ROOM_NAMES[session[:room]].guesses
    room_limit = Map::ROOM_NAMES[session[:room]].limit
    p "Total Page Loads: #{room_guesses}"

    if room && room_guesses < room_limit # as long as the room exists and hasn't been accessed too many times it is shown.
        erb :show_room, :locals => {:room => room}
    
    elsif room && room_guesses >= room_limit # if the room exists and has been accessed too many times, it loads the appropriate room instead.
        all_guesses_consumed = room.go("All Guesses Consumed")
        Map::save_room(session, all_guesses_consumed) # saves the next_room to the game session
        room = Map::load_room(session)

        if room
            erb :show_room, :locals => {:room => room}
        else
            erb :you_died
        end

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