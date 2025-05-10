class User < ApplicationRecord
  has_secure_password
  before_destroy :ensure_an_admin_remains

  class Error < StandardError; end

  private

  def ensure_an_admin_remains
    if User.where(admin: true).count == 1 && self.admin?
      raise Error.new "Não é possível excluir o último administrador"
    end
  end
end
