# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(id: 1, email: "user1@example.com", password: "123456")
User.create!(id: 2, email: "user2@example.com", password: "123456")
User.create!(id: 3, email: "user3@example.com", password: "123456")

Organization.create!(id: 1, name: "Test Organization 1", user_id: 1)
Organization.create!(id: 2, name: "Test Organization 2", user_id: 2)
Organization.create!(id: 3, name: "Test Organization 3", user_id: 3)

Campaign.create!(id: 1, name: "Campaign 1", organization_id: 1)
Campaign.create!(id: 2, name: "Campaign 2", organization_id: 1)
