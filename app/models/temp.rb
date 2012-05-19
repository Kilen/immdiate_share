class Temp < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar, :styles=>{:original=>"600x600>"},
    :url=>"/assets/avatar/temp/:style/:basename.:extension",
    :path=>":rails_root/public/assets/avatar/temp/:style/:basename.:extension", 
    :processors => [:cropper]

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']

  before_create :change_avatar_name
  after_update :reprocess_avatar, :if => :cropping?

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def avatar_width
    geo = Paperclip::Geometry.from_file(avatar.path(:original))
    return geo.width
  end
  def avatar_height
    geo = Paperclip::Geometry.from_file(avatar.path(:original))
    return geo.height
  end
  def cropping?
    return (!crop_x.blank? && !crop_y.blank? && \
            !crop_w.blank? && !crop_h.blank?)
  end
  private
  def change_avatar_name 
    extension = File.extname(avatar_file_name).downcase  
    #你可以改image成你想要的文件名，把下面这个方法的第二个参数随便改了就可以
    self.avatar.instance_write(:file_name, "user_avatar_#{self.user.id}#{extension}")  
  end  
  def reprocess_avatar
    self.avatar.reprocess!
    turn_temp_avatar_to_official_avatar()
  end
  def turn_temp_avatar_to_official_avatar
    official_avatar_name = User.dirname + "/" + self.avatar_file_name
    logger.info("**********************************************")
    logger.info(official_avatar_name)
    File.rename(self.avatar.path(:original), official_avatar_name) 
    self.user.avatar_file_name = self.avatar_file_name
    self.user.save()
    self.delete()
  end
end
