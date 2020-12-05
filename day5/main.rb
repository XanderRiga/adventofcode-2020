# frozen_string_literal: true

require './day5/boarding_passes'

boarding_passes = Day5::BoardingPasses.new

puts "Part 1: #{boarding_passes.part_1(127, 7)}"
puts "Part 2: #{boarding_passes.part_2(127, 7)}"
