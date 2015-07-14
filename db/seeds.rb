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
              description: Faker::Lorem.sentence,
              sex: ['M', 'F'].sample,
              color: ["black", "brown", "white", "red", "grey", "orange"].sample,
              birth_date: Faker::Time.backward(10000)
              )
end

# t.string   "name",        null: false
# t.text     "description", null: false
# t.string   "sex",         null: false
# t.string   "color",       null: false
# t.datetime "birth_date",  null: false
# t.datetime "created_at",  null: false
# t.datetime "updated_at",  null: false
