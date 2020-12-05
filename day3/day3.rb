class Day3
  def initialize(args = {})
    
  end

  def read_file(file_path)
    text=File.open(file_path).read
    i = 0
    @base_line = []
    @matrix = []
    text.each_line do |line|
      @base_line[i] = line.strip.split('')
      @matrix[i] = @base_line[i]
      i += 1
    end
  end
  
  def part2
    file_path = File.join(File.dirname(__FILE__), 'input.txt')
    read_file(file_path)
    @current_x = 0
    @current_y = 0
    @current_maxtrix_lenght = @matrix[0].size
    @tree_count = []
    @need_check = [[1,1], [3,1], [5, 1], [7,1], [1, 2]]
    @need_check.each_with_index do |slopes|
      @tree_count << move(slopes)
      @current_x = 0
      @current_y = 0
    end
    @tree_count.inject(:*)
  end

  def move(slopes)
    count = 0
    while @current_x < @matrix.size - 1
      repeats_matrix_right if @current_y + slopes[0] > @current_maxtrix_lenght - 1 
      move_right(slopes[0])
      move_bottom(slopes[1])
      count += 1 if current_value == '#'
    end
    count
  end

  def current_value
    @matrix[@current_x][@current_y]
  end

  def move_right(num)
    @current_y += num
  end

  def move_bottom(num)
    @current_x += num
  end

  def repeats_matrix_right
    @matrix.each_with_index do |line, index|
      # p '~'*50
      # p @base_line[index]
      # p '~'*50
      @matrix[index] += @base_line[index] 
    end
    # print_matrix
    @current_maxtrix_lenght = @matrix[0].size
  end

  def print_matrix
    p '++++++++++++ MATRIX ++++++++++++++++'
    @matrix.each do |line|
      p line.join('')
    end
    p '++++++++++++++++++++++++++++++++++++'
  end
  
end
