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
      flash.now[:message] = "Please sign up or log in"
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end
