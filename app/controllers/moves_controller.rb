class MovesController < ApplicationController

  get '/moves' do
    if logged_in?
      @moves = current_user.moves.all
      erb :'/moves/all_moves'
    else
      redirect_if_not_logged_in
    end
  end

  get '/moves/new' do
    redirect_if_not_logged_in
    erb :'/moves/new'
  end

  post '/moves' do
    redirect_if_not_logged_in
    if params[:origin].empty? || params[:destination].empty? || params[:move_date].empty?
      flash[:alert] = "Pleae don't leave blank content"
      redirect to '/moves/new'
    else
      @owner = current_user
      @move = Move.create(owner_id: @owner.id, origin: params[:origin], destination: params[:destination], move_date: params[:move_date])
      @owner.moves << @move
      @owner.save
      redirect to "/moves"
    end
  end

  get '/moves/:id/edit' do
    if logged_in?
     erb :'/moves/edit'
   else
     redirect_if_not_logged_in
   end
  end

  patch '/moves/:id' do
   if !params[:origin].empty? && !params[:destination].empty? && !params[:move_date].empty?
     @move = current_move
     @move.update(origin: params[:origin], destination: params[:destination], move_date: params[:move_date])
     flash[:message] = "Move Updated"
     redirect to "/moves"
   else
     flash[:message] = "Please don't leave blank content"
     redirect to "/moves/#{params[:id]}/edit"
   end
  end

  delete '/moves/:id/delete' do
   if logged_in?
     #flash message -are you sure you want to delete this move?
     #all associated boxes and items will be deleted as well
     @move = current_move
     @move.destroy
     redirect to "/moves"
   else
     redirect_if_not_logged_in
   end
 end


end
