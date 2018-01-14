class OwnersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'owners/signup'
    else
      redirect_to_owner_page
    end
  end

  post '/signup' do
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

  get '/owners/:id/edit' do
   if logged_in?
      erb :'/owners/edit'
   else
     redirect_if_not_logged_in
   end
 end

 patch '/owners/:id' do
   if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
     @owner = Owner.find(params[:id])
     @owner.update(username: params[:username], email: params[:email], password: params[:password])
     flash[:message] = "Account Updated"
     redirect to "/owners/#{@owner.id}"
   else
     flash[:message] = "Please don't leave blank content"
     redirect to "/owners/#{params[:id]}/edit"
   end
 end

  get '/owners/:id' do
    if logged_in?
      erb :'/owners/show'
    else
      redirect_if_not_logged_in
    end
  end

  delete '/owners/:id/delete' do
   if logged_in?
     current_user.delete
     redirect to "/logout"
   else
     redirect_if_not_logged_in
   end
 end

  get '/logout' do
    if logged_in?
      session.clear
      redirect_to_index_page
    else
      redirect_to_index_page
    end
  end

end
