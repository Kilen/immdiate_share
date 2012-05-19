class CreateShareLinks < ActiveRecord::Migration
  def change
    create_table :share_links do |t|
      t.integer :share_info_id
      t.string :website_url
      t.text :description

      t.timestamps
    end
  end
end
