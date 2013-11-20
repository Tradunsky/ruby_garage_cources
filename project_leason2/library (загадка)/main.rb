$LOAD_PATH << File.dirname(__FILE__)
require 'library'

p "initializing data..."
library = Library.new
anderson = Book.new("Funny storyes:)", "Anderson")
sammervil = Book.new("UML basics", "Sammervil")
lolbook = Book.new("Some lol book", "Lol")
library.books = [anderson, sammervil, lolbook]

p ".....................make_order......................."
library.make_order("Watson", ["Some lol book", "Funny storyes:)"], ["Lol", "Anderson"], [Time.now, Time.now])
library.make_order("Holms", ["Funny storyes:)"], ["Anderson"], [Time.now])
library.make_order("Slavik", ["UML basics"], ["Sammervil"], [Time.now])

p "...................check orders start................."
p library.readers["Watson"].to_s
p "......................................................"

p "..the smallest period for which library found a book.."
p library.min_date_period
p "......................................................"

p ".............what is the most popular book............"
p library.most_popular
p "......................................................"

p "how many people ordered one of the three most popular books"
p library.count_people_ordered_most_popular_books(3)
p "......................................................"
