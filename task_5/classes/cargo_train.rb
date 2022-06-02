class CargoTrain < Train

  def initialize(number)
    super(number)
    @type = 'cargo'
    puts "Создан грузовой поезд №#{@number}"
  end

end