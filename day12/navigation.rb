module Day12
  class Navigation
    def part_1
      instructions
    end

    private

    def instructions
      File.read('./day12/input.txt').split("\n").map do |n|
        Instruction.new(n[0], n[1..-1].to_i)
      end
    end
  end

  class Instruction
    attr_reader :action, :value

    def initialize(action, value)
      @action = action
      @value = value
    end
  end
end
