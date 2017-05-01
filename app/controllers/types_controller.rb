class TypesController < ApplicationController

  get '/types' do
    @types = Type.all
    @items = Item.all
    erb :'/types/index'
  end

  get '/types/:slug' do
    @type = Type.find_by_slug(params[:slug])
    erb :'/types/show'
  end

end
