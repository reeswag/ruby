require 'yaml/store'
require 'sinatra'
gem 'psych'
require 'psych'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

$choices = { # all possible voting choices are assigned here
    'HAM' => 'Hamburger',
    'PIZ' => 'Pizza',
    'CUR' => 'Curry',
    'NOO' => 'Noodles',
    }
    
get '/' do 
    @title = "What do you fancy..."
    erb :index, :locals => {'title' => @title}
end

post '/cast' do 
    @title = "Thanks for casting your vote!"
    @vote = params['vote'] # assignes the instance variable to which ever Key was selected from the choices hash
    @store = YAML::Store.new "votes.yml" # creates a temp yaml store file instance
    @store.transaction do # accesses the votes.yml file (creates it if it doesn't already exist) and runs the block below 
        @store['votes'] ||= {} # the ||= stops the variable from being overwritten if it already exists. 
        @store['votes'][@vote] ||= 0 # the vote choice is assigned a count of 0 unless it already exists
        @store['votes'][@vote] += 1 # 1 vote is added to the total 
    end
    erb :cast, :locals => {'title' => @title, 'vote' => @vote}
end

get '/results' do
    @title = 'Results so far:'
    @store = YAML::Store.new 'votes.yml'
    @votes = @store.transaction {@store['votes']} # accesses the votes hash
    erb :results, :locals => {'title' => @title} 
end