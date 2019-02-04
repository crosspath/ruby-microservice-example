class Setup < ActiveRecord::Migration[5.2]
  def change
    create_table User.table_name do |t|
      t.string :email, null: false
      t.timestamps null: false
    end
    
    create_table UserOrder.table_name do |t|
      t.references :user, null: false
      t.string :product, null: false
      t.float :price, null: false
      t.timestamps null: false
    end
    
    create_table BonusAccount.table_name do |t|
      t.references :user, null: false
      t.float :bonuses, null: false, default: 0
      t.timestamps null: false
    end
    
    create_table BonusLog.table_name do |t|
      t.references :bonus_account, null: false,
          comment: 'Who will receive bonus for inviting new user with this UserOrder?'
      t.references :user_order, null: false
      t.float :bonuses, null: false, default: 0
      t.timestamps null: false
    end
  end
end
