# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do |index|
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password)
  # Wiki.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user_id: user.sample.id)
end

User.all.each do |user|
  Wiki.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user_id: user.id)
end

p "Created #{User.count} users"
p "Created #{Wiki.count} wikis"
