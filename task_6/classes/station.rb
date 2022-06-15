
require './modules/instance_counter.rb'

class Station
  include InstanceCounter
  attr_accessor :trains
  attr_reader :name

  @@stations_list = []

  def self.all
    @@stations_list
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@stations_list << self
  end

  def add_train(train)
    puts "На станции #{@name} появился поезд #{train.number} типа #{train.type}"
    @trains << train
  end

  def get_trains
    if @trains.empty?
      puts "Поездов нет"
    else
      puts "На станции #{@name} находятся поезда:"
      @trains.each_with_index { |train, ind| puts "#{ind+1}: #{train.number}, тип: #{train.type}" }
    end
  end


  def trains_by_type(type)
    trains_amount = 0
    trains_by_type_list = []

    @trains.each do |train|
      if train.type == type
        trains_amount+= 1
        trains_by_type_list << train
      end
    end

    puts "Сейчас на станции #{trains_amount} поездов типа #{type}."
    puts "Вот они: #{trains_by_type_list}"
  end

  def train_departure(train)
    if @trains.include?(train)
      puts "Поезд №#{train.number} отправился со станции #{@name}"
      @trains.delete(train)
    else
      puts "Нет поезда №#{train.number} на станции #{@name}"
    end
  end

end