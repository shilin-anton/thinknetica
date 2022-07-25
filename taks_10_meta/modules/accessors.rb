
module Accessors

  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      name = "@#{attr}".to_sym
      history = "@#{attr}_history".to_sym

      define_method(attr) { instance_variable_get(name) }

      define_method("#{attr}_history".to_sym) { instance_variable_get(history) }

      define_method("#{attr}=".to_sym) do |value| 
        instance_variable_set(name, value)
        prev_history = instance_variable_get(history)
        instance_variable_set(history, prev_history.nil? ? [value] : prev_history << value)
      end
    end
  end

  def strong_attr_accessor(attr, attr_class)
    name = "@#{attr}".to_sym
    
    define_method(attr) { instance_variable_get(name) }
    
    define_method("#{attr}=".to_sym) do |value|
      raise ClassMatchError unless value.class == attr_class
      instance_variable_set(name, value)
    end
  end

  class ClassMatchError < StandardError
    def initialize
      puts "!!!EXCEPTION!!! Value class does not match passed class name!"
      super
    end
  end

end