FactoryBot.define do
  factory :category do
    title { 'Title' }
    picture
  end

  factory :product do
    title       { 'Title' }
    description { 'So testy....' }
    product_types { |i| [i.association(:product_type)] }
    category
    picture
  end

  factory :product_type do
    price  { 199 }
    weight { 290 }
  end

  factory :picture do
    image_name { 'image.png' }
  end
end
