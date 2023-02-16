#encoding: UTF-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
#require './check/logins.rb'
require './table/create_table.rb'

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
	erb "Главная страница!"
end

get '/warehours' do
   	erb :warehours
end

get '/stock' do 
	system "D:\Ruby My Project\job\86_workshop\table\start app.rb" 			

	@file_stock = File.open('D:\Ruby My Project\job\86_workshop\public\table.txt').read
   	erb :stock
end

get '/add' do
   	erb :add
end

get '/sets' do
    	erb :remotebox
end


get '/login' do
	@access = 'Должность'
   	erb :login_form
end

get '/logout' do	
	session.delete(:identity)
        redirect to '/'
end



post '/login/access' do 

#check_ligon = Positional.new([params[:user_login].to_s, params[:user_pass].to_s])
#check_login.check
#check_login.result

if params['user_login'] == 'admin' && params['user_pass'] == 'admin'
	session[:identity] = params['user_login']
	where_user_came_from = session[:previous_url] || '/'
	redirect to where_user_came_from
	
else	
	@access = 'Не верный пароль'
	erb :login_form
end

end



post '/usselect' do
   	erb "<h2>#{params[:userselect1]}<br />#{params[:allsum]}<br /#{params[:datecreatebox]}<br />#{params[:datemaster]}</h2>"
end










