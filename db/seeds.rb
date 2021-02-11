# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create email: 'alpha.ru@gmail.com', password: 'admin123'
Admin.create email: 'deinkoo@yandex.ru', password: 'admin123'
user = User.create email: 'user@user.ru', password: 'user123', name: 'User', last_name: 'Name'
FactoryBot.create_list(:event, 20, author: user)
