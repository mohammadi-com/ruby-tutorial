sentence = gets&.chomp&.strip&.downcase
words = sentence&.gsub(/[^a-zA-Z0-9\s]/, "")&.split
exit if words.nil? || words.length == 0

frequency = Hash.new(0)
words.each { |word| frequency[word]+= 1}
p frequency.sort_by { |key, value| [-value, key]}.to_h