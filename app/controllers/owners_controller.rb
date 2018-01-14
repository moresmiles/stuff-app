class OwnersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'owners/signup'
    else
      redirect_to_owner_page
    end
  end

  post '/signup' do
    # NEEDS Flash Error Message for if Username or Email is already is use
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:alert] = "Pleae don't leave blank content"
      redirect to '/signup'
    else
      @owner = Owner.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @owner.id
      flash[:alert] = "It's time to start moving"
      redirect_to_owner_page
    end
  end

  get '/login' do
    if logged_in?
      redirect_to_owner_page
    else
      erb :'/owners/login'
    end
  end

  post '/login' do
    @owner = Owner.find_by(email: params[:email])
    if @owner && @owner.authenticate(params[:password])
      session[:user_id] = @owner.id
      redirect_to_owner_page
    else
      flash[:message] = "We can't find you, Please try again"
      redirect_if_not_logged_in
    end
  end
end
