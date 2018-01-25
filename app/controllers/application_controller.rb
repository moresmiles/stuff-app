require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  get '/practice' do
    erb :practice
  end

  helpers do

   def logged_in?
     !!session[:user_id]
     !!current_user
   end

   def current_user
     Owner.find(session[:user_id])
    @current_user ||= Owner.find_by(:id => session[:user_id]) if session[:user_id]
   end

   def current_move
     current_user.moves.find_by(params[:id])
   end

   def redirect_if_not_logged_in
     if !logged_in?
       redirect "/login"
   def current_box
     current_move.boxes.find_by(params[:id])
   end

   def redirect_to_login_page
       redirect to "/login"
     end
   end

   def redirect_to_index_page
     redirect to "/"
   end

   def redirect_to_owner_page
     redirect to "/owners/:id"
   end
 end


end
