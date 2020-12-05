class Day2
  def initialize(args = {})
    
  end
  
  def read_file(file_path)
    # text=File.open(file_path).read
    File.readlines(file_path)
    # arr = []
    # text.each_line do |line|
    #   arr << line.strip
    # end
    # arr.map(&:to_i).sort
  end

  def part1
    file_path = File.join(File.dirname(__FILE__), 'input.txt')
    lines = read_file(file_path)
    count = 0
    lines.each do |corporate|
      policy, password = corporate.split(':')
      rule, str = policy.split(' ')
      min, max = rule.split('-')&.map(&:to_i)
      if (min..max).include?(password.count(str.strip))
        count += 1
      end
    end
    count
  end

  def part2
    file_path = File.join(File.dirname(__FILE__), 'input.txt')
    lines = read_file(file_path)
    count = 0
    lines.each do |corporate|
      policy, password = corporate.split(':')
      rule, str = policy.split(' ')
      pos1, pos2 = rule.split('-')&.map(&:to_i)
      if (password[pos1 - 1] == str && password[pos2 - 1] != str) || (password[pos1 - 1] != str && password[pos2 - 1] == str)
        count += 1
      end
    end
    count
  end
  
end

p Day2.new().part1
