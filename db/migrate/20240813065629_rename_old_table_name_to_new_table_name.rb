class RenameOldTableNameToNewTableName < ActiveRecord::Migration[7.1]
  def change
    rename_table :client_playlists, :playlists
  end
end
