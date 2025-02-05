after_destroy :ensure_an_admin_remains

class Error < StandardError
end

private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Não é possível excluir o último usuário"
    end
  end
