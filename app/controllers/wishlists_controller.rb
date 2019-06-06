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
		if !current_user.nil?
			erb :"wishlists/new"
		else
			redirect "/wishlists"
		end
	end
	
	get '/wishlists/:id' do
		found = Wishlist.find(params[:id])
		if logged_in? && !public_wishlist?(Wishlist.find(params[:id]))
			@wishlist = current_user.wishlists.find(params[:id])
			erb :"wishlists/show"
		elsif public_wishlist?(found)
			@wishlist = found
			erb :"wishlists/show"
		else
			redirect "/wishlists"
		end
	end

	patch '/wishlists/:id' do
		wishlist = current_user.wishlists.find(params[:id])
		binding.pry
		wishlist.update(name: params[:name], private: params[:private], item_ids: params[:item_ids])
		redirect "/wishlists/#{wishlist.id}"
	end

	get '/wishlists/:id/edit' do
			@wishlist = current_user.wishlists.find(params[:id])

			@items = Item.all
			erb :"wishlists/edit"
	end

	delete '/wishlists/:id/delete' do
			@wishlist = current_user.wishlists.find(params[:id])
			@wishlist.delete
			redirect "/#{current_user.id}/wishlists"
	end

end