# frozen_string_literal: true

class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  
  def initialize(number, manufacturer)
    @type = 'passenger'
    super(number, manufacturer)
  end
end
