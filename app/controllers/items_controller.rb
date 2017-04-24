class ItemsController < ApplicationController

  get '/items' do
    if !logged_in?
      redirect "/login"
    else
      @items = Item.all
      erb :'/items/show'
    end
  end

  get '/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :'/items/new'
    end
  end

  post '/items' do
    if params[:title].strip != "" && params[:creator].strip != "" && params[:type].strip != ""
      @item = current_user.items.create(title: params[:title], creator: params[:creator])
      if !Type.all.include?(params[:type])
        Type.create(name: params[:type])
      else
        @item.type_id = params[:types]

      end


      @item.save
      redirect to "/items"
    else
      redirect to "/new"
    end
  end



end
