
require './modules/manufacturer.rb'
require './modules/capacity.rb'

class Car
  include Manufacturer, Capacity, Validation
  attr_reader :type, :free_space

  def initialize(manufacturer, capacity)
    set_manufacturer(manufacturer)
    set_capacity(capacity)
    @free_space = capacity.to_i

    valid, msg = valid?(self)
    raise ValidationError.new(msg) if !valid
  end

  def occupied_space
    return (capacity - @free_space)
  end
  
end