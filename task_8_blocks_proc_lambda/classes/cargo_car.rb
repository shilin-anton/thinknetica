class CargoCar < Car

  def initialize(manufacturer, capacity)
    @type = 'cargo'
    super(manufacturer, capacity)
  end

  def take_space(volume)
    if @free_space > 0 && @free_space >= volume
      @free_space -= volume
      puts "У вагона #{self} занят объем == #{volume}! \n Свободный объем: #{@free_space}"
    else
      puts "У вагона #{self} недостаточно объема! \n Свободный объем: #{@free_space}"
    end
  end
end