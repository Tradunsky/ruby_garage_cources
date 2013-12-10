# Please implement your own class 'Factory' which 
# will have the same behavior as 'Struct' class.

# For exmpl: Struct.new(:name, :address, :zip)

class Factory  
  def self.new(*keys, &block)
     Class.new do
         module_eval(&block) if block_given?        
         keys.each do |key|
           attr_accessor key.to_sym
         end          
         
         define_method "initialize".to_sym do |*values|
           keys.each_with_index do |key, index|
             instance_eval "@#{key} = values[index]"
           end
         end       
     end
  end    
end

Customer = Factory.new(:name, :address, :zip)do
  def hi
    p "Hi man!"
  end
end
#p Customer.methods.grep(/name/)
cus = Customer.new("Slavik", "Somewhere", 123) 
p "Nam: "+cus.name.to_s+"; address: "+cus.address.to_s+"; zip: "+cus.zip.to_s
p cus.hi
