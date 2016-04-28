require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require './models'
require 'bundler/setup'
require 'rack-flash'

enable :sessions
use Rack::Flash, :sweep => true

configure(:development){set :database, 'sqlite3:microblog.sqlite3'}
#will set logins to a session
set :sessions, true

# this will notify us whether a user is signed in
def current_user     
	if session[:user_id]       
		@current_user = User.find(session[:user_id])     
	end   
end


get '/' do
	@users = User.all
	erb :login
end


post '/sign-in' do
	@user = User.where(username: params[:username]).first
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You are signed in successfully."
		erb :home
	else
		flash[:alert] = "There was a problem signing you in."
		erb :login
	end
end

post '/sign-up' do
	@user = User.create!(fname: params[:fname])
	User.create!(lname: params[:lname])
	User.create!(email: params[:email])
	User.create!(username: params[:username])
	User.create!(password: params[:password])
	User.create!(age: params[:age])
	User.create!(location: params[:location])
end