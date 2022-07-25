# frozen_string_literal: true

require './modules/instance_counter'
require './modules/meta_validation'

class Station
  # include Validation
  include MetaValidation
  include InstanceCounter
  attr_accessor :trains
  attr_reader :name

  validate :name, :presence

  @@stations_list = []

  def self.all
    @@stations_list
  end

  def initialize(name)
    @name = name
    @trains = []

    # valid, msg = valid?(self)
    # raise ValidationError, msg unless valid

    register_instance
    @@stations_list << self
  end

  def add_train(train)
    puts "На станции #{@name} появился поезд #{train.number} типа #{train.type}"
    @trains << train
  end

  def get_trains
    if @trains.empty?
      puts 'Поездов нет'
    else
      @trains
    end
  end

  def trains_by_type(type)
    trains_amount = 0
    trains_by_type_list = []

    @trains.each do |train|
      if train.type == type
        trains_amount += 1
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

  def iterate_trains(&block)
    @trains.each { |train| block.call(train) }
  end
end
