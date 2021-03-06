=begin
Требуется написать следующие классы:

Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. 
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной

Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, 
эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). 
Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route). 
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    puts "На станции #{@name} появился поезд #{train.number} типа #{train.type} с кол-вом вагонов == #{train.cars_amount}"
    @trains << train
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

class Route
  attr_accessor :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if @stations.include?(station)
      puts "Станция #{station.name} удалена из маршрута!"
      @stations.delete(station)
    else
      puts "Станции #{station.name} нет в промежуточном маршруте!"
    end
  end

  def get_stations
    @stations.each { |s| puts s.name } 
  end
end

class Train
  attr_reader :number, :type, :cars_amount, :route
  attr_accessor :speed

  def initialize(number, type, cars_amount)
    @speed = 0
    @number = number
    @type = type
    @cars_amount = cars_amount
  end
  
  # "Может набирать скорость" - значит можно выполнить Train.speed = N,
  # или нужен отдельный метод как ниже?
  def increase_speed
    @speed+= 5
  end

  def stop
    @speed = 0
  end

  def add_car
    @cars_amount+=1 if speed == 0
  end

  def remove_car
    @cars_amount-= 1 if (speed == 0 && @cars_amount > 1)
  end

  def set_route(route)
    @route = route
    stations = @route.get_stations
    puts "Поезд №#{@number} отправляется по маршруту #{@route}. Начальная станция: #{stations.first.name}"
    @current_station = stations.first
    stations.first.add_train(self)
  end

  def get_current_station
    if @route.nil?
      puts "У поезда №#{@number} не задан маршрут!"
    else
      puts "Поезд №#{@number} сейчас находится на станции #{@current_station.name}"
      @current_station
    end
  end

  def get_next_station
    next_station = nil

    if @route.nil?
      puts "У поезда №#{@number} не задан маршрут!"
    else
      stations = @route.get_stations
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
      stations = @route.get_stations
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
end