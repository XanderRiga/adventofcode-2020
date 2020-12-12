module Day12
  class Navigation
    def part_1
      ship = Ship.new
      instructions.each do |instruction|
        ship.execute_instruction(instruction)
      end

      ship.x.abs + ship.y.abs
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

  class Ship
    attr_reader :x, :y

    def initialize
      @x = 0 # east is positive, west is negative
      @y = 0 # north is positive, south is negative
      @facing = 'E'
    end

    def execute_instruction(instruction)
      # Do the thing
    end
  end
end
