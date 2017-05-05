class TypesController < ApplicationController

  get '/types' do
    if !logged_in?
      redirect "/login"
    else
      @types = Type.all
      @items = Item.all
      erb :'/types/index'
    end
  end

  get '/types/:slug' do
    @type = Type.find_by_slug(params[:slug])
    erb :'/types/show'
  end

end
