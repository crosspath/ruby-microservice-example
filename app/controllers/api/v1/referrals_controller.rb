module Api
  module V1
    class ReferralsController < ApplicationController
      # params:
      #   order:    integer -> UserOrder.id
      #   referrer: integer -> User.id
      def create
        referrer = params[:referrer].to_i
        user = User.find_by(id: referrer)
        
        unless user
          response_error 110
          return
        end
        
        order = params[:order].to_i
        user_order = UserOrder.find_by(id: order)
        
        unless user_order
          response_error 111
          return
        end
        
        if user_order.user_id == referrer
          response_error 112
          return
        end
        
        if user_order.bonus_log
          response_error 113
          return
        end
        
        account = user.bonus_account || user.create_bonus_account!
        bonuses = user_order.bonus_amount
        
        user_order.create_bonus_log!(
          bonus_account_id: account.id,
          user_order_id: user_order.id,
          bonuses: bonuses
        )
        
        response_success bonuses: bonuses
      rescue => e
        args = ENV.fetch('SHOW_EXCEPTIONS', 0).to_i > 0 ? {message: e.message} : {}
        response_error 500, args
      end
    end
  end
end
