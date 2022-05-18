=begin
Сумма покупок. 
Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара 
(может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не 
введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, 
содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

result = {}

loop do
  puts "Товар:"
  product = gets.chomp
  break if product == "стоп"
  puts "Цена за единицу:"
  price = gets.chomp.to_f
  puts "Кол-во:"
  amount = gets.chomp.to_f
  
  result[product] = {"price" => price, "amount" => amount}
end

sum = 0
result.each { |k,v| sum += v["price"] * v["amount"] }

puts result
puts "Итого: #{sum}"

