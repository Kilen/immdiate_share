class ShareText < ActiveRecord::Base
  belongs_to :share_info, :dependent => :destroy
  validates :content, :presence => true

end
