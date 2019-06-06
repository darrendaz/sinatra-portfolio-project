class UsersController < ApplicationController
    get '/signup' do
        erb :'users/new'
    end

    post '/users' do
        if params[:name] == "" || params[:username] == "" || params[:password] == ""
            redirect "/signup"
        else
            user = User.create(params)
            session[:user_id] = user.id
            redirect "/"
        end
    end

    get "/users/:id" do
        if logged_in?
            erb :"users/show"
        else
            redirect "/"
        end
    end

    get '/logout' do
        session.clear
        redirect "/"
    end

    get '/login' do
        erb :"users/login"
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/"
        else
            redirect "/login"
        end
    end

end