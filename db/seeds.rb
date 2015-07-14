# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = []


99.times do
  random_name = [Faker::Name.first_name, Faker::Name.last_name].sample
  while names.include?(random_name)
    random_name = [Faker::Name.first_name, Faker::Name.last_name].sample
  end
  names << random_name

  Cat.create!(name: random_name,
              description: Faker::Hacker.say_something_smart,
              sex: ['M', 'F'].sample,
              color: ["black", "brown", "white", "red", "grey", "orange"].sample,
              birth_date: Faker::Time.backward(10000)
              )
end

CatRentalRequest.create!(
  cat_id: 1,
  status: 'APPROVED',
  start_date: 7.days.ago,
  end_date: 7.days.from_now
)

CatRentalRequest.create!(
  cat_id: 1,
  status: 'APPROVED',
  start_date: 2.weeks.ago,
  end_date: 10.days.ago
)



# create_table "cat_rental_requests", force: :cascade do |t|
#   t.integer  "cat_id",                         null: false
#   t.string   "status",     default: "PENDING", null: false
#   t.date     "start_date",                     null: false
#   t.date     "end_date"
