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
  has_many :system_message_sendeds, :class_name => "SystemMessage", 
           :foreign_key => :from
  has_many :system_message_recieveds, :class_name => "SystemMessage",
           :foreign_key => :to
  has_one :temp, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true,
            :if => "self.hashed_password == nil" 
  validates :email, :email_format => true, :presence => true
  validates :avatar_file_name, :presence => true

  attr_accessible :name, :password, :password_confirmation, :email,
                  :avatar_file_name
  
  before_create :get_random_system_default_avatar


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
  def self.exit? id
    user = User.find_by_id(id)
    if user
      return true
    else
      return false
    end
  end

  #where avatar store
  def self.dirname
    return Rails.root.join("public","assets","avatar").to_s
  end
  def avatar_url
    return "avatar/" + self.avatar_file_name
  end
  def self.system_default_avatar_num
    return 12
  end


  private
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  def self.encrypted_password pwd, salt
    string = pwd + salt
    return Digest::SHA1::hexdigest(string)
  end
  def get_random_system_default_avatar
    self.avatar_file_name = "system_default_avatar(#{get_random()}).png"
  end
  def get_random
    return (rand*100).floor % User.system_default_avatar_num + 1
  end
end
