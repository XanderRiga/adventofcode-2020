# frozen_string_literal: true

# Before you leave, the Elves in accounting just need you to fix your expense
# report (your puzzle input);
# apparently, something isn't quite adding up.
#
# Specifically, they need you to find the two entries that sum to
# 2020 and then multiply those two numbers together.

module Day1
  class ExpenseReport
    def pair
      sorted = load_file.sort
      sorted.each do |first_entry|
        sorted.reverse.each do |second_entry|
          if (first_entry + second_entry) == 2020
            return first_entry * second_entry
          end
        end
      end
    end

    def triples
      sorted = load_file.sort
      sorted.each do |first_entry|
        sorted.each do |second_entry|
          sorted.each do |third_entry|
            if first_entry + second_entry + third_entry == 2020
              return first_entry * second_entry * third_entry
            end
          end
        end
      end
    end

    def load_file
      values = []
      File.open('./day1/input.txt', 'r') do |f|
        f.each_line do |line|
          values << Integer(line)
        end
      end
      values
    end
  end
end
