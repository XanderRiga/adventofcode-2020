module Day5
  class BoardingPasses
    def part_1(num_rows, num_cols)
      highest_seat_id = 0

      boarding_passes.each do |pass|
        seat_id = id_from_pass(pass, num_rows, num_cols)
        highest_seat_id = seat_id if seat_id > highest_seat_id
      end

      highest_seat_id
    end

    def part_2(num_rows, num_cols)
      ids = boarding_passes.map { |pass| id_from_pass(pass, num_rows, num_cols) }.sort

      ids.each_cons(2) do |x, y|
        return x + 1 if y - x > 1
      end
    end

    private

    def row_col_from_pass(pass, num_rows, num_cols)
      rows = pass[0, 7]
      cols = pass.chars.last(3).join

      row_range = Range.new(num_rows)
      col_range = Range.new(num_cols)

      rows.split('').each do |row|
        if row == 'B'
          row_range.upper_half
        elsif row == 'F'
          row_range.lower_half
        end
      end

      cols.split('').each do |col|
        if col == 'L'
          col_range.lower_half
        elsif col == 'R'
          col_range.upper_half
        end
      end

      # The upper and lower half should always be the same by this point
      [row_range.upper_limit, col_range.upper_limit]
    end

    def id_from_pass(pass, num_rows, num_cols)
      row_col = row_col_from_pass(pass, num_rows, num_cols)

      (row_col[0] * 8) + row_col[1]
    end

    def boarding_passes
      return @boarding_passes if @boarding_passes

      @boarding_passes = []
      File.open('./day5/input.txt', 'r') do |f|
        f.each_line do |line|
          @boarding_passes << line.strip
        end
      end
      @boarding_passes
    end
  end

  class Range
    attr_accessor :upper_limit, :lower_limit

    def initialize(max_val)
      @lower_limit = 0
      @upper_limit = max_val
    end

    def upper_half
      diff = upper_limit - lower_limit
      half_value = (diff / 2) + 1

      @lower_limit += half_value
    end

    def lower_half
      diff = upper_limit - lower_limit
      half_value = (diff / 2) + 1

      @upper_limit -= half_value
    end
  end
end
