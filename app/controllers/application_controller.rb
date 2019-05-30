class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
    end

    get '/' do
        erb :index
    end

    get '/signup' do
        erb :"users/new"
    end

    get '/wishlists' do
        "wishlists"
    end

    get '/items' do
        "items"
    end

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

end