=begin
Заполнить массив числами фибоначчи до 100
=end

arr = []
n = 0

until n > 100 do 
  if n == 0
    arr << n
  elsif n == 1
    2.times {arr << n}
  else
    value = arr[-1] + arr[-2]
    break if value > 100
    arr << value
  end
  n+=1
end

print arr