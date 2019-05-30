class UsersController < ApplicationController
    get '/signup' do
        erb :'users/new'
    end

    post '/users' do
        if params[:name] == "" || params[:username] == "" || params[:password] == ""
            redirect "/signup"
        else
            binding.pry
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/:id"
        end
    end

    get '/users/:id' do
        "howdy"
    end

    get '/logout' do
        session.clear
    end

end