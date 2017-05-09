class ItemsController < ApplicationController

  helpers Sinatra::RedirectWithFlash

  get '/items' do
    if !logged_in?
      redirect "/login"
    else
      @items = Item.all
      if @items == []
        flash.now[:message] = "You have nothing in your caboodalls =("
      end
      erb :'/users/show'
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
    if params[:title].strip != "" && params[:creator].strip != "" && params[:type_name] != ""
      @user = current_user
      @type = @user.types.find_or_create_by(name: params[:type_name])
      @type.user_id = @user.id
      @item = Item.create(title: params[:title], creator: params[:creator], type_id: @type.id, user_id: @user.id)
      @item.save
      flash.now[:message] = %Q[<a href="/items/#{@item.slug}">#{@item.title}</a>  by #{@item.creator} has been added to your <a href="/types/#{@type.slug}">#{@type.name}s</a> caboodall.]
      erb :"/items/new"
    else
      flash.now[:message] = "Please fill out all fields."
      @fields_mes = flash[:message]
      erb :"/items/new"
    end
  end

  get '/items/:slug' do
    @item = Item.find_by_slug(params[:slug])
    erb :'/items/show'
  end

  delete '/items/:slug/delete' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      if !!@item && @item.user_id == current_user.id
        @item.delete
        # if URI(request.referrer).path == "/items/#{@item.slug}"
        #   || URI(request.referrer).path == "/types"
        #   erb :"/users/show"
        # flash[:message] =
        # @del_mes = flash[:message]
        flash[:message] = "Your item has been deleted successfully"
        @del_mes = flash[:message]
        if URI(request.referer).path == "/items"
          erb :"/items/new"
        elsif URI(request.referer).path == "/types"
          # flash[:message] = "Your item has been deleted successfully"
          # @del_mes = flash[:message]
          erb :"/types/show"
        else
          erb :"/users/show"
        end
      end
    else
      redirect "/login"
    end
  end

end
