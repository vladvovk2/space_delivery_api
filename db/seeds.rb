if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

AdminUser.create!(email: 'vlad.vovk.884@gmal.com', password: 'vladvovk2', password_confirmation: 'vladvovk2')
Category.create(title: 'Burgers')
