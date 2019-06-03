# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

Blog.destroy_all
User.destroy_all

user = User.create!(
  id: 1,
  name: "Will Smith",
  email: "will@gmail.com",
  password: "independence" 
)

20.times do |index|
  Blog.create!(
    title: Faker::Company.bs,
    body: Faker::Movies::StarWars.quote,
    status: rand(2),
    user_id: user.id,
  )
end

p "Create #{User.count} users"
p "Created #{Blog.count} articles"