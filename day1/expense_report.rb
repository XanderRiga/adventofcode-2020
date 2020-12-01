# frozen_string_literal: true

# Before you leave, the Elves in accounting just need you to fix your expense
# report (your puzzle input);
# apparently, something isn't quite adding up.
#
# Specifically, they need you to find the two entries that sum to
# 2020 and then multiply those two numbers together.

module Day1
  class ExpenseReport
    def pairs
      pair = load_file.combination(2).find { |x, y| x + y == 2020 }
      pair[0] * pair[1]
    end

    def triples
      pair = load_file.combination(3).find { |x, y, z| x + y + z == 2020 }
      pair[0] * pair[1] * pair[2]
    end

    def load_file
      return @values if @values

      @values = []
      File.open('./day1/input.txt', 'r') do |f|
        f.each_line do |line|
          @values << Integer(line)
        end
      end
      @values
    end
  end
end
