$LOAD_PATH << File.dirname(__FILE__)
require 'book'
require 'reader'


class Library   
    attr_accessor :readers, :books
    #how many orders were not satisfied
    attr_reader :not_satisfied_orders
    
    def initialize()
        @readers = Hash.new
        @books = Array.new
        @not_satisfied_orders = 0
    end
    
    def make_order(name, book_titles, book_authors, issue_dates)
        #out info messages:
        # - books not found
        # - lib have a many books, list it and choose all or one of them. 
        searched_books = @books.map do |book|  # will be returned one of many equal book(books titles and authors)
          book_titles.zip(book_authors).detect do |book_title, book_author|
            if book.title.eql?(book_title) && 
               book.author.eql?(book_author)
              book.rateUp
              book
            end
          end            
        end
        searched_books = searched_books.compact #compact is not required
        books_was_not_found = 0        
        books_was_not_found = book_titles.size - searched_books.size
        unless books_was_not_found == 0
          @not_found_books += books_was_not_found;                      
        else
          @readers.store(name, Reader.new(name)) unless @readers.key?(name)
          @readers[name].order(searched_books, issue_dates)
        end
    end
    
    #the smallest period for which library found a book
    def min_date_period(date_format='%Y-%m-%d %H:%M')    
      reader_min_period = @readers.first.fetch(1).orders.first
      @readers.each do |name, reader| 
        min_period = reader.orders.min_by do |order| 
           order.issue_date - order.order_date
        end
        reader_min_period = min_period if (reader_min_period.issue_date - reader_min_period.order_date) > (min_period.issue_date - min_period.order_date)
      end
      reader_min_period.issue_date.strftime(date_format)
      reader_min_period.order_date.strftime(date_format)
      "Book: #{reader_min_period.book} on #{reader_min_period.order_date} - #{reader_min_period.issue_date}"
    end
    
    #what is the most popular book
    def most_popular
      @books.sort_by {|book| book.rate}
    end
    
    #how many people ordered one of the three most popular books.
    def count_people_ordered_most_popular_books(count_of_popular_books)
      most_popular_books = most_popular
      people = Array.new
      most_popular_books[0..count_of_popular_books].each do |book|
        @readers.each do |name, value|
          value.orders.detect do |order|
#            p "order.book="+order.book.to_s
#            p "book="+book.title.to_s
            p "Book.class= "+order.book.class.to_s
            people << value if book == order.book
          end
        end          
      end
      return people.size #maybe a good idea return all people?
    end
end
