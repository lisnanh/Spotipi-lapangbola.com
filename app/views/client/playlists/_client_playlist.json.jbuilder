json.extract! client_playlist, :id, :name, :description, :users_id, :created_at, :updated_at
json.url client_playlist_url(client_playlist, format: :json)
