# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Organization.delete_all
Campaign.delete_all

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}"))
end

User.create!(id: 1, email: "bg8s@colgate.edu", password: "123456")
User.create!(id: 2, email: "pastapls@yahoo.com", password: "123456")
User.create!(id: 3, email: "hello@schooltheyouth.org", password: "123456")

Organization.create!(id: 1, user_id: 1, name: "Gates Foundation", primary_contact: "Bill Gates", address: "1 Microsoft Way", email: "bg8s@colgate.edu", description: "Mosquitos are bugs. We're expert debuggers.", is_approved: true, image: seed_image('gates_foundation.png'))
Organization.create!(id: 2, user_id: 2, name: "Spaghetti 4 Freddy", primary_contact: "Fred Y.", address: "11 Noodle Lane", email: "pastapls@yahoo.com", description: "Give Freddy the Italian hospitality he doesn't deserve, today", is_approved: true, image: seed_image('spaghetti.jpg'))
Organization.create!(id: 3, user_id: 3, name: "Youth Education", primary_contact: "Jean Erick", address: "95 Charity Ave.", email: "hello@schooltheyouth.org", description: "Bright minds are bright futures", is_approved: true, image: seed_image('youth_education.jpg'))

Campaign.create!(id: 1, name: "Malaria Vaccines", organization_id: 1, description: "We are funding a large wave of Malaria vaccines for children in rural Zimbabwe.", goal: 300000, image: seed_image('malaria_vaccine.jpeg'))
Campaign.create!(id: 2, name: "Ravioli Meal for 1", organization_id: 2, description: "Olive Garden is closed all next week and I think I'm going to starve.", goal: 20, image: seed_image('ravioli.jpeg'))
Campaign.create!(id: 3, name: "Cure for Polio", organization_id: 1, description: "This is an ambitious undertaking; immunization is not enough. We need to cure polio. Again.", goal: 1000000, image: seed_image('polio.jpg'))
Campaign.create!(id: 4, name: "Textbooks for 1st Graders", organization_id: 3, description: "SAT Prep for Toddlers and Junior Differential Equations needed for a class of 20!", goal: 1000, image: seed_image('textbooks.jpg'))
