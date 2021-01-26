require 'data_mapper'
require 'sinatra'
require 'sinatra/reloader'

DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/PhoneNumber.db")


DataMapper.finalize
