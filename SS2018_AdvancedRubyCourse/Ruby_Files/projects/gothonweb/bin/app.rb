require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello world'
end

get '/hello/' do
    greeting = params[:greeting] || "Hi There" # the || says either use what is in params or "Hi There"
    erb :index, :locals => {'greeting' => greeting}
end


