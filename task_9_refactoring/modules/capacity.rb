

module Capacity
  def set_capacity(capacity)
    self.volume = capacity.to_i
  end

  def capacity
    self.volume
  end

  protected
  attr_accessor :volume
end