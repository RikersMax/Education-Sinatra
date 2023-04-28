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