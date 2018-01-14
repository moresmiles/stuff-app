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
end
