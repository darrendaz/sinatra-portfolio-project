class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
        register Sinatra::Flash
    end

    get '/' do
        erb :index
    end

    def logged_in?
        session.has_key?(:user_id)
    end

    def private_wishlist?(wishlist)
        @private_wishlists = Wishlist.all.where(private: 1)
        @private_wishlists.include?(wishlist)
    end

    def current_user
        @current_user ||= User.find_by(:id => session[:user_id])
    end

end