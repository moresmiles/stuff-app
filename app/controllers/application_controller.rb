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

end
