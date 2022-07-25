
=begin
module MyAttrAccessor

  def my_attr_accessor(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end
end

class Test
  extend MyAttrAccessor

  my_attr_accessor :my_attr, :a, :b, :c
end
=end

puts "Enter string"
str = gets.chomp

puts "Enter method name"
method = gets.chomp.to_sym

puts str.send(method)