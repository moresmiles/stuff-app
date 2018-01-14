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
end
