require './song'
require 'sinatra'
require 'slim'
require 'sass'

set:public_folder, 'public'
set:views, 'views'

get('/styles.css'){ scss :styles }

get '/' do
    slim :home
end

get '/about' do
    @title = "All About This Website"
    slim :about
end

get '/contact' do
    @title = "Contact Us"
    slim :contact
end

not_found do
    slim :not_found
end