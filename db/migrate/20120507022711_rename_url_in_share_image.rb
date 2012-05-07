class RenameUrlInShareImage < ActiveRecord::Migration
  def up
    rename_column :share_images, :url, :website_url
  end

  def down
    rename_column :share_images, :website_url, :url
  end
end
