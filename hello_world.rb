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
# name = gets.chomp
puts "Hi " + name + "!"

# basic calculator
# a = gets.chomp().to_i
# b = gets.chomp().to_f
# puts a + b

friends = Array.new
friends[0] = "Mammad"
friends[5] = "Sam"  # between the two values will be filled with nil
puts friends
puts friends.length()
puts friends.include? "Sam"
puts friends.reverse()  # doesn't do it in place
puts friends
# puts friends.sort()  # nil causes fail
# puts friends

states = {
    "NY" => "New York",
    "CA" => "California",
    :MI => "Michigan"
}

p states