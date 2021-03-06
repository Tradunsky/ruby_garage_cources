class Parcel
  attr_reader :city, :street, :house, :apartment, :destination, :value
  
  def initialize(city, street, house, apartment, destination, value)
    @city = city
    @street = street 
    @house = house
    @apartment = apartment
    @destination = destination
    @value = value
  end
  
  def address
    "#{@city} #{@street} #{@house} #{@apartment}"
  end
end
