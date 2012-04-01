class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :email
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true,
            :if => :hashed_password_blank?
  validates :email, :email_format => true, :presence => true

  attr_accessor :password_confirmation
  def password
    return @password
  end
  def password= pwd
    return if pwd.blank?
    @password = pwd
    create_new_salt()
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  def self.authenticate? name, pwd
    user = User.find_by_name(name)
    res = false
    res = false unless user
    hashed_password = User.encrypted_password(pwd, user.salt)
    if hashed_password == user.hashed_password
      res = true
    end
    return res
  end

  private
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  def self.encrypted_password pwd, salt
    string = pwd + salt
    return Digest::SHA1::hexdigest(string)
  end
  def hashed_password_blank?
    return self.hashed_password == nil
  end
end
