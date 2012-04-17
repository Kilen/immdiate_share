class CreateShareTexts < ActiveRecord::Migration
  def change
    create_table :share_texts do |t|
      t.integer :share_info_id
      t.text :content

      t.timestamps
    end
  end
end
