class Route
  attr_accessor :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    result = false
    if @stations.include?(station)
      puts "Станция #{station.name} уже входит в состав маршрута!"
    else 
      @stations.insert(-2, station)
      result = true
    end
    result
  end

  def delete_station(station)
    if @stations.include?(station)
      if station != @stations.at(0) && station != @stations.at(-1)
        puts "Станция #{station.name} удалена из маршрута!"
        @stations.delete(station)
      else
        puts "Нельзя удалять начальные и конечные станции маршрута!"
      end
    else
      puts "Станции #{station.name} нет в промежуточном маршруте!"
    end
  end

  def get_stations
    @stations.each { |s| puts s.name } 
  end
end