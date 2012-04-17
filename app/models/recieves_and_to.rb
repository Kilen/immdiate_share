class RecievesAndTo < ActiveRecord::Base
  belongs_to :user
  belongs_to :share_info
end
