# attributes:
#   id:         integer
#   user_id:    integer -> User
#   bonuses:    float
#   created_at: timestamp
#   updated_at: timestamp

class BonusAccount < ApplicationRecord
  has_many :bonus_logs
  
  belongs_to :user
end
