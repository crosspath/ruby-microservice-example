module Api
  module V1
    class ReferralsController < ApplicationController
      # params:
      #   order:    integer -> UserOrder.id
      #   referrer: integer -> User.id
      def create
        form = ReferralForm.new(
          referrer_id:   params[:referrer].to_i,
          user_order_id: params[:order].to_i
        )
        
        if form.save
          return response_success bonuses: form.bonuses
        end
        
        response_error(form.error_code || 500)
      rescue => e
        response_error 500, e
      end
    end
  end
end
