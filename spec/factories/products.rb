FactoryBot.define do
  factory :product do
    title   { 'Title' }
    price   { 199 }
    weigth  { 290 }
    image   { 'image.png' }
    description { 'So testy....' }
  end
end
