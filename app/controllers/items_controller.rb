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
    if params[:title].strip != "" && params[:creator].strip != ""
      @item = current_user.items.create(title: params[:title], creator: params[:title])
      if !params[type][name].empty?
        

      # if Type.all.none?{|type| type.name == params[:type]}
      #   Type.create(name: params[:type])
      #   @item.type = params[:type]
      # else
      #   @item.type = params[:type]
      #
      # end


      @item.save
      redirect to "/items"
    else
      redirect to "/new"
    end
  end



end
