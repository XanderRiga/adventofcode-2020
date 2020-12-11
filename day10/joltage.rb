module Day10
  class Joltage
    def part_1
      curr_adapter = 0
      one_jolt = 0
      three_jolt = 0
      while true
        if has_n_jolt(adapters, curr_adapter, 1)
          one_jolt += 1
          curr_adapter = has_n_jolt(adapters, curr_adapter, 1)
          next
        elsif has_n_jolt(adapters, curr_adapter, 3)
          three_jolt += 1
          curr_adapter = has_n_jolt(adapters, curr_adapter, 3)
          next
        end
        break
      end

      one_jolt * (three_jolt + 1)
    end

    def part_2
      p2_adapters = [0, *adapters, adapters.max + 3]

      ways = [0] * p2_adapters.size
      ways[0] = 1

      (1...p2_adapters.size).each do |i|
        (1..3).each do |j|
          if i - j >= 0
            if p2_adapters[i] - p2_adapters[i - j] <= 3
              ways[i] += ways[i - j]
            end
          end
        end
      end

      ways.last
    end

    private

    def has_n_jolt(list, adapter, n)
      if list.include?(adapter + n)
        return adapter + n
      end

      false
    end

    def adapters
      @adapters ||= File.read('./day10/input.txt').split("\n").map { |n| n.to_i }.sort
    end
  end
end
