# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: "bg8s@colgate.edu")

Organization.delete_all

Organization.create!(name: "Gates Foundation", primary_contact: "Bill Gates", address: "1 Microsoft Way", email: "bg8s@colgate.edu", description: "Mosquitos are bugs. We're expert debuggers.", is_approved: true)
Organization.create!(name: "Spaghetti 4 Freddy", primary_contact: "Fred Y.", address: "11 Noodle Lane", email: "pastapls@yahoo.com", description: "Give Freddy the Italian hospitality he doesn't deserve, today", is_approved: true)
Organization.create!(name: "Youth Education", primary_contact: "Jean Erick", address: "95 Charity Ave.", email: "hello@schooltheyouth.org", description: "Bright minds are bright futures", is_approved: true)


