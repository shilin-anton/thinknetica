=begin
Прямоугольный треугольник. 
Программа запрашивает у пользователя 3 стороны треугольника и определяет, 
является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru), 
равнобедренным (т.е. у него равны любые 2 стороны) или равносторонним (все 3 стороны равны) 
и выводит результат на экран. 

Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону 
(гипотенуза) и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. 
Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.
=end

sides = []

3.times do
  puts "Введите стороны треугольника"
  sides << gets.chomp.to_i  
end

if sides.uniq.size == 1
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный"
else
  sides.sort!

  is_right = (sides[2]**2 == sides[0]**2 + sides[1]**2) 
  is_isosceles = sides.uniq.size == 2

  if is_right && is_isosceles
    puts "Треугольник равнобедренный и прямой"
  elsif is_right && !is_isosceles
    puts "Треугольник прямой"
  elsif !is_right && is_isosceles
    puts "Треугольник равнобедренный"
  else
    puts "Самый обычный треугольник.."
  end
end


