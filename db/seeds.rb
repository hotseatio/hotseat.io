# typed: false
# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

def read_csv(file_name, &)
  csv_text = Rails.root.join('lib', 'seeds', file_name).read
  csv = CSV.parse(csv_text, headers: true)
  csv.each(&)
end

# Create Terms
quarters = %w[W S F 1]
years = %w[99 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27]
years.product(quarters)
     .map(&:join)
     .each { |term| Term.find_or_create_by!(term:) }

unless Rails.env.test?
  read_csv 'subject-areas-1999-2019.csv' do |row|
    SubjectArea.find_or_create_by!(name: row['name'], code: row['code'])
  end
end
