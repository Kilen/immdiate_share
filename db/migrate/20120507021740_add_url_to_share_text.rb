class AddUrlToShareText < ActiveRecord::Migration
  def change
    add_column :share_texts, :url, :string
  end
end
