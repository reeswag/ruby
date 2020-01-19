require 'sinatra'
require 'sass'
require './lib/rent_a_bike.rb'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
use Rack::Session::Pool
set :session_secret, 'BADSECRET'

get('/styles.css'){ scss :styles }

get '/reset' do
    factory_reset
    redirect to('/')
end

get '/logout' do
    session[:user] = nil
    redirect to('/')
end

get '/' do
    @hidden_message = 'Dock Initialisation Complete'
    begin
        rent_a_bike_initialiser
        puts "Dock Initialisation Complete"
    rescue Exception => e
        puts "caught exception #{e}! Initialisation not required!"
    end

    erb:homepage, :locals => {:user => session[:user] ||= nil, :hidden => @hidden_message}
end

post '/' do
    session[:username] = params[:username]
    session[:user_choice] = params[:user_choice]

    if session[:user_choice] == 'login'
        if session[:username] == "MAINTENANCE"
            @user = UserData.first(:username => "MAINTENANCE")
            session[:user] = @user
            puts @user
            redirect to '/maintenance'
        else
            begin
                @user = UserData.first(:username => session[:username])
                unless @user
                    erb:error, :locals => {:user => session[:username], :error => "User #{session[:username]}, does not exist!"}
                else
                    session[:user] = @user
                    redirect to '/'
                end
            end
        end
    elsif session[:user_choice] == 'register_new_user'
        redirect to('/welcome')
    elsif session[:user_choice] == 'view_user_account'
        redirect to('/user')
    elsif session[:user_choice] == 'hire_bike'
        begin
            release_bike(session[:user].username)
            redirect to('/newrental')
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            erb:error, :locals => {:user => session[:username], :error => e.to_s}
        end
    elsif session[:user_choice] == 'return_bike'
        begin
            #return_bike(session[:user].username)
            redirect to('/returnbike')
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            erb:error, :locals => {:user => session[:username], :error => e.to_s}
        end
    elsif session[:user_choice] == 'logout'
        redirect to('/logout')
    elsif session[:user_choice] == 'report_damage'
        redirect to('/reportdamage')
    else
        puts "Hello World"
    end
end

get '/user' do
    unless session[:user]
        puts "User Does Not Exist"
        redirect to '/'
    else
        @user_bikes = session[:user].access_user_bikes
        erb:user, :locals => {:user => session[:username], :bikes => session[:user].bike_count}
    end
end

get '/welcome' do
    @test = UserData.all(:username => session[:username])
    p @test
    if @test.empty?
        @user = UserData.create(username: session[:username])
        session[:user] = @user
        p session[:user]
        p UserData.all
        erb:welcome, :locals => {:user => session[:username]}
    else
        @error_message = "Sorry, the username: #{session[:username]} has already been taken!"
        erb:unwelcome, :locals => {:user => session[:username]}
    end
end

get '/newrental' do
    session[:user].access_user_bikes
    erb:newrental, :locals => {:user => session[:username]}
end

get '/returnbike' do
    @user_bikes = session[:user].access_user_bikes

    if session[:user].bike_count == 0
        @message = "No bikes out for rental, #{session[:username]}!"
    else
        @message =""
    end
    
    erb:returnbike,:locals => {:user => session[:user],:message => @message, :bikes => @user_bikes, :bike_count => session[:user].bike_count}
end

post '/returnbike' do
    @bike_choice = params[:bike_choice].to_i
    puts @bike_choice
    return_bike(session[:username], @bike_choice)
    redirect to ('returnbike')
end

get '/reportdamage' do
    @user_bikes = session[:user].access_user_bikes

    if session[:user].bike_count == 0
        @message = "No bikes out for rental, #{session[:username]}!"
    else
        @message =""
    end

    erb:reportdamage,:locals => {:user => session[:username],:message => @message,:bikes => @user_bikes, :bike_count => session[:user].bike_count}
end

post '/reportdamage' do
    @bike_choice = params[:bike_choice].to_i
    @damage = params[:damage]
    @bikes = Bikes.all(:assigned_to => session[:username])
    @bikes[@bike_choice].assign_condition(@damage)
    redirect to ('reportdamage')
end

