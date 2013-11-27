#class Module
  def attribute arg, &block            
      
    variable, value = (arg.is_a?(Hash))? [arg.keys[0].to_s, arg.values[0]]: [arg.to_s, 0];                   
    
    if block_given?
       value = :var
       define_method(value, &block)
    end
    
    #module_eval "def #{variable}; @#{variable}? @#{variable}:@#{variable} = #{value}; @#{variable}; end"
    module_eval "def #{variable}; @#{variable}||=#{value}; end"
    module_eval "def #{variable}=(value); @#{variable} = value; end"
    module_eval "def #{variable}?; @#{variable}? true: false; end"                      
  end
    
#end
