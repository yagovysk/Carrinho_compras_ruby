class SupportRequestMailer < ApplicationMailer
  # O assunto pode ser configurado no seu arquivo I18n em config/locales/en.yml
  # com a seguinte busca:
  #   en.support_request_mailer.respond.subject

  default from: "support@example.com"

  def respond(support_request)
    @support_request = support_request
    mail to: @support_request.email, subject: "Re: #{@support_request.subject}"
  end
end
