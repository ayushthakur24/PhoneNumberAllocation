
class SpecialPhoneNumber
    include DataMapper::Resource
    property :phoneNo, Integer, :key => true
end