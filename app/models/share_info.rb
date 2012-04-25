class ShareInfo < ActiveRecord::Base
  has_one :share_text, :dependent => :destroy
  belongs_to :from_user, :class_name => "User", :foreign_key => :from
  has_many :user_addresses, :class_name => "RecievesAndTo",
           :dependent => :destroy
  has_many :to_users, :class_name => "User", 
           :through => :user_addresses, :source => :user,
           :uniq => true
  has_many :comments

  attr_accessible :share_type, :url, :content
  validates_associated :share_text
  validate :user_address_validator, :before => :create
  validate :type_validator

  after_save :save_friend_addresses_and_content
  def send_to_friends current_user, user_ids
    return unless user_ids
    user_ids.each do |id|
      if current_user.friends.find_by_id(id)
        user_addresses.build(:user_id => id)
      else
        errors[:base] << "no friend with such an id"
        return
      end
    end
  end
  def content= text
    self.share_text = ShareText.new(:content => text)
  end
  def content
    text = self.share_text
    if text
      return text.content
    else
      return ""
    end
  end

  private

  def type_validator
    unless ["text", "picture", "vedio"].include?(share_type)
      errors.add(:type, "no such type of share")
    end
  end
  def user_address_validator
    if self.user_addresses.blank?
      errors[:base] << "you must share with your friends"
    end
  end
  def save_friend_addresses_and_content
    self.user_addresses.each do |address|
      address.save()
    end
    self.share_text.save()
  end
end
