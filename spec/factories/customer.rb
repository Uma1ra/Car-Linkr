FactoryBot.define do
  factory :customer do
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_name_kana { Faker::Name.last_name }
    first_name_kana { Faker::Name.first_name }
    post_code { Faker::Number.number(digits: 7) }
    phone_number { Faker::Number.number(digits: 10) }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 10) }
    is_deleted { true }
    is_guest { false }
  end
end