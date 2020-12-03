# frozen_string_literal: true

module Day3
  class Trees
    def part_1(traverse_x, traverse_y)
      x = 0
      y = 0
      width = tree_matrix[0].length - 1
      height = tree_matrix.length

      trees = 0
      while y <= (height - 1) do
        trees += 1 if tree_matrix[y][x] == '#'

        x += traverse_x
        y += traverse_y

        x -= (width + 1) if x > width

        puts "X: #{x}"
        puts "Y: #{y}"
      end

      trees
    end

    private

    def tree_matrix
      return @tree_matrix if @tree_matrix

      @tree_matrix = []
      File.open('./day3/input.txt', 'r') do |f|
        f.each_line do |line|
          @tree_matrix << line.strip.split('')
        end
      end
      @tree_matrix
    end
  end
end
