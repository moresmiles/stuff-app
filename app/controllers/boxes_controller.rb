class BoxesController < ApplicationController

  get '/moves/:id/boxes' do
    if logged_in?
      @move = current_move
      erb :'/boxes/boxes'
    else
      redirect_if_not_logged_in
    end
  end
end
