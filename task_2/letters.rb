=begin
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

vowels = ['a', 'e', 'i', 'o', 'u', 'y']

hash = Hash.new

('a'..'z').each_with_index { |l, i| hash[l] = i+1 if vowels.include?(l) }

print hash