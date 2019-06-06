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
		wishlist = Wishlist.find_by(id: params[:id])
		if logged_in? && private_wishlist?(wishlist) &&current_user.wishlists.include?(wishlist)
			@wishlist = current_user.wishlists.find(params[:id])
			erb :"wishlists/show"
		elsif !private_wishlist?(wishlist) && !wishlist.nil?
			@wishlist = wishlist
			erb :"wishlists/show"
		else
			flash[:notice] = "Sorry the wishlist you've requested is not available."
			redirect "/wishlists"
		end
	end

	patch '/wishlists/:id' do
		wishlist = current_user.wishlists.find(params[:id])
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