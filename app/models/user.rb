# attributes:
#   id:         integer
#   email:      string
#   created_at: timestamp
#   updated_at: timestamp

class User < ApplicationRecord
  has_one :bonus_account
  has_many :user_orders
end
