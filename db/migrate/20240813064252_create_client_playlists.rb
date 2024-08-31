class CreateClientPlaylists < ActiveRecord::Migration[7.1]
  def change
    create_table :client_playlists do |t|
      t.string :name
      t.text :description
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
