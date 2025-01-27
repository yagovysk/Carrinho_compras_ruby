# config/environments/development.rb (ou production.rb, dependendo do ambiente)

Rails.application.configure do
  # Define o método de envio de e-mails
  config.action_mailer.delivery_method = :smtp
  
  # Configurações do SMTP
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "domain.of.sender.net",
    authentication: "plain",
    user_name: ENV['MAIL_USERNAME'],   # Usa variável de ambiente para maior segurança
    password: ENV['MAIL_PASSWORD'],   # Usa variável de ambiente para maior segurança
    enable_starttls_auto: true
  }

  # Configura a URL padrão caso seja necessário em ambiente de desenvolvimento ou teste
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
