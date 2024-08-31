class RenameOldColumnNameToNewColumnNameInTableName < ActiveRecord::Migration[7.1]
  def change
    rename_column :playlists, :users_id, :user_id
  end
end
