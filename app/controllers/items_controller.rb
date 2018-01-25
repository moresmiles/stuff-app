class ItemsController < ApplicationController

  get '/boxes/items/:id' do
    if !logged_in?
      redirect_to_login_page
    else
      @item = Item.find(params[:id])
      if @item.box.move.owner == current_user
      erb :'/items/show'
    else
      flash[:alert] = "Please only access your pages"
      redirect to "moves/boxes/#{current_box.id}"
    end
  end
end

  get '/boxes/:id/items/new' do
    if !logged_in?
      redirect_to_login_page
    else
      @box = Box.find(params[:id])
      if @box.move.owner == current_user
        erb :'/items/new'
      else
        flash[:alert] = "Please only access your pages"
        redirect to "boxes/#{current_box.id}/items/new"
      end
    end
  end

  post '/boxes/:id/items' do
    if params[:name].empty?
      flash[:alert] = "Pleae don't leave blank content"
      redirect to "/boxes/#{params[:id]}/items/new"
    else
      @box = Box.find(params[:id])
      if @box.move.owner == current_user
        @item = Item.create(box_id: @box.id, name: params[:name])
        @box.items << @item
        @box.move.owner.save
        flash[:message] = "Item Created"
        redirect to "/moves/boxes/#{@box.id}"
      else
        flash[:alert] = "Please only access your pages"
        redirect to "boxes/#{current_box.id}/items/new"
      end
    end
  end

  get '/boxes/items/:id/edit' do
    if !logged_in?
      redirect_to_login_page
    else
      @item = Item.find(params[:id])
      if @item.box.move.owner == current_user
      erb :'items/edit'
      else
        flash[:alert] = "Please only access your pages"
        redirect to "/moves/boxes/#{current_box.id}"
      end
    end
  end

  patch '/boxes/items/:id' do
    if params[:name].empty?
      flash[:message] = "Please don't leave blank field"
      redirect to "/boxes/items/#{params[:id]}/edit"
    else
      @item = Item.find(params[:id])
      if @item.box.move.owner == current_user
        @item.update(name: params[:name])
        flash[:message] = "Item Updated"
        redirect to "/boxes/items/#{@item.id}"
      else
        flash[:alert] = "Please only access your pages"
        redirect to "/moves/boxes/#{current_box.id}"
      end
    end
  end

  delete '/boxes/items/:id/delete' do
    if !logged_in?
      redirect_to_login_page
    else
      @item = Item.find(params[:id])
      if @item.box.move.owner == current_user
        @item.delete
        redirect to "/moves/boxes/#{@item.box_id}"
      else
        flash[:alert] = "Please only access your pages"
        redirect to "/moves/boxes/#{current_box.id}"
      end
    end
  end


end
