# frozen_string_literal: true

module Day4
  class PassportProcessing
    def part_1
      passports.select { |passport| part_1_valid?(passport) }.count
    end

    def part_2
      passports.select { |passport| part_2_valid?(passport) }.count
    end

    private

    def part_2_valid?(passport)
      part_1_valid?(passport) &&
        passport.map { |field, value| field_valid?(field, value) }.all?(true)
    end

    def part_1_valid?(passport)
      required_fields.each do |field|
        return false unless passport.key?(field)
      end

      true
    end

    def field_valid?(field, value)
      case field
      when 'byr'
        int_value = value.to_i
        int_value >= 1920 && int_value <= 2002
      when 'iyr'
        int_value = value.to_i
        int_value >= 2010 && int_value <= 2020
      when 'eyr'
        int_value = value.to_i
        int_value >= 2020 && int_value <= 2030
      when 'hgt'
        unit = value.chars.last(2).join
        return false unless height_units.include?(unit)

        num = value[0...-2].to_i
        if unit == 'cm'
          num >= 150 && num <= 193
        elsif unit == 'in'
          num >= 59 && num <= 76
        end
      when 'hcl'
        hash = value[0]
        return false unless hash == '#'

        characters = value[1..-1]
        return false if characters.length != 6

        characters.count('^ABCDEFabcdef0-9').zero?
      when 'ecl'
        eye_colors.include?(value)
      when 'pid'
        value.length == 9 && value.count('^0-9').zero?
      when 'cid'
        true
      else
        false
      end
    rescue StandardError
      false
    end

    def height_units
      %w[in cm]
    end

    def eye_colors
      %w[amb blu brn gry grn hzl oth]
    end

    def required_fields
      %w[byr iyr eyr hgt hcl ecl pid]
    end

    def passports
      return @passports if @passports

      @passports = []
      passport_strings = File.read('./day4/input.txt').split("\n\n")
      passport_strings.each do |passport_string|
        stripped_string = passport_string.gsub("\n", ' ')
        fields = stripped_string.split(' ')
        passport = {}
        fields.each do |field|
          split_field = field.split(':')

          passport[split_field[0]] = split_field[1]
        end
        @passports << passport
      end
      @passports
    end
  end
end
