require './classes/station.rb'

class StationControl
  include Validation

  def initialize(main_data)
    @main_data = main_data
  end

  def start
    puts "\n\nУПРАВЛЕНИЕ СТАНЦИЯМИ"
    puts "1 - Создать станцию"
    puts "2 - Запросить список станций"
    puts "3 - Запросить список поездов на станции"
    puts "4 - Запросить список объектов станций (метод класса all)"
    puts "0 или любой текст - Вернуться в главное меню"

    action = gets.chomp.to_i

    case action
      when 1
        create_station
      when 2 
        get_stations
      when 3
        get_trains_on_station
      when 4
        self_get_stations
      else
        @main_data.start
    end
  end

  private

  def create_station
    puts "Введите название станции!"
    station_name = gets.chomp
    station = Station.new(station_name)

    rescue ValidationError
      puts 'Попробуйте ещё раз!'
      retry
    else
      @main_data.stations << station
      system 'clear'
      puts "Станция #{station} создана успешно!"
      start    
  end

  def get_stations
    system 'clear'
    @main_data.get_all_stations
    start
  end

  def get_trains_on_station
    if @main_data.stations.empty?
      system 'clear'
      puts "Нет станций!"
      start
    end

    puts "Выберите станцию:"
    @main_data.stations.each_with_index { |station, ind| puts "#{ind+1}: #{station.name}" }
    index = gets.chomp.to_i - 1
    
    if @main_data.stations.at(index).nil?
      system 'clear'
      puts "Похоже, что такой станции нет.. Попробуйте ещё раз"
      get_trains_on_station
    end

    station = @main_data.stations.at(index)
    system 'clear'
    if station.trains.empty?
      puts "На станции #{station.name} нет поездов"
    else 
      station.iterate_trains { |train| puts "Номер: #{train.number}, тип: #{train.type}, число вагонов: #{train.cars.count}" }
    end
    start 
  end

  def self_get_stations
    system 'clear'
    puts "Список объектов станций из метода класса Station:"
    puts Station.all
    start
  end

end