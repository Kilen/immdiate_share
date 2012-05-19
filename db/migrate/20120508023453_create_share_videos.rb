class CreateShareVideos < ActiveRecord::Migration
  def change
    create_table :share_videos do |t|
      t.integer :share_info_id
      t.text :description
      t.string :video_url
      t.string :website_url

      t.timestamps
    end
  end
end
