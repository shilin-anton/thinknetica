class CargoTrain < Train

  def initialize(number, manufacturer)
    super(number, manufacturer)
    @type = 'cargo'
    puts "Создан грузовой поезд №#{@number}, производитель: #{manufacturer}"
  end

end