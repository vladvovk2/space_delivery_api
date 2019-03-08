class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
<<<<<<< HEAD
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
=======
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable
>>>>>>> project
end
