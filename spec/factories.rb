FactoryBot.define do
  factory :user do
    username { Faker::Lorem.word }
    password { Faker::Lorem.word }
    role { 'admin' }
  end
  factory :employee do
    name { Faker::Lorem.word}
    family_name { Faker::Lorem.word}
    birthday_date { '1986-10-22'}
    hiring_date { '2016-10-01' }
    photo_profile { 'string' }
    net_salary { 1550 }
  end
end
