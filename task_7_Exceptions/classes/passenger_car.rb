class PassengerCar < Car

  def initialize(manufacturer)
    @type = 'passenger'
    super(manufacturer)
  end

end