class CreateTemps < ActiveRecord::Migration
  def change
    create_table :temps do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
