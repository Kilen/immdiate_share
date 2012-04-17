class RemoveColumnFromShareInfo < ActiveRecord::Migration
  def up
    remove_column :share_infos, :to
      end

  def down
    add_column :share_infos, :to, :integer
  end
end
