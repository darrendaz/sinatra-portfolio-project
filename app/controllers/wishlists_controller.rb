class WishlistsController < ApplicationController
    get '/wishlists' do
        @public_wishlists = Wishlist.all.where(private: 0)
        erb :"wishlists/index"
    end

    post '/wishlists' do
        wishlist = Wishlist.create(params)
        wishlist.user_id = current_user.id
        wishlist.save
        redirect "/#{current_user.id}/wishlists"
    end

    get '/:id/wishlists'do
        erb :"wishlists/user-wishlists"
    end
    
    get '/wishlists/new' do
        erb :"/wishlists/new"
    end

end