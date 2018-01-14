class ItemsController < ApplicationController

  get '/boxes/items/:id' do
    if logged_in?
      @box = Box.find(params[:id])
      @item = Item.find(params[:id])
      erb :'/items/show'
    else
      redirect_if_not_logged_in
    end
  end

  get '/boxes/:id/items/new' do
    if logged_in?
      @box = Box.find(params[:id])
      erb :'/items/new'
    else
      redirect_if_not_logged_in
    end
  end

  post '/boxes/:id/items' do
    if !params[:name].empty?
      @owner = current_user
      @box = Box.find(params[:id])
      @move = @box.move_id
      @item = Item.create(box_id: @box.id, move_id: @move, owner_id: @owner.id, name: params[:name])
      @box.items << @item
      @box.save
      @owner.save
      redirect to "/moves/boxes/#{@box.id}"
    else
      flash[:alert] = "Pleae don't leave blank content"
      redirect to '/moves/:id/items/new'
    end
  end
end
