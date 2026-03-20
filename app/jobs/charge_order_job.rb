class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order_id, pay_type_params)
    order = Order.find(order_id)
    order.charge!(pay_type_params)
  rescue ActiveRecord::RecordNotFound
    Rails.logger.warn("Order #{order_id} not found while trying to charge")
  end
end
