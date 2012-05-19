class ShareVideo < ActiveRecord::Base
  belongs_to :share_info, :dependent => :destroy
  validates :video_url, :presence => true
  validates_format_of :video_url, :with => %r{\.(swf|flv|f4v)$}i, 
                      :message => ":this is not a valide video url"
end
