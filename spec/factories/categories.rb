FactoryBot.define do
  factory :category do
    title { 'Title' }

    factory :category_with_products do
      transient do
        products_count { 2 }
      end

      after(:create) do |category, evaluator|
        create_list(:product, evaluator.posts_count, category: category)
      end
    end
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
