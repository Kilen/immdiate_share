class AddUrlToShareImage < ActiveRecord::Migration
  def change
    add_column :share_images, :url, :string

  end
end
