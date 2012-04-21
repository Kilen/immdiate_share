class RenameTypeInShareInfo < ActiveRecord::Migration
  def up
    rename_column :share_infos, :type, :share_type
  end

  def down
    rename_column :share_infos, :share_type, :type
  end
end
