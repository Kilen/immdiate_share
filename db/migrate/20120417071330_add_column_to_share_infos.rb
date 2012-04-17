class AddColumnToShareInfos < ActiveRecord::Migration
  def change
    add_column :share_infos, :url, :string

  end
end
