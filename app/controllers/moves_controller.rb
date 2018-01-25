class MovesController < ApplicationController

  get '/moves/:id' do
    if !logged_in?
      redirect_to_login_page
    else
      @owner = Owner.find(params[:id])
        if @owner == current_user
          @moves = current_user.moves.all
          erb :'/moves/all_moves'
      else
        flash[:alert] = "Please only access your move page"
        redirect to "moves/#{current_user.id}"
      end
    end
  end

  get '/moves/:id/new' do
    if !logged_in?
      redirect_to_login_page
    else
      @owner = Owner.find(params[:id])
        if @owner == current_user
          erb :'/moves/new'
      else
        flash[:alert] = "Please only access your new move page"
        redirect to "moves/#{current_user.id}/new"
      end
    end
  end

  post '/moves' do
    if params[:origin].empty? || params[:destination].empty? || params[:move_date].empty?
      flash[:alert] = "Pleae don't leave blank content"
      redirect to '/moves/new'
    else
      @owner = current_user
      @move = Move.create(owner_id: @owner.id, origin: params[:origin], destination: params[:destination], move_date: params[:move_date])
      @owner.moves << @move
      @owner.save
      redirect to "/moves/#{@owner.id}"
    end
  end

  get '/moves/:id/edit' do
    if !logged_in?
      redirect_to_login_page
    else
      @move = Move.find(params[:id])
      if @move == current_move
        erb :'/moves/edit'
    else
      flash[:alert] = "Please only edit your page"
        redirect to "moves/#{current_move.id}/edit"
      end
    end
  end

  patch '/moves/:id' do
    if params[:origin].empty? || params[:destination].empty? || params[:move_date].empty?
     flash[:message] = "Please don't leave blank content"
     redirect to "/moves/#{params[:id]}/edit"
   else
     @move = Move.find(params[:id])
     if @move.owner == current_user
        @move.update(origin: params[:origin], destination: params[:destination], move_date: params[:move_date])
        flash[:message] = "Move Updated"
        redirect to "/moves#{@move.owner.id}"
      else
        flash[:alert] = "Please only edit your page"
        redirect_to_index_page
      end
    end
  end

  delete '/moves/:id/delete' do
   if !logged_in?
     redirect_to_login_page
   else
     @move = Move.find(params[:id])
      if @move.owner == current_user
        @move.destroy
        redirect to "/moves/#{current_user.id}"
      else
        flash[:alert] = "Please only edit your page"
        redirect to "/moves/#{current_user.id}"
      end
    end
  end

end
