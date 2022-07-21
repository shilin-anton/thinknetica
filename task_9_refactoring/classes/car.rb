# frozen_string_literal: true

require './modules/manufacturer'
require './modules/capacity'

class Car
  include Validation
  include Capacity
  include Manufacturer
  attr_reader :type, :free_space

  def initialize(manufacturer, capacity)
    set_manufacturer(manufacturer)
    set_capacity(capacity)
    @free_space = capacity.to_i

    valid, msg = valid?(self)
    raise ValidationError, msg unless valid
  end

  def occupied_space
    (capacity - @free_space)
  end
end
