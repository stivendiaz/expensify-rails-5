# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([{name: 'Car'},{name: 'Food'},{name: 'Gym'},{name: 'Phone'},{name: 'Nightlife'}])

20.times do 
  Category.create(name: Faker::Commerce.unique.department(1))
end

Type.create([{name: 'Purchase'},{name: 'Retirement'},{name: 'Transfer'},{name: 'Payment'}])

500.times do
  a = Expense.create(
    type_id: rand(1..Type.count),
    category_id: rand(1..Category.count),
    concept: Faker::Commerce.product_name,
    date: Faker::Time.between(DateTime.now, DateTime.now.months_ago(6)),
    amount: Faker::Number.between(1, 50000)
  )
  a.save
end
