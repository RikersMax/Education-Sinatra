# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
   	erb 'hello'	
end

get '/about' do
   	erb :about
end