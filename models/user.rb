class User < Person
  def admin?
    role == 'admin'
  end

end
