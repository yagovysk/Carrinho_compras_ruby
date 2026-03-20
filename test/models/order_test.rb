require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "add line items from cart" do
    order = orders(:one)
    cart = carts(:one)
    product = products(:ruby)

    cart.line_items.create!(product: product, quantity: 2)

    assert_difference("order.line_items.count", 1) do
      order.add_line_items_from_cart(cart)
    end

    assert_nil order.line_items.last.cart_id
  end
end
