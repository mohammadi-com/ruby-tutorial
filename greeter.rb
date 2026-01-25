puts "What's your name?"
name = gets.chomp.capitalize
puts "How old are you?"
age = gets.chomp.to_i
puts "Your name is #{name} and you're #{age} year(s) old, next year you'll be #{age+1}."