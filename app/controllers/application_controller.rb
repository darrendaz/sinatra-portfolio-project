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

    def logged_in?
        session.has_key?(:user_id)
    end

    def public_wishlist?(wishlist)
        @public_wishlists = Wishlist.all.where(private: 0)
        @public_wishlists.include?(wishlist)
    end

    def current_user
        @current_user ||= User.find_by(:id => session[:user_id])
    end

end