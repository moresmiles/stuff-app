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
      redirect to "/moves/#{@move.id}"
    end
  end
end
