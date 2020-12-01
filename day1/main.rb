# frozen_string_literal: true

require './day1/expense_report'

expense_report = Day1::ExpenseReport.new

puts "#{expense_report.pairs} for pairs"
puts "#{expense_report.triples} for triples"
