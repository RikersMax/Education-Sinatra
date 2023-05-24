# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'

def is_barber_exists? (data_base, name)
	data_base.execute('SELECT * FROM Barbers where barbername=?', [name]).length > 0
end


def seed_db (data_base, barbers)

	barbers.each do |barb|
		if !is_barber_exists?(data_base, barb)
			data_base.execute('INSERT INTO Barbers (barbername) VALUES (?)', [barb]) 
		end 
	end

end


def db_get
   	return SQLite3::Database.new('barber.db')
end

configure do 
   	db = db_get
	db.execute('CREATE TABLE IF NOT EXISTS "Users"(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT,
		"userfname" VARCHAR(50),
		"userlname" VARCHER(50),
		"phone" VARCHAR(15),
		"datestemp" VARCHAR(20),
		"gender" VARCHAR(6),
		"barber" VARCHAR(50),
		"summary" TEXT)')

	db.execute('CREATE TABLE IF NOT EXISTS "Barbers"(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT,
		"barbername" VARCHAR(50))')	


	seed_db(db, ['Nastia', 'Kris', 'lora'])


end

before do
   	db = db_get
	db.results_as_hash = true

	@barber_name = []
	db.execute('SELECT * FROM Barbers') do |row|
		@barber_name << row['barbername']	   	
	end

end


get '/test' do
	db = db_get
	db.results_as_hash = true
	
	@show_user = ''
	@arr_db = []
        
	db.execute('SELECT * FROM Users') do |row|			
        	@arr_db << row			
	end
	
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

	


	db = db_get
	db.execute('INSERT INTO Users
		(
		userfname,
		userlname,
		phone,
		datestemp,
		gender,
		barber,
		summary
		)
		VALUES(?, ?, ?, ?, ?, ?, ?)',
		[@user_fname_client, @user_lname_client, @user_phone_client, @user_time_client, @user_gender_client, @pairdresser_name_client, @user_text_client])
	




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














