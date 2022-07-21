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
    puts "9 - Занять место/объем в вагоне"
    puts "10 - Запросить список вагонов"
    puts "0 или любой текст - Вернуться в главное меню"

    action = gets.chomp.to_i
    system 'clear'

    case action
      when 1
        create_train
      when 2
        set_route
      when 3
        add_car
      when 4
        remove_car
      when 5
        move_forward
      when 6
        move_backward
      when 7
        get_trains
      # when 8
      #   call_find
      when 9
        take_car_space
      when 10
        get_cars
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

    puts "Укажите вместимость вагона:\n(кол-во мест для пассажирского/объем для грузового)"
    capacity = gets.chomp
      
    if train.type == 'cargo' 
      car = CargoCar.new(manufacturer, capacity)
    elsif train.type == 'passenger'
      car = PassengerCar.new(manufacturer, capacity)
    else
      car = Car.new(manufacturer, capacity)
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

  def take_car_space
    start if is_trains_empty?
    puts "Выберите поезд, в вагоне которого нужно занять место/объем:"
    train = select_train_from_list(@main_data.trains)
    
    if train.nil?
      system 'clear'
      puts "Похоже, что такого поезда нет.. Попробуйте ещё раз"
      take_car_space
    end

    puts "Выберите вагон, в котором нужно занять место/объем:"
    train.cars.each_with_index { |car, i| puts "#{i+1}: #{car}"}
    ind = gets.chomp.to_i - 1
    current_car = train.cars.at(ind)

    if current_car.nil?
      system 'clear'
      puts "Похоже, что такого вагона нет.. Попробуйте ещё раз"
      take_car_space
    else
      system 'clear'
      if current_car.type == 'cargo'
        puts "Введите объем для заполнения:"
        volume = gets.chomp.to_i
        current_car.take_space(volume)
      else
        current_car.take_space
      end
      start
    end
  end

  def get_cars
    start if is_trains_empty?
    puts "Выберите поезд:"
    train = select_train_from_list(@main_data.trains)

    if train.nil?
      system 'clear'
      puts "Похоже, что такого поезда нет.. Попробуйте ещё раз"
      get_cars
    end

    system 'clear'

    puts "Поезд #{train}:\n"
    puts "Вагонов нет!" if train.cars.count == 0

    train.iterate_cars { |car, i| puts "Вагон №#{i+1}: Тип: #{car.type}, Производитель: #{car.manufacturer}, Вместимость: #{car.capacity}, Свободно: #{car.free_space}, Занято: #{car.occupied_space}"}
  end
end