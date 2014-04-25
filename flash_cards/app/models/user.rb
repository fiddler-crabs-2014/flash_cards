class User < ActiveRecord::Base
  has_many :rounds
  has_many :decks, :through => :rounds
  # Remember to create a migration!

  def self.authenticate(email, password)
    @user = User.where(email: email).first
    if @user.nil?
      return false
    else
      if @user.password == password
        return @user
      else
        return false
      end
    end
  end

end
