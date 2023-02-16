#encoding: UTF-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Вход'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path 
    halt erb(:login_form)
  end
end


get '/' do
	erb 'Главная страница'
end

get '/warehours' do
   	erb :warehours
end

get '/add' do
   	erb :add
end

get '/login' do
   	erb :login_form
end

post '/login/access' do 
	
if params['users'] == 'admin' && params['userspass'] == 'admin'
	session[:identity] = params['users']
	where_user_came_from = session[:previous_url] || '/'
	redirect to where_user_came_from
else
	@access = 'Accsess denied'
	erb :login_form
end

end