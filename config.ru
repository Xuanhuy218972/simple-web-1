$LOAD_PATH.unshift << '.'
require 'lib/frack'
require 'app/controllers/users_controller'
require 'app/controllers/home_controller'
require 'app/controllers/sessions_controller'
require 'app/models/user'
require_relative 'lib/middlewares/logger_middleware'
require 'rack/session/cookie'

use Rack::Static, root: 'public', urls: ['/images', '/js', '/css']
use LoggerMiddleware

use Frack::Router do 
    get '/sign_up' => 'users#new'
    post '/users/sign_up' => 'users#create'
    post '/sign_in' => 'sessions#create'
    delete '/sign_out' => 'sessions#destroy'
    get '/users' => 'users#index'
    post '/users' => 'users#create'
    get "/" => 'home#show'
end

use Rack::Session::Cookie, 
    key:'rack.session',
    path: '/',
    secret: 'your_secret_key_0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'

run Frack::Application