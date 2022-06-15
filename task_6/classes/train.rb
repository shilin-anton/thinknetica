
require './modules/manufacturer.rb'
require './modules/instance_counter.rb'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :route, :type, :cars

  @@trains_list = []

  def initialize(number, manufacturer)
    @number = number
    @type = nil
    @speed = 0
    @cars = []
    set_manufacturer(manufacturer)
    register_instance
    @@trains_list << self
  end

  # в public части все что касается управлением поезда

  def self.find(number)
    @@trains_list.each { |train| return train if train.number == number }
    nil
  end
  
  def increase_speed
    @speed+= 1
  end

  def stop
    @speed = 0
  end

  def set_route(route)
    @route = route
    stations = @route.stations
    puts "Поезд №#{@number} отправляется по маршруту #{@route.stations.first.name} - #{@route.stations.last.name}"
    @current_station = stations.first
    stations.first.add_train(self)
  end

  def get_current_station
    if @route.nil?
      puts "Маршрут не задан!"
    else
      puts "Сейчас находится на станции #{@current_station.name}"
      @current_station
    end
  end

  def get_next_station
    next_station = nil

    if @route.nil?
      puts "У поезда №#{@number} не задан маршрут!"
    else
      stations = @route.stations
      if @current_station == stations.last
        puts "У поезда №#{@number} нет следующей станции! Он находится в конце маршрута!"
      else
        index = stations.index(@current_station)
        next_station = stations[index+1]
        puts "Следующая станция для поезда №#{number}: #{next_station.name}"
      end
    end
    next_station
  end

  def get_previous_station
    prev_station = nil

    if @route.nil?
      puts "У поезда №#{@number} не задан маршрут!"
    else
      stations = @route.stations
      if @current_station == stations.first
        puts "У поезда №#{@number} нет предыдущей станции! Он находится в начале маршрута!"
      else
        index = stations.index(@current_station)
        prev_station = stations[index-1]
        puts "Предыдущая станция для поезда №#{number}: #{prev_station.name}"
      end
    end
    prev_station
  end

  def move_forward
    if @route.nil?
      puts "У поезда №#{@number} не задан маршрут!"
    else
      next_station = get_next_station
      if !next_station.nil?
        @current_station.train_departure(self)
        @current_station = next_station
        next_station.add_train(self)
      end
    end
  end

  def move_backward
    if @route.nil?
      puts "У поезда №#{@number} не задан маршрут!"
    else
      prev_station = get_previous_station
      if !prev_station.nil?
        @current_station.train_departure(self)
        puts "Поезд №#{@number} отправляется назад, на станцию #{prev_station.name}"
        @current_station = prev_station
        prev_station.add_train(self)
      end
    end
  end

  def add_car(car)
    if type_matching?(car)
      @cars << car if !is_moving?
    else
      puts "Тип вагона не подходит"
    end
  end

  def remove_car(car)
    @cars.delete(car) if !is_moving?
  end

  private

  # не уверен, может ли клиент выполнять эту проверку?
  def is_moving?
    @speed > 0
  end

  # клиент не должен сравнивать типы вагонов и поездов
  def type_matching?(car)
    @type = car.type
  end
end

