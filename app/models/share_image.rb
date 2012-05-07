require "open-uri"
class ShareImage < ActiveRecord::Base
  has_attached_file :image,
    :styles=>{:thumb=>"100x100>", :medium=>"350x350>", :original=>"650x450>"},
    :url=>"/assets/share_images/:style/:basename.:extension",
    :path=>":rails_root/public/assets/share_images/:style/:basename.:extension"

  belongs_to :share_info, :dependent=>:destroy

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']
  
  attr_accessor :from_where #"from_computer" or "from_url"
  attr_accessor :url
  before_create :formalize_file_name  
  

  def image_url= url
    @url = url
    self.image = open(url) if url && url != ""
  end
  def image_url
    return @url
  end

  private  

  def formalize_file_name  
    extension = File.extname(image_file_name).downcase  
    #你可以改image成你想要的文件名，把下面这个方法的第二个参数随便改了就可以
    self.image.instance_write(:file_name, 
              "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
  end  

end
