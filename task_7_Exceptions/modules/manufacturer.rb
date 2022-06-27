
module Manufacturer
  def set_manufacturer(manufacturer)
    self.company_name = manufacturer
  end

  def manufacturer
    self.company_name
  end

  protected
  attr_accessor :company_name
end