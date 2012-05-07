class ChangeShareImages < ActiveRecord::Migration
  def up
    rename_column :share_images, :photo_file_name, :image_file_name
    rename_column :share_images, :photo_content_type, :image_content_type
    rename_column :share_images, :photo_file_size, :image_file_size
    rename_column :share_images, :photo_updated_at, :image_updated_at
  end

  def down
    rename_column :share_images, :image_file_name, :photo_file_name
    rename_column :share_images, :image_content_type, :photo_content_type
    rename_column :share_images, :image_file_size, :photo_file_size
    rename_column :share_images, :image_updated_at, :photo_updated_at
  end
end
