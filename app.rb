# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/test_jquery' do
   	erb :page_test
end

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
	@user_lname_client = params[:user_lname]
	@user_phone_client = params[:user_phone]
	@user_time_client = params[:user_time]
	@user_gender_client = params[:gender]
	@pairdresser_name_client = params[:barber_name]
	@user_text_client = params[:user_text]

	hash_error = { 	
			:user_fname => 'Enter first name',
			:user_lname => 'Enter last neme',
			:user_phone => 'Enter phone',
			:user_time => 'Enter date'
			}


	hash_error.each do |k, v|
	        if params[k] == '' then
	           	@error = hash_error[k]
			return erb :visit
		end	   	
	end
	



	erb("Good! <p><b>#{@user_fname_client.capitalize} #{@user_lname_client.capitalize}</b><p> 
	you will come to visit us on <b>#{@user_time_client}</b> <p>Will be waiting for you</p> <b>#{@pairdresser_name_client}</b>")	
	
end