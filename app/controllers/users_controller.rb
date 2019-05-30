class UsersController < ApplicationController
    get '/signup' do
        erb :'users/new'
    end

    post '/users' do
        @user = User.create(params)
        session[:user_id] = @user.id
    end

end