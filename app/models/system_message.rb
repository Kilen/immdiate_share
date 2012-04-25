class SystemMessage < ActiveRecord::Base
  belongs_to :from_user, :class_name => "User", :foreign_key => :from
  belongs_to :to_user, :class_name => "User", :foreign_key => :to

  validate :message_type_validator
  attr_accessible :message_type, :is_read, :to_user  
  
  def self.create_message from_id, to_id, message_type
    return false if from_id == to_id || from_id.class != to_id.class
    terms = {:from=>from_id, :to=>to_id, :message_type=>message_type}
    system_message = SystemMessage.new()
    system_message.assign_attributes(terms, :without_protection=>:true)
    if User.exit?(from_id) && User.exit?(to_id) && \
      system_message.save()
      return true
    end
    return false
  end

  def self.mark_message_read id
    message = SystemMessage.find_by_id(id)
    message.is_read = true
    if message && message.save()
      return true
    else
      return false
    end
  end

  private

  def message_type_validator
    unless ["share", "comment", "reply", "ask_friendship", "agree_friendship"].include?(self.message_type)
      errors.add(:message_type, "invalid message type")
    end
  end
end
