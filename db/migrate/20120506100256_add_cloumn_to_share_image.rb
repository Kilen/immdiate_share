class AddCloumnToShareImage < ActiveRecord::Migration
  def change
    add_column :share_images, :description, :text
  end
end
