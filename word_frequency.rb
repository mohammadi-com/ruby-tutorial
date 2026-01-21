def word_frequency(text)
  cleaned_text = text.downcase.gsub(/[^a-zA-Z0-9\s]/, "")
  # gsub("[^a-z0-9\s]", "") => “Replace the exact characters [, ^, a, -, z, …”
  # Which is not what we want.
  words = cleaned_text.split
  frequency = Hash.new(0)

  for word in words  # for under the hood is each
    frequency[word] += 1
  end

  frequency
end

text = "Hello, hello world! World."
p word_frequency(text)

