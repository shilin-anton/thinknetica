# frozen_string_literal: true

class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  
  def initialize(number, manufacturer)
    @type = 'cargo'
    super(number, manufacturer)
  end
end
