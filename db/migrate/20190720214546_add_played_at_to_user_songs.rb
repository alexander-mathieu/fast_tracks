class AddPlayedAtToUserSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :user_songs, :played_at, :integer
  end
end
