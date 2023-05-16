# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'

configure do 
   	@db = SQLite3::Database.new('barber.db')
	@db.execute('CREATE TABLE IF NOT EXISTS"Users"(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT,
		"userfname" VARCHAR(50),
		"userlname" VARCHER(50),
		"phone" VARCHAR(15),
		"datestemp" VARCHAR(20),
		"gender" VARCHAR(6),
		"barber" VARCHAR(50),
		"summary" TEXT)')

end


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

get '/contacts' do
   	erb :contacts
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

post '/client-review' do
   	
	@mail_name_client = params[:email_name]
	@mail_pass_client = params[:email_pass]	
	@mail_header_client = params[:email_header]
	@mail_text_client = params[:email_text]
	
	hash_email = {	:email_name => 'Enter email',
			:email_pass => 'Enter pass email',
			:email_header => 'Enter header',
			:email_text => 'Enter text'		
			}


	hash_email.each do |k, v|
	   	if params[k] == '' then
			@error = hash_email[k]
			return erb :contacts
		end
	end



	Pony.mail({
		:subject => @mail_header_client,
		:body => @mail_text_client,
		:to => 'project.testing@mail.ru',
		:from => @mail_name_client,
		:via => :smtp,
			:via_options => {
			:address => 'smtp.mail.ru',
			:port => '465',
			:tls => true,
			:user_name => @mail_name_client,
			:password => @mail_pass_client, 
			:authentication => :plain
  			}
		}
)
	

	erb('Thanks for your feedback!')


end


