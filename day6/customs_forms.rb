module Day6
  class CustomsForms
    def part_1
      part_1_group_forms.map(&:count).sum
    end

    def part_2
      sum = 0
      part_2_group_forms.each do |list_of_forms|
        list_of_forms[0].chars.each do |char|
          sum += 1 if list_of_forms.all? { |form| form.include?(char) }
        end
      end
      sum
    end

    private

    def part_2_group_forms
      return @group_forms_2 if @group_forms_2

      @group_forms_2 = []
      form_strings = File.read('./day6/input.txt').split("\n\n")
      form_strings.each do |form_string|
        people = form_string.split("\n")
        people.map { |person| person.strip.gsub("\n", ' ') }
        @group_forms_2 << people
      end
      @group_forms_2
    end

    def part_1_group_forms
      return @group_forms if @group_forms

      @group_forms = []
      form_strings = File.read('./day6/input.txt').split("\n\n")
      form_strings.each do |form_string|
        @group_forms << form_string.strip.gsub(/\s+/, '').chars.uniq
      end
      @group_forms
    end
  end
end
