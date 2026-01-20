def transform_numbers(nums) # one liner solution
    nums.map {|num| num.even? ? num*2 : num+1}
end

def transform_numbers2(nums)
    nums.each do |num|
        if num % 2 == 0
            num *= 2
        else
            num += 1
        end
    end
end

nums = [1, 2, 3, 4]
result = transform_numbers(nums)

puts "Result: #{result}"
puts "Original: #{nums.inspect}"