class ItemsController < ApplicationController

  get '/items' do
    if !logged_in?
      redirect "/login"
    else
      @items = Item.all
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
      flash[:message] = "#{@item.title} by #{@item.creator} has been added to your #{@type.name} caboodall"
      redirect to "/new"
    else
      flash[:message] = "Please fill out all fields."
      redirect to "/new"
    end
  end

  get '/items/:slug' do
    @item = Item.find_by_slug(params[:slug])
    erb :'/items/show'
  end

  delete '/items/:slug/delete' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      if @item.user_id == current_user.id
        @item.delete
        flash[:message] = "Your item has been deleted successfully"
        redirect "/items"
      end
    else
      redirect "/login"
    end
  end




end