get '/maintenance' do
    halt(401,'Not Authorized') unless session[:username] == "MAINTENANCE"
    @error = params[:error] ||= nil
    puts @error
    session[:user].access_user_bikes
    if session[:user].bike_count == 0
        @message = "\tNone."
    else
        @message =""
        (session[:user].access_user_bikes).each_with_index do |x, index|
            @message << "\tBike #{index.to_s}: #{x.condition}\n"
        end
    end
    erb:maintenance, {:locals => {:maintenance => session[:user], :message => @message, :error => @error, :bike_count => session[:user].bike_count}}
end

post '/maintenance' do
    @maintenance_choice = params[:maintenance_choice]
    if @maintenance_choice == "retrieve_broken_bikes"
        begin
            release_bikes_for_repair
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            redirect to("/maintenance?error=#{e.to_s}")
        end
    elsif @maintenance_choice == "return_working_bikes"
        begin
            return_working_bikes
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            redirect to("/maintenance?error=#{e.to_s}")
        end
    elsif @maintenance_choice == "repair_bikes"
        repair_bikes
    else
        puts "this shouldn't ever happen"
    end
    redirect to '/maintenance'
end

=begin
        (session[:users]).each do |x|
            next if x.username != session[:username]
            session[:user] = x
        end
        if session[:username] == "MAINTENANCE" #if session[:user].username == "MAINTENANCE"
            redirect to '/maintenance'
        else
            redirect to '/'
        end
    elsif session[:user_choice] == 'register_new_user'
        redirect to('/welcome')
    elsif session[:user_choice] == 'view_user_account'
        redirect to('/user')
    elsif session[:user_choice] == 'hire_bike'
        begin
            session[:user].hire_bike(session[:dock])
            redirect to('/newrental')
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            erb:error, :locals => {:user => session[:username], :error => e.to_s}
        end
    elsif session[:user_choice] == 'return_bike'
        begin
            #session[:user].return_bike(session[:dock])
            redirect to('/returnbike')
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            erb:error, :locals => {:user => session[:username], :error => e.to_s}
        end
    elsif session[:user_choice] == 'logout'
        redirect to('/logout')
    elsif session[:user_choice] == 'report_damage'
        redirect to('/reportdamage')
    else
        puts "Hello World"
    end
end






helpers do
    def docking_station
        @current_dock = DockingStation.new
        8.times do 
            @current_dock.dock_bike(Bike.new)
        end
        @current_dock.dock_bike(Bike.new('Flat Tyre'))
        @current_dock.dock_bike(Bike.new('Faulty Breaks'))
        @current_dock
    end
end

before do
    
    if request.path != "/"
        unless session[:users]
            redirect "/"
        end
    end

end

get '/' do
    @hidden_message = 'Dock Initialisation Complete'

    if session[:dock]
        @hidden_message = 'Dock Already Exists'
        p session[:dock]
    else
        docking_station
        session[:dock] = @current_dock
    end

    unless session[:users] 
        session[:users] = [Maintenance.new]
    end

    p session[:user]
    p session[:users]

    erb:homepage, :locals => {:user => session[:user] ||= nil, :hidden => @hidden_message}
end

post '/' do
    session[:username] = params[:username]
    session[:user_choice] = params[:user_choice]

    if session[:user_choice] == 'login'
        (session[:users]).each do |x|
            next if x.username != session[:username]
            session[:user] = x
        end
        if session[:username] == "MAINTENANCE" #if session[:user].username == "MAINTENANCE"
            redirect to '/maintenance'
        else
            redirect to '/'
        end
    elsif session[:user_choice] == 'register_new_user'
        redirect to('/welcome')
    elsif session[:user_choice] == 'view_user_account'
        redirect to('/user')
    elsif session[:user_choice] == 'hire_bike'
        begin
            session[:user].hire_bike(session[:dock])
            redirect to('/newrental')
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            erb:error, :locals => {:user => session[:username], :error => e.to_s}
        end
    elsif session[:user_choice] == 'return_bike'
        begin
            #session[:user].return_bike(session[:dock])
            redirect to('/returnbike')
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            erb:error, :locals => {:user => session[:username], :error => e.to_s}
        end
    elsif session[:user_choice] == 'logout'
        redirect to('/logout')
    elsif session[:user_choice] == 'report_damage'
        redirect to('/reportdamage')
    else
        puts "Hello World"
    end
