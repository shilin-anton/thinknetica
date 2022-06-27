class CargoTrain < Train

  def initialize(number, manufacturer)
    @type = 'cargo'
    super(number, manufacturer)
  end

end