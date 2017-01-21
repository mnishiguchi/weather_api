# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Location.create!([
  {name: "Washington"},
  {name: "Reston"},
  {name: "Little Rock"},
])

temp_list = [12, 15, 19, 21, 26, 35, 37, 38, 39]
status_list = %w(sunny cloudy rainy snowy)
Location.all.each do |location|
  5.times do
    location.recordings.create!(temp: temp_list.sample, status: status_list.sample)
  end
end
