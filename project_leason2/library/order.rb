$LOAD_PATH << File.dirname(__FILE__)
require 'book'


class Order
    attr_reader  :book, :order_date, :issue_date
    
    def initialize(book, issue_date)      
        #raise Exception not nil arguments       
        @book = book
        @order_date = Time.new
        @issue_date = issue_date
    end
    
    #maybe need a price or money something like this
    #def pay(issue_date)
    #  @issue_date = issue_date
    #end
    
    def to_s
      "#{book.title} of #{book.author} when #{order_date}"
    end
end
