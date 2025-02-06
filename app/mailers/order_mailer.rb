class OrderMailer < ApplicationMailer
  default from: 'Loja <no-reply@exemplo.com>'

  def received(order)
    @order = order
    mail to: order.email, subject: 'Confirmação do Pedido'
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Seu Pedido foi Enviado'
  end
end
