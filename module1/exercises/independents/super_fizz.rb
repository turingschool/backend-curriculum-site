class SuperFizzBuzz
  def output(num)
    output = ""
    if num % 7 == 0
      output += "Super"
    end
    if num % 3 == 0
      output += "Fizz"
    end
    if num % 5 == 0
      output += "Buzz"
    end
    output = num.to_s if output == ""
    return output
  end

  def output_range(start_num, end_num)
    range = (start_num..end_num).to_a
    range.map do |num|
      output(num)
    end
  end
end
