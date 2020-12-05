class Day5
  def initialize(args = {})
    @seatsID = []
    @seats = []
    @base_row = (0..127).to_a
    @base_col = (0..7).to_a
  end

  def read_file(file_path)
    text=File.open(file_path).read
    text.each_line do |line|
      @seats << line.strip
    end
  end
  
  
  def part1
    file_path = File.join(File.dirname(__FILE__), 'input.txt')
    read_file(file_path)
    detect_seats
    @seatsID.max
  end

  def part2
    part1
    ((0..@seatsID.max).to_a - @seatsID).max
  end

  def detect_seats
    @seats.each do |seat|
      @seatsID << detect_seat_id(seat)
    end
  end

  def detect_seat_id(seat)
    row = detect_row(seat)
    col = detect_col(seat)
    row * 8 + col
  end

  def detect_row(seat)
    row = @base_row
    seat.split('').first(7).each do |char|
      row = char == 'F' ? get_first(row) : get_last(row)
    end
    row[0]
  end

  def detect_col(seat)
    col = @base_col
    seat.split('').last(3).each do |char|
      col = char == 'L' ? get_first(col) : get_last(col)
    end
    col[0]
  end

  def get_first(arr)
    arr[0...(arr.length / 2)]
  end

  def get_last(arr)
    arr[(arr.length / 2)..arr.length]
  end  
end

p Day5.new().part2
