class PhoneNumber
    include DataMapper::Resource
    property :phoneNo, Integer, :key => true
end