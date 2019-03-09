burgers    = ['Черный бургер', 'Романтический бургер']
salats     = %i[Цезарь Домашний]
categories = %i[Бургеры Салаты]

categories.each { |title| Category.create(title: title) }


AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password') if Rails.env.development?
