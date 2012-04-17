class ShareText < ActiveRecord::Base
  belongs_to :share_info, :dependent => :destroy

  attr_accessor :url
end
