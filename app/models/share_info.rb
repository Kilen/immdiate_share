class ShareInfo < ActiveRecord::Base
  has_one :share_text, :dependent => :destroy
  has_one :share_image, :dependent => :destroy
  has_one :share_video, :dependent => :destroy
  has_one :share_link, :dependent => :destroy
  belongs_to :from_user, :class_name => "User", :foreign_key => :from
  has_many :user_addresses, :class_name => "RecievesAndTo",
           :dependent => :destroy
  has_many :to_users, :class_name => "User", 
           :through => :user_addresses, :source => :user,
           :uniq => true
  has_many :comments

  attr_accessible :share_type, :url, :content
  validates_associated :share_text, :share_image, :share_video, :share_link
  validate :user_address_validator, :before => :create
  validate :type_validator

  after_save :save_friend_addresses_and_content
  def put_down_friends_address current_user, user_ids
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
  def self.put_in_envolope share, current_user, friend_ids, type
    share_info = ShareInfo.new
    share_info.link_with_share(share, type)
    share_info.share_type = type
    share_info.from = current_user.id
    share_info.put_down_friends_address(current_user, friend_ids)
    if share_info.save()
      ShareInfo.create_share_messages_to_friends(current_user.id,
                                                 friend_ids)
      return true
    else
      return false
    end
  end
  def link_with_share share, type
    case type
    when "text": self.share_text = share
    when "image": self.share_image = share
    when "video": self.share_video = share
    when "link": self.share_link = share
    else raise "no such type(#{type}) of content"
    end
  end


  private

  def type_validator
    unless ["text", "image", "video", "link"].include?(share_type)
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
    save_content()
  end
  def save_content
    case self.share_type
    when "text": self.share_text.save()
    when "image": self.share_image.save()
    when "video": self.share_video.save()
    when "link": self.share_link.save()
    else raise "save content error"
    end
  end
  def self.create_share_messages_to_friends current_user_id, friend_ids
    friend_ids.each do |friend_id|
      SystemMessage.create_message(current_user_id, friend_id.to_i, "share")
    end
  end
end
