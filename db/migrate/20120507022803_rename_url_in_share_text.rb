class RenameUrlInShareText < ActiveRecord::Migration
  def up
    rename_column :share_texts, :url, :website_url
  end

  def down
    rename_column :share_texts, :website_url, :url
  end
end
