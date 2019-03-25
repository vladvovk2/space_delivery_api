FactoryBot.define do
  factory :user do
    email        { Faker::Internet.unique.email }
    last_name    { Faker::Name.unique.first_name }
    first_name   { Faker::Name.unique.last_name }
    phone_number { Faker::Number.unique.number(9) }
    password              { 'vladvovk2' }
    password_confirmation { 'vladvovk2' }
  end
end
