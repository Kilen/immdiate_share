class CreateRecievesAndTos < ActiveRecord::Migration
  def change
    create_table :recieves_and_tos do |t|
      t.integer :share_info_id
      t.integer :user_id

      t.timestamps
    end
  end
end
