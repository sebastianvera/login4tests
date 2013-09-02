#encode: uft-8
require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/flash"
require 'slim'

enable "sessions"

username="foo"
password="bar"

helpers do
   def logged?
      session[:user]
   end
end

get '/' do
   slim :index
end

get '/login' do
   @title = "Login"
   if logged?
      flash[:logged] = "You are already logged in!"
      redirect '/'
   end
   slim :login
end

post '/login' do
   if params[:username] == username && params[:password] == password
      session[:user] = true
      flash[:logged_in] = "You are now logged in!"
      redirect "/"
   else
      @error = "Incorrect username or password"
      slim :login
   end
end

get '/logout' do
   session[:user] = nil
   flash[:logged_out] = "You have successfully logged out!"
   redirect '/'
end

