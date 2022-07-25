# frozen_string_literal: true

module Capacity
  def set_capacity(capacity)
    self.volume = capacity
  end

  def capacity
    volume
  end

  protected

  attr_accessor :volume
end
