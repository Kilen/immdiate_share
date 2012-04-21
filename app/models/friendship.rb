class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  before_save :save_inverse_friendship
  before_destroy :destroy_inverse_friendship

  validates :friend_id, :presence => true
  validates :user_id, :presence => true

  private 
  def save_inverse_friendship
    inverse_friendship = Friendship.new(:user_id => friend_id,
                                        :friend_id => user_id)
    Friendship.skip_callback(:save, :before, :save_inverse_friendship)
    inverse_friendship.save()
    Friendship.set_callback(:save, :before, :save_inverse_friendship)
  end
  def destroy_inverse_friendship
    inverse_friendship = Friendship.find(:first, :conditions => ["user_id = :friend_id and friend_id = :user_id", {:friend_id => friend_id, :user_id => user_id}])
    if inverse_friendship
      inverse_friendship.delete() #bypass before_destroy callback
    end
  end
end
