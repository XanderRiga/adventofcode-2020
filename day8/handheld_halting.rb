module Day8
  class HandheldHalting
    def part_1
      @acc = 0
      i = 0

      all_instructions = instructions

      while true
        curr_instruction = all_instructions[i]
        if curr_instruction.times_run == 1
          return @acc
        end

        result = run_operation(curr_instruction, i)
        if result
          i = result
          next
        end

        i += 1
      end
    end

    def part_2
      all_instructions = instructions
      all_instructions.each_with_index do |instruction, i|
        if instruction.operation == 'nop'
          copied_list = instructions
          copied_list[i].operation = 'jmp'
          result = is_infinite?(copied_list)

          if result
            return result
          end
        elsif instruction.operation == 'jmp'
          copied_list = instructions
          copied_list[i].operation = 'nop'
          result = is_infinite?(copied_list)

          if result
            return result
          end
        end
      end

      false
    end

    private

    def is_infinite?(instruction_list)
      @acc = 0
      i = 0

      while true
        break if i >= instruction_list.length

        curr_instruction = instruction_list[i]
        if curr_instruction.times_run == 1
          return false
        end

        result = run_operation(curr_instruction, i)
        if result
          i = result
          next
        end

        i += 1
      end

      @acc
    end

    def run_operation(instruction, index)
      instruction.increment_times_run

      case instruction.operation
      when 'acc'
        perform_acc(instruction)
        nil
      when 'jmp'
        return jmp_index(instruction, index)
      when 'nop'
        nil
      else
        nil
      end
    end

    def jmp_index(instruction, index)
      if instruction.argument_sign == '+'
        index + instruction.argument
      elsif instruction.argument_sign == '-'
        index - instruction.argument
      end
    end

    def perform_acc(instruction)
      if instruction.argument_sign == '+'
        @acc += instruction.argument
      elsif instruction.argument_sign == '-'
        @acc -= instruction.argument
      end
    end

    def instructions
      instr = []
      instruction_strings = File.read('./day8/input.txt').split("\n")
      instruction_strings.each do |instruction_string|
        split_instruction = instruction_string.split(' ')
        argument_sign = split_instruction[1].slice!(0)
        argument = split_instruction[1].to_i
        instr << Instruction.new(
          split_instruction[0],
          argument, argument_sign
        )
      end
      instr
    end
  end

  class Instruction
    attr_accessor :operation, :argument, :argument_sign, :times_run

    def initialize(operation, argument, argument_sign)
      @operation = operation
      @argument = argument
      @argument_sign = argument_sign
      @times_run = 0
    end

    def increment_times_run
      @times_run += 1
    end
  end
end
