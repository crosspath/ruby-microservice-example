# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

module DataGenerator
  ALPHA = ('a'..'z').to_a
  ALPHA_NUM = ALPHA + (0..9).to_a
  
  class << self
    def email
      name_length   = rand(18) + 2
      domain_length = rand(12) + 2
      zone_length   = rand(4)  + 2
      
      name   = name_length.times.map   { |t| ALPHA_NUM.sample }.join
      domain = domain_length.times.map { |t| ALPHA_NUM.sample }.join
      zone   = zone_length.times.map   { |t| ALPHA.sample }.join
      
      "#{name}@#{domain}.#{zone}"
    end
    
    def product
      length = rand(18) + 2
      length.times.map { |t| ALPHA_NUM.sample }.join
    end
    
    def price
      (rand * 100).ceil(2)
    end
    
    def orders_count
      rand(3)
    end
    
    def referrer
      d = User.select('min(id) as min_id, max(id) as max_id')[0]
      boundary = rand(d.max_id - d.min_id) + d.min_id
      User.find_by('id >= ?', boundary)
    end
    
    def coin?
      rand(2) == 0
    end
  end
end

1_000.times do
  User.transaction do
    user = User.create!(email: DataGenerator.email)
    
    DataGenerator.orders_count.times do |t|
      order = user.user_orders.create!(
        product: DataGenerator.product,
        price: DataGenerator.price
      )
      
      if t == 0 && DataGenerator.coin?
        referrer = DataGenerator.referrer
        if referrer
          account = referrer.bonus_account || referrer.create_bonus_account!
          
          log = order.create_bonus_log!(
            bonus_account_id: account.id,
            bonuses: order.bonus_amount
          )
          
          account.update!(bonuses: account.bonuses + log.bonuses)
        end
      end
    end
  end
end
