def init_data(file_path)
  text=File.open(file_path).read
  arr = []
  text.each_line do |line|
    arr << line.strip
  end
  arr.map(&:to_i).sort
end

def part1
  file_path = File.join(File.dirname(__FILE__), 'input.txt')
  arr = init_data(file_path)
  i = 0
  j = arr.size - 1
  while i < j do
    case arr[i] + arr[j]
    when 2020
      return arr[i] * arr[j]
    when 1..2019
      i += 1
    else
      j -= 1
    end
  end
end

def part2
  file_path = File.join(File.dirname(__FILE__), 'input.txt')
  arr = init_data(file_path)
  arr.each_with_index do |e, index|
    cal_arr = arr.drop(index + 1)
    needed = 2020 - e
    i = 0
    j = cal_arr.size - 1
    while i < j do
      case cal_arr[i] + cal_arr[j]
      when needed
        return cal_arr[i] * cal_arr[j] * e
      when 1..needed - 1 
        i += 1
      else
        j -= 1
      end
    end
  end
end

p part1
p part2