class Book
    attr_reader :title, :author
    attr_accessor :rate
    
    def initialize(title, author)
        @title, @author, @rate = title, author, 0
    end
    
    def rateUp
        @rate+=1
    end
    
    def ==(other_book)
      ((@title == other_book.title)&&(@author == other_book.author))
    end
end
