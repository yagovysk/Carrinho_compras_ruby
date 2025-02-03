require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Confirmação do Pedido", mail.subject
    assert_equal ["cliente@example.com"], mail.to
    assert_equal ["no-reply@exemplo.com"], mail.from
    assert_match '/Obrigado por comprar/', mail.body.encoded
  end
end

