class WishlistsController < ApplicationController
    get '/wishlists' do
        binding.pry
        @public_wishlists = Wishlist.all.where(private: 0)
        erb :"wishlists/show"
    end

    post '/wishlists' do
        wishlist = Wishlist.create(params)
        wishlist.user_id = current_user.id
        wishlist.save
        redirect "/wishlists"
    end
    
    get '/wishlists/new' do
        erb :"/wishlists/new"
    end

end