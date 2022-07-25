require './modules/errors'

module MetaValidation
  VALIDATIONS = [:presence, :format, :type]

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def validations
      @validations || []
    end

    def validate(attr_name, validation_type, arg = nil)
      if VALIDATIONS.include?(validation_type.to_sym)
        validation = { attr_name: attr_name, validation_type: validation_type, arg: arg }
        instance_variable_set(:@validations, validations.push(validation))
      else
        raise NoValidation, validation_type
      end    
    end
  end

  module InstanceMethods

    def perform_validation(validation)
      case validation[:validation_type]
      when :presence
        check_presence(validation[:attr_name])
      when :format
        check_format(validation[:attr_name], validation[:arg])
      when :type
        check_type(validation[:attr_name], validation[:arg])
      else
        raise NoValidation.new(validation[:validation_type])
      end
    end

    def validate!
      self.class.validations.each do |validation|
        perform_validation(validation)
      end
    end

    def valid?
      validate!
      true
    rescue NoValidation, NotPresented, WrongTypeFormat
      false  
    end

    private

    def check_presence(name)
      value = instance_variable_get("@#{name}")
      raise NotPresented.new if value.nil? || value == ''
    end

    def check_format(name, arg_format)
      value = instance_variable_get("@#{name}".to_sym)
      raise WrongTypeFormat.new(arg_format) unless value =~ arg_format
    end

    def check_type(name, class_name)
      arg_class = instance_variable_get("@#{name}").class
      raise WrongTypeFormat.new(class_name) unless arg_class == class_name
    end
  end

end