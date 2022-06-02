require_relative 'train_control.rb'
require_relative 'station_control.rb'
require_relative 'route_control.rb'

class MainInterface

  attr_accessor :trains, :stations, :routes

  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def start
    loop do
      system 'clear'
      puts "ГЛАВНОЕ МЕНЮ"
      puts "1 - Управление поездами"
      puts "2 - Управление станциями"
      puts "3 - Управление маршрутами"
      puts "0 или любой текст - ВЫХОД"
  
      action = gets.chomp.to_i
  
      case action
        when 1
          TrainControl.new(self).start
        when 2
          StationControl.new(self).start
        when 3
          RouteControl.new(self).start
        else
          exit
      end
    end
  end

  def get_all_trains
    system 'clear'
    if @trains.empty?
      puts "Поездов нет!"
    else
      puts "Список всех поездов:"
      @trains.each_with_index { |t, i| puts "#{i+1}: #{t.number}, тип: #{t.type}" }
    end
  end

  def get_all_stations
    system 'clear'
    if @stations.empty?
      puts "Станций нет!"
    else
      puts "Список всех станций:"
      @stations.each_with_index { |s, i| puts "#{i+1}: #{s.name}" }
    end
  end

  def get_all_routes
    system 'clear'
    if @routes.empty?
      puts "Маршрутов нет!"
    else
      puts "Список всех маршрутов:"
      @routes.each_with_index { |r, i| puts "#{i+1}: #{r.stations.first.name} - #{r.stations.last.name}" }
    end
  end
end