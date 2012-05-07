class RemoveUrlFromShareInfo < ActiveRecord::Migration
  def up
    remove_column :share_infos, :url
  end

  def down
    add_column :share_infos, :url, :string
  end
end
