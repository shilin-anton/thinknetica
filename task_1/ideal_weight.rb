=begin
Идеальный вес. 
Программа запрашивает у пользователя имя и рост и выводит идеальный вес 
по формуле (<рост> - 110) * 1.15, после чего выводит результат пользователю 
на экран с обращением по имени. Если идеальный вес получается отрицательным, 
то выводится строка "Ваш вес уже оптимальный"
=end

puts "Введите имя"
name = gets.chomp
puts "Введите рост"
height = gets.chomp.to_i

weight = (height - 110) * 1.15

if weight < 0
  puts "#{name}! Ваш вес уже оптимальный"
else
  puts "#{name}! Ваш оптимальный вес == #{weight}"
end