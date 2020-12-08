class Day8
  def initialize(args = {})
    @instructions = []
    file_path = File.join(File.dirname(__FILE__), 'input.txt')
    read_file(file_path)
    @accumulator = 0
    @tmp_arr_index = []
    @current_index = 0
    @swap_arr = []
  end
  
  def read_file(file_path)
    text=File.open(file_path).read
    @index = 0
    text.each_line do |line|
      @instructions[@index] = {} if @instructions[@index].nil?
      @instructions[@index]['key'], @instructions[@index]['value'] = line.strip.split(' ')
      @index += 1
    end 
  end

  def part1
    while @tmp_arr_index.count(@current_index) < 2
      case @instructions[@current_index]['key']
      when 'nop'
        @current_index += 1
      when 'acc'
        @accumulator += @instructions[@current_index]['value'].to_i
        @current_index += 1
      when 'jmp'
        @current_index += @instructions[@current_index]['value'].to_i
      end
      @tmp_arr_index << @current_index
    end
    @accumulator
  end

  def part2
    origin = @instructions.dup
    while @tmp_arr_index.count(@current_index) < 2
      case @instructions[@current_index]['key']
      when 'nop'
        @swap_arr << { 'key': 'nop', 'index': @current_index }
        @current_index += 1
      when 'acc'
        @accumulator += @instructions[@current_index]['value'].to_i
        @current_index += 1
      when 'jmp'
        @swap_arr << { 'key': 'jmp', 'index': @current_index }
        @current_index += @instructions[@current_index]['value'].to_i
      end
      @tmp_arr_index << @current_index
    end
    @swap_arr.each do |ins|
      instruction = []
      @instructions.each{|e| instruction << e.dup}
      if ins[:key] == 'nop'
        instruction[ins[:index]]['key'] = 'jmp'
      else
        instruction[ins[:index]]['key'] = 'nop'
      end
      a = check_ins(instruction)
      return a unless a.zero?
    end
    0
  end

  def check_ins(instruction)
    tmp_arr_index = []
    current_index = 0
    accumulator = 0
    while tmp_arr_index.count(current_index) < 2
      case instruction[current_index]['key']
      when 'nop'
        current_index += 1
      when 'acc'
        accumulator += instruction[current_index]['value'].to_i
        current_index += 1
      when 'jmp'
        current_index += instruction[current_index]['value'].to_i
      end
      tmp_arr_index << current_index
      if current_index > instruction.size - 1
        return accumulator
      end
    end
    0
  end
end

p Day8.new().part2
