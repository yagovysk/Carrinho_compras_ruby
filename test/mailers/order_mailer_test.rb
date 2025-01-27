require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    order = orders(:one)
    mail = OrderMailer.received(order)

    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match(/1 x Programming Ruby 1.9/, mail.body.encoded)
  end

  test "shipped" do
    order = orders(:one)
    mail = OrderMailer.shipped(order)

    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from

    assert_match(%r(
      <td[^>]*>1<\/td>\s* # Verifica a quantidade
      <td>&times;<\/td>\s* # Verifica o símbolo "×"
      <td[^>]*>\s*Programming\s*Ruby\s*1.9\s*<\/td> # Verifica a descrição do item
    )x, mail.body.encoded)
  end
end
