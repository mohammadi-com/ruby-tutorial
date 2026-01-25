secret_number = rand(1..100)
guess_count = 0

loop do
  puts "Enter a number between 0 and 100:"
  raw_input = gets&.chomp&.strip
  next if raw_input.nil?
  begin
    number_input = Integer(raw_input)
    raise ArgumentError if number_input < 0 || number_input > 100
    guess_count += 1
    if number_input > secret_number
      puts "Too High!"
    elsif number_input < secret_number
      puts "Too Low!"
    else
      puts "Correct!!!"
      break
    end
  rescue ArgumentError
    puts "Enter a valid number between 0 and 100 please"
  end
end

puts "You got it correct in #{guess_count} attempt(s)!"