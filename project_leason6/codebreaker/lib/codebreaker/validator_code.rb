module CodeValidator
  class Matcher
    def initialize(attribute)
      @attribute = attribute      
    end
  
    def matches?(code, size, max_number)
      @errors = []
      @errors << "#{code.class}: #{code} should have size of #{size}" unless (code.size==size)
      @errors << "should contains number from 1 to #{max_number}" unless (code =~ /^$[1-#{max_number}]{#{size}}/)
      @errors.empty?
    end
    
    def failure_message
      @errors.each {|message| fail_message = message + "\n"}
      fail_message
    end
    
    def valid_code?(code, size, max_number)
      Matcher.new(code)
    end
  end
end
