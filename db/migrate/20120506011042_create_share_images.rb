class CreateShareImages < ActiveRecord::Migration
  def change
    create_table :share_images do |t|
      t.integer :share_info_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end
  end
end
