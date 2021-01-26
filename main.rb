require 'data_mapper'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/PhoneNumber.db")

require '.\PhoneNumber.rb'
require '.\SpecialPhoneNumber.rb'


get '/' do
    erb :main
end


get '/allotNumber' do
    defaultphoneNumber = PhoneNumber.last.phoneNo
    if !defaultphoneNumber
        defaultphoneNumber = 1111111110
    end
    defaultphoneNumber = defaultphoneNumber
    defaultphoneNumber = defaultphoneNumber + 1
    while( SpecialPhoneNumber.get( defaultphoneNumber ) )
        defaultphoneNumber = defaultphoneNumber + 1
    end
    phoneNumber  = PhoneNumber.new 
    phoneNumber.phoneNo = defaultphoneNumber
    phoneNumber.save
    session[:message] = defaultphoneNumber.to_s + ' number allocated'

    erb :main
end

post '/allotNumber' do
    if params[:number]
        if( !( SpecialPhoneNumber.get(params[:number].to_i ) || PhoneNumber.get( params[:number].to_i )) )# not in the database
            specialNumber = SpecialPhoneNumber.new 
            specialNumber.phoneNo = params[:number].to_i
            specialNumber.save
            session[:message] =  params[:number] +" successfully allocated" 
        else
            session[:message] =  "sorry" + params[:number] +" has already been allocated "
        end
    end
    erb :main
end


get '/allotSpecialNumber' do
    erb :specialNumber
end


DataMapper.finalize

