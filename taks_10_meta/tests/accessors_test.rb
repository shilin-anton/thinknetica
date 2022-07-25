require './classes/train'

train = Train.new('123-qq', 'manufacturer')

puts "Train created!"
puts train

puts "Starting tests for attr_accessor_with_history"

puts "\n"
puts "-------------------------------------------"

puts "Setting: train.test1 = 123"
train.test1 = 123
puts "train.test1 == #{train.test1}"
puts "\n"
puts "Setting: train.test1 = 222"
train.test1 = 222
puts "train.test1 == #{train.test1}"
puts "\n"
puts "Setting: train.test1 = 333"
train.test1 = 333
puts "train.test1 == #{train.test1}"
puts "\n"
puts "TEST1 history == #{train.test1_history}"
puts "\n"
puts "-------------------------------------------"
puts "\n"

puts "Setting: train.test2 = 'qweqwe'"
train.test2 = 'qweqwe'
puts "train.test2 == #{train.test2}"
puts "\n"
puts "Setting: train.test2 = 999"
train.test2 = 999
puts "train.test2 == #{train.test2}"
puts "\n"
puts "Setting: train.test2 = false"
train.test2 = false
puts "train.test2 == #{train.test2}"
puts "\n"
puts "TEST2 history == #{train.test2_history}"
puts "\n"
puts "-------------------------------------------"
puts "\n"

puts "##############################################"
puts "Starting tests for strong_attr_accessor"

puts "\n"
puts "Setting: train.test3 = 'Im String, all good', with class String"
train.test3 = 'Im String, all good'
puts "train.test3 == #{train.test3}"
puts "\n"
puts "-------------------------------------------"
puts "\n"


puts "Setting: train.test4 = boolean FALSE, with class String, so waiting for Exception"
train.test4 = false
puts "train.test4 == #{train.test4}"
puts "\n"
puts "-------------------------------------------"
puts "\n"



