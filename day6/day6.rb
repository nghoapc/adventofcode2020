class Day6
  def initialize(args = {})
    @groups = []
    file_path = File.join(File.dirname(__FILE__), 'input.txt')
    read_file(file_path)
  end
  
  def read_file(file_path)
    text=File.open(file_path).read
    @i = 0
    text.each_line do |line|
      @groups[@i] = Hash.new{0} if @groups[@i].nil?
      str = line.strip
      if str == ''
        @i += 1
        next
      end
      @groups[@i]['sum'] += 1
      str.split('').each do |ans|
        @groups[@i][ans] += 1
      end
    end 
  end

  def part1
    count = 0
    @groups.each do |group|
      count += group.keys.size - 1 
    end
    count
  end

  def part2
    count = 0
    @groups.each do |group|
      group.keys.each do |key|
        next if key == 'sum'
        count += 1 if group[key] == group['sum']
      end
    end
    count
  end
end

p Day6.new().part2

