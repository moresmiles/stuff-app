require './config/environment'
require 'rack-flash'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash
use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
  get '/' do
    erb :index
  end
    erb :welcome
  end

  helpers do

   def logged_in?
     !!session[:user_id]
   end

   def current_user
     Owner.find(session[:user_id])
   end

   def current_move
     current_user.moves.find_by(params[:id])
   end

   def redirect_if_not_logged_in
     if !logged_in?
       redirect "/login"
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
