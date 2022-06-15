
require './modules/manufacturer.rb'

class Car
  include Manufacturer
  attr_reader :type

  def initialize(manufacturer)
    set_manufacturer(manufacturer)
  end
  
end