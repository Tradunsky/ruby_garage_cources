$LOAD_PATH << File.dirname(__FILE__)
require 'parcel'

class Mail
  attr_accessor :parcels 
  
  def initialize
    @parcels = Array.new
  end
  
  def send_parcel(city, street, house, apartment, destination, value)
    @parcels << Parcel.new(city, street, house, apartment, destination, value)
  end
  
  #the number of parcels sent to some city
  def count_parcels_to_city(city)
    @parcels.find_all {|parcel| parcel.city == city}.size
  end
  
	#how many parcels with value higher than 10 were sent
	def more_than(value)
	  @parcels.find_all {|parcel| parcel.value>value}.size
	end
		
	#what is the most popular address
	def most_popular_address
	  most_popular = @parcels.sort_by do |parcel|
	    #"#{parcel.city} #{parcel.street} #{parcel.house} #{parcel.apartment}"
	    parcel.address
	  end
	  most_popular.first.address
	end
end
