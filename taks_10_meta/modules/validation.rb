# Наличие "# frozen_string_literal: true" вызывает ошибку, при 
# любйо попытке записать что-то в @message <<

module Validation
  TRAIN_NUMBER_FORMAT = /^[a-zа-я|\d]{3}-*[a-zа-я|\d]{2}$/i.freeze
  TYPES = %w[cargo passenger].freeze

  def valid?(object)
    @result = true
    @message = ''
    case object
    when CargoTrain, PassengerTrain, Train
      number_validation(object.number)
      manufacturer_validation(object.manufacturer)
      type_validation(object.type)
    when Car, CargoCar, PassengerCar
      manufacturer_validation(object.manufacturer)
      type_validation(object.type)
      capacity_validation(object.capacity)
    when Station
      name_validation(object.name)
    else
      @result = false
      @message = 'What are you trying to create?'
    end
    [@result, @message]
  end

  class ValidationError < StandardError
    def initialize(msg)
      # system 'clear'
      puts msg
      super
    end
  end

  private

  def type_validation(type)
    if !TYPES.include?(type) || type.nil?
      @result = false
      @message << "Type is not valid!\n"
    end
  end

  def number_validation(number)
    if number.nil? || number.empty? || number !~ TRAIN_NUMBER_FORMAT
      @result = false
      @message << "Number is not valid!\n"
    end
  end

  def name_validation(name)
    if name.nil? || name.empty? || name.length < 3
      @result = false
      @message << "Name is not valid!\n"
    end
  end

  def manufacturer_validation(manufacturer)
    if manufacturer.nil? || manufacturer.empty? || manufacturer.length < 3
      @result = false
      @message << "Manufacturer is not valid!\n"
    end
  end

  def capacity_validation(capacity)
    puts capacity
    if capacity.nil? || capacity.negative? || capacity.zero?
      @result = false
      @message << "Capacity is not valid!\n"
    end
  end
end
