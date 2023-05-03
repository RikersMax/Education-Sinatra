# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
   	erb :start	
end

get '/about' do
   	erb :about
end

get '/visit' do
   	erb :visit
end

get '/services' do
   	erb :services
end

post '/visit-client' do
   	@user_fname_client = params[:user_fname]
	@user_lnaem_client = params[:user_lname]
	@user_phone_client = params[:user_phone]
	@user_time_client = params[:user_time]
	@user_gender_client = params[:gender]
	@pairdresser_name_client = params[:barber_name]
	@user_text_client = params[:user_text]


	erb("Good! <p><b>#{@user_fname_client.capitalize} #{@user_lnaem_client.capitalize}</b><p> 
	you will come to visit us on <b>#{@user_time_client}</b> <p>Will be waiting for you</p> <b>#{@pairdresser_name_client}</b>")	
	
end