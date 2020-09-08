class UserRepository < Hanami::Repository
  def by_email(email)
    users.where(email: email).first
  end

  def count
    users.count
  end
end
