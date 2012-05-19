class ShareLink < ActiveRecord::Base
  belongs_to :share_info, :dependent => :destroy
  validates :website_url, :presence => true
  validates :title, :presence => true
end
