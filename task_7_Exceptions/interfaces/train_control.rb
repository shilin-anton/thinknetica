require './classes/train.rb'
require './classes/cargo_train.rb'
require './classes/passenger_train.rb'
require './classes/car.rb'
require './classes/passenger_car.rb'
require './classes/cargo_car.rb'

require './modules/validation.rb'

class TrainControl
include Validation

  def initialize(main_data)
    @main_data = main_data
  end

  def start
    puts "\n\nУПРАВЛЕНИЕ ПОЕЗДАМИ"
    puts "1 - Создать поезд"
    puts "2 - Назначить маршрут"
    puts "3 - Добавить вагон"
    puts "4 - Отцепить вагон"
    puts "5 - Отправиться на следующую станцию"
    puts "6 - Отправиться на предыдущую станцию"
    puts "7 - Запросить список поездов"
    # puts "8 - Вызвать метод find"
    puts "0 или любой текст - Вернуться в главное меню"

    action = gets.chomp.to_i

    case action
      when 1
        system 'clear'
        create_train
      when 2
        system 'clear'
        set_route
      when 3
        system 'clear'
        add_car
      when 4
        system 'clear'
        remove_car
      when 5
        system 'clear'
        move_forward
      when 6
        system 'clear'
        move_backward
      when 7
        system 'clear'
        get_trains
      # when 8
      #   system 'clear'
      #   call_find
      else
        @main_data.start
    end
  end

private 

  def create_train
    puts "Выберите тип поезда:"
    
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
    type = gets.chomp.to_i
    
    puts "Введите № поезда"
    number = gets.chomp

    puts "Укажите производителя поезда:"
    manufacturer = gets.chomp
  
    if type == 1
      train = PassengerTrain.new(number, manufacturer)
    elsif type == 2
      train = CargoTrain.new(number, manufacturer)
    else
      train = Train.new(number, manufacturer)
    end

    rescue ValidationError
      puts 'Попробуйте ещё раз!'
      retry
    else
      @main_data.trains << train
      system 'clear'
      puts "Поезд #{train} создан успешно!"
  end

  def set_route
    start if is_trains_empty?

    if @main_data.routes.empty?
      system 'clear'
      puts "Сначала нужно создать хотя бы один маршрут из главного меню"
      start
    end

    puts "Выберите поезд, которому назначить маршрут:"

    @main_data.trains.each_with_index do |train, index|
      puts "#{index+1}: Поезд №#{train.number}, Тип: #{train.type}"
    end

    ind = gets.chomp.to_i - 1

    if @main_data.trains.at(ind).nil?
      system 'clear'
      puts "Похоже, что такого поезда нет.. Попробуйте ещё раз"
      set_route
    else
      puts "Выберите маршрут:"

      @main_data.routes.each_with_index do |route, index|
        puts "#{index+1}: Маршрут #{route.stations.first.name} - #{route.stations.last.name}"
      end

      ind = gets.chomp.to_i - 1

      if @main_data.routes.at(ind).nil?
        system 'clear'
        puts "Похоже, что такого маршрута нет.. Попробуйте ещё раз"
        set_route
      else
        system 'clear'
        @main_data.trains.at(ind).set_route(@main_data.routes.at(ind))
        start
      end
    end
  end

  def add_car
    start if is_trains_empty?

    puts "Выберите поезд, к которому нужно прицепить вагон:"
    train = select_train_from_list(@main_data.trains)

    if train.nil?
      system 'clear'
      puts "Похоже, что такого поезда нет.. Попробуйте ещё раз"
      add_car
    end
  
    train.stop

    puts "Укажите производителя вагона:"
    manufacturer = gets.chomp
      
    if train.type == 'cargo' 
      car = CargoCar.new(manufacturer)
    elsif train.type == 'passenger'
      car = PassengerCar.new(manufacturer)
    else
      car = Car.new(manufacturer)
    end

    rescue ValidationError
      puts 'Попробуйте ещё раз!'
      retry
    else
      system 'clear'
      train.add_car(car)
      start
  end

  def remove_car
    start if is_trains_empty?

    puts "Выберите поезд, от которого нужно отцепить вагон:"
    train = select_train_from_list(@main_data.trains)

    if train.nil?
      system 'clear'
      puts "Похоже, что такого поезда нет.. Попробуйте ещё раз"
      remove_car
    else
      if train.cars.empty?
        system 'clear'
        puts "У поезда №#{train.number} нет вагонов!"
        start
      else
        train.stop
        puts "Выберите вагон, который нужно отцепить:"
        train.cars.each_with_index {|car, index| puts "#{index+1}: Вагон №#{index+1}" }
        ind = gets.chomp.to_i
        if train.cars.at(ind-1).nil?
          system 'clear'
          puts "Похоже, что такого вагона нет.. Попробуйте ещё раз"
        else
          car = train.cars.at(ind-1)
          train.remove_car(car)
        end
        start
      end
    end
  end

  def move_forward
    start if is_trains_empty?
    puts "Выберите поезд, который нужно переместить по маршруту вперед:"
    train = select_train_from_list(@main_data.trains)
    if train.nil?
      system 'clear'
      puts "Похоже, что такого поезда нет.. Попробуйте ещё раз"
      move_forward
    end
    train.move_forward
    start
  end

  def move_backward
    start if is_trains_empty?
    puts "Выберите поезд, который нужно переместить по маршруту назад:"
    train = select_train_from_list(@main_data.trains)
    if train.nil?
      system 'clear'
      puts "Похоже, что такого поезда нет.. Попробуйте ещё раз"
      move_backward
    end
    train.move_backward
    start
  end

  def get_trains
    @main_data.get_all_trains
    start
  end

  def select_train_from_list(list)
    list.each_with_index { |t, i| puts "#{i+1}: #{t.number}, тип: #{t.type}" }
    index = gets.chomp.to_i - 1
    @main_data.trains.at(index)
  end

  def is_trains_empty?
    result = false
    if @main_data.trains.empty?
      puts "Сначала нужно создать хотя бы один поезд"
      result = true
    end
    result
  end

  # def call_find
  #   start if is_trains_empty?

  #   puts "Введите номер поезда для поиска"
  #   number = gets.chomp
  #   train_object = Train.find(number)

  #   system 'clear'
  #   if train_object.nil?
  #     puts "Такого поезда нет"
  #   else
  #     puts "Вот поезд: #{train_object}"
  #     puts "QQQ: #{train_object.instances}"
  #   end
  #   start
  # end
end