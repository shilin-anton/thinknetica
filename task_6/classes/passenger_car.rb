class PassengerCar < Car

  def initialize(manufacturer)
    super(manufacturer)
    @type = 'passenger'
  end

end