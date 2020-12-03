# frozen_string_literal: true

require './day3/trees'

trees = Day3::Trees.new

puts "Part 1: #{trees.part_1(3, 1)}"


part_2_solution = trees.part_1(1, 1) *
                  trees.part_1(3, 1) *
                  trees.part_1(5, 1) *
                  trees.part_1(7, 1) *
                  trees.part_1(1, 2)

puts "Part 2: #{part_2_solution}"
