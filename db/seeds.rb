# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Starting DB Seed Operation'
puts 'Deleting current Allow List entries'
PostcodeAllowList.destroy_all
puts 'Creating new Allow List entries'
PostcodeAllowList.create!([{ postcode: 'SH24 1AA' }, { postcode: 'SH24 1AB' }])
puts 'Completed DB See Operation'
