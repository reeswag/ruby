require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do # this is the handler - it specifies what happens when you visit a certain page
    return 'Hello world'
end

get '/hello/' do
    erb :hello_form
end

post '/hello/' do # the post indicates that we will be recieving a form 
    greeting = params[:greeting] || "Hi There" # Takes the greeting parameter from the form
    name = params[:name] || "Nobody" # Takes the name parameter from the form

    erb :index, :locals => {'greeting' => greeting, 'name' => name} # Passes the above parameters to the index template.
end

get '/upload/' do
    erb :upload_form
end

post '/save_image' do
    if params[:file]
        filename = params[:file][:filename]
        tempfile = params[:file][:tempfile]
        target = "./static/images/#{filename}"
      
        File.open(target, 'wb') {|f| f.write tempfile.read }
        erb :show_image, :locals => {'filename' => filename}
    end
end

get '/viewer/' do
    erb :show_image, :locals => {'filename' => filename}
end