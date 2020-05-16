require_relative 'grpc_server'
require 'sinatra'

get '/' do
    'Welcome to the Sinatra API test'
end

get '/test' do
    'Here we are testing the opportunity to access other websites'
end

get '/result' do
    'It is as easy as it can be!'
end