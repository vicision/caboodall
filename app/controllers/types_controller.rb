class TypesController < ApplicationController

  get '/types' do
    @types = Type.all
    erb :'/types/index'
  end

  get '/types/:slug' do
    @genre = Type.find_by_slug(params[:slug])
    erb :'/types/show'
  end

end
