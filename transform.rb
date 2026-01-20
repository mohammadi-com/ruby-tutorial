def transform_numbers(nums) # one liner solution
    return nums.map {|num| num % 2 == 0 ? num*2 : num+1}
end

def transform_numbers2(nums)
    nums.map do |num|
        if num % 2 == 0
            num *= 2
        else
            num += 1
        end
    end
end

nums = [1, 2, 3, 4]
result = transform_numbers2(nums)

puts "Result: #{result}"
puts "Original: #{nums.inspect}"