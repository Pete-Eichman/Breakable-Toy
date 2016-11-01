# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(first_name: "Testing", last_name: "Testing", email: "testing@gmail.com", password: "testing", phone_number: "508-333-3523" admin: true)
User.create(first_name: "Pete", last_name: "Eichman", email: "eichy14@gmail.com", password: "testing", phone_number: "508-333-3524" admin: false)
