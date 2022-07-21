class PassengerCar < Car

  def initialize(manufacturer, capacity)
    @type = 'passenger'
    super(manufacturer, capacity)
  end

  def take_space
    if @free_space > 0
      @free_space -= 1
      puts "В вагоне #{self} занято место! Осталось: #{@free_space}"
    else
      puts "В вагоне #{self} нет свободных мест!"
    end
  end

end