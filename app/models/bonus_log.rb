# attributes:
#   id:               integer
#   bonus_account_id: integer -> BonusAccount
#   user_order_id:    integer -> UserOrder
#   bonuses:          float
#   created_at:       timestamp
#   updated_at:       timestamp

class BonusLog < ApplicationRecord
  belongs_to :bonus_account
  belongs_to :user_order
end
