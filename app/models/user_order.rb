# attributes:
#   id:         integer
#   user_id:    integer -> User
#   product:    string
#   price:      float
#   created_at: timestamp
#   updated_at: timestamp

class UserOrder < ApplicationRecord
  BONUS = 10 # percent
  
  has_one :bonus_log
  
  belongs_to :user
  
  def bonus_amount
    self.price * BONUS / 100.0
  end
end
