# frozen_string_literal: true

module Manufacturer
  def set_manufacturer(manufacturer)
    self.company_name = manufacturer
  end

  def manufacturer
    company_name
  end

  protected

  attr_accessor :company_name
end
