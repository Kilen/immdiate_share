class User < ActiveRecord::Base
  has_many :shares, :class_name => "ShareInfo", :dependent => :destroy,
           :foreign_key => :from
  has_many :recieves_and_tos, :dependent => :destroy
  has_many :recieves,
           :through => :recieves_and_tos, :source => :share_info
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :comments
  has_many :replies

  attr_accessible :name, :password, :password_confirmation, :email
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true,
            :if => "self.hashed_password == nil" 
  validates :email, :email_format => true, :presence => true

  attr_accessor :password_confirmation
  def password
    return @password
  end
  def password= pwd
    @password = pwd
    return if pwd.blank?
    create_new_salt()
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  def self.authenticate? name, pwd
    user = User.find_by_name(name)
    res = false
    if user
      hashed_password = User.encrypted_password(pwd, user.salt)
      if hashed_password == user.hashed_password
        res = true
      end
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
end
