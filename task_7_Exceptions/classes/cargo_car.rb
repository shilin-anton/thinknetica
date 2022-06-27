class CargoCar < Car

  def initialize(manufacturer)
    @type = 'cargo'
    super(manufacturer)
  end

end