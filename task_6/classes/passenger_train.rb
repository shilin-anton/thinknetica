class PassengerTrain < Train

  def initialize(number, manufacturer)
    super(number, manufacturer)
    @type = 'passenger'
    puts "Создан пассажирский поезд №#{@number}, производитель: #{manufacturer}"
  end

end