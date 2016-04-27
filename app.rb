require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require './models'
require 'bundler/setup'
require 'rack-flash'

set :database, 'sqlite3:microblog.sqlite3'

get '/' do
	@users = User.all
	erb :home
end