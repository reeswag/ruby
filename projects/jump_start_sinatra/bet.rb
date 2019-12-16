require 'sinatra'

get '/bet/:stake/on/:number' do
    stake = params[:stake].to_i
    number = params[:number].to_i
    roll = rand(6) + 1
    
    if number == roll
        "It landed on #{roll}. Well done, you win #{stake * 6} chips!"
    else
        "It landed on #{roll}. You lose your stake of #{stake} chips!"
    end
end