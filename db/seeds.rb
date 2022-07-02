# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
    employees = Employee.create([{name: 'Taher', family_name: 'taher', birthday_date:"22-10-1986", hiring_date:"01-01-2020", photo_profile: 'string', net_salary: 1500},
    {name: 'Insaf', family_name: 'Missaoui', birthday_date:"10-02-1994", hiring_date: "15-06-2021", photo_profile: 'string', net_salary: 2000}])
