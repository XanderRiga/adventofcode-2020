module Day7
  class Luggage
    def part_1
      all_bags.select { |bag| contains_shiny_gold?(all_bags, bag) }.count
    end

    def part_2
      shiny_gold_bag = all_bags.select { |bag| bag.name == 'shiny gold' }[0]
      num_bags_contained(all_bags, shiny_gold_bag)
    end

    private

    def num_bags_contained(all_bags, bag)
      current_bags = [bag]
      count = 0
      until current_bags.empty?
        current_bag = current_bags.shift
        count += 1

        current_bags.concat(bags_for_held_bags_with_count(all_bags, current_bag))
      end
      count - 1
    end

    def contains_shiny_gold?(all_bags, bag)
      return true if bag.contains_shiny_gold_immediate?
      return false if bag.empty?

      bags_for_held_bag(all_bags, bag).any? { |bag| contains_shiny_gold?(all_bags, bag) }
    end

    def bags_for_held_bags_with_count(all_bags, bag)
      result = []
      bag.held_bags.each do |held_bag|
        bag = all_bags.select { |bag| bag.name == held_bag.bag_name }.first
        result += [bag] * held_bag.count
      end
      result
    end

    def bags_for_held_bag(all_bags, bag)
      bag.held_bags.map { |held_bag| all_bags.select { |bag| bag.name == held_bag.bag_name } }.flatten
    end

    def all_bags
      return @all_bags if @all_bags

      @all_bags = []
      rule_strings = File.read('./day7/input.txt').split("\n")
      rule_strings.each do |rule_string|
        name = rule_string.split('bags')[0].strip
        if rule_string.split('contain')[1].include?('no other bags')
          @all_bags << Bag.new(name, [])
          next
        end
        contained_strings = rule_string.split('contain')[1].strip.split(', ')
        held_bags = []
        contained_strings.each do |contained_string|
          contained_string.slice!('bags')
          contained_string.slice!('bag')
          held_bags << HeldBag.new(contained_string[1..-1]
                                .tr('.', '').strip, contained_string[0].to_i)
        end
        @all_bags << Bag.new(name, held_bags)
      end
      @all_bags
    end
  end

  class Bag
    attr_accessor :name, :held_bags

    def initialize(name, held_bags)
      @name = name
      @held_bags = held_bags
    end

    def empty?
      return true if held_bags.empty?

      false
    end

    def contains_shiny_gold_immediate?
      held_bags.any? { |held_bag| held_bag.bag_name == 'shiny gold'}
    end
  end

  class HeldBag
    attr_accessor :bag_name, :count

    def initialize(bag_name, count)
      @bag_name = bag_name
      @count = count
    end
  end
end
