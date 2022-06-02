require './classes/station.rb'

class StationControl

  def initialize(main_data)
    @main_data = main_data
  end

  def start

    puts "УПРАВЛЕНИЕ СТАНЦИЯМИ"
    puts "1 - Создать станцию"
    puts "2 - Запросить список станций"
    puts "3 - Запросить список поездов на станции"
    puts "0 или любой текст - Вернуться в главное меню"

    action = gets.chomp.to_i

    case action
      when 1
        create_station
      when 2 
        get_stations
      when 3
        get_trains_on_station
      else
        @main_data.start
    end
  end

  private

  def create_station
    puts "Введите название станции!"
    station_name = gets.chomp
    station = Station.new(station_name)
    @main_data.stations << station
    system 'clear'
    puts "Создана станция #{station.name}"
    start
  end

  def get_stations
    @main_data.get_all_stations
    start
  end

  def get_trains_on_station
    if @main_data.stations.empty? 
      puts "Нет станций!"
      start
    end

    puts "Выберите станцию:"
    @main_data.stations.each_with_index { |station, ind| puts "#{ind+1}: #{station.name}" }
    index = gets.chomp.to_i - 1
    
    if @main_data.stations.at(index).nil?
      puts "Похоже, что такой станции нет.. Попробуйте ещё раз"
      get_trains_on_station
    end

    station = @main_data.stations.at(index)
    system 'clear'
    if station.trains.empty?
      puts "На станции #{station.name} нет поездов"
    else 
      station.get_trains
    end
    start 
  end

end