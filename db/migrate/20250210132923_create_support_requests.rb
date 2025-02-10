class CreateSupportRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :support_requests do |t|
      t.string  :email, comment: "Email do solicitante"
      t.string  :subject, comment: "Assunto do e-mail de suporte"
      t.text    :body, comment: "Corpo do e-mail de suporte"
      t.references :order,
                   foreign_key: true,
                   comment: "Pedido mais recente, se aplicável"
      t.timestamps
    end
  end
end
