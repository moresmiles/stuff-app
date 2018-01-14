class BoxesController < ApplicationController

  get '/moves/:id/boxes' do
    if logged_in?
      @move = current_move
      erb :'/boxes/boxes'
    else
      redirect_if_not_logged_in
    end
  end

  get '/moves/:id/boxes/new' do
    if logged_in?
      @move = current_move
      erb :'boxes/new'
    else
      redirect_if_not_logged_in
    end
  end

  post '/moves/:id/boxes' do
    if params[:name].empty? || params[:location].empty?
      flash[:alert] = "Pleae don't leave blank content"
      redirect to '/moves/:id/boxes/new'
    else
      @owner = current_user
      @move = current_move
      @box = Box.create(owner_id: @owner.id, move_id: @move.id, name: params[:name], location: params[:location])
      @move.boxes << @box
      @move.save
      @owner.save
      redirect to "/moves/boxes/#{@box.id}"
    end
  end

  get '/moves/boxes/:id' do
    if logged_in?
      @box = Box.find(params[:id])
      erb :'boxes/show'
    else
      redirect_if_not_logged_in
    end
  end

  get '/moves/:id/boxes/edit' do
    if logged_in?
      @box = Box.find(params[:id])
      erb :'/boxes/edit'
    else
      redirect_if_not_logged_in
    end
  end

  patch '/moves/boxes/:id' do
    if !params[:name].empty? && !params[:location].empty?
      @box = Box.find(params[:id])
      @box.update(name: params[:name], location: params[:location])
      flash[:message] = "Box Updated"
      redirect to "/moves/boxes/#{@box.id}"
    else
      flash[:message] = "Please don't leave blank fields"
      redirect to "/moves/#{params[:id]}/boxes/edit"
    end
  end

  delete '/moves/:id/boxes/delete' do
   if logged_in?
     #flash message -are you sure you want to delete this move?
     #all associated boxes and items will be deleted as well
     @box = Box.find(params[:id])
     @box.destroy
     redirect to "/moves/#{@box.move_id}/boxes"
   else
     redirect_if_not_logged_in
   end
 end

end
