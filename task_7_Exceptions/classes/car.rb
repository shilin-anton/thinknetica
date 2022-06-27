
require './modules/manufacturer.rb'

class Car
  include Manufacturer, Validation
  attr_reader :type

  def initialize(manufacturer)
    set_manufacturer(manufacturer)

    valid, msg = valid?(self)
    raise ValidationError.new(msg) if !valid
  end
  
end