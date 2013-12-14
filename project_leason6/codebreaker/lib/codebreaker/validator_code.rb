module Codebreaker
  class CodeValidator
    attr_accessor :size, :max_number
      
    def initialize(size, max_number)
      @size, @max_number = size, max_number      
    end
   
    def valid?(code)
      @errors = []
      @errors << "Code: #{code} should have size of #{@size}" unless (code.size==@size)
      @errors << "Code: #{code} should contains number from 1 to #{@max_number}" unless (code =~ /[1-#{@max_number}]{#{@size}}/)
      @errors.empty?
    end
    
    def failure_message
       @errors.join("\n")
       #@errors * "\n" #another ruby way
    end  
      
    def has_errors?
      @errors.empty?
    end                    
  end
end
