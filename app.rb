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

get '/logout' do
	session.clear
	flash[:notice] = "You have successfully signed out of your session."
	erb :login
end

get '/profile' do
	
	@posts = current_user.posts
	erb :profile
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

	#THE CODE below is an attempt to validate. Fix this later if you have time.
	# if params[:fname] = "" or params[:lname] = "" or params[:email] = "" or params[:username] = "" or params[:password] = "" or params[:age] = "" or params[:location] = ""
	# 	flash[:alert] = "There was a problem signing you in."
	# 	erb :login
@user = User.create!(fname: params[:fname], lname: params[:lname],email: params[:email], username: params[:username], password: params[:password], age: params[:age], location: params[:location])
		flash[:notice] = "Thank you for signing up!"
		erb :home
end

post '/new-post' do
	@post = Posts.create!(user_id: current_user.id, body: params[:body], title: params[:title])

	erb :profile
end
