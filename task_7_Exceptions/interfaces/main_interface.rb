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
      puts "\n\nГЛАВНОЕ МЕНЮ"
      puts "1 - Управление поездами"
      puts "2 - Управление станциями"
      puts "3 - Управление маршрутами"
      puts "0 или любой текст - ВЫХОД"
  
      action = gets.chomp.to_i
  
      case action
        when 1
          system 'clear'
          TrainControl.new(self).start
        when 2
          system 'clear'
          StationControl.new(self).start
        when 3
          system 'clear'
          RouteControl.new(self).start
        else
          exit
      end
    end
  end

  def get_all_trains
    puts @trains
    @trains
  end

  def get_all_stations
    puts @stations
    @stations
  end

  def get_all_routes
    puts @routes
    @routes
  end
end