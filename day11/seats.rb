module Day11
  class Seats
    def part_1
      curr_matrix = seats
      while true
        new_matrix = perform_part_1_action(curr_matrix)

        if new_matrix == curr_matrix
          return count_occupied_seats(new_matrix)
        end

        curr_matrix = new_matrix
      end
    end

    def part_2
      curr_matrix = seats
      while true
        new_matrix = perform_part_2_action(curr_matrix)

        if new_matrix == curr_matrix
          return count_occupied_seats(new_matrix)
        end

        curr_matrix = new_matrix
      end
    end

    def count_occupied_seats(matrix)
      count = 0
      matrix.each do |row|
        row.each do |val|
          count += 1 if val == '#'
        end
      end

      count
    end

    def perform_part_2_action(start_matrix)
      new_matrix = Array.new(start_matrix.length){Array.new(start_matrix[0].length)}
      (0...(start_matrix.length)).each do |row|
        (0...(start_matrix[0].length)).each do |col|
          if start_matrix[row][col] == '.'
            new_matrix[row][col] = '.'
          elsif start_matrix[row][col] == '#'
            new_matrix[row][col] = from_occupied_part_2(start_matrix, row, col)
          elsif start_matrix[row][col] == 'L'
            new_matrix[row][col] = from_empty_part_2(start_matrix, row, col)
          end
        end
      end

      new_matrix
    end

    def from_occupied_part_2(matrix, row, col)
      return 'L' if first_seat_in_all_directions(matrix, row, col).select { |val| val == '#' }.count >= 5
      '#'
    end

    def from_empty_part_2(matrix, row, col)
      return '#' unless first_seat_in_all_directions(matrix, row, col).include?('#')
      'L'
    end

    def first_seat_in_all_directions(matrix, start_row, start_col)
      visible_seats = []

      curr_row = start_row - 1
      curr_col = start_col - 1
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_row = curr_row - 1
          curr_col = curr_col - 1
        else
          visible_seats << '.'
          break
        end
      end

      curr_row = start_row
      curr_col = start_col - 1
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_col = curr_col - 1
        else
          visible_seats << '.'
          break
        end
      end

      curr_row = start_row - 1
      curr_col = start_col
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_row = curr_row - 1
        else
          visible_seats << '.'
          break
        end
      end

      curr_row = start_row + 1
      curr_col = start_col
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_row = curr_row + 1
        else
          visible_seats << '.'
          break
        end
      end

      curr_row = start_row + 1
      curr_col = start_col + 1
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_row = curr_row + 1
          curr_col = curr_col + 1
        else
          visible_seats << '.'
          break
        end
      end

      curr_row = start_row
      curr_col = start_col + 1
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_col = curr_col + 1
        else
          visible_seats << '.'
          break
        end
      end

      curr_row = start_row - 1
      curr_col = start_col + 1
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_row = curr_row - 1
          curr_col = curr_col + 1
        else
          visible_seats << '.'
          break
        end
      end

      curr_row = start_row + 1
      curr_col = start_col - 1
      while true
        if inside_matrix_bounds?(matrix, curr_row, curr_col)
          if matrix[curr_row][curr_col] == 'L'
            visible_seats << 'L'
            break
          elsif matrix[curr_row][curr_col] == '#'
            visible_seats << '#'
            break
          end

          curr_row = curr_row + 1
          curr_col = curr_col - 1
        else
          visible_seats << '.'
          break
        end
      end

      visible_seats
    end

    def inside_matrix_bounds?(matrix, row, col)
      row >= 0 && col >= 0 && row <= matrix.length - 1 && col <= matrix[0].length - 1
    end

    def perform_part_1_action(start_matrix)
      new_matrix = Array.new(start_matrix.length){Array.new(start_matrix[0].length)}
      (0...(start_matrix.length)).each do |row|
        (0...(start_matrix[0].length)).each do |col|
          if start_matrix[row][col] == '.'
            new_matrix[row][col] = '.'
          elsif start_matrix[row][col] == '#'
            new_matrix[row][col] = from_occupied(start_matrix, row, col)
          elsif start_matrix[row][col] == 'L'
            new_matrix[row][col] = from_empty(start_matrix, row, col)
          end
        end
      end

      new_matrix
    end

    def from_occupied(matrix, row, col)
      return 'L' if all_adjacent_values(matrix, row, col).select { |val| val == '#' }.count >= 4

      '#'
    end

    def from_empty(matrix, row, col)
      return '#' unless all_adjacent_values(matrix, row, col).include?('#')
      'L'
    end

    def all_adjacent_values(matrix, row, col)
      values = []
      values << matrix[row - 1][col - 1] if row - 1 >= 0 && col - 1 >= 0
      values << matrix[row][col - 1] if col - 1 >= 0
      values << matrix[row][col + 1] if col + 1 <= matrix[0].length - 1
      values << matrix[row - 1][col + 1] if row - 1 >= 0 && col + 1 <= matrix[0].length - 1
      values << matrix[row - 1][col] if row - 1 >= 0
      values << matrix[row + 1][col - 1] if col - 1 >= 0 && row + 1 <= matrix.length - 1
      values << matrix[row + 1][col] if row + 1 <= matrix.length - 1
      values << matrix[row + 1][col + 1] if row + 1 <= matrix.length - 1 && col + 1 <= matrix[0].length - 1
      values
    end

    def seats
      @seats ||= File.read('./day11/input.txt').split("\n")
    end
  end
end
