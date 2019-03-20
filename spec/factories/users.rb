FactoryBot.define do
  factory :user do
    email { 'vlad.vovk.844@gmail.com' }
    last_name  { 'Vovk' }
    first_name { 'Vlad' }
    phone_number { '687285102' }
    password { 'vladvovk2' }
    password_confirmation { 'vladvovk2' }
  end
end