end

get '/user' do
    p session[:user]
    @user_bikes = session[:user].bikes
    erb:user, :locals => {:user => session[:username], :bikes => @user_bikes.count}
end

get '/welcome' do
    @test = (session[:users]).detect {|x| x.username == session[:username]}
    
    if @test == nil
        session[:user] = User.new(session[:username]) 
        session[:users].push(session[:user])
        p session[:user]
        p session[:users]
        erb:welcome, :locals => {:user => session[:username]}
    else
        @error_message = "Sorry, the username: #{session[:username]} has already been taken!"
        erb:unwelcome, :locals => {:user => session[:username]}
    end
end

get '/reportdamage' do
    if (session[:user].bikes).empty?
        @message = "No bikes out for rental, #{session[:username]}!"
    else
        @message =""
        (session[:user].bikes).each_with_index do |x, index|
            @message << "\tBike #{index.to_s}: #{x.condition}\n"
        end
    end

    @bike_count = (session[:user].bikes).count
    erb:reportdamage,:locals => {:user => session[:user],:message => @message, :bike_count => @bike_count}
end

post '/reportdamage' do
    @damage = params[:damage]
    @bike_choice = (session[:user].bikes)[params[:bike_choice].to_i]
    @bike_choice.assign_condition(@damage) 
    redirect to ('reportdamage')
end

get '/newrental' do
    #session[:user].hire_bike(session[:dock])
    p session[:user]
    erb:newrental, :locals => {:user => session[:username]}
end

get '/returnbike' do
    if (session[:user].bikes).empty?
        @message = "No bikes out for rental, #{session[:username]}!"
    else
        @message =""
        (session[:user].bikes).each_with_index do |x, index|
            @message << "\tBike #{index.to_s}: #{x.condition}\n"
        end
    end

    @bike_count = (session[:user].bikes).count
    erb:returnbike,:locals => {:user => session[:user],:message => @message, :bike_count => @bike_count}
end

post '/returnbike' do
    @bike_choice = params[:bike_choice].to_i
    puts @bike_choice
    session[:user].return_bike(session[:dock], @bike_choice)
    redirect to ('returnbike')
end

get '/maintenance' do
    @error = params[:error] ||= nil
    puts @error
    if (session[:user].bikes).empty?
        @message = "\tNone."
    else
        @message =""
        (session[:user].bikes).each_with_index do |x, index|
            @message << "\tBike #{index.to_s}: #{x.condition}\n"
        end
    end
    erb:maintenance, {:locals => {:maintenance => session[:user], :message => @message, :error => @error} , :layout => nil}
end

post '/maintenance' do
    @maintenance_choice = params[:maintenance_choice]
    if @maintenance_choice == "retrieve_broken_bikes"
        begin
            session[:user].retrieve_broken_bikes(session[:dock])
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            redirect to("/maintenance?error=#{e.to_s}")
        end
    elsif @maintenance_choice == "return_working_bikes"
        begin
            session[:user].return_working_bikes(session[:dock])
        rescue Exception => e
            puts "caught exception #{e}! ohnoes!"
            redirect to("/maintenance?error=#{e.to_s}")
        end
    elsif @maintenance_choice == "repair_bikes"
        session[:user].repair_bikes
    else
        puts "this shouldn't ever happen"
    end
    redirect to '/maintenance'
end

get '/logout' do
    session[:user] = nil
    redirect to('/')
end

get '/reset' do
    session.clear
    redirect to('/')
end

=begin
get '/welcome' do
    session[:user] = User.new(session[:username]) 
    session[:users].push(session[:user])
    p session[:user]
    p session[:users]
    erb:welcome, :locals => {:user => session[:username]}
end

get '/oldreturnbike' do
    if (session[:user].bikes).empty?
        @body = "#{session[:username]}: No bikes out for hire!"
    else
        #session[:user].return_bike(session[:dock])
        p session[:user]
        @body = "Thank you for returning the bike, #{session[:username]}!"
    end
    erb:returnbike, :locals => {:body => @body}
end

=end