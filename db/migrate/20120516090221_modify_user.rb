class ModifyUser < ActiveRecord::Migration
  def up
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_updated_at
  end

  def down
    add_column :users, :avatar_updated_at, :datetime
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
  end
end
