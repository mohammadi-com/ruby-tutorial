name = "Mohammad"
age = "35"
print "Hello World!\n"
puts "Hello Mohammad!"
puts "Hello Jafar!"

puts "Hi " + name

puts "Hi".include? "H"
puts "Hi"[0]
puts "Salam"[1,4]
puts "Salam".index("A")
puts "Salam".index("a")
puts "upcase".upcase()
puts "DOWNCASE".downcase()

puts "my favourite age is: " + age
puts "my favourite age is: " + age.to_s
puts ("my favourite age is: " + age)

puts Math.sqrt(36)

puts 10 / 7  # since both operands are integers, we get an integer as a result.

puts "Please enter your name:"
name = gets
puts "Hi " + name + "!"