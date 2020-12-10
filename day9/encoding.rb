module Day9
  class Encoding
    SOLUTION = 530627549

    def part_1
      x = 0
      while true
        unless is_valid?(numbers[x, 25], numbers[x + 25])
          return numbers[x + 25]
        end

        x += 1
      end
    end

    def part_2
      x = 0
      numbers.length.times do
        if sums_to_solution(numbers, x)
          return sums_to_solution(numbers, x)
        end

        x += 1
      end
    end

    private

    def sums_to_solution(list, start_index)
      x = start_index
      values = []
      sum = 0
      (list.length - start_index).times do
        values << list[x]
        sum += list[x]

        if sum == SOLUTION
          return (values.min + values.max)
        elsif sum > SOLUTION
          return false
        end

        x += 1
      end
      false
    end

    def is_valid?(list, value)
      !!list.uniq.combination(2).detect { |a, b| a + b == value }
    end

    def numbers
      @numbers ||= File.read('./day9/input.txt').split("\n").map { |n| n.to_i }
    end
  end
end
