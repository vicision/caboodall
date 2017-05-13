class TypesController < ApplicationController

  helpers Sinatra::RedirectWithFlash

  get '/types' do
    if !logged_in?
      redirect "/login"
    else
      @types = current_user.types.all
      @items = current_user.items.all
      erb :'/types/index'
    end
  end

  get '/types/:slug' do
    @type = current_user.types.find_by_slug(params[:slug])
    erb :'/types/show'
  end

end
