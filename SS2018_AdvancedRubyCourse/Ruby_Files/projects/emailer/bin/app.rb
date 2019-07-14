require 'sinatra'
require './lib/emailer/emailer.rb'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'

get '/' do
    erb:feedback
end

post '/' do
    EMAILER::feedback_message('reeswag@gmail.com', params[:email], 'Feedback', params[:user], params[:feedback])
    erb:feedback_recieved, :locals => {:feedback => params[:feedback]}
end