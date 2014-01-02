class AddUseridToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :user_id, :integer
  end
end
