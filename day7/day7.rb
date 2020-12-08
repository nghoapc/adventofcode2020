class Day7
  def initialize(args = {})
    @rules = []
    file_path = File.join(File.dirname(__FILE__), 'input.txt')
    read_file(file_path)
  end
  
  def read_file(file_path)
    text=File.open(file_path).read
    @index = 0
    text.each_line do |line|
      @rules[@index] = {} if @rules[@index].nil?
      detect_rule(line)
      @index += 1
    end 
  end

  def detect_rule(line)
    line.split(',').each_with_index do |mini_rule, index|
      if index.zero?
        detect_first_rule(mini_rule) 
        next
      end
      detect_other_rule(mini_rule)
    end
  end

  def detect_first_rule(mini_rule)
    @color_bag, first_rule = mini_rule.split(' bags contain ')
    @rules[@index][@color_bag] = {}
    tmp_arr = first_rule.split(' ')
    number = tmp_arr.first
    color_name = tmp_arr[1..-2].join(' ')
    @rules[@index][@color_bag][color_name] = number
  end

  def detect_other_rule(mini_rule)
    tmp_arr = mini_rule.strip.split(' ')
    number = tmp_arr.first
    color_name = tmp_arr[1..-2].join(' ')
    @rules[@index][@color_bag][color_name] = number
  end

  def contain(color)
    @keys = [] 
    @rules.each do |rule|
      if rule.first[1].has_key?(color)
        @keys << rule.first[0]
        @keys += contain(rule.first[0])
      end
    end
    @keys
  end

  def part1
    contain('shiny gold').uniq.count
  end

  def number_of_contain(color)
    count = 0
    @rules.each do |rule|
      if rule.has_key?(color)
        return 1 if rule[color] == {"other"=>"no"}
        rule[color].each do |k,v|
          bag_inside = number_of_contain(k)
          count += bag_inside * v.to_i
          count += v.to_i if bag_inside != 1
        end
      end
    end
    count
  end

  def part2
    color = 'shiny gold'
    count = number_of_contain(color)
    count
  end
end

p Day7.new().part2