FactoryBot.define do
  factory :category do
    title { Faker::Food.unique.vegetables }
    picture

    factory :category_with_products do
      transient do
        products_count { 3 }
      end

      after(:create) do |category, evaluator|
        create_list(:product, evaluator.products_count, category: category)
      end
    end
  end

  factory :product do
    title         { Faker::Food.unique.dish }
    description   { Faker::Food.description }
    product_types { |i| [i.association(:product_type)] }
    category
    picture
  end

  factory :product_type do
    price      { Faker::Number.number(3) }
    weight     { Faker::Number.number(3) }
    proportion { Faker::Food.measurement }
  end

  factory :picture do
    image_name { Faker::Avatar.image }
  end
end
