# attributes:
#   id:         integer
#   user_id:    integer -> User
#   product:    string
#   price:      float
#   created_at: timestamp
#   updated_at: timestamp

class UserOrder < ApplicationRecord
  has_one :bonus_log
  
  belongs_to :user
end
