require 'yaml/store'
require 'sinatra'
gem 'psych'
require 'psych'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

$choices = {
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
    @vote = params['vote']
    @store = YAML::Store.new "votes.yml"
    puts File.dirname('@store') 
    @store.transaction do
        @store['votes'] ||= {}
        @store['votes'][@vote] ||=0
        @store['votes'][@vote] += 1
    end
    erb :cast, :locals => {'title' => @title, 'vote' => @vote}
end

get '/results' do
    @title = 'Results so far:'
    @store = YAML::Store.new 'votes.yml'
    @votes = @store.transaction {@store['votes']}
    erb :results, :locals => {'title' => @title} 
end