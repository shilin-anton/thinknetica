# frozen_string_literal: true

require './classes/station'
require './classes/route'

class RouteControl
  def initialize(main_data)
    @main_data = main_data
  end

  def start
    puts "\n\nУПРАВЛЕНИЕ МАРШРУТАМИ"
    puts '1 - Создать маршрут'
    puts '2 - Добавить станцию на маршрут'
    puts '3 - Удалить станцию с маршрута'
    puts '4 - Запросить список маршрутов'
    puts '5 - Запросить список станций на маршруте'
    puts '0 или любой текст - Вернуться в главное меню'

    action = gets.chomp.to_i

    system 'clear'
    case action
    when 1
      create_route
    when 2
      add_station_to_route
    when 3
      remove_station_from_route
    when 4
      get_routes
    when 5
      get_stations_in_route
    else
      @main_data.start
    end
  end

  private

  def create_route
    if @main_data.stations.length < 2
      system 'clear'
      puts 'Для создания маршрута требуется наличие хотя бы 2ух станций!'
      start
    end

    station_list = @main_data.stations

    puts 'Выберите начальную станцию:'
    start_station = select_from_list(station_list)

    if start_station.nil?
      system 'clear'
      puts 'Похоже, такой станции нет, попробуйте ещё раз'
      create_route
    end

    no_start_station_list = station_list - [start_station]

    puts 'Выберите конечную станцию:'
    end_station = select_from_list(no_start_station_list)

    if end_station.nil?
      system 'clear'
      puts 'Похоже, такой станции нет, попробуйте ещё раз'
      create_route
    end

    route = Route.new(start_station, end_station)
    @main_data.routes << route
    system 'clear'
    puts "Создан новый маршрут: #{route.inspect}"
    start
  end

  def add_station_to_route
    if @main_data.stations.empty?
      system 'clear'
      puts 'Для начала создайте станцию!'
      start
    end

    if @main_data.routes.empty?
      system 'clear'
      puts 'Для начала создайте маршрут!'
      start
    end

    puts 'Выберите маршрут, в который нужно добавить станцию:'
    route = select_route_from_list(@main_data.routes)

    if route.nil?
      system 'clear'
      puts 'Похоже, такого маршрута нет, попробуйте ещё раз'
      add_station_to_route
    end

    puts "Выберите станцию, которую хотите добавить в маршрут #{route}:"
    station = select_from_list(@main_data.stations)

    if station.nil?
      system 'clear'
      puts 'Похоже, такой станции нет, попробуйте ещё раз'
      add_station_to_route
    end

    system 'clear'
    puts "Станция #{station.name} теперь в составе маршрута #{route}" if route.add_station(station)
    start
  end

  def remove_station_from_route
    if @main_data.routes.empty?
      system 'clear'
      puts 'Для начала создайте маршрут!'
      start
    end

    puts 'Выберите маршрут, из которого нужно удалить станцию:'
    route = select_route_from_list(@main_data.routes)

    if route.nil?
      system 'clear'
      puts 'Похоже, такого маршрута нет, попробуйте ещё раз'
      remove_station_from_route
    end

    puts "Выберите станцию, которую хотите удалить из маршрута #{route}:"
    station = select_from_list(route.stations)

    if route.nil?
      system 'clear'
      puts 'Похоже, такой стацнии нет, попробуйте ещё раз'
      remove_station_from_route
    end

    route.delete_station(station)
    start
  end

  def get_routes
    @main_data.all_routes
    start
  end

  def get_stations_in_route
    if @main_data.routes.empty?
      system 'clear'
      puts 'Маршрутов нет!'
      start
    end
    puts 'Выберите маршрут:'
    route = select_route_from_list(@main_data.routes)

    if route.nil?
      system 'clear'
      puts 'Похоже, такого маршрута нет, попробуйте ещё раз'
      get_stations_in_route
    end

    puts 'Список станций:'
    route.get_stations
    start
  end

  def select_from_list(list)
    list.each_with_index { |obj, i| puts "#{i + 1}: #{obj.name}" }
    index = gets.chomp.to_i - 1
    list.at(index)
  end

  def select_route_from_list(list)
    list.each_with_index { |obj, i| puts "#{i + 1}: #{obj.stations.first.name} - #{obj.stations.last.name}" }
    index = gets.chomp.to_i - 1
    list.at(index)
  end
end
