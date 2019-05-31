class ItemsController < ApplicationController
    get '/items' do
        erb :"items/index"
    end

    post '/items' do
        item = Item.create(params)
        redirect "/items"
    end

    get '/items/new' do
        erb :"items/new"
    end

end