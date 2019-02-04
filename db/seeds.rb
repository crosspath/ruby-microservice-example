# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  # 1
  {
    attributes: {email: 'sls8sdf@ljl.aa'},
    user_orders: [
      attributes: {product: 'pencil 216', price: 0.4}
    ]
  },
  # 2
  {
    attributes: {email: 'ljaljlk22l@qnewl.qq'},
    user_orders: [
      {
        attributes: {product: 'star 77', price: 1.2},
        bonus_log: {
          attributes: {bonuses: 0.12},
          referrer_email: 'sls8sdf@ljl.aa' # 1
        }
      },
      {
        attributes: {product: 'pioneer 3', price: 4}
      }
    ]
  },
  # 3
  {
    attributes: {email: 'oasd8a8sd@ljlqe.df'},
    user_orders: [
      {
        attributes: {product: 'ebook 12.7', price: 11.8},
        bonus_log: {
          attributes: {bonuses: 1.18},
          referrer_email: 'sls8sdf@ljl.aa' # 1
        }
      }
    ]
  },
  # 4
  {
    attributes: {email: 'asd8s9@l2l.wp'},
    user_orders: [
      {
        attributes: {product: 'umbrella 1.1', price: 4.3},
        bonus_log: {
          attributes: {bonuses: 0.43},
          referrer_email: 'ljaljlk22l@qnewl.qq' # 2
        }
      }
    ]
  },
  # 5
  {
    attributes: {email: 'sds9@lbt.eu'}
  },
  # 6
  {
    attributes: {email: 'vsvs9vs@bt.wa'},
    user_orders: [
      {
        attributes: {product: 'lamp 3r', price: 2.8}
      }
    ]
  },
  # 7
  {
    attributes: {email: 'lnc3@4w.wo'},
    user_orders: [
      {
        attributes: {product: 'graal 2', price: 82.1}
      }
    ]
  },
  # 8
  {
    attributes: {email: 'cwljkl@llkt.ew'},
    user_orders: [
      {
        attributes: {product: 'phone 243', price: 7}
      }
    ]
  },
  # 9
  {
    attributes: {email: 'ljadls0@ldas.vi'},
    user_orders: [
      {
        attributes: {product: 'court @1', price: 18}
      }
    ]
  },
  # 10
  {
    attributes: {email: 'moca8@mo.vs'},
    user_orders: [
      {
        attributes: {product: 'fax #a', price: 1.7}
      }
    ]
  },
  # 11
  {
    attributes: {email: 'mi7v@kwv.bu'},
    user_orders: [
      {
        attributes: {product: 'device 2', price: 4}
      }
    ]
  },
  # 12
  {
    attributes: {email: 'njuy7@i8.cr'},
    user_orders: [
      {
        attributes: {product: 'gem 7.1', price: 7.1}
      }
    ]
  },
  # 13
  {
    attributes: {email: 'l7w@jl.bw'},
    user_orders: [
      {
        attributes: {product: 'mouse trap', price: 2.4}
      }
    ]
  },
  # 14
  {
    attributes: {email: 'muc3c9@jlqc.ec'},
    user_orders: [
      {
        attributes: {product: 'case 0.8', price: 1.1}
      }
    ]
  }
]

User.transaction do
  users.each do |user|
    u = User.create!(user[:attributes])
    
    if user[:user_orders]
      user[:user_orders].each do |order|
        o = u.user_orders.create!(order[:attributes])
        
        if order[:bonus_log]
          ref = User.find_by(email: order[:bonus_log][:referrer_email])
          account = ref.bonus_account || ref.create_bonus_account!
          
          log = o.create_bonus_log!(
            bonus_account_id: account.id,
            user_order_id: o.id,
            bonuses: o.bonus_amount
          )
          
          account.update!(bonuses: account.bonuses + log.bonuses)
        end
      end
    end
  end
end
