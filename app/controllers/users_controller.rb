class UsersController < Sinatra::Base
    get '/signup' do
        erb :"users/new"
    end

    post '/users' do
        
    end

end