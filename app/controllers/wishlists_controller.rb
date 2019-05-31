class WishlistsController < ApplicationController
	get '/wishlists' do
			@public_wishlists = Wishlist.all.where(private: 0)
			erb :"wishlists/index"
	end

	post '/wishlists' do
		binding.pry
		# if !params["item"]["name"].empty?
		# 	@wishlist.items << Item.create(name: params["item"]["name"])
		# end

		Wishlist.find(@wishlist.id).update(params[:wishlist][:items])
		redirect "wishlists/#{@wishlist.id}"
	end

	# post '/wishlists' do
	# 		wishlist = Wishlist.create(params)
	# 		wishlist.user_id = current_user.id
	# 		wishlist.save
	# 		redirect "/#{current_user.id}/wishlists"
	# end
	
	get '/:id/wishlists'do
			erb :"wishlists/user-wishlists"
	end

	get '/wishlists/new' do
			erb :"wishlists/new"
	end
	
	get '/wishlists/:id' do
			binding.pry
			@wishlist = current_user.wishlists.find(params[:id])
			erb :"wishlists/show"
	end

	patch '/wishlists/:id' do
    ####### bug fix
    if !params[:wishlist].keys.include?("item_ids")
    	params[:wishlist]["item_ids"] = []
    end
    #######
 
    @wishlist = Wishlist.find(params[:id])
    @wishlist.update(params["wishlist"])
			if !params["item"]["name"].empty?
				@wishlist.items << Item.create(name: params["item"]["name"])
			end
    redirect "wishlists/#{@wishlist.id}"
	end

	# patch '/wishlists/:id' do
	# 		wishlist = current_user.wishlists.find(params[:id])

	# 		wishlist.update(name: params[:name], private: params[:private])
	# 		redirect "/wishlists/#{wishlist.id}"
	# end

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