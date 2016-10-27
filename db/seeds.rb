# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: "Tester", last_name: "St.Testler", email: "testing1@gmail.com", password: "testing", phone_number: "508-333-3523" admin: true)

User.create(first_name: "Test-Girl", last_name: "St.Testler", email: "testing2@gmail.com", password: "testing")

User.create(first_name: "Test-Boy", last_name: "Testington", email: "testing@gmail.com", password: "testing")
