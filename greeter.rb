# # Simple input method with almost no checks # #
# 
# puts "What's your name?"
# name = gets.chomp.capitalize
# puts "How old are you?"
# age = gets.chomp.to_i
# puts "Your name is #{name} and you're #{age} year(s) old, next year you'll be #{age+1}."

# # Robust input with checks # #

puts "What's your name?"
name = gets&.chomp&.capitalize # the & checks that it is not nil. Returns nil if it is nil
puts "How old are you?"
age = nil
loop do
  input = gets&.chomp&.strip
  if input.nil?
    puts "Please enter a valid age"
    next
  end
  begin
    age = Integer(input)
    if age < 0 || age > 120
      puts "Please enter a valid age between 0 and 120"
    else
      break
    end
  rescue ArgumentError
    puts "Please enter a valid age like 12"
  end
end
puts "Hi #{name}, you're #{age} and next year you'll be #{age+1}"