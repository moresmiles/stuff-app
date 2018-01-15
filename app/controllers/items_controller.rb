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
      flash[:message] = "Item Created"
      redirect to "/moves/boxes/#{@box.id}"
    else
      flash[:alert] = "Pleae don't leave blank content"
      redirect to '/moves/:id/items/new'
    end
  end

  get '/boxes/items/:id/edit' do
    if logged_in?
      @item = Item.find(params[:id])
      erb :'items/edit'
    else
      redirect_if_not_logged_in
    end
  end

  patch '/boxes/items/:id' do
    if !params[:name].empty?
      @item = Item.find(params[:id])
      @item.update(name: params[:name])
      flash[:message] = "Item Updated"
      redirect to "/boxes/items/#{@item.id}"
    else
      flash[:message] = "Please don't leave blank field"
      redirect to "/boxes/items/#{@item.id}/edit"
    end
  end

  delete '/boxes/items/:id/delete' do
    if logged_in?
      @item = Item.find(params[:id])
      @item.delete
      redirect to "/moves/boxes/#{@item.box_id}"
    else
      redirect_if_not_logged_in
    end
  end


end
