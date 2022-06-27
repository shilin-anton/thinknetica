class PassengerTrain < Train

  def initialize(number, manufacturer)
    @type = 'passenger'
    super(number, manufacturer)
  end

end