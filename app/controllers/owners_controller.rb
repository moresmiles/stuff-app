class OwnersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'owners/signup', :layout => :'not_logged_in_layout'
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
      flash[:message] = "It's time to start moving"
      redirect to "/owners/#{@owner.id}"
    end
  end

  get '/login' do
    if logged_in?
      redirect_to_owner_page
    else
      erb :'/owners/login', :layout => :'not_logged_in_layout'
    end
  end

  post '/login' do
    @owner = Owner.find_by(email: params[:email])
    if @owner && @owner.authenticate(params[:password])
      session[:user_id] = @owner.id
      redirect to "/owners/#{@owner.id}"
    else
      flash[:alert] = "We can't find you, Please try again"
      redirect_to_login_page
    end
  end

  get '/owners/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @owner = Owner.find(params[:id])
        if @owner == current_user
            erb :'/owners/edit'
        else
          flash[:alert] = "Sorry, you do not have access to that page"
          redirect to "owners/#{current_user.id}/edit"
      end
    end
  end

 patch '/owners/:id' do
   if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
     @owner = Owner.find(params[:id])
     if @owner == current_user
       @owner.update(username: params[:username], email: params[:email], password: params[:password])
       flash[:message] = "Account Updated"
       redirect to "/owners/#{@owner.id}"
   else
     flash[:alert] = "Please don't leave blank content"
     redirect to "/owners/#{params[:id]}/edit"
   end
 end
end

  get '/owners/:id' do
    if !logged_in?
      redirect_to_login_page
    else
      @owner = Owner.find(params[:id])
      if @owner == current_user
      erb :'/owners/show'
    else
      flash[:alert] = "Please only access your pages"
      redirect to "owners/#{current_user.id}"
    end
    end
  end

  delete '/owners/:id/delete' do
   if logged_in?
     @owner = Owner.find(params[:id])
     if @owner == current_user
       current_user.delete
       redirect to "/logout"
     else
       redirect_to '/login'
     end
   end
 end

  get '/logout' do
    if logged_in?
      session.clear
      redirect_to_login_page
    else
      redirect_to_login_page
    end
  end

end
