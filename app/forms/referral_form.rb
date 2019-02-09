class ReferralForm
  attr_reader :bonuses, :error_code
  
  def initialize(options = {})
    @referrer_id   = options[:referrer_id]
    @user_order_id = options[:user_order_id]
    
    if @referrer_id.nil? || @user_order_id.nil?
      raise ArgumentError, 'Required parameters: referrer_id, user_order_id'
    end
  end
  
  def referrer
    @referrer ||= User.preload(:bonus_account).find_by(id: @referrer_id)
  end
  
  def order
    @order ||= UserOrder.preload(:bonus_log).find_by(id: @user_order_id)
  end

  def valid?
    @error_code = if !referrer
      110
    elsif !order
      111
    elsif order.user_id == referrer.id
      112
    elsif order.bonus_log
      113
    else
      nil
    end

    @error_code.nil?
  end
  
  def save
    return false unless valid?
    
    account = referrer.bonus_account || referrer.create_bonus_account!
    @bonuses = order.bonus_amount
    
    order.create_bonus_log!(
      bonus_account_id: account.id,
      bonuses: @bonuses
    )
    
    true
  end
end
