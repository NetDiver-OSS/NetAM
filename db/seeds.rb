# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emails = %w[sebastien@sdeu.fr vincent@fricouv.eu rigonkmalk@gmail.com]

emails.each do |email|
  r = Random.urandom(128)
  User.create!({ email: email, password: r, password_confirmation: r })
end
