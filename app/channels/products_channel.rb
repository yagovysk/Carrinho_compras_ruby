class ProductsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "products"
  end

  def unsubscribed
    # Limpeza necessária ao cancelar a assinatura
  end
end
