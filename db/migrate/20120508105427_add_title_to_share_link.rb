class AddTitleToShareLink < ActiveRecord::Migration
  def change
    add_column :share_links, :title, :string

  end
end
