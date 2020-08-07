# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



(1..10).each do |i|
  User.create!(name: "Example User #{i}", email: "Example-Email-#{i}@example.org", password: "foobar#{i}", 
  password_confirmation: "foobar#{i}")
end