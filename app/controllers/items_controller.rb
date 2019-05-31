class ItemsController < ApplicationController
	get '/items' do
		@items = Item.all
		erb :"items/index"
	end

	post '/items' do
		item = Item.create(params)
		redirect "/items"
	end
	
	get '/items/new' do
		if !current_user.nil?
			erb :"items/new"
		else
			redirect "/items"
		end
	end
	
	get '/items/:id' do
		@item = Item.find(params[:id])
		erb :"items/show"
	end
end