$LOAD_PATH << File.dirname(__FILE__)
require 'book'
require 'order'

class Reader
    attr_accessor :orders
    attr_reader :name
    
    def initialize(name)
        #raise Exception not nil parameters
        @name = name
        @orders = Array.new
    end
    
    def order(books, issue_dates)
        #maybe check other parameters for nil     
        books.zip(issue_dates).each do |book, issue_date|
          @orders << Order.new(book, issue_date) if book          
        end
    end
    
    def to_s
        @name +" reads: "+ @orders.to_s
    end   
end
