class MovesController < ApplicationController

  get '/moves' do
    if logged_in?
      @moves = current_user.moves.all
      erb :'/moves/all_moves'
    else
      redirect_if_not_logged_in
    end
  end
end
