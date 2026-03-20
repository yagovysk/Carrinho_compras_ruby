require 'active_model/serializers/xml'
require 'pago'

class Order < ApplicationRecord
  include ActiveModel::Serializers::Xml

  enum pay_type: {
    "Check"          => 0,
    "Credit card"    => 1,
    "Purchase order" => 2
  }

  has_many :line_items, dependent: :destroy

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      line_items << line_item
    end
  end

  def charge!(pay_type_params)
    permitted_params = pay_type_params.to_h.symbolize_keys

    payment_method, payment_details = build_payment_payload(permitted_params)

    result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    if result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise result.error
    end
  end

  private

  def build_payment_payload(params)
    case pay_type
    when "Check"
      [:check, {
        routing: fetch_required!(params, :routing_number),
        account: fetch_required!(params, :account_number)
      }]
    when "Credit card"
      month, year = normalize_expiration(fetch_required!(params, :expiration_date))

      [:credit_card, {
        cc_num: fetch_required!(params, :credit_card_number),
        expiration_month: month,
        expiration_year: year
      }]
    when "Purchase order"
      [:po, {
        po_num: fetch_required!(params, :po_number)
      }]
    else
      raise ArgumentError, "Invalid payment method"
    end
  end

  def fetch_required!(params, key)
    value = params[key].to_s.strip
    raise ArgumentError, "Missing #{key}" if value.blank?

    value
  end

  def normalize_expiration(raw_value)
    match = raw_value.match(/\A(0[1-9]|1[0-2])\s*\/\s*(\d{2}|\d{4})\z/)
    raise ArgumentError, "Invalid expiration date format" unless match

    month = match[1]
    year = match[2].length == 2 ? "20#{match[2]}" : match[2]

    [month, year]
  end
end
