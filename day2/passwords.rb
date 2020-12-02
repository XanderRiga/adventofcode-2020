# frozen_string_literal: true

module Day2
  class Passwords
    def part_1
      corrupted_passwords.select do |pw|
        num_occurrences = pw.password.scan(pw.value).length
        num_occurrences >= pw.min_occurrences && num_occurrences <= pw.max_occurrences
      end.length
    end

    def part_2
      corrupted_passwords.select do |pw|
        indices = all_substring_indices(str: pw.password, sub: pw.value)
        indices.include?(pw.min_occurrences - 1) ^
          indices.include?(pw.max_occurrences - 1)
      end.length
    end

    def all_substring_indices(str:, sub:)
      str.enum_for(:scan, sub).map { Regexp.last_match.offset(0).first }
    end

    def corrupted_passwords
      return @corrupted_passwords if @corrupted_passwords

      @corrupted_passwords = []
      File.open('./day2/input.txt', 'r') do |f|
        f.each_line do |line|
          @corrupted_passwords << CorruptedPassword.new(
            min_occurrences: Integer(line.split('-')[0]),
            max_occurrences: Integer(line.split('-')[1].split(' ')[0]),
            value: line.split(' ')[1].gsub(/\W/, ''),
            password: line.split(' ')[2]
          )
        end
      end
      @corrupted_passwords
    end
  end

  class CorruptedPassword
    attr_reader :min_occurrences, :max_occurrences, :value, :password

    def initialize(
      min_occurrences:,
      max_occurrences:,
      value:,
      password:
    )
      @min_occurrences = min_occurrences
      @max_occurrences = max_occurrences
      @value = value
      @password = password
    end
  end
end
