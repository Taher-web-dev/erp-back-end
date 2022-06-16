FactoryBot.define do
  factory :user do
    Full_name { Faker::Lorem.words }
    username { Faker::Lorem.word }
    password { Faker::Lorem.word }
    role { "admin" }

  end
end