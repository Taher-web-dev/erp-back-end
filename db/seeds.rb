# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
    users = User.create([{Full_name: 'Taher Haggui', username: 'taher', password:"77471580t", role:"admin"},
    {Full_name: 'Insaf Missaoui', username: 'Insaf', password:"77471642t", role:"nothing"}])
