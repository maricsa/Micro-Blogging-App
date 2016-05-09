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


get '/home' do
	@posts = Post.last(10)
	erb :home
end


get '/profile' do
	@posts = current_user.posts
	erb :profile
end


get '/members' do
	@users = User.all
	erb :members
end


get '/logout' do
	session.clear
	flash[:notice] = "You have successfully signed out of your session."
	erb :login
end


get '/profileupdate' do
	@user = current_user
	erb :profileupdate
end 


get '/delete-account' do
	@user = current_user
	erb :accountdelete
end


post '/sign-up' do

	#THE CODE below is an attempt to validate. Fix this later if you have time.
	# if params[:fname] = "" or params[:lname] = "" or params[:email] = "" or params[:username] = "" or params[:password] = "" or params[:age] = "" or params[:location] = ""
	# 	flash[:alert] = "There was a problem signing you in."
	# 	erb :login
@user = User.create!(fname: params[:fname], lname: params[:lname],email: params[:email], username: params[:username], password: params[:password], age: params[:age], location: params[:location])
	session[:user_id] = @user.id
		flash[:notice] = "Thank you for signing up!"
		redirect '/home'
end


post '/sign-in' do
	@user = User.where(username: params[:username]).first
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You are signed in successfully."
		redirect '/home'
	else
		flash[:alert] = "There was a problem signing you in."
		redirect '/'
	end
end


post '/new-post' do
	@post = Post.create!(user_id: current_user.id, body: params[:body], title: params[:title])

	redirect '/home'
end


post '/new-post-profile' do
	@post = Post.create!(user_id: current_user.id, body: params[:body], title: params[:title])

	redirect '/profile'
end


post '/profile-update' do
@user = current_user
current_user.update(fname: params[:fname], lname: params[:lname],email: params[:email], username: params[:username], password: params[:password], age: params[:age], location: params[:location])
		flash[:notice] = "Your profile has been updated."
		redirect '/profile'
end


get '/delete' do
	@user = current_user
	@user.delete
	session.clear
	flash[:notice] = "Your account has been deleted."
	redirect '/'
end


get '/:id' do
	@user = User.find(params[:id])
	erb :show
end






