class UsersController < ApplicationController

  helpers Sinatra::RedirectWithFlash

  get '/signup' do
    if logged_in?
      redirect "/types"
    else
      @user = User.new
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/types'
    else
      flash[:message] = @user.errors.full_messages.join(', ')
      erb :'/users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/types"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/types"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
