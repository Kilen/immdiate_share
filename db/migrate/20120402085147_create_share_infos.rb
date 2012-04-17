class CreateShareInfos < ActiveRecord::Migration
  def change
    create_table :share_infos do |t|
      t.integer :from
      t.integer :to
      t.string :type

      t.timestamps
    end
  end
end
