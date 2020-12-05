class Day4
	def initialize(args = {})
		
	end

	def read_file(file_path)
    @passports = []
    text=File.open(file_path).read
    @i = 0
    text.each_line do |line|
    	@passports[@i] = {} if @passports[@i].nil?
      if line.strip == ''
      	@i += 1
      	next
      end
     	detect_passport(line.strip)
    end
  end

  def detect_passport(line)
  	line.split(' ').each do |key_value|
  		key, value = key_value.split(':')
  		@passports[@i][key] = value
  	end
  end

  def part1
  	file_path = File.join(File.dirname(__FILE__), 'input.txt')
    read_file(file_path)
    valid_passport = 0
  	@passports.each do |passport|
  		next if passport.keys.uniq.size < 7
  		valid_passport += 1 if passport.keys.uniq.size == 8
  		valid_passport += 1 if !passport.keys.include?('cid')
  	end
  	valid_passport
  end

  def part2
  	file_path = File.join(File.dirname(__FILE__), 'input.txt')
    read_file(file_path)
    valid_passport = 0
  	@passports.each do |passport|
  		next if passport.keys.uniq.size < 7
  		valid_passport += 1 if passport.keys.uniq.size == 8 && check_passport(passport)
  		valid_passport += 1 if !passport.keys.include?('cid') && check_passport(passport)
  	end
  	valid_passport
  end

  def check_passport(passport)
  	check_byr?(passport['byr']) &&
  		check_iyr?(passport['iyr']) &&
  		check_eyr?(passport['eyr']) &&
  		check_hgt?(passport['hgt']) &&
  		check_hcl?(passport['hcl']) &&
  		check_ecl?(passport['ecl']) &&
  		check_pid?(passport['pid'])
  end

  def check_byr?(byr)
  	byr.to_i.between?(1920, 2002)
  end

  def check_iyr?(iyr)
  	iyr.to_i.between?(2010, 2020)
  end
	
	def check_eyr?(eyr)
		eyr.to_i.between?(2020, 2030)
	end

	def check_hgt?(hgt)
		case hgt[-2..-1]
		when 'cm'
			hgt.to_i.between?(150, 193)
		when 'in'
			hgt.to_i.between?(59, 76)
		else
			false
		end
	end

	def check_hcl?(hcl)
		return false unless hcl.start_with?('#')
		rg = /^[a-fA-F0-9]+$/;
		hcl[0] = ''
		hcl.size == 6 && rg.match?(hcl)
	end
	
	def check_ecl?(ecl)
		['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(ecl)
	end

	def check_pid?(pid)
		r = /^\d+$/;
		pid.size == 9 && r.match?(pid)
	end
end

p Day4.new().part2