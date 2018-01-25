class BoxesController < ApplicationController

  get '/moves/:id/boxes' do
    if !logged_in?
      redirect_to_login_page
    else
      @move = Move.find(params[:id])
      if @move.owner == current_user
      erb :'/boxes/boxes'
    else
      flash[:alert] = "Please only access your pages"
      redirect to "/moves/#{current_move.id}/boxes"
    end
  end
end

  get '/moves/:id/boxes/new' do
    if !logged_in?
      redirect_to_login_page
    else
      @move = Move.find(params[:id])
      if @move.owner == current_user
        erb :'boxes/new'
    else
      flash[:alert] = "Please only access your pages"
      redirect to "/moves/#{current_move.id}/boxes"
    end
  end
end

  post '/moves/:id/boxes' do
    if params[:name].empty? || params[:location].empty?
      flash[:alert] = "Pleae don't leave blank content"
      redirect to  "/moves/#{params[:id]}/boxes/new"
    else
      @move = Move.find(params[:id])
      if @move == current_move
        @box = Box.create(move_id: @move.id, name: params[:name], location: params[:location])
        @move.boxes << @box
        @move.save
        current_user.save
      redirect to "/moves/boxes/#{@box.id}"
    else
      flash[:alert] = "Please only access your pages"
      redirect_to_index_page
    end
  end
end

  get '/moves/boxes/:id' do
    if !logged_in?
      redirect_to_login_page
    else
      @box = Box.find(params[:id])
      if @box.move == current_move
        erb :'boxes/show'
      else
        flash[:alert] = "Please only access your pages"
        redirect to "/moves/boxes#{@box.id}"
      end
    end
  end

  get '/moves/:id/boxes/edit' do
    if !logged_in?
      redirect_to_login_page
    else
      @box = Box.find(params[:id])
      if @box.move == current_move
          erb :'/boxes/edit'
      else
        flash[:alert] = "Please only access your pages"
        redirect to "/moves/boxes#{@box.id}"
      end
    end
  end

  patch '/moves/boxes/:id' do
    if !params[:name].empty? && !params[:location].empty?
      flash[:message] = "Please don't leave blank fields"
      redirect to "/moves/#{params[:id]}/boxes/edit"
    else
      @box = Box.find(params[:id])
      if @box.move == current_move
        @box.update(name: params[:name], location: params[:location])
        flash[:message] = "Box Updated"
        redirect to "/moves/boxes/#{@box.id}"
      else
        flash[:alert] = "Please only access your pages"
        redirect_to_index_page
      end
    end
  end

  delete '/moves/:id/boxes/delete' do
   if !logged_in?
     redirect_to_login_page
   else
     @box = Box.find(params[:id])
     if @box.move == current_move
       @box.destroy
       redirect to "/moves/#{current_move.id}/boxes"
     else
      flash[:alert] = "Please only access your pages"
      redirect_to_index_page
      end
    end
  end

end
