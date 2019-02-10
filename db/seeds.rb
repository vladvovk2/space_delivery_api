burgers    = ['Черный бургер', 'Романтический бургер']
salats     = ['Цезарь', 'Домашний']
categories = ['Бургеры', 'Салаты']
#categories.each { |title| Category.create(title: title)}
burgers.each do |title| 
  Product.create(title: title,
    price: (rand(90..120)),
    description: 'Самый вкусный бургер',
    weight: 390,
    category_id: 1)
end
salats.each do |title| 
  Product.create(title: title,
    price: (rand(90..120)),
    description: 'Самый свежий салат',
    weight: 90,
    category_id: 2)
end