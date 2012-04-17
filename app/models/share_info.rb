class ShareInfo < ActiveRecord::Base
  has_one :share_text, :dependent => :destroy
  belongs_to :from_user, :class_name => "User",
             :foreign_key => "from"
  has_many :recieves_and_tos, :dependent => :destroy
  has_many :to_users, :class_name => "User", 
           :through => :recieves_and_tos, :source => :user
  validates_associated :share_text
end
