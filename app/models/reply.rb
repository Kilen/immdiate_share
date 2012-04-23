class Reply < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => :user_id
  belongs_to :comment

  validates :content, :presence => true
  attr_accessible :content
end
