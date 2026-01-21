def char_frequency(text)
  cleaned_text = text.gsub(/[^a-zA-Z]/, "").downcase
  frequency = Hash.new(0)  # the 0 parameter prevents key error in 0 -> 1
  # for char in cleaned_text.each_char  # "hello".chars also works but allocates an Array in the memory
  # # for does NOT create a new scope
  #   frequency[char] += 1
  # end
  cleaned_text.each_char {|char| frequency[char] += 1}
  frequency
end

p char_frequency("Salam Mohammad!")