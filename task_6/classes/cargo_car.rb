class CargoCar < Car

  def initialize(manufacturer)
    super(manufacturer)
    @type = 'cargo'
  end

end