$LOAD_PATH << File.dirname(__FILE__)
require 'library'

p "initializing data..."
library = Library.new
sammervil = Book.new("UML basics", "Sammervil")
anderson = Book.new("Funny storyes:)", "Anderson")
lolbook = Book.new("Some lol book", "Lol")
library.books = [anderson, sammervil, lolbook]

p ".....................make_order......................."
library.make_order("Watson", ["Some lol book", "Funny storyes:)"], ["Lol", "Anderson"], [Time.new(2020,1), Time.new(2014,1)])
library.make_order("Holms", ["Funny storyes:)"], ["Anderson"], [Time.new(2014,1)])
library.make_order("Slavik", ["UML basics"], ["Sammervil"], [Time.new(2015,1)])
library.make_order("Holms", ["UML basics"], ["Sammervil"], [Time.new(2015,1)])
library.make_order("Watson", ["UML basics"], ["Sammervil"], [Time.new(2015,1)])
library.make_order("Slavik", ["Not exist"], ["unknow"], [Time.new(2015,1)])

#task

p "..the smallest period for which library found a book.."
  book_with_min_period = library.min_date_period
  p "Book: \"#{book_with_min_period.book.title}\" on #{book_with_min_period.order_date} - #{book_with_min_period.issue_date}"
p "......................................................"

p "..........how many orders were not satisfied.........."
p library.not_satisfied_orders
p "......................................................"

p "..............who often takes the book................"
p "Best reader: #{library.best_reader.name}"
p "......................................................"

p ".............what is the most popular book............"
  popular_books = library.most_popular
  popular_books.each_with_index {|book, index| p "#{index+1}. #{book.title}"}
p "......................................................"

p "how many people ordered one of the three most popular books"
p library.count_people_ordered_most_popular_books(1)
p "......................................................"
