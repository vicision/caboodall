class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/items"
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:message] = "Please fill out all fields."
      redirect "/signup"
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/items"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/items"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/items"
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
