class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => :user_id
  belongs_to :share_info
  has_many :replies, :dependent => :destroy
  
  attr_accessible :content
  validates :content, :presence => true
end
