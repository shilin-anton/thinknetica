require './classes/train'
require './classes/car'
require './classes/station'
require './classes/route'

puts "Creating train!"
train = Train.new('qwe-12', 'manufacturer')
puts "train = Train.new('qwe-12', 'manufacturer')"
puts "Result of 'valid?' ==  #{train.valid?}"
puts "\n"

puts "Creating train!"
train2 = Train.new('', 'manufacturer')
puts "train2 = Train2.new('', 'manufacturer')"
puts "Result of 'valid?' ==  #{train2.valid?}"
puts "\n"

puts "Creating car!"
car = Car.new('manufacturer', 500)
puts "car = Car.new('manufacturer', 500)"
puts "Result of 'valid?' ==  #{car.valid?}"
puts "\n"

puts "Creating car!"
car2 = Car.new('manufacturer', '')
puts "car2 = Car.new('manufacturer', '')"
puts "Result of 'valid?' ==  #{car2.valid?}"
puts "\n"

puts "Creating station!"
station = Station.new('station_name')
puts "station = Station.new('station_name')"
puts "Result of 'valid?' ==  #{station.valid?}"
puts "\n"

puts "Creating station!"
station2 = Station.new('')
puts "station2 = Station.new('')"
puts "Result of 'valid?' ==  #{station2.valid?}"
puts "\n"


