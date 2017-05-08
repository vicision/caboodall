require './config/environment'
require 'rack-flash'
require 'sinatra/redirect_with_flash'


class ApplicationController < Sinatra::Base

  use Rack::Flash
  helpers Sinatra::RedirectWithFlash


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "place_holder"
  end

  get "/" do
    if logged_in?
      redirect "/types"
    else
      flash[:message] = "Please log in or sign up"
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
