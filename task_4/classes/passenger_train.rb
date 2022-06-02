class PassengerTrain < Train

  def initialize(number)
    super(number)
    @type = 'passenger'
    puts "Создан пассажирский поезд №#{@number}"
  end

end