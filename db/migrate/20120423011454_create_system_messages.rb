class CreateSystemMessages < ActiveRecord::Migration
  def change
    create_table :system_messages do |t|
      t.integer :from
      t.integer :to
      t.string :message_type
      t.boolean :is_read, :default => false

      t.timestamps
    end
  end
end
