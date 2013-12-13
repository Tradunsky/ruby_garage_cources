module Codebreaker
  module Matchers
    class CodeValidator
      def initialize(size, max_number)
        @size, @max_number = size, max_number      
      end
    
      def matches?(code)
        @errors = []
        @errors << "Code: #{code} should have size of #{@size}" unless (code.size==@size)
        @errors << "Code: #{code} should contains number from 1 to #{@max_number}" unless (code =~ /[1-#{@max_number}]{#{@size}}/)
        @errors.empty?
      end
      
      def failure_message
        @errors.join("\n")
      end        
    end    
    def valid_code(size, max_number)
        Matchers::CodeValidator.new(size, max_number)
    end  
  end
end
