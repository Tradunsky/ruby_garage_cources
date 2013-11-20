$LOAD_PATH << File.dirname(__FILE__)
require 'mail'

mail = Mail.new
p "...........................initialize.............................."
mail.send_parcel("Dneptopetrovsk", "Someware", "152", "152", "Tradunsky V.V.", 10)
mail.send_parcel("Kiev", "Someware", "152", "152", "Tradunsky V.V.", 9)
mail.send_parcel("Lviv", "Someware", "152", "152", "Tradunsky V.V.", 10)
mail.send_parcel("Dneptopetrovsk", "Someware", "152", "152", "Tradunsky V.V.", 15)
p "...............the number of parcels sent to some city............."
p mail.count_parcels_to_city("Dneptopetrovsk")
p "........how many parcels with value higher than 10 were sent......."
p mail.more_than(10)
p "..................what is the most popular address................."
p mail.most_popular_address

