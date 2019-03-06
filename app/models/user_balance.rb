class UserBalance < ApplicationRecord
  belongs_to :user, optional: true
end
